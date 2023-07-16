import java_cup.runtime.*;

%%

%class scanner
%unicode
%cup
%line
%column


%{
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

nl = \r|\n|\r\n
ws = [ \t]
integer =  ([1-9][0-9]*|0)
float = [-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?
%%

/* "string or {name}  { action }" */

{ws}|{nl}       {;}

. {System.out.println("SCANNER ERROR: "+yytext());}
