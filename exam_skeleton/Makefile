default: scanner parser
	javac *.java

scanner:
	jflex scanner.jflex
	
parser:
	java java_cup.Main -parser parser parser.cup
	
clean:
	rm -fr parser.java scanner.java sym.java
	rm -vfr *.class
	rm -vfr *.*~
	
run:
	java Main test.txt

new: default run
