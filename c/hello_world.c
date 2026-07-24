#include <stdio.h>

int main()
{
    FILE *fp;
    char name[100];

    // open file for writing
    fp = fopen("sample.txt", "w");
    if (fp == NULL) {
        printf("Error opening for wrting");
        return 1;
    }

    // write to file
    fprintf(fp, "Hellow from c file handling!\n");
    fclose(fp);

    // open file for reading
    fp = fopen("sample.txt", "r");
    if (fp == NULL) {
        printf("Error opening an file for reading!");
        return 1;
    }

    // read and display the content
    while(fgets(name, sizeof(name), fp) != NULL) {
        printf("%s", name);
    }
    fclose(fp);
    return 0;

}
