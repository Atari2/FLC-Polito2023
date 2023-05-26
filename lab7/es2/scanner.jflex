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
id = [A-Za-z_][A-Za-z0-9_]*
integer =  ([1-9][0-9]*|0)

%%

"int"   {return symbol(sym.INT_TYPE);}
"double" {return symbol(sym.DOUBLE_TYPE);}
"char" {return symbol(sym.CHAR_TYPE);}
"float" {return symbol(sym.FLOAT_TYPE);}
"long" {return symbol(sym.LONG_TYPE);}
"*" {return symbol(sym.POINTER);}

"["     {return symbol(sym.SO);}
"]"     {return symbol(sym.SC);}

;       {return symbol(sym.S);}
,       {return symbol(sym.CM);}

{id}      {return symbol(sym.ID, yytext());}
{integer} {return symbol(sym.INT, new Integer(yytext()));}

"/*" ~ "*/"     {;}

{ws}|{nl}       {;}

. {System.out.println("SCANNER ERROR: "+yytext());}
