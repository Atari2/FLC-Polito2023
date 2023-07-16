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

tok1_alt1 = "A_" ((\+\*?)+|(\*\+?)+)?
tok1_alt2 = "A_" 1*01*01*( 01*01*01* )?
word = ("-3"[02] | "-"[12][02468] | "-"?[2468] | 0 | \d{1,2}[02468] | 1[01]\d[02468] | 12[0-3][02468] | 124[0246] )
tok1 = {tok1_alt1} | {tok1_alt2}
tok2 = "B_" ({word}[*$+]{word}[*$+]{word}[*$+]{word})([*$+]{word}[*$+]{word})*
real_number = \d+(\.\d+)?([eE][+-]?\d+)?

%%
{tok1}     { return sym(sym.TOK1); }
{tok2}     { return sym(sym.TOK2); }
{real_number} { return sym(sym.NUMBER, new Double(yytext())); }
"START"   { return sym(sym.START); }
"-"       { return sym(sym.MINUS); }
"BATTERY"  { return sym(sym.BATTERY); }
"kWh"    { return sym(sym.KWH); }
"FUEL"   { return sym(sym.FUEL); }
"liters"  { return sym(sym.LITERS); }
"PLUS"   { return sym(sym.PLUS); }
"STAR"   { return sym(sym.STAR); }
"MAX"    { return sym(sym.MAX); }
"MOD"    { return sym(sym.MOD); }
"USE"    { return sym(sym.USE); }
"DO"      { return sym(sym.DO); }
"DONE"   { return sym(sym.DONE); }
"units/km" { return sym(sym.UNITS_PER_KM); }
"km"    { return sym(sym.KM); }
"("      { return sym(sym.LPAREN); }
")"      { return sym(sym.RPAREN); }
("%%%%") ("%%")*     { return sym(sym.SEPARATOR); }
";"         { return sym(sym.SC); }
","        { return sym(sym.COMMA); }
"(((-" ~ "-)))" {;}
"---" ~ \n     {;} 
\r | \n | \r\n | " " | \t	{;}
.				{ System.out.println("Scanner Error: " + yytext()); }
