# annotate-platypus-vcf

### Automatic annotation of variants called by Platypus

This tool classifies variant types and calculates several variant metrics
not provided by Platypus. It also inserts population data and variant effect
predictions using [ExAC web API](http://exac.hms.harvard.edu/).

For details, please see [Discussion of objectives and solutions](discussion.md).

The code is written in perl using the [Vcf
module](http://search.cpan.org/~snkwatt/VCF-1.0/lib/VCF/V4_0.pm)
to parse and render VCF.

For simplicity, external requests are made in the order of input, except for
multi-allelic variants that are queried with asynchronous
[Promises](https://github.com/stevan/promises-perl).

For ease of deployment, all annotation and utility code is contained in a
single file. For details, please see the [annotated code
(Docco)](https://cdn.rawgit.com/selkovjr/annotate-platypus-vcf/master/docs/annotate-platypus-vcf.html).

## Usage
```
   annotate-platypus-vcf [-r reference.fa] < input.vcf > annotated.vcf
```
The reference genome must be a `samtools faindex`'ed file. It is only required to normalize and validate indels and can be omitted while processing a SNP-only VCF.

## Installation

1. Resolve dependencies (manually). We are not going full CPAN on this project.

   On a naive Ubuntu 14.04 system, the following steps were required:
   ```
   sudo aptitude install vcftools libanyevent-http-perl
   sudo cpan Promises
   ```
2. Test

   Edit the `REF` variable in the `Makefile` to point to your Build 37 human
   genome FASTA. Then run

   ```
   make test
   ```

   The output should look as follows:

   ```
   test-indel: expected error condition
   OK
   test-multiallelic
   OK
   test-unlocalized
   OK
   ```
3. Copy the tool to any executable path:

   ```
   cp annotate-platypus-vcf ~/bin
   ```
   
## Example

The [example](https://github.com/selkovjr/annotate-platypus-vcf/tree/master/example) directory contains a longer test sample and its annotated version. The following table shows one annotated record from that sample (annotated values in bold):

| CHROM | POS | ID | REF | ALT | QUAL | FILTER | INFO | FORMAT | SAMPLE |
|-------|-----|----|-----|-----|------|--------|------|--------|--------|
|1|182429295|.|CTGTG|C,CTG|2995|PASS|**AF=0.07306,.**; **ALL=<br>1-182429295-C-CTG,<br>1-182429295-C-CTGTG,<br>1-182429295-CTG-C,<br>1-182429295-CTGTG-C,<br>1-182429295-CTGTGTG-C**;<br>**ARF=51.244:48.756,51.244:48.756**;<br>BRF=0.17; FR=0.5000,0.5000;<br>**GN=ENSG00000121446**;<br>HP=2; HapScore=1;<br>MGOF=4; MMLQ=33; MQ=59.32;<br>NF=11,11; NR=92,92;<br>**OBS=1039/14222,.**;<br>PP=343,2995; QD=3.36893203883;<br>SC=ATGCGTGTGTCTGTGTGTGTG;<br>SbPval=0.65; Source=Platypus;<br>TC=201; TCF=24; TCR=177; TR=103,103;<br>**TYPE=DEL,DEL**;<br>**VEP=intron_variant**;<br>WE=182429306; WS=182429285|GT:<br>GL:<br>GOF:<br>GQ:<br>NR:<br>NV|1/2:<br>-1,-1,-1:<br>4:<br>99:<br>201,201:<br>103,103|
