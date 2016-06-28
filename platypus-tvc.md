# Platypus-TVC correspondence

## Locus annotations (INFO)

Platypus tags listed here come from a single example of Platipus output. It is
likely an incomplete set.

Platypus | TVC | Type | Description
---------|-----|------|------------
| | `TYPE` | String | The type of allele: SNP, MNP, INS, DEL, or COMPLEX
| | `AO` | Integer | Alternate allele observations
`BRF` | | Float | Fraction of reads around this variant that failed filters
| `FS` | | Float | Fisher's exact test for strand bias (Phred score)
`FR` | | Float | Estimated population frequency of variant
| | `FR` | String | Reason why the variant was filtered
`HapScore` | | Integer | Haplotype score measuring the number of haplotypes the variant is segregating into in a window
`HP` | | Integer | Homopolymer run length around variant locus
| | `HRUN` | Integer | Run length: the number of consecutive repeats of the alternate allele in the reference
| | `LEN` | Integer | Allele length
| | `HS` | Flag | Indicate it is a hotspot
| `MGOF` | | Integer | Worst goodness-of-fit value reported across all samples
| `MMLQ` | | Float | Median minimum base quality for bases around variant
| `MQ` | | Float | Root mean square of mapping qualities of reads at the variant position
| | `MLLD` | Float | Mean log-likelihood delta per read
| `NF` | | Integer | Total number of forward reads containing this variant
| `NR` | | Integer | Total number of reverse reads containing this variant
| | `PB` | Float | Bias of relative variant position in reference reads versus variant reads. Equals Mann-Whitney _U_ ρ statistic P(_Y_ > _X_) + 0.5 P(_Y_ = _X_)
| | `PBP` | Float | Pval of relative variant position in reference reads versus variant reads. Related to GATK `ReadPosRankSumTest`
| `PP` | | Float | Posterior probability (Phred-scaled) that this variant segregates
| `QD` | | Float | (_Variant quality_ / _read depth_) for this variant
| | `QD` | Float | `QualityByDepth` as 4·`QUAL`/`FDP` (analogous to GATK)
| | `RO` | Integer | Reference allele observations
| `SbPval` | | Float | Binomial P-value for strand bias test
| | `SSSB` | Float | Strand-specific strand bias for allele
| | `STB` | Float | Strand bias in variant relative to reference
| | `STBP` | Float | Pval of strand bias in variant relative to reference
| | `SXB` | Float | Experimental strand bias based on approximate bayesian score for difference in frequency
| `TC` | | Integer | Total coverage at this locus
| | `DP` | Integer | Total read depth at the locus
| `TCF` | | Integer | Total forward strand coverage at this locus
| `TCR` | | Integer | Total reverse strand coverage at this locus
| `TR` | | Integer | Total number of reads containing this variant
| | `SAF` | Integer | Alternate allele observations on the forward strand
| | `SAR` | Integer | Alternate allele observations on the reverse strand
| | `SRF` | Integer | Number of reference observations on the forward strand
| | `SRR` | Integer | Number of reference observations on the reverse strand


## Sample annotations (FORMAT + SAMPLE)

Platypus | TVC | Type | Description
---------|-----|------|------------
| | `AO` | Integer | Alternate allele observation count
| | `DP` | Integer | Read depth
| `GL` | | Float | _log<sub>10</sub>_-likelihoods for _AA_, _AB_ and _BB_ genotypes, where _A_ = _ref_ and _B_ = _variant_. Only applicable to bi-allelic sites.
`GOF` | | Float | Goodness-of-fit value
`GQ` | | Integer | Genotype quality as Phred score
| | `GQ` | Integer | Genotype quality, the Phred-scaled marginal (or unconditional) probability of the called genotype
`GT` | | String | Unphased genotypes
| | `GT` | String | Genotype
`NR` | | Integer | Number of reverse reads covering variant location in this sample
`NV` | | Integer | Total number of reads covering variant location in this sample
| | `RO` | Integer | Reference allele observation count
| | `SAF` | Integer | Alternate allele observations on the forward strand
| | `SAR` | Integer | Alternate allele observations on the reverse strand
| | `SRF` | Integer | Number of reference observations on the forward strand
| | `SRR` | Integer | Number of reference observations on the reverse strand

### References
* [Platypus](https://github.com/andyrimmer/Platypus/blob/master/src/cython/vcfutils.pyx)
* [TVC](https://github.com/iontorrent/TS/blob/master/Analysis/VariantCaller/Bookkeeping/VcfFormat.cpp)
* [VCF v4.1](https://samtools.github.io/hts-specs/VCFv4.1.pdf)
