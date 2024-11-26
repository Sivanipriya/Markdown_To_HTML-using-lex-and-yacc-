%option noyywrap                                                                                                                                         
                                                                                                                                                         
%{                                                                                                                                                       
                                                                                                                                                         
#include "y.tab.h"                                                                                                                                       
                                                                                                                                                         
#include <stdio.h>                                                                                                                                       
                                                                                                                                                         
#include <stdlib.h>                                                                                                                                      
                                                                                                                                                         
#include <string.h>                                                                                                                                      
                                                                                                                                                         
%}                                                                                                                                                       
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
%%                                                                                                                                                       
                                                                                                                                                         
"1." { yylval.str = strdup(yytext);  return NUM;}                                                                                                        
                                                                                                                                                         
[a-zA-Z0-9.:\/;]+ {                                                                                                                                      
                                                                                                                                                         
    yylval.str = strdup(yytext);                                                                                                                         
                                                                                                                                                         
    return ID;                                                                                                                                           
                                                                                                                                                         
}                                                                                                                                                        
                                                                                                                                                         
"-"              { return DASH; }                                                                                                                        
                                                                                                                                                         
"#" { return HASH; }                                                                                                                                     
                                                                                                                                                         
"*" { return AST; }                                                                                                                                      
                                                                                                                                                         
"[" { return LBR;}                                                                                                                                       
                                                                                                                                                         
"]" { return RBR;}                                                                                                                                       
                                                                                                                                                         
"(" { return LPAR;}                                                                                                                                      
                                                                                                                                                         
")" { return RPAR;}                                                                                                                                      
                                                                                                                                                         
"{" { return LCURL;}                                                                                                                                     
                                                                                                                                                         
"}" { return RCURL;}                                                                                                                                     
                                                                                                                                                         
"!" { return NOT;}                                                                                                                                       
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
"<style>" { return STYLE;}                                                                                                                               
                                                                                                                                                         
"</style>" { return ESTYLE;}                                                                                                                             
                                                                                                                                                         
"\n" { return EL; }                                                                                                                                      
                                                                                                                                                         
[ \t]+   ;    /* Ignore whitespace */                                                                                                                    
                                                                                                                                                         
.        { return yytext[0]; }                                                                                                                           
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
%%                         
