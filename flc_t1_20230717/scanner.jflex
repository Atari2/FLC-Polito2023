import java_cup.runtime.*;

%%

%class scanner
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

nl = \r|\n|\r\n
ws = [ \t]
integer =  ([1-9][0-9]*|0)
float = [-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?
h = [0-9a-fA-F]
alpha = [a-zA-Z]
hex = ( 27[a-fA-F] |
  2[8-9a-fA-F]{h} |
  1[01]{h}{h} |
  12[0-9aA]{h} |
  12b[0-3]
)
ipnum = ( 0 |
  [0-9] |
  [1-9][0-9] |
  1[0-9][0-9] |
  25[0-5]
)
tok1 = {hex}"*"( {alpha}{5} ({alpha}{alpha})* )"-" ( "****" ("**")* | "Y" ("X" ("XX")*) "Y")?
ipaddr = {ipnum}"."{ipnum}"."{ipnum}"."{ipnum}
// 05/10/2023 to 03/03/2024
date = ( 0[5-9]"/10/2023" |
  ([12][0-9]|3[01])"/10/2023" |
  (0[1-9]|[12][0-9]|30)"/11/2023" |
  (0[1-9]|[12][0-9]|3[01])"/12/2023" |
  (0[1-9]|[12][0-9]|3[01])"/01/2024" |
  (0[1-9]|[12][0-9])"/02/2024" |
  0[1-3]"/03/2024"
)
tok2 = {ipaddr}"-"{date}
tok3num = ([0-9]{4}|[0-9]{6})
tok3 = ({tok3num}[-+]{tok3num}[-+]{tok3num})([-+]{tok3num}[-+]{tok3num})?
%%

/* "string or {name}  { action }" */
{tok1}  { return sym(sym.TOK1); }
{tok2}  { return sym(sym.TOK2); }
{tok3}  { return sym(sym.TOK3); }
";"     { return sym(sym.SC); }
"***"   { return sym(sym.SEPARATOR); }
"%"     { return sym(sym.PERC); }
"-"     { return sym(sym.MINUS); }
","     { return sym(sym.COMMA); }
{integer} { return sym(sym.INTEGER, new Integer(yytext())); }
{float} { return sym(sym.REAL, new Double(yytext())); }
"euro"  { return sym(sym.EURO); }
\" ~ \"  { return sym(sym.STRING, yytext()); }
"//" ~ {nl} {;}
"{{" ~ "}}" {;}
{ws}|{nl}       {;}

. {System.out.println("SCANNER ERROR: "+yytext());}
