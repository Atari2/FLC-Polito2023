import java_cup.runtime.*;

%%

%class scanner
%unicode
%cup
%line
%column


%{
  private Symbol symbol(int type) {
    // System.out.println("SCANNER: "+yytext());
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    // System.out.println("SCANNER: "+type+" "+value);
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

nl = \r|\n|\r\n
ws = [ \t]
variable = [a-z]
vector_variable = [A-Z]
number = [0-9]+(\.[0-9]+)?([eE][-+]?[0-9]+)?
%%

{ws}|{nl}            {;}
"+"                {return symbol(sym.PLUS);}
"-"                {return symbol(sym.MINUS);}
"*"                {return symbol(sym.MULT);}
"/"                {return symbol(sym.DIV);}
"^"                {return symbol(sym.POW);}
"."                {return symbol(sym.DOT);}
"["                {return symbol(sym.LBRACK);}
"]"                {return symbol(sym.RBRACK);}
";"                {return symbol(sym.SEMICOLON);}
"?"               {return symbol(sym.QUESTION);}
"="                 {return symbol(sym.EQUALS);}
","                 {return symbol(sym.COMMA);}
{variable}         {return symbol(sym.VARIABLE, yytext());}
{vector_variable}  {return symbol(sym.VECTOR_VARIABLE, yytext());}
{number}           {return symbol(sym.NUMBER, new Double(yytext()));}

. {System.out.println("SCANNER ERROR: "+yytext());}
