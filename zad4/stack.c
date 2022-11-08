#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>
#include <stdio.h>
#include "stack.h"

bool STACK_ANNOUNCE_ERRORS = true;

stack *stack_create()
{
    stack *s = (stack *)malloc(sizeof(stack));
    if(s == NULL) {
        if(STACK_ANNOUNCE_ERRORS) {
			printf("Error: malloc failed in stack_create\n");
		}
        return NULL;
    }
    s->top = NULL;
    return s;
}

bool stack_empty(stack *s)
{
	if (s->top == NULL)
		return true;
	else
		return false;
}

void stack_push(stack *s, int data)
{
	stack_node *newNode;
	newNode = (stack_node*)malloc(sizeof(stack_node));
    if(newNode == NULL) {
		if(STACK_ANNOUNCE_ERRORS) {
        	printf("Error: malloc failed in stack_push\n");
		}
        return;
    }
	newNode->data = data;
	newNode->next = s->top;
	s->top = newNode;
}

int stack_pop(stack *s)
{
	stack_node *temp;
	int data;
	if (stack_empty(s))
	{
		if(STACK_ANNOUNCE_ERRORS) {
			printf("Error: stack is empty in stack_pop\n");
		}
		return INT_MAX;
	}
	else
	{
		temp = s->top;
		data = temp->data;
		s->top = s->top->next;
		free(temp);
		return data;
	}
}

int stack_peek(stack *s)
{
	if (stack_empty(s))
	{
		if(STACK_ANNOUNCE_ERRORS) {
			printf("Error: stack is empty in stack_peek\n");
		}
		return INT_MAX;
	}
	else
	{
		return s->top->data;
	}
}

void stack_print(stack *s)
{
	stack_node *temp;
	if (stack_empty(s))
	{
		printf("Stack is empty");
	}
	else
	{
		temp = s->top;
		while (temp != NULL)
		{
			printf("%d ", temp->data);
			temp = temp->next;
		}
	}
    printf("\n");
}

void stack_destroy(stack **s_p)
{
    stack *s = *s_p;
	stack_node *temp;
	if (!stack_empty(s))
	{
		while (s->top != NULL)
		{
			temp = s->top;
			s->top = s->top->next;
			free(temp);
		}
	}
    free(s);
    *s_p = NULL;
}
