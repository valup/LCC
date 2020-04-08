#include <semaphore.h>
#include "mutex_sem.h"

int pthread_mutex_init(pthread_mutex_t *mutex, pthread_mutexattr_t *attr) {
  int i = sem_init(mutex->lock, attr->pshared, 1);
  if (!i)
    return i;
  return -1;
}

int pthread_mutex_lock(pthread_mutex_t *mutex) {
  int i = sem_wait(mutex->lock);
  if (!i)
    return i;
  return -1;
}

int pthread_mutex_unlock(pthread_mutex_t *mutex) {
  int i = sem_post(mutex->lock);
  if (!i)
    return i;
  return -1;
}

int pthread_mutex_destroy(pthread_mutex_t *mutex) {
  int i = sem_destroy(mutex->lock);
  free(mutex);
  if (!i)
    return i;
  return -1;
}
