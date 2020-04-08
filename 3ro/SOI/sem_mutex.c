#include "sem_mutex.h"
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>

int sem_init(sem_t *sem, int init) {
  sem->cont = init; // asumo que la memoria esta alocada
  return pthread_mutex_init(&sem->lock, NULL);
}

int sem_incr(sem_t *sem) {
  sem->cont++;
  if (sem->cont == 0)
    return pthread_mutex_unlock(sem->lock);
  return 0;
}

int sem_decr(sem_t *sem) {
  sem->cont--;
  if (sem->cont <= 0) {
    return pthread_mutex_lock(sem->lock);
  }
  return 0;
}
