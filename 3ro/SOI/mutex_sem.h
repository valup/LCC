#include <semaphore.h>

typedef struct pthread_mutex_t {
  sem_t lock;
} pthread_mutex_t;

typedef struct pthread_mutexattr_t {
  int pshared;
}

int pthread_mutex_init(pthread_mutex_t *mutex, pthread_mutexattr_t *attr);

int pthread_mutex_lock(pthread_mutex_t *mutex);

int pthread_mutex_unlock(pthread_mutex_t *mutex);

int pthread_mutex_destroy(pthread_mutex_t *mutex);
