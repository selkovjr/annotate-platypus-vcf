TOOL=./annotate-platypus-vcf
REF=../hg37.fa

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

all:

test: test-multiallelic

test-indel:
	@-$(TOOL) < t/$@.vcf > t/out/$@.vcf 2> t/err/$@ && ([ $$? -eq 0 ] && echo ${GREEN}$@${NC}) || echo "${RED}$@${NC}: fail"
	diff t/out/$@.vcf t/expected/$@.vcf
	diff t/err/$@ t/expected/$@.err

test-multiallelic:
	@-$(TOOL) -r $(REF) < t/$@.vcf > t/out/$@.vcf 2> t/err/$@ && ([ $$? -eq 0 ] && echo ${GREEN}$@${NC}) || echo "${RED}$@${NC}: fail"
	cmp t/out/$@.vcf t/expected/$@.vcf
	@echo "  OK"
