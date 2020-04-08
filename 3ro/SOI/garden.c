/* POSIX Threads */
#include<pthread.h>
/* Assert library */
#include<assert.h>
/* I/O*/
#include<stdio.h>
/*malloc*/
#include<stdlib.h>

/* Constantes */
#define NVisitantes 10000
/*
  Problema introductorio a exclusión mutua.
 */

pthread_mutex_t lock;

void * turnstile(void *argV){
  pthread_mutex_lock(&lock);
  for(int j = 0; j < NVisitantes; j++)
    (*(int *)argV) ++ ;
  pthread_mutex_unlock(&lock);
  return NULL;
}

int main(void){
  pthread_t ts[2];

  if (pthread_mutex_init(&lock, NULL) != 0)
  {
    printf("\n mutex init failed\n");
    return 1;
  }

  /* Variable compartida */
  int *counter = malloc(sizeof(int));
  *counter = 0;
  /********************/

  /********************/
  /* Se crean NHilos */
  assert(! pthread_create( &ts[0], NULL, turnstile,(void*)(counter)));
  assert(! pthread_create( &ts[1], NULL, turnstile,(void*)(counter)));


  /* Se espera a que terminen */
  assert(!pthread_join(ts[0], NULL));
  assert(!pthread_join(ts[1], NULL));

  pthread_mutex_destroy(&lock);

  /* Se muestra el resultado del día */
  printf("NVisitantes en total: %d\n", *counter);
  /*
    Resultado esperado sería NVisitantes*NHilos. ¿Siempre entrega el mismo
    resultado?
   */
  free(counter);
  return 0;
}
