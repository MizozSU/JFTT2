%s CODE
%s STRING_A
%s STRING_B
%s STRING_C
%s STRING_D

%%


<INITIAL>^#![^\r\n]*\r?\n?					ECHO; BEGIN(CODE);

<INITIAL,CODE>\"						ECHO; BEGIN(STRING_A);
<INITIAL,CODE>\'						ECHO; BEGIN(STRING_B);
<INITIAL,CODE>\"\"\"						ECHO; BEGIN(STRING_C);
<INITIAL,CODE>\'\'\'						ECHO; BEGIN(STRING_D);
<INITIAL,CODE>[ \t]*#.*\r?\n?					;

<STRING_A>\"							ECHO; BEGIN(CODE);
<STRING_B>\'							ECHO; BEGIN(CODE);
<STRING_C>\"\"\"						ECHO; BEGIN(CODE);
<STRING_D>\'\'\'						ECHO; BEGIN(CODE);

<INITIAL>.							ECHO; BEGIN(CODE);

%%

int main() {
	yylex();
}
