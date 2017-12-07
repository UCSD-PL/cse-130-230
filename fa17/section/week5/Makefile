all:
	ocamlyacc parser.mly
	ocamllex lexer.mll
	ocamlc syntax.ml parser.mli parser.ml lexer.ml prec.ml -o prec

clean:
	rm -f *.cmo *.cmi *.mli *.out lexer.ml parser.ml
