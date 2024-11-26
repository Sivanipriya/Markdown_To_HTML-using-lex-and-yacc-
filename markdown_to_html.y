%{                                                                                                                                                       
                                                                                                                                                         
#include <stdio.h>                                                                                                                                       
                                                                                                                                                         
#include <stdlib.h>                                                                                                                                      
                                                                                                                                                         
#include <string.h>                                                                                                                                      
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
void yyerror(const char *s);                                                                                                                             
                                                                                                                                                         
int yylex(void);                                                                                                                                         
                                                                                                                                                         
%}                                                                                                                                                       
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
%union {                                                                                                                                                 
                                                                                                                                                         
    char *str;                                                                                                                                           
                                                                                                                                                         
}                                                                                                                                                        
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
%token HASH EL AST LPAR RPAR LBR RBR NOT LCURL RCURL STYLE ESTYLE DASH                                                                                   
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
%token <str> ID NUM                                                                                                                                      
                                                                                                                                                         
%type <str> program statements statement header hindex bold anchor image para style_block style_content list list2 style_b                               
                                                                                                                                                         
%%                                                                                                                                                       
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
program: statements {                                                                                                                                    
                                                                                                                                                         
    printf("%s", $1);                                                                                                                                    
                                                                                                                                                         
}                                                                                                                                                        
                                                                                                                                                         
statements: statement EL statements {                                                                                                                    
                                                                                                                                                         
               $$ = (char *) malloc(strlen($1) + strlen($3) + 2);                                                                                        
                                                                                                                                                         
               sprintf($$, "%s\n%s", $1, $3);                                                                                                            
                                                                                                                                                         
           }                                                                                                                                             
                                                                                                                                                         
         | statement EL {                                                                                                                                
                                                                                                                                                         
               $$ = (char *) malloc(strlen($1) + 2);                                                                                                     
                                                                                                                                                         
               sprintf($$, "%s\n", $1);                                                                                                                  
                                                                                                                                                         
           }                                                                                                                                             
                                                                                                                                                         
         ;                                                                                                                                               
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
statement: header { $$ = $1; }                                                                                                                           
                                                                                                                                                         
         | bold { $$ = $1; }                                                                                                                             
                                                                                                                                                         
         | anchor { $$ = $1; }                                                                                                                           
                                                                                                                                                         
         | image { $$=$1; }                                                                                                                              
                                                                                                                                                         
         | para {$$=(char*)malloc(strlen($1)+20); sprintf($$,"<p>%s</p>",$1);}                                                                           
                                                                                                                                                         
         | style_b { $$=$1;}                                                                                                                             
                                                                                                                                                         
         | list { $$=$1;}                                                                                                                                
                                                                                                                                                         
         | list2 { $$=$1;}                                                                                                                               
                                                                                                                                                         
         ;                                                                                                                                               
                                                                                                                                                         

                                                                                                                                                         
style_b: STYLE style_block ESTYLE { $$ =(char*)malloc(strlen($2)+50); sprintf($$,"<style>%s</style>",$2); }  ;                                           
                                                                                                                                                         
style_block: ID ID LCURL style_content RCURL style_block {                                                                                               
                                                                                                                                                         
                $$ = (char *) malloc(strlen($2) + strlen($4)+strlen($6) + 18);  // Adjust memory allocation                                              
                                                                                                                                                         
                sprintf($$, ".%s {%s}\n%s", $2, $4, $6);  // Wrap style content                                                                          
                                                                                                                                                         
            }                                                                                                                                            
                                                                                                                                                         
            |                                                                                                                                            
                                                                                                                                                         
            HASH ID LCURL style_content RCURL style_block {  // Handle style block with hash ID                                                          
                                                                                                                                                         
                $$ = (char *) malloc(strlen($2) + strlen($4) +strlen($6)+ 20);                                                                           
                                                                                                                                                         
                sprintf($$, "#%s {%s}\n%s", $2, $4,$6);  // Wrap style content // Wrap style content with an id                                          
                                                                                                                                                         
            }                                                                                                                                            
                                                                                                                                                         
            | {$$=strdup("");}                                                                                                                           
                                                                                                                                                         

                                                                                                                                                         
            ;                                                                                                                                            
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
style_content: ID { $$ = $1; }                                                                                                                           
                                                                                                                                                         
            | ID style_content {                                                                                                                         
                                                                                                                                                         
                $$ = (char *) malloc(strlen($1) + strlen($2) + 2);                                                                                       
                                                                                                                                                         
                sprintf($$, "%s %s", $1, $2);                                                                                                            
                                                                                                                                                         
            }                                                                                                                                            
                                                                                                                                                         

                                                                                                                                                         
            ;                                                                                                                                            
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
header: hindex ID {                                                                                                                                      
                                                                                                                                                         
           $$ = (char *) malloc(strlen($2) + strlen($1) + 10);                                                                                           
                                                                                                                                                         
           sprintf($$, "<h%s>%s</h%s>", $1, $2, $1);                                                                                                     
                                                                                                                                                         
       }                                                                                                                                                 
                                                                                                                                                         
       | hindex ID LCURL HASH ID ID ID RCURL {                                                                                                           
                                                                                                                                                         
           $$ = (char *) malloc(strlen($2) + strlen($1)+strlen($5)+strlen($7)+30);                                                                       
                                                                                                                                                         
           sprintf($$, "<h%s id=\"%s\" class=\"%s\">%s</h%s>", $1,$5,$7,$2, $1);                                                                         
                                                                                                                                                         
       }                                                                                                                                                 
                                                                                                                                                         
        | hindex ID LCURL HASH ID RCURL {                                                                                                                
                                                                                                                                                         
           $$ = (char *) malloc(strlen($2) + strlen($1)+strlen($5)+30);                                                                                  
                                                                                                                                                         
           sprintf($$, "<h%s id=\"%s\" >%s</h%s>", $1,$5,$2, $1);                                                                                        
                                                                                                                                                         
       }                                                                                                                                                 
                                                                                                                                                         
       | hindex ID LCURL ID ID RCURL {                                                                                                                   
                                                                                                                                                         
           $$ = (char *) malloc(strlen($2) + strlen($1)+strlen($5)+30);                                                                                  
                                                                                                                                                         
           sprintf($$, "<h%s class=\"%s\">%s</h%s>", $1,$5,$2, $1);                                                                                      
                                                                                                                                                         
       }                                                                                                                                                 
                                                                                                                                                         
       ;                                                                                                                                                 
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
hindex: HASH hindex {                                                                                                                                    
                                                                                                                                                         
           $$ = (char *) malloc(3);                                                                                                                      
                                                                                                                                                         
           sprintf($$, "%d", atoi($2) + 1);                                                                                                              
                                                                                                                                                         
       }                                                                                                                                                 
                                                                                                                                                         
     | HASH {                                                                                                                                            
                                                                                                                                                         
           $$ = strdup("1");                                                                                                                             
                                                                                                                                                         
       }                                                                                                                                                 
                                                                                                                                                         
     ;                                                                                                                                                   
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
bold: AST AST ID AST AST {                                                                                                                               
                                                                                                                                                         
           $$ = (char *) malloc(strlen($3) + 20);                                                                                                        
                                                                                                                                                         
           sprintf($$, "<strong>%s</strong>", $3);                                                                                                       
                                                                                                                                                         
       }                                                                                                                                                 
                                                                                                                                                         
     ;                                                                                                                                                   
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
anchor:LBR ID RBR LPAR ID RPAR  {                                                                                                                        
                                                                                                                                                         
           $$ = (char *) malloc(strlen($2) + strlen($5) + 30);  // Increased memory allocation size for URL and text                                     
                                                                                                                                                         
           sprintf($$, "<a href=\"%s\">%s</a> ", $5, $2);  // Properly formatted <a> tag                                                                 
                                                                                                                                                         
       }                                                                                                                                                 
                                                                                                                                                         
           | LBR ID RBR LPAR ID RPAR LCURL HASH ID ID ID RCURL {                                                                                         
                                                                                                                                                         
           $$ = (char *) malloc(strlen($2) + strlen($5) + strlen($9)+ strlen($11)+ 30);  // Increased memory allocation size for URL and text            
                                                                                                                                                         
           sprintf($$, "<a href=\"%s\" id=\"%s\" class=\"%s\">%s</a> ", $5,$9,$11,$2);  // Properly formatted <a> tag                                    
                                                                                                                                                         
       }                                                                                                                                                 
                                                                                                                                                         
       |LBR ID RBR LPAR ID RPAR LCURL HASH ID RCURL {                                                                                                    
                                                                                                                                                         
           $$ = (char *) malloc(strlen($2) + strlen($5) + strlen($9)+ 30);  // Increased memory allocation size for URL and text                         
                                                                                                                                                         
           sprintf($$, "<a href=\"%s\"  id=\"%s\">%s</a> ", $5, $9,$2);  // Properly formatted <a> tag                                                   
                                                                                                                                                         
       }                                                                                                                                                 
                                                                                                                                                         
       |LBR ID RBR LPAR ID RPAR LCURL ID ID RCURL {                                                                                                      
                                                                                                                                                         
           $$ = (char *) malloc(strlen($2) + strlen($5) + strlen($9)+ 30);  // Increased memory allocation size for URL and text                         
                                                                                                                                                         
           sprintf($$, "<a href=\"%s\" class=\"%s\">%s</a>  ", $5, $9,$2);  // Properly formatted <a> tag                                                
                                                                                                                                                         
       }                                                                                                                                                 
                                                                                                                                                         
     ;                                                                                                                                                   
                                                                                                                                                         

                                                                                                                                                         
image: NOT LBR ID RBR LPAR ID RPAR  {                                                                                                                    
                                                                                                                                                         
        $$ = (char *) malloc(strlen($3) + strlen($6) + 30);  // Increased memory allocation size for URL and text                                        
                                                                                                                                                         
        sprintf($$, "<img src=\"%s\" alt=\"%s\" >", $6, $3);  // Properly formatted <a> tag                                                              
                                                                                                                                                         
    }                                                                                                                                                    
                                                                                                                                                         
        |NOT LBR ID RBR LPAR ID RPAR LCURL HASH ID ID ID RCURL {                                                                                         
                                                                                                                                                         
        $$ = (char *) malloc(strlen($3) + strlen($6) + strlen($10)+ strlen($12)+ 30);  // Increased memory allocation size for URL and text              
                                                                                                                                                         
        sprintf($$, "<img src=\"%s\" alt=\"%s\" id=\"%s\" class=\"%s\">", $6, $3,$10,$12);  // Properly formatted <a> tag                                
                                                                                                                                                         
    }                                                                                                                                                    
                                                                                                                                                         
    |NOT LBR ID RBR LPAR ID RPAR LCURL HASH ID RCURL {                                                                                                   
                                                                                                                                                         
        $$ = (char *) malloc(strlen($3) + strlen($6) + strlen($10)+ 30);  // Increased memory allocation size for URL and text                           
                                                                                                                                                         
        sprintf($$, "<img src=\"%s\" alt=\"%s\"  id=\"%s\">", $6, $3,$10);  // Properly formatted <a> tag                                                
                                                                                                                                                         
    }                                                                                                                                                    
                                                                                                                                                         
    |NOT LBR ID RBR LPAR ID RPAR LCURL ID ID RCURL {                                                                                                     
                                                                                                                                                         
        $$ = (char *) malloc(strlen($3) + strlen($6) + strlen($10)+ 30);  // Increased memory allocation size for URL and text                           
                                                                                                                                                         
        sprintf($$, "<img src=\"%s\" alt=\"%s\" class=\"%s\">", $6, $3,$10);  // Properly formatted <a> tag                                              
                                                                                                                                                         
    }                                                                                                                                                    
                                                                                                                                                         

                                                                                                                                                         
;                                                                                                                                                        
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
list: DASH ID list {                                                                                                                                     
                                                                                                                                                         
          $$ = (char *) malloc(strlen("<ul><li>") + strlen($2) + strlen("</li></ul>") + strlen($3) + 10);                                                
                                                                                                                                                         
          sprintf($$, "<ul><li>%s</li>%s</ul>", $2, $3);
                                                                                                                                                         
          free($2); free($3);                                                                                                                            
                                                                                                                                                         
      }                                                                                                                                                  
                                                                                                                                                         
    | DASH ID  {                                                                                                                                         
                                                                                                                                                         
          $$ = (char *) malloc(strlen("<ul><li>") + strlen($2) + strlen("</li></ul>") + 10);                                                             
                                                                                                                                                         
          sprintf($$, "<li>%s</li>", $2);                                                                                                                
                                                                                                                                                         
          free($2);                                                                                                                                      
                                                                                                                                                         
      }                                                                                                                                                  
                                                                                                                                                         
    ;                                                                                                                                                    
                                                                                                                                                         

                                                                                                                                                         
    list2: NUM ID list2 {                                                                                                                                
                                                                                                                                                         
          $$ = (char *) malloc(strlen("<ol><li>") + strlen($2) + strlen("</li></ol>") + strlen($3) + 10);                                                
                                                                                                                                                         
          sprintf($$, "<ol><li>%s</li>%s</ol>", $2, $3);                                                                                                 
                                                                                                                                                         
          free($2); free($3);                                                                                                                            
                                                                                                                                                         
      }                                                                                                                                                  
                                                                                                                                                         
    |NUM ID {                                                                                                                                            
                                                                                                                                                         
          $$ = (char *) malloc(strlen("<ol><li>") + strlen($2) + strlen("</li></ol>") + 10);                                                             
                                                                                                                                                         
          sprintf($$, "<li>%s</li>", $2);                                                                                                                
                                                                                                                                                         
          free($2);                                                                                                                                      
                                                                                                                                                         
      }                                                                                                                                                  
                                                                                                                                                         
    ;                                                                                                                                                    
                                                                                                                                                         
    para: ID para { $$=(char*) malloc(strlen($1)+strlen($2)+20); sprintf($$,"%s %s",$1,$2);}                                                             
                                                                                                                                                         
|ID { $$=(char*) malloc(strlen($1)+20); sprintf($$,"%s",$1);}                                                                                            
                                                                                                                                                         
;                                                                                                                                                        
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
%%                                                                                                                                                       
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
void yyerror(const char *s) {                                                                                                                            
                                                                                                                                                         
    fprintf(stderr, "Error: %s\n", s);                                                                                                                   
                                                                                                                                                         
}                                                                                                                                                        
                                                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
int main() {                                                                                                                                             
                                                                                                                                                         
    return yyparse();                                                                                                                                    
                                                                                                                                                         
}                 
