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
alpha = [a-zA-Z]
hexdigit = [0-9a-fA-F]
string = \"{alpha}({alpha}|{ws}|,|\.)*\"
isbn_code = \d{2}-\d{2}-{hexdigit}{5}-(\d|\w)
collocation = (LI|LS){ws}*(AV|BO|SO){ws}*\d+{ws}*{alpha}?
date = \d{2}\/\d{2}\/\d{4}
number = \d+
divider = "%%"
%%

{ws}|{nl}       {;}
{string}        {return symbol(sym.STRING, yytext());}
":"             {return symbol(sym.CL);}  
";"             {return symbol(sym.S);}
","             {return symbol(sym.CM);}
"->"            {return symbol(sym.ARROW);}
{isbn_code}     {return symbol(sym.ISBN, yytext());}
{collocation}   {return symbol(sym.COLLOCATION, yytext());}
{number}        {return symbol(sym.NUMBER, yytext());}
{divider}       {return symbol(sym.DIVIDER);}
{date}          {return symbol(sym.DATE, yytext());}
. {System.out.println("SCANNER ERROR: "+yytext());}
