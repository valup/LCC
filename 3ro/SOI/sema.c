#include "sema.h"
#include <semaphore.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>

int sema_init(sema_t *sem, int pshared, unsigned int value) {
  sem->cont = value;
  return sem_init(sem->sem, pshared, value);
}

int sema_post(sema_t *sem) {
  sem->cont++;
  return sem_post(sem->sem);
}

int sema_wait(sema_t *sem) {
  sem->cont--;
  return sem_wait(sem->sem);
}

int sema_destroy(sema_t *sem) {
  int i = sem_destroy(sem->sem);
  free(sema);
  return i;
}
