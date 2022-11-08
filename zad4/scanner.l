%{
#include "stack.h"
#include <limits.h>
#include <stdio.h>
#include <tgmath.h>

stack *stk;

void error_args() {
	printf("Error: too few arguments...\n");
        stack_destroy(&stk);
        stk = stack_create();
}

void error_operators() {
	printf("Error: too few operators...\n");
	stack_destroy(&stk);
	stk = stack_create();
}

void error_unexpected_char(const char *c) {
	printf("Error: unexpected char <%s>...\n", c); 
	stack_destroy(&stk);
	stk = stack_create();
}

void error_div_zero() {
	printf("Error: division by 0...\n");
	stack_destroy(&stk);
	stk = stack_create();
}

%}

%x ERROR_LINE_RESET

%%

<ERROR_LINE_RESET>.*\r?\n			BEGIN(INITIAL);

[-]?[0-9]+					stack_push(stk, atoi(yytext));

"+"						{
						bool error_flag = false;
						error_flag |= stack_empty(stk);
						int a = stack_pop(stk);
						error_flag |= stack_empty(stk);
						int b = stack_pop(stk);
						if(error_flag) {
							error_args();
							BEGIN(ERROR_LINE_RESET);
						} else {
							stack_push(stk, b + a);
						}
						}

"-"						{
						bool error_flag = false;
						error_flag |= stack_empty(stk);
						int a = stack_pop(stk);
						error_flag |= stack_empty(stk);
						int b = stack_pop(stk);
						if(error_flag) {
							error_args();
                                                        BEGIN(ERROR_LINE_RESET);
                                                } else {
                                                        stack_push(stk, b - a);
                                                }
						}

"*"						{
						bool error_flag = false;
						error_flag |= stack_empty(stk);
						int a = stack_pop(stk);
						error_flag |= stack_empty(stk);
						int b = stack_pop(stk);
						if(error_flag) {
							error_args();
                                                        BEGIN(ERROR_LINE_RESET);
                                                } else {
                                                        stack_push(stk, b * a);
                                                }
						}

"/"						{
						bool error_flag = false;
						error_flag |= stack_empty(stk);
						int a = stack_pop(stk);
						error_flag |= stack_empty(stk);
						int b = stack_pop(stk);
						if(error_flag) {
							error_args();
                                                        BEGIN(ERROR_LINE_RESET);
                                                } else {
							if(a == 0) {
								error_div_zero();
								BEGIN(ERROR_LINE_RESET);
							} else {
                                                        	stack_push(stk, b / a);
							}
                                                }
						}

"%"						{
						bool error_flag = false;
						error_flag |= stack_empty(stk);
						int a = stack_pop(stk);
						error_flag |= stack_empty(stk);
						int b = stack_pop(stk);
						if(error_flag) {
							error_args();
                                                        BEGIN(ERROR_LINE_RESET);
                                                } else {
							if(a == 0) {
								error_div_zero();
								BEGIN(ERROR_LINE_RESET);
							} else {
                                                        	stack_push(stk, b % a);
							}
                                                }
						}

"^"						{
						bool error_flag = false;
						error_flag |= stack_empty(stk);
						int a = stack_pop(stk);
						error_flag |= stack_empty(stk);
						int b = stack_pop(stk);
						if(error_flag) {
							error_args();
                                                        BEGIN(ERROR_LINE_RESET);
                                                } else {
                                                        stack_push(stk, (int) powl(b, a));
                                                }
						}

\r?\n						{
						if(stack_empty(stk)) {
							error_args();
						} else {
							int a = stack_pop(stk);
							if(stack_empty(stk)) {
								printf("%d\n", a);
							} else {
								error_operators();
							}
						}
						}

[ \t]+						;

.						{
						error_unexpected_char(yytext);
						BEGIN(ERROR_LINE_RESET);
						}

%%

int main() {
	STACK_ANNOUNCE_ERRORS = false;
	stk = stack_create();
	yylex();
	stack_destroy(&stk);
	return 0;
}
