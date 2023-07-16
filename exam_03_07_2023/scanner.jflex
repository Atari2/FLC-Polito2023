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

ranged_number = (-1[02468])|(-[2468])|(\d[02468])|(1\d[02468])|(2[0-7][02468])|(28[0246])
excl = "!!!!" ("!!")*
question = "?????" ("???")*
date_fmt_1 = ((0[2-9]|[12]\d|3[01])\/07\/2023)|(0[1-6]\/10\/2023)|((0[1-9]|[12]\d|3[01])\/08\/2023)|((0[1-9]|[12]\d|30)\/09\/2023)
date_fmt_2 = (2023\/07\/(0[2-9]|[12]\d|3[01]))|(2023\/10\/0[1-6])|(2023\/08\/(0[1-9]|[12]\d|3[01]))|(2023\/09\/(0[1-9]|[12]\d|30))
s = ":" [0-5]\d ":" [0-5]\d
hhmmss = ( 0[8-9] {s} | 1\d {s} | 2[01] {s} |
        07 ":" [45]\d ":" [0-5]\d |
        07 ":" 3[89] ":" [0-5]\d |
        07 ":" 37 ":" 19 |
        22 ":" [0-2]\d ":" [0-5]\d |
        22 ":" 3[0-8] ":" [0-5]\d |
        22 ":" 39 ":" 2[0-3]
)
hhmm = ( 0[8-9] ":" [0-5]\d |
        1\d ":" [0-5]\d |
        2[0-1] ":" [0-5]\d |
        22 ":" [0-2]\d |
        22 ":" 3[0-8]
)
tok1 = ({excl}{ranged_number}|{question})";"
tok2 = ({date_fmt_1}|{date_fmt_2})";"
tok3 = ({hhmmss}|{hhmm})";"
sep = ("$$$")("$$")*
%%

{tok1}    { return sym(sym.TOK1, yytext()); }
{tok2}    { return sym(sym.TOK2, yytext()); }
{tok3}    { return sym(sym.TOK3, yytext()); }
"start"    { return sym(sym.START); }
"end"      { return sym(sym.END); }
"house"     { return sym(sym.HOUSE); }
"if"       { return sym(sym.IF); }
"fi"    { return sym(sym.FI); }
"then"   { return sym(sym.THEN); }
"print"   { return sym(sym.PRINT); }
"and"     { return sym(sym.AND); }
"or"      { return sym(sym.OR); }
"not"     { return sym(sym.NOT); }
{sep}       { return sym(sym.SEPARATOR); }
";"          { return sym(sym.SC); }
","         { return sym(sym.CM); }
"."        { return sym(sym.DOT); }
"("        { return sym(sym.RO); }
")"         { return sym(sym.RC); }
"=="       { return sym(sym.EQ); }
"<*" ~ "*>"    {;} // comment
\" ~ \"     { return sym(sym.STRING, yytext()); }
[1-9][0-9]*     { return sym(sym.NUMBER, new Integer(yytext())); }

\r | \n | \r\n | " " | \t	{;}

.				{ System.out.println("Scanner Error: " + yytext()); }
