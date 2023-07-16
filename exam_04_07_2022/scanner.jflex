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
month30 = "September" | "November"
month31 = "August"  | "October" | "December"
date = ( 0[4-9]\/"July"\/2022 |
    (0[1-9]|[12][0-9]|30)\/{month30}\/2022 |
    (0[1-9]|[12][0-9]|3[01])\/{month31}\/2022 |
    0[1-9]\/"January"\/2023 |
    1[0-5]\/"January"\/2023
)
tok1 = "D-" {date} ("-" {date})?
word = ("XX"|"YY"|"ZZ"){4,15}
tok2 = "R-" {word} ( "????" ("??")* )? 
h = [0-9a-fA-F]
hex = ( 2[aAbBcCdDeEfF] |
    [3-9a-fA-F]{h} |
    [1-9aA]{h}{h} |
    [bB][0-9aAbB]{h} |
    [bB][cC][0-3]
)
tok3 = "N-" ({hex}[*\/+]{hex}[*\/+]{hex}[*\/+]{hex}[*\/+]{hex}) ([*\/+]{hex}[*\/+]{hex})*
cident = [a-zA-Z_][a-zA-Z0-9_]*
%%
{tok1}        { return sym(sym.TOK1); }
{tok2}        { return sym(sym.TOK2); }
{tok3}        { return sym(sym.TOK3); }
"TRUE"        { return sym(sym.TRUE); }
"FALSE"       { return sym(sym.FALSE); }
"IF"          { return sym(sym.IF); }
"FI"          { return sym(sym.FI); }
"OR"          { return sym(sym.ORWORD); }
"AND"         { return sym(sym.ANDWORD); }
"DO"          { return sym(sym.DO); }
"DONE"        { return sym(sym.DONE); }
"PRINT"       { return sym(sym.PRINT); }
"!"           { return sym(sym.NOT); }
"&"           { return sym(sym.AND); }
"|"           { return sym(sym.OR); }
"("           { return sym(sym.LP); }
")"           { return sym(sym.RP); }
";"           { return sym(sym.SC); }
"===="        { return sym(sym.SEPARATOR); }
"="           { return sym(sym.EQ); }
{cident}      { return sym(sym.VAR, yytext()); }
\" ~ \"       { return sym(sym.STRING, yytext()); }
"[[--" ~ "--]]" {;}
\r | \n | \r\n | " " | \t	{;}
.				{ System.out.println("Scanner Error: " + yytext()); }
