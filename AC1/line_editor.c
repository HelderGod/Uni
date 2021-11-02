#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <stdbool.h>
#include <limits.h>

struct node {
	struct node *prev;
	char *data[100];
	struct node *next;
};

struct node* addToEmpty (struct node* text) {
    struct node *temp = (struct node *)malloc(sizeof(struct node));
    temp->prev = NULL;
    temp->next = NULL;
    text = temp;
    return text;
}

bool Command (char instruct[10], char comando) {
    for (int i=0; i<10; i++) {
        if (instruct[i] == comando)
            return true;
    }
    return false;
}

bool Ultimo (struct node *p) {
    if (p->next == NULL)
        return true;
    return false;
}

void Last (struct node *text, struct node *p, int line) {
    p = text;
    line = 0;
    while (p->next != NULL) {
        p = p->next;
        line++;
    }
    printf("linhas: %d\n", line);
    Initialize(text, p, line);
}

void Continue (struct node *text, struct node *p, int line) {
    
    char word[1000];
    
    do
    {
        struct node *linha = malloc(sizeof(struct node));
        gets(linha->data);
        if (linha->data[0] == '.')
            break;
        linha->prev = NULL;
        linha->next = NULL;
        if (p->next != NULL) {
            struct node *temp2 = p->next;
            linha->next = temp2;
            temp2->prev = linha;
        }
        linha->prev = p;
        p->next = linha;
        p = linha;
    } while (word[0] != '.');
    Last(text, p, line);
    /*Initialize(text, p, line);*/
}

struct node* insert (struct node *text, struct node *p, int line, char instruct[10]) {
    struct node *linha;
    char word[1000];
    char comando = atoi(instruct);
    if (comando > line) {
        printf("?\n");
        Initialize(text, p, line);
    }
    if (comando >= 1 && comando <= line) {
        for (line; line>comando; line--)
            p = p->prev;
        linha = malloc(sizeof(struct node));
        gets(linha->data);
        linha->prev = NULL;
        linha->next = NULL;
        struct node *temp = p->prev;
        linha->prev = temp;
        linha->next = p;
        temp->next = linha;
        p->prev = linha;
        p = linha;
    }
    Continue(text, p, line); 
}

struct node* append (struct node *text, struct node *p, int line, char instruct[10]) {
    char comando = atoi(instruct);
    char word[1000];
    struct node *linha;
    if (comando > line) {
        printf("?\n");
        Initialize(text, p, line);
    }
    else if (comando < line) {
        if (comando >= 1) {
            for (line; line>comando; line--)
                p = p->prev;
        }
        linha = malloc(sizeof(struct node));
        gets(linha->data);
        linha->prev = NULL;
        linha->next = NULL;

        struct node *temp = p->next;
        linha->prev = p;
        linha->next = temp;
        p->next = linha;
        temp->prev = linha;
        p = linha;
    }

    Continue(text, p, line);
}

struct node* change (struct node *text, struct node *p, int line, char instruct[10]) {
    struct node *linha;
    char comando = atoi(instruct);
    char word[1000];
    struct node *temp;
    if (comando > line) {
        printf("?\n");
        Initialize(text, p, line);
    }
    else {
        if (comando >= 1) {
            for (line; line>comando; line--)
                p = p->prev;
        }
        linha = malloc(sizeof(struct node));
        gets(linha->data);
        linha->prev = NULL;
        linha->next = NULL;
        temp = p;
        if (Ultimo(p) == true) {
            p = p->prev;
            linha->prev = p;
            p->next = linha;
        }
        else {
            struct node *temp2 = p->next;
            p = p->prev;
            linha->prev = p;
            linha->next = temp2;
            p->next = linha;
            temp2->prev = linha;
        }
        free(temp);
        p = linha;
    }
    Continue(text, p, line);
}

void delete (struct node *text, struct node *p, int line, char instruct[10]) {
    char comando = atoi(instruct);
    struct node *temp;
    if (comando > line) {
        printf("?\n");
        Initialize(text, p, line);
    }
    else {
        if (comando >= 1) {
            for (line; line>comando; line--)
                p = p->prev;
        }
        temp = p;
        if (Ultimo(p) == true) {
            p = p->prev;
            p->next = NULL;
        }
        else {
            struct node *temp2 = p->next;
            p = p->prev;
            p->next = temp2;
            temp2->prev = p;
        }
        free(temp);
    }
    Last(text, p, line);
}

void print (struct node *text, struct node *p, int line, char instruct[10]) {
    char comando = atoi(instruct);
    if (comando > line) {
        printf("?\n");
        Initialize(text, p, line);
    }
    else {
        if (instruct[0] == '%') {
            struct node *temp = text->next;
            while (!Ultimo(temp)) {
                printf("%s\n", temp->data);
                temp = temp->next;
            }
        }
        else if (comando >= 1) {
            for(line; line>comando; line--)
                p= p->prev;
        }
        printf("%s\n", p->data);
        Last(text, p, line);
    }
}

/*FILE fileedit (struct node *text, struct node *p, int line) {
    FILE *fp;
    char file[20];

    printf ("Nome do File: \n");
    gets(file);

    fp = fopen(file, "r");
    if(fp==NULL){
        printf ("?\n");
        fileedit();
    }
    while (!feof(fp)) {
        struct node *aux, *linha = malloc(sizeof(struct node));
        fscanf(fp, "%s", &linha->data);
        for (int i=0; i<line; line--)
            p = p->prev;
        
    }
}*/

void file () {
}

void write () {
}

void quitsave () {
}

void quit () {
    exit(EXIT_SUCCESS);
}

void Instruct (struct node *text, struct node *p, int line, char instruct[10]) {
    if (Command(instruct, 'i') == true)
        text = insert(text, p, line, instruct);
    if (Command(instruct, 'a') == true)
        text = append(text, p, line, instruct);
    if (Command(instruct, 'c') == true)
        text = change(text, p, line, instruct);
    if (Command(instruct, 'd') == true)
        delete(text, p, line, instruct);
    if (Command(instruct, 'p') == true)
        print(text, p, line, instruct);
    /*if (comando->e == 'e')
    if (comando->e == 'f')
    if (comando->e == 'w')
    if (comando->e == 'q')*/
    if (Command(instruct, 'Q') == true)
        quit();
    else {
        printf("?\n");
        Initialize(text, p, line);
    }
}

void Averiguate (struct node *text, struct node *p, int line, char instruct[10]) {
    if(Command(instruct, 'i') == true || Command(instruct, 'a') == true)
        Instruct(text, p, line, instruct);
    else {
        printf("?\n");
        Initialize(text, p, line);
    }
}

void Initialize (struct node *text, struct node *p, int line) {
    char instruct[10];
    gets(instruct);
    if (text->next == NULL)
        Averiguate(text, p, line, instruct);
    else {
        Instruct(text, p, line, instruct);
    }
}

void main () {
    struct node *text = addToEmpty(text);
    struct node *p = text;
    int line = 0;
    Initialize(text, p, line);
}