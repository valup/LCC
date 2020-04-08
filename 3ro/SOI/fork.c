#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main(){
  pid_t pid = fork();
  if(pid){
    int p, status; printf("padre\n");
    p = wait(&status);
    printf("proceso %d termino con %d\n",pid,status);
  }else{
    printf("soy el hijo con pid = %d\n",pid);
    sleep(5); //*((int)NULL)=666;
    printf("fin\n");
  }
  return 66;
}
