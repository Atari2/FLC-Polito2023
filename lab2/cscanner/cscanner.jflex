%%
%class CScanner

%{
  private static String inputfilename = "";
  private static class Yytoken {
    /* empty class to allow yylex() to compile */
  }
  public static void main(String argv[]) {
    if (argv.length == 0) {
      System.out.println("Usage : java CScanner <inputfile>");
    }
    else {
      int firstFilePos = 0;
      String encodingName = "UTF-8";
      for (int i = firstFilePos; i < argv.length; i++) {
        inputfilename = argv[i]; // LINE OF INTEREST
        CScanner scanner = null;
        try {
          java.io.FileInputStream stream = new java.io.FileInputStream(argv[i]);
          java.io.Reader reader = new java.io.InputStreamReader(stream, encodingName);
          scanner = new CScanner(reader);
          while ( !scanner.zzAtEOF ) scanner.yylex();
        }
        catch (java.io.FileNotFoundException e) {
          System.out.println("File not found : \""+argv[i]+"\"");
        }
        catch (java.io.IOException e) {
          System.out.println("IO error scanning file \""+argv[i]+"\"");
          System.out.println(e);
        }
        catch (Exception e) {
          System.out.println("Unexpected exception:");
          e.printStackTrace();
        }
      }
    }
  }
%}

nl		=  \n|\r|\r\n
ident = [a-zA-Z_][a-zA-Z_0-9]*
block_comment = \/\*.*\n?\*\/
include_directive = \#include\s+[<\"].*[>\"]
integer = [0-9]+
floating_point = [0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)?
whitespace = [ \t]+
%%
{block_comment} {;}
"int"|"double" {System.out.print(yytext().toUpperCase() + "_TYPE ");}
"if"|"else"|"while"|"print" {System.out.print(yytext().toUpperCase() + " ");}
{include_directive} {;}
{integer} {System.out.print("INT:" + yytext().toUpperCase() + " ");}
{floating_point} {System.out.print("DOUBLE:" + yytext().toUpperCase() + " ");}

"[" {System.out.print("SO ");}
"]" {System.out.print("SC ");}
"{" {System.out.print("BO ");}
"}" {System.out.print("BC ");}
"(" {System.out.print("RO ");}
")" {System.out.print("RC ");}
"+" {System.out.print("PLUS ");}
"-" {System.out.print("MINUS ");}
"*" {System.out.print("MULT ");}
"/" {System.out.print("DIV ");}
"=" {System.out.print("EQ ");}
";" {System.out.print("S ");}
"." {System.out.print("DOT ");}
"," {System.out.print("COMMA ");}
"<" {System.out.print("MIN ");}
">" {System.out.print("MAJ ");}
"&" {System.out.print("AND ");}
"|" {System.out.print("OR ");}
"!" {System.out.print("NOT ");}

{ident} {System.out.print("ID:" + yytext() + " ");}
{nl} {;}
{whitespace} {;}

.		{throw new java.io.IOException("Error: " + yytext());}