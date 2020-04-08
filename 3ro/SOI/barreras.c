#include <pthread.h>
#include "barreras.h"

int barrier_init(barrier_t *barr, unsigned int count) {
  int i = pthread_cond_init(&barr->cond, NULL);
  if (i) {
    return -1;
  }
  i = pthread_mutex_init(&barr->mutex, NULL);
  if (i) {
    return -1;
  }
  barr->esperando = 0;
  barr->total = count;
  return i;
}

int barrier_wait(barrier_t *barr) {
  int i = pthread_mutex_lock(&barr->mutex);
  if (i) {
    return -1;
  }
  barr->restantes--;
  if (!barr->restantes) {
    i = pthread_cond_broadcast(&barr->cond);
    if (i) {
      return -1;
    }
  } else {
    i = pthread_cond_wait(&barr->cond,&barr->mutex);
    if (i) {
      return -1;
    }
  }
  i = pthread_mutex_unlock(&barr->mutex);
  return i;
}

int barrier_destroy(barrier_t *barr) {
  int i = pthread_mutex_destroy(&barr->mutex);
  if (i) {
    return -1;
  }
  i = pthread_cond_destroy(&barr->cond);
  if (i) {
    return -1;
  }
  free(barr);
  return i;
}
