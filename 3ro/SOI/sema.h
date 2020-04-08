#include <semaphore.h>

typedef struct sema_t {
  int cont;
  sem_t sem;
} sema_t;

/* Función de creación de Semáforo */
int sema_init(sema_t *sem, int pshared, unsigned int value);

/* Incremento del semáforo. */
int sema_post(sema_t *sem);

/* Decremento del semáforo. Notar que es una función que puede llegar a bloquear
   el proceso.*/
int sema_wait(sema_t *sem);

/* Destrucción de un semáforo */
int sema_destroy(sema_t *sem);
