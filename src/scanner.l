%{
/* This %{ ... %} section is code that is glued into the generated scanner. */
#include "parser.h"
#define YYDEBUG 1
extern int outputStage; // This variable is located in vslc.c
    #define RETURN(t) do {                                             \
        if ( outputStage == 1 )                                        \
            fprintf ( stderr, "TOKEN ( %d,\t'%s' )\n", t, yytext );    \
        return t;                                                      \
    } while ( 0 )
%}

%option array
%option noyywrap
%option yylineno

DIGIT [0-9]
LETTER [a-zA-Z_]
WHITESPACE [\ \t\n]

%%

    /* Stuff */
{WHITESPACE}+ {}
\/\/.*\n {}
{DIGIT}+ { RETURN(INT_CONST); }
\"([^\n\"]|\\\")*\" { RETURN(STRING_CONST); }
{DIGIT}+\.{DIGIT}+  { RETURN(FLOAT_CONST); }

    /* Bools */
"TRUE"      { RETURN(TRUE_CONST); }
"FALSE"     { RETURN(FALSE_CONST); }

    /* Punctuation */
"("         { RETURN('('); }
")"         { RETURN(')'); }
";"         { RETURN(';'); }
","         { RETURN(','); }

    /* Here there be reserved keywords */
"FUNC"      { RETURN(FUNC); }
"PRINT"     { RETURN(PRINT); }
"RETURN"    { RETURN(RETURN); }
"IF"        { RETURN(IF); }
"THEN"      { RETURN(THEN); }

"ELSE"      { RETURN(ELSE); }
"END"       { RETURN(END); }
"WHILE"     { RETURN(WHILE); }
"DO"        { RETURN(DO); }
"INT"       { RETURN(INT); }
"BOOL"      { RETURN(BOOL); }
"FLOAT"     { RETURN(FLOAT); }
"CLASS"     { RETURN(_CLASS_); }
"HAS"       { RETURN(HAS); }
"WITH"      { RETURN(WITH); }
"START"     { RETURN(START); }

"VOID"		{ RETURN(VOID); }
"THIS"      { RETURN(THIS); }
"NEW"       { RETURN(NEW); }

    /* Here be operators */
":="        { RETURN(ASSIGN); }
"+"			{ RETURN('+'); }
"-"			{ RETURN('-'); }
"*"			{ RETURN('*'); }
"/"			{ RETURN('/'); }
">"         { RETURN('>'); }
"<"         { RETURN('<'); }
"<="        { RETURN(LEQUAL); }
">="        { RETURN(GEQUAL); }
"=="        { RETURN(EQUAL); }
"!="        { RETURN(NEQUAL); }
"||"        { RETURN(OR); }
"&&"        { RETURN(AND); }
"!"         { RETURN('!'); }
"."         { RETURN('.'); }

    /* Identifiers */
{LETTER}{1}({LETTER}|{DIGIT})* { RETURN(IDENTIFIER); }

%%
