# Objectives

Each variant must be annotated with the following pieces of information:

1. **Type of variation (Substitution, Insertion, Silent, Intergenic, etc.) If
there are multiple possibilities, annotate with the most deleterious possibility.**

   There are three levels of classification here.

   **Level 1** is information directly computable from the VCF: the type of
   editing required to transform REF to ALT. Variations at this level are
   classified using the new (to Platypus) INFO tag `TYPE` with these values:
   `SNP`, `MNP`, `INS`, `DEL`, `COMPLEX`, and `MATCH`. The value of `COMPLEX`
   (in this prototype) indicates a small number of SNPs separated by short runs
   of matching bases. `MATCH` allows making assertions of the absence of
   variation (a possibility that does not materialize in the example VCF).

   **Level 2** is information computable from the reference genome and gene
   annottations: Silent, Intergenic, and such. It can be done locally, but since
   we are headed over to ExAC for predictions, and this information will be
   present in query results, there is no need for local computation.

   **Level 3** includes predictions that cannot be easily made locally, such as
   consequences of mutations. Computation at this level involves complex
   inference and extensive database support. ExAC has it all and is a fast
   responder.

   The most adverse predicted effect is annotated with a Sequence Ontology term
   in the INFO tag `VEP`:
   ```
   VEP=splice_region_variant;
   ```

   _For more up-to-date information, we could go straight to VEP, but it is
   slow and accessing it will require making a fully non-blocking loop with a
   merge buffer and complex exception handling. Doing that right will take more
   time._

2. **Depth of sequence coverage at the site of variation.**

   This is already annotated in Platypus output with the INFO tag `TC` (Total
   coverage).

3. **Number of reads supporting the variant.**

   This is annotated in Platypus output using the INFO tag `TR` (Total number of
   reads containing this variant), and separately in the sample-level tag `NV`
   (Number of reads containing varinat in this sample).

4. **Percentage of reads supporting the variant versus those supporting reference reads.**

   The only interpetation I imagine fitting this description is both ratios
   displayed in the same tag. If _versus_ means ratio, it can be infinite, and
   how does one measure percent infinity?

   Pending clarification, the solution is to insert an INFO tag `ARF`
   (Alternate-Reference percent Frequencies):
   ```
   ARF=98.995:1.005
   ```
   In the case of multi-allelic variants, this will be a comma-separated list of pairs.

5. **Allele frequency of variant from Broad Institute ExAC Project API (API documentation is available here: http://exac.hms.harvard.edu/)**

   In INFO tag `AF`. Comma-separated values for multiallelic variants, omitted
   where no data are available:
   ```
   AF=0.07306,;
   ```

6. **Additional optional information from ExAC that you feel might be relevant**

   Off-hand, other likely relevant information might be allele observation
   counts, other alleles that have been observed at this locus, and the list of
   features affected by this allele.

   New tags:
     * `OBS`: Allele observation counts (proper / total)
     * `ALL`: All alleles observed at this locus
     * `GN`: Genes containing this locus



