ifeq ($(OS),Windows_NT)
	GraphCommand = CUPGraphLayout output.json
else
	GraphCommand = CUPGraphLayout -Kdot -Tsvg -o output.svg output.json
endif

default: scanner parser

	javac *.java

json: scanner parser_json
	javac *.java

scanner:
	jflex scanner.jflex
	
parser:
	java java_cup.Main -expect 2 -parser parser parser.cup

parser_json:
	java java_cup.MainOutputJson -expect 2 -parser parser parser.cup
	
clean:

	rm -fr parser.java scanner.java sym.java
	rm -vfr *.class
	rm -vfr *.*~
	
init:
	mkdir source build
	
run:
	java Main bubble.c

new: default run

run_json: run
	$(GraphCommand)