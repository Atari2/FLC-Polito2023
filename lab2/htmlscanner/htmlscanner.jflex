import java.util.HashMap;
%%
%class HTMLScanner
%caseless

%{
  private static int total_tags = 0;
  private static HashMap<String, Integer> tag_quantities = new HashMap<String, Integer>();
  private static int current_tag = -1;
  enum State { TEXT, TAG, COMMENT };
  private static State state = State.TEXT;
  private static String inputfilename = "";
  private static class Yytoken {
    /* empty class to allow yylex() to compile */
  }
  private void PrintTok() {
    if (state != State.COMMENT) {
        System.out.print(yytext());
    }
  }
  private Boolean CountTag() throws java.io.IOException {
    if (state == State.TAG) tag_quantities.merge(yytext().toLowerCase(), 1, Integer::sum);
    else { return false; }
    return true;
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
        HTMLScanner scanner = null;
        try {
          java.io.FileInputStream stream = new java.io.FileInputStream(argv[i]);
          java.io.Reader reader = new java.io.InputStreamReader(stream, encodingName);
          scanner = new HTMLScanner(reader);
          while ( !scanner.zzAtEOF ) scanner.yylex();
          System.out.println("\nTotal number of tags: " + total_tags);
          System.out.println("Total number of table tags: " + tag_quantities.getOrDefault("table", 0));
          System.out.println("Total number of h1 tags: " + tag_quantities.getOrDefault("h1", 0));
          System.out.println("Total number of h2 tags: " + tag_quantities.getOrDefault("h2", 0));
          System.out.println("Total number of h3 tags: " + tag_quantities.getOrDefault("h3", 0));
          System.out.println("Total number of h4 tags: " + tag_quantities.getOrDefault("h4", 0));
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
whitespace = [ \t]+
string = \"([^\"\\]|\\.)*\"
number = [0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)?
%%
"<!--" {state = State.COMMENT;}
"-->" {state = State.TEXT; }
"<" {if (state != State.COMMENT) { total_tags++; state = State.TAG; System.out.print(yytext()); }}
"</" {if (state != State.COMMENT) { total_tags++; state = State.TAG; System.out.print(yytext()); }}
">" {if (state != State.COMMENT) { state = State.TEXT; System.out.print(yytext()); }}
"head"|"body"|"html"|"title"|"table"|"h1"|"h2"|"h3"|"h4" { if (CountTag()) { System.out.print(yytext()); } }
"=" {PrintTok();}
"&"[a-zA-Z_0-9]+";" {PrintTok();}
{string} {PrintTok();}
{number} {PrintTok();}
{ident} {PrintTok();}
{nl} {PrintTok();}
{whitespace} {PrintTok();}

.		{if (state != State.COMMENT) { throw new java.io.IOException("Error: " + yytext()); } }