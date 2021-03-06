TOOL=./annotate-platypus-vcf
REF=Homo_sapiens.GRCh37.75.dna.toplevel.fa

GREEN=\033[0;32m
RED=\033[0;31m
NC=\033[0m

all:

validate:
	vcf-validator example/annotated.vcf

doc:
	docco -e .pl ${TOOL}

test: test-indel test-multiallelic test-unlocalized

test-indel:
	@-${TOOL} < t/$@.vcf > t/out/$@.vcf 2> t/err/$@ && ([ $$? -eq 0 ] && echo "${RED}$@${NC}: fail") || echo "${GREEN}$@${NC}: expected error condition"
	@cmp t/out/$@.vcf t/expected/$@.vcf
	@diff -I HASH -I main::error t/err/$@ t/expected/$@.err
	@echo "  OK"

test-multiallelic:
	@-${TOOL} -r ${REF} < t/$@.vcf > t/out/$@.vcf 2> t/err/$@ && ([ $$? -eq 0 ] && echo "${GREEN}$@${NC}") || echo "${RED}$@${NC}: fail"
	@cmp t/out/$@.vcf t/expected/$@.vcf
	@echo "  OK"

test-unlocalized:
	@-${TOOL} -r ${REF} < t/$@.vcf > t/out/$@.vcf 2> t/err/$@ && ([ $$? -eq 0 ] && echo "${GREEN}$@${NC}") || echo "${RED}$@${NC}: fail"
	@cmp t/out/$@.vcf t/expected/$@.vcf
	@echo "  OK"
