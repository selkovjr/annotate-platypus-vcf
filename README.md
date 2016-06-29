# annotate-platypus-vcf
Automatic annotation of variants called by Platypus

This tool classifies variant types and calculates several variant metrics
not provided by Platypus output. It also inserts population data and variant effect
predictions using [ExAC web API](http://exac.hms.harvard.edu/).

For details, please see [Discussion of objectives and solutions](discussion.md).

The code is written in perl using the [Vcf
module](http://search.cpan.org/~snkwatt/VCF-1.0/lib/VCF/V4_0.pm)
to parse and render VCF.

For simplicity, external requests are made in the order of input, except for
multi-allelic variants that are queried with asynchronous
[Promises](https://github.com/stevan/promises-perl).

For ease of deployment, all annotation and utility code is contained in a
single file. For a detailed description, please see [Annotated code
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
