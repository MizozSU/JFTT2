%{
#include <stdbool.h>

bool docs_enabled = 1;

%}

%x INCLUDE_1
%x INCLUDE_2
%x STRING

/* /*** Java Style Doc String */
%x COMMENT_1

/* /// .NET Style Doc String */
%x COMMENT_2

/* // Comment */
%x COMMENT_3

/* /* Multi-Line Comment */
%x COMMENT_4

/* //! Comment */
%x COMMENT_5

/* /*! Comment */
%x COMMENT_6

%%

^#include[ ]?<					ECHO; BEGIN(INCLUDE_1);
^#include[ ]?\"					ECHO; BEGIN(INCLUDE_2);
<INCLUDE_1>>					ECHO; BEGIN(INITIAL);
<INCLUDE_2>\"					ECHO; BEGIN(INITIAL);

\"						ECHO; BEGIN(STRING);
<STRING>\\\r?\n					ECHO;
<STRING>\r?\n					ECHO; BEGIN(INITIAL);
<STRING>\"					ECHO; BEGIN(INITIAL);

\/(\\\r?\n)?[*](\\\r?\n)?[*]			if(docs_enabled) ECHO; BEGIN(COMMENT_1);
<COMMENT_1>[*](\\\r?\n)?\/			if(docs_enabled) ECHO; BEGIN(INITIAL);
<COMMENT_1>.					if(docs_enabled) ECHO;

\/(\\\r?\n)?\/(\\\r?\n)?\/			if(docs_enabled) ECHO; BEGIN(COMMENT_2);
<COMMENT_2>\\\r?\n				if(docs_enabled) ECHO;
<COMMENT_2>\r?\n				if(docs_enabled) ECHO; BEGIN(INITIAL);
<COMMENT_2>.					if(docs_enabled) ECHO;

\/(\\\r?\n)?\/					BEGIN(COMMENT_3);
<COMMENT_3>\\\r?\n				;
<COMMENT_3>\r?\n				BEGIN(INITIAL);
<COMMENT_3>.					;

\/(\\\r?\n)?[*]					BEGIN(COMMENT_4);
<COMMENT_4>[*](\\\r?\n)?\/			BEGIN(INITIAL);
<COMMENT_4>.					;

\/(\\\r?\n)?\/(\\\r?\n)?!			if(docs_enabled) ECHO; BEGIN(COMMENT_5);
<COMMENT_5>\\\r?\n				if(docs_enabled) ECHO;
<COMMENT_5>\r?\n				if(docs_enabled) ECHO; BEGIN(INITIAL);
<COMMENT_5>.					if(docs_enabled) ECHO;

\/(\\\r?\n)?[*](\\\r?\n)?!			if(docs_enabled) ECHO; BEGIN(COMMENT_6);
<COMMENT_6>[*](\\\r?\n)?\/			if(docs_enabled) ECHO; BEGIN(INITIAL);
<COMMENT_6>.					if(docs_enabled) ECHO;

%%

int main() {
	yylex();
	return 0;
}
