/**************************
 Scanner
***************************/

import java_cup.runtime.*;

%%

%unicode
%cup
%line
%column

%{
	private Symbol sym(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	
	private Symbol sym(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
	
%}

real_number = \d+(\.\d+)?([eE][+-]?\d+)?

word = [abc]{7}([abc][abc])*
he = [024568aAcCeE]
de = [123456789abcdefABCDEF]
num = ("-5" [02468aAcC] |
    "-" [4321] {he} |
    "-"? [2468aAcCeE] |
    "0" |
    {de}{he} |
    [123456789]{de}{he} |
    [aA](\d|[aA]){he} |
    [aA][bB][0246]
)
s = [0-5][0-9]
hour = ( 07 ":" 13 ":" ([01][0-9]|2[01234]) |
    07 ":" (0[0-9]|1[012]) ":" {s} |
    0[89] ":" {s} ":" {s} |
    1[012356] ":" {s} ":" {s} |
    17 ":" ([012][0-9]|3[0123456]) ":" {s} |
    17 ":" 37 ":" ([0123][0-9]|4[0123])
)
binnum = ( 101 | 110 | 111 |
    [01]{4} |
    10[01]{3} |
    11000 |
    11001 |
    11010 
)
tok1 = {word} "#" ({num})?
tok2 = {hour} ":" {binnum}
cident = [_a-zA-Z][_a-zA-Z0-9]*
%%

{tok1}        { return sym(sym.TOK1); }
{tok2}        { return sym(sym.TOK2); }
[1-9]\d*      { return sym(sym.NUM, new Integer(yytext())); }
"compare"     { return sym(sym.COMPARE); }
"with"        { return sym(sym.WITH); }
"end"         { return sym(sym.END); }
"print"       { return sym(sym.PRINT); }
{cident}      { return sym(sym.VAR, yytext()); }
"("           { return sym(sym.LP); }
")"           { return sym(sym.RP); }
"}"           { return sym(sym.RB); }
"{"           { return sym(sym.LB); }
"+"           { return sym(sym.PLUS); }
"-"           { return sym(sym.MINUS); }
"*"           { return sym(sym.MULT); }
"/"           { return sym(sym.DIV); }
"="           { return sym(sym.EQ); }
";"           { return sym(sym.SC); }
"$$"          { return sym(sym.SEPARATOR); }
"(++" ~ "++)" {;}
\r | \n | \r\n | " " | \t	{;}
.				{ System.out.println("Scanner Error: " + yytext()); }
