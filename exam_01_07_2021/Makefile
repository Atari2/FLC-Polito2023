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
	java java_cup.Main -parser parser parser.cup

parser_json:
	java java_cup.MainOutputJson -parser parser parser.cup
	
clean:
	rm -fr parser.java scanner.java sym.java
	rm -vfr *.class
	rm -vfr *.*~
	
run:
	java Main test.txt

new: default run

run_json: run
	$(GraphCommand)