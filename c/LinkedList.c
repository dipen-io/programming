#include <stdio.h>
#include <stdlib.h>

//node structure
struct Node {
    int data;
    struct Node* next;
};

// create  a new node 
struct Node* createNode(int value) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));

    if (newNode == NULL) {
        printf("Memory allocator falied\n");
        exit(1);
    }

    newNode->data = value;
    newNode->next = NULL;
    return newNode;
};

struct Node* insertEnd(struct Node*  head, int value){
    struct Node* newNode = createNode(value);
    // if ther eis not element in node
    if (head == NULL) {
        return newNode;
    }
    struct Node* temp = head;
    while (temp->next != NULL) {
        temp = temp->next;
    }
    temp->next = newNode;
    return head;
};

void printList( struct Node* head) {
    struct Node* temp= head;

    while(temp != NULL) {
        printf("%d ->", temp->data);
        temp = temp->next;
    }
    printf("NULL\n");
}


int main()
{

    printf("**LINKED LIST**\n");

    struct Node* head = NULL;

    head = insertEnd(head,10);
    head = insertEnd(head,20);
    head = insertEnd(head,30);
    printList(head);

    return 0;
}
