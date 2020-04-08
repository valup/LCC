#include<stdlib.h>
#include<stdio.h>
#include<math.h>
#include<pthread.h>
#include<assert.h>

 pthread_mutex_t lock;

#define t 4
#define NPoints 10000000
#define r 1000000

void* piCalculation(void* circ){
  pthread_mutex_lock(&lock);
  for (int i=0;i<NPoints;i++){
    if (sqrt(pow(random() % r,2)+pow(random() % r,2))<=r){
      (*(double*)circ)++;
    }
  }
  pthread_mutex_unlock(&lock);
  return circ;
}

int main(void){
  double* circ = malloc(sizeof(double));
  *circ = 0;
  // Seed setting
  srandom(4);
  pthread_t ts[t];
  if (pthread_mutex_init(&lock, NULL) != 0)
  {
    printf("\n mutex init failed\n");
    return 1;
  }

  for (int i = 0; i < t; i++) {
    assert(! pthread_create( &ts[i], NULL, piCalculation,(void*)(circ)));
  }

  for (int i = 0; i < t; i++) {
    assert(!pthread_join(ts[i], NULL));
  }

  pthread_mutex_destroy(&lock);
  int points = t*NPoints;
  printf("Approximación de pi con %d puntos es: %'.10f\n",points,4*(*circ/points));
  free(circ);

  return 0;
}
