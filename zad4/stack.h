#ifndef STACK_H
#define STACK_H

#include <stdbool.h>

extern bool STACK_ANNOUNCE_ERRORS;

typedef struct stack_node
{
	int data;
	struct stack_node *next;
}stack_node;

typedef struct stack
{
	stack_node *top;
}stack;

stack *stack_create();
bool stack_empty(stack *s);
void stack_push(stack *s, int data);
int stack_pop(stack *s);
int stack_peek(stack *s);
void stack_print(stack *s);
void stack_destroy(stack **s_p);


#endif