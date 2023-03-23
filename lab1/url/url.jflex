
%%

%standalone
%class Url

nl		=  \n|\r|\r\n
hexDigit = [0-9a-fA-F]
number = [0-9]
esc = %{hexDigit}{2}
letter = ([a-zA-Z]|{esc})
scheme = {letter}+:
domainasname = "//"{letter}+\.({letter}+\.)*{letter}+
domainasip = "//"{number}{0,3}\.{number}{0,3}\.{number}{0,3}\.{number}{0,3}
filename = {letter}+(\.{letter}+)?
path = {letter}+
anchor = #({letter}|{number})+
port = :{number}+
url = {scheme}({domainasname}|{domainasip})({port})?("/"{path})*"/"({filename}({anchor}?))?
%%

{scheme} {System.out.println("Scheme: " + yytext());}
{domainasname} {System.out.println("Domain as name: " + yytext());}
{domainasip} {System.out.println("Domain as ip: " + yytext());}
{port} {System.out.println("Port: " + yytext());}
{anchor} {System.out.println("Anchor: " + yytext());}
{esc} {System.out.println("Escape sequence: " + yytext());}
{url}  {System.out.println("URL: " + yytext());}
{nl}    {;}

.		{System.out.println("Error: " + yytext());}