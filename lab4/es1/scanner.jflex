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
comment = "/*" .* "*/"
atom_string = [a-z]([a-zA-Z0-9_])*
atom_number = ([-+])?[0-9]+(\.[0-9]+)?([eE][-+]?[0-9]+)?
atom = {atom_string}|{atom_number}
variable = [A-Z_]([a-zA-Z0-9_])*
%%

{ws}|{nl}            {;}
"."             {return symbol(sym.DOT);}
","             {return symbol(sym.COMMA);}
":-"            {return symbol(sym.OWAL);}
"?-"            {return symbol(sym.QWAL);}
"("             {return symbol(sym.LPAR);}
")"             {return symbol(sym.RPAR);}
{atom}         {return symbol(sym.ATOM, yytext());}
{variable}     {return symbol(sym.VARIABLE, yytext());}

{comment}       {System.out.println("COMMENT: "+yytext()); }
. {System.out.println("SCANNER ERROR: "+yytext());}
