#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>

#define MAXARG 100
#define MAXCHAR 1000

void ejecutar(char *str);
int generarArgs(char *str, char **args);

extern char **environ;

int main(void){
  char buffer[MAXCHAR];

  while(1){
    printf(">");
    fgets(buffer, MAXCHAR, stdin);
    if(feof(stdin))
      exit(0);
    ejecutar(buffer);
    // if (buffer[0] == EOF)
    //   exit(0);
    // else if (buffer[0] == '\n')
    //   continue;
    // else
    //   ejecutar(buffer);
  }

  return 0;
}

void ejecutar(char *str){
  pid_t pid;
  char *args[MAXARG];

  str[strlen(str)-1] = ' ';
  int background = generarArgs(str, args);

  if((pid = fork()) == 0){
    if(execve(args[0], args, environ) < 0){
      printf("error\n");
      exit(0);
    }
  }

  if(!background){
    int status;
    waitpid(pid, &status, 0);
  }
}


int generarArgs(char *str, char **args){
  char *p;
  while (*str == ' ')
    str++;
  int i = 0;
  while((p = strchr(str, ' '))){
    args[i] = str;
    i++;
    *p = '\0';
    str = p + 1;
    while(*str == ' ')
      str++;
  }
  args[i] = NULL;

  int amp = *args[i-1] == '&';
  if (amp){
    i--;
    args[i] = NULL;
    return 1;
  }
  else
    return 0;
}
