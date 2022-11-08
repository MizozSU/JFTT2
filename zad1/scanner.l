%{
#include <stdio.h>

int num_words  = 0;
int num_lines = 0;
int flag = 1;

%}

%%

^[ \t]+\r?\n				;
^\r?\n					;
^[ \t]+/.				;
[ \t]+/(\r?\n)				;
[ \t]+					;
[ \t]+/.				printf(" ");

[^ \t\r\n]+				num_words++; num_lines += flag; flag = 0; ECHO;
\r?\n					flag = 1; ECHO;


%%

int main()
{
	yylex();
	fprintf(stderr, "# of lines = %d, # of words = %d\n", num_lines, num_words);
}

