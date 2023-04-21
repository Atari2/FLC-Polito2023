default: scanner parser
	javac *.java

draw: scanner parser_draw
	javac *.java

json: scanner parser_json
	javac *.java

scanner:
	jflex scanner.jflex

parser_draw:
	java java_cup.MainDrawTree -parser parser parser.cup

parser_json:
	java java_cup.MainOutputJson -parser parser parser.cup

parser:
	java java_cup.Main -parser parser parser.cup

clean:
	rm -fr parser.java scanner.java sym.java
	rm -vfr *.class
	rm -vfr *.*~

run:
	java Main example_library.txt

run_json: run
	CUPGraphLayout output.json