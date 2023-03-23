%%
%class CLexer

%{
  private static String inputfilename = "";
  private StringBuffer myHtml = new StringBuffer();
  private static class Yytoken {
    /* empty class to allow yylex() to compile */
  }
  public static void main(String argv[]) {
    if (argv.length == 0) {
      System.out.println("Usage : java CLexer <inputfile>");
    }
    else {
      int firstFilePos = 0;
      String encodingName = "UTF-8";
      for (int i = firstFilePos; i < argv.length; i++) {
        inputfilename = argv[i]; // LINE OF INTEREST
        CLexer scanner = null;
        try {
          java.io.FileInputStream stream = new java.io.FileInputStream(argv[i]);
          java.io.Reader reader = new java.io.InputStreamReader(stream, encodingName);
          scanner = new CLexer(reader);
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
%eof{
    String preHtml =  "<HTML><BODY bgcolor=\"#FFFFFF\"><H2>" + inputfilename + "</H2><CODE>";
    String postHtml = "</CODE></BODY></HTML>";
    int index = inputfilename.lastIndexOf(".");
    String htmlFilename = inputfilename.substring(0, index) + ".html";
    myHtml.insert(0, preHtml);
    myHtml.append(postHtml);
    try {
        var fw = new java.io.FileWriter(htmlFilename);
        fw.write(myHtml.toString());
        fw.close();
    } catch (java.io.IOException e) {
        System.out.println("Error writing to file " + htmlFilename);
    }
%eof}

nl		=  \n|\r|\r\n
ident = [a-zA-Z_][a-zA-Z_0-9]*
line_comment = \/\/[^\n]*
block_comment = \/\*.*\n?\*\/
preproc_directive = \#.*
number = [0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)?
whitespace = [ \t]+
string = \"([^\"\\]|\\.)*\"
%%
{line_comment}  {myHtml.append("<FONT COLOR=\"#C0C0C0\">" + yytext() + "</FONT>");}
{block_comment} {myHtml.append("<FONT COLOR=\"#C0C0C0\">" + yytext().replaceAll("<", "&lt;").replaceAll(">", "&gt;") + "</FONT>");}
"int"|"float"|"unsigned"|"char"|"void"           {myHtml.append("<FONT COLOR=\"#0000FF\">" + yytext() + "</FONT>");}
"if"|"else"|"while"|"for"|"return"|"break"|"continue"|"switch"|"case"|"default"|"do"|"goto" {myHtml.append("<FONT COLOR=\"#0000FF\">" + yytext() + "</FONT>");}
"sizeof"|"typedef"|"struct"|"union"|"enum"|"static"|"extern"|"const" {myHtml.append("<FONT COLOR=\"#0000FF\">" + yytext() + "</FONT>");}
"}"|"{"|[\[\]\(\)]             {myHtml.append(yytext());}
[-!;<>,\"=+*/%&|\^~?:]           {myHtml.append(yytext());}
{preproc_directive} {myHtml.append("<FONT COLOR=\"#00FF00\">" + yytext().replaceAll("<", "&lt;").replaceAll(">", "&gt;")  + "</FONT>");}
{number} {myHtml.append("<FONT COLOR=\"#FF0000\">" + yytext() + "</FONT>");}
{ident} {myHtml.append(yytext());}
{string} {myHtml.append("<FONT COLOR=\"#FF00FF\">" + yytext() + "</FONT>");}
{nl} {myHtml.append("<br>");}
{whitespace} {myHtml.append(yytext());}

.		{throw new java.io.IOException("Error: " + yytext());}