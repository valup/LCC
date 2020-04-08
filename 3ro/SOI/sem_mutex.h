struct semaphore_t;

typedef struct semaphore_t {
  int cont;
  pthread_mutex_t lock;
} sem_t;

/* Función de creación de Semáforo */
int sem_init(sem_t *sem, int init);

/* Incremento del semáforo. */
int sem_incr(sem_t *sem);

/* Decremento del semáforo. Notar que es una función que puede llegar a bloquear
   el proceso.*/
int sem_decr(sem_t *sem);

/* Destrucción de un semáforo */
int sem_destroy(sem_t *sem);
