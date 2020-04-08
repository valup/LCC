#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>

#define N_FILOSOFOS 5
#define ESPERA 500000

pthread_mutex_t tenedor[N_FILOSOFOS];

void pensar(int i)
{
  printf("Filosofo %d pensando...\n",i);
  usleep(random() % ESPERA);
}

void comer(int i)
{
  printf("Filosofo %d comiendo...\n",i);
  usleep(random() % ESPERA);
}

void tomar_tenedores(int i)
{
  pthread_mutex_lock(&tenedor[i]); /* Toma el tenedor a su derecha */
  pthread_mutex_lock(&tenedor[(i+1)%N_FILOSOFOS]); /* Toma el tenedor a su izquierda */
}

void dejar_tenedores(int i)
{
  pthread_mutex_unlock(&tenedor[i]); /* Deja el tenedor de su derecha */
  pthread_mutex_unlock(&tenedor[(i+1)%N_FILOSOFOS]); /* Deja el tenedor de su izquierda */
}

void tomar_tenedores2(int i)
{
  pthread_mutex_lock(&tenedor[(i+1)%N_FILOSOFOS]); /* Toma el tenedor a su izquierda */
  pthread_mutex_lock(&tenedor[i]); /* Toma el tenedor a su derecha */
}

// void dejar_tenedores2(int i)
// {
//   pthread_mutex_unlock(&tenedor[(i+1)%N_FILOSOFOS]); /* Deja el tenedor de su izquierda */
//   pthread_mutex_unlock(&tenedor[i]); /* Deja el tenedor de su derecha */
// }

void *filosofo(void *arg)
{
  int i = *(int *)arg;
  for (;;)
  {
    tomar_tenedores(i);
    comer(i);
    dejar_tenedores(i);
    pensar(i);
  }
}

void *filosofo2(void *arg)
{
  int i = *(int *)arg;
  for (;;)
  {
    tomar_tenedores2(i);
    comer(i);
    dejar_tenedores(i);
    pensar(i);
  }
}

int main()
{
  int i;
  pthread_t filo[N_FILOSOFOS];
  for (i=0;i<N_FILOSOFOS;i++)
    pthread_mutex_init(&tenedor[i], NULL);
  int zurdo = random() % N_FILOSOFOS;
  printf("%d\n", zurdo);
  for (i=0;i<N_FILOSOFOS;i++) {
    if (i == zurdo) {
      pthread_create(&filo[i], NULL, filosofo2, (void *)&i);
    } else{
      pthread_create(&filo[i], NULL, filosofo, (void *)&i);}
  }
  pthread_join(filo[0], NULL);
  return 0;
}
