.PHONY: all lib coq install

all: frap_book.pdf coq

frap_book.pdf: frap_book.tex Makefile
	pdflatex frap_book
	pdflatex frap_book
	makeindex frap_book
	pdflatex frap_book
	pdflatex frap_book

coq: Makefile.coq
	$(MAKE) -f Makefile.coq

lib: Makefile.coq
	$(MAKE) -f Makefile.coq Sets.vo Map.vo Relations.vo Var.vo Invariant.vo\
		ModelCheck.vo FrapWithoutSets.vo Frap.vo Imp.vo AbstractInterpret.vo\
		SepCancel.vo BasicSyntax.vo Polymorphism.vo DataAbstraction.vo\
		Interpreters.vo FirstClassFunctions.vo RuleInduction.vo\
		TransitionSystems.vo ModelChecking.vo OperationalSemantics.vo\
		AbstractInterpretation.vo CompilerCorrectness.vo\
		LambdaCalculusAndTypeSoundness.vo HoareLogic.vo SeparationLogic.vo

Makefile.coq: Makefile _CoqProject *.v
	coq_makefile -f _CoqProject -o Makefile.coq

clean:: Makefile.coq
	$(MAKE) -f Makefile.coq clean
	rm -f Makefile.coq

frap.tgz: Makefile _CoqProject *.v *.tex *.html
	git archive --format=tar.gz HEAD >frap.tgz

fraplib.tgz: Makefile
	rm -rf fraplib
	mkdir fraplib
	cp LICENSE fraplib/
	cp Makefile.fraplib fraplib/Makefile
	cp _CoqProject.fraplib fraplib/_CoqProject
	cp Relations.v fraplib/
	cp Map.v fraplib/
	cp Var.v fraplib/
	cp Invariant.v fraplib/
	cp ModelCheck.v fraplib/
	cp FrapWithoutSets.v fraplib/
	cp Sets.v fraplib/
	cp Frap.v fraplib/
	cp Imp.v fraplib/
	cp AbstractInterpret.v fraplib/
	cp SepCancel.v fraplib/
	tar cf fraplib.tgz fraplib/*

WHERE=chlipala.net:sites/chlipala/adam/frap/

install: index.html frap_book.pdf frap.tgz fraplib.tgz
	rsync frap_book.pdf $(WHERE)
	rsync frap.tgz $(WHERE)
	rsync fraplib.tgz $(WHERE)
	rsync index.html $(WHERE)
