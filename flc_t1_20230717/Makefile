ifeq ($(OS),Windows_NT)
	rmcommand = powershell -Command Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
else
	rmcommand = rm -rf 
endif

default: scanner parser
	javac *.java

draw: scanner parser_draw
	javac *.java

scanner:
	jflex scanner.jflex
	
parser:
	java java_cup.Main -parser parser parser.cup

parser_draw:
	java java_cup.MainDrawTree -parser parser parser.cup
	
clean:
	$(rmcommand) parser.java
	$(rmcommand) scanner.java
	$(rmcommand) sym.java
	$(rmcommand) *.class
	$(rmcommand) *.*~
	
run:
	java Main 20230717_flc.txt

new: default run
