TOOLS = bap mc

check: runtest-exists revision-updated
	@export status=0;\
	for tool in $(TOOLS); do runtest --status --all --tool=$$tool || status=1; done;\
	exit $$status

veri: runtest-exists revision-updated
	if [ -d .git ]; then git submodule init; git submodule update; 	fi
	@export status=0;\
	runtest --status --all --tool=veri || status=1; \
	exit $$status

clean:
	rm -f *.log *.sum

runtest-exists:
	@if runtest -version >/dev/null 2>&1; then :; \
	else echo "Please, install runtest (dejagnu)"; exit 1; fi

revision-updated:
ifdef REVISION
	git checkout ${REVISION}
endif
