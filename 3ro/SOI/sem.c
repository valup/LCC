#include "sem_mutex.h"
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>

int sem_init(sem_t *sem, int init) {
  sem = malloc(sizeof(sem_t));
  sem->cont = init;
  pthread_mutex_init(&sem->lock, NULL);
  return init;
}

int sem_incr(sem_t *sem) {
  sem->cont++;
  if (sem->cont == 0)
    pthread_mutex_unlock(sem->lock);
  return sem->cont;
}

int sem_decr(sem_t *sem) {
  sem->cont--;
  while (sem->cont < 0)
    pthread_mutex_lock(sem->lock);
  pthread_mutex_unlock(sem->lock);
  return sem->cont;
}
