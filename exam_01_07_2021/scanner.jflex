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

hm = [0-5][0-9]
hour = ( 03 ":" 51 ":" (4[7-9]|5[0-9]) |
    03 ":" 5[2-9] ":" {hm} |
    (0[4-9]|1[0-9]|2[0-2]) ":" {hm} ":" {hm} |
    23 ":" [0-3][0-9] ":" {hm} |
    23 ":" 4[0-4] ":" {hm} |
    23 ":" 45 ":" ([0-2][0-9]|3[0-4])
)
bin = ( 101 | 110 | 111 |
    [01]{4,6} |
    100[01]{4} |
    101000[01]
)
word = ("aa"|"ab"|"ba"|"bb")
tok1 = "X-" {hour} ( {word}{5}({word}{word})* )?
// "Y-" (({bin}"-"){3}|({bin}"-"){122}|({bin}"-"){256}) {bin}
tok2 = "Y-" (({bin}"-"){3}) {bin}
real = [0-9]+"."[0-9]{2}
integer = [1-9][0-9]*
%%
{tok1}      { return sym(sym.TOK1); }
{tok2}      { return sym(sym.TOK2); }
"{"          { return sym(sym.LB); }
"}"          { return sym(sym.RB); }
","          { return sym(sym.CM); }
":"          { return sym(sym.COL); }
{real}        { return sym(sym.REAL, new Double(yytext())); }
{integer}     { return sym(sym.INTEGER, new Integer(yytext())); }
"euro/kg"     { return sym(sym.EURO_KG); }
"euro"       { return sym(sym.EURO); }
"kg"         { return sym(sym.KG); }
\" ~ \"      { return sym(sym.STRING, yytext()); }
";"           { return sym(sym.SC); }
"####"          { return sym(sym.SEPARATOR); }
"(*" ~ "*)" {;}
\r | \n | \r\n | " " | \t	{;}
.				{ System.out.println("Scanner Error: " + yytext()); }
