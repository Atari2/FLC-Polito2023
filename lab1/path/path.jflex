
%%

%standalone
%class Path

nl		=  \n|\r|\r\n
digit	=  [0-9]
letter = [^\/\\:*\?\"<>\|\n]
drive = {letter}
id = ({letter}|{digit})({letter}|{digit})*
pathName = {id}
fileName = {id}
fileType = {id}
drive = {letter}
path = ({drive}:)?(\\)?({pathName}\\)*{fileName}(.{fileType})?
%%

{path}      {System.out.println("PATH: " + yytext());}

{nl}        {;}

.		{System.out.println("Error: " + yytext());}