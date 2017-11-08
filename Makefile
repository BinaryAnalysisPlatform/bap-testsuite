TOOLS = bap mc

check: runtest-exists
	@export status=0;\
	for tool in $(TOOLS); do runtest --status --all --tool=$$tool || status=1; done;\
	exit $$status

runtest-exists:
	@if runtest -version >/dev/null 2>&1; then :; \
	else echo "Please, install runtest (dejagnu)"; exit 1; fi

veri: runtest-exists
	@export status=0;\
	runtest --status --all --tool=bap-veri || status=1; \
	exit $$status

clean:
	rm -f *.log *.sum
