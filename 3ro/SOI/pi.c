#include<stdlib.h>
#include<stdio.h>
#include<math.h>

#define NPoints 100000000

double piCalculation(void){
  int r = 10000000;
  double circ = 0;
  for (int i=0;i<NPoints;i++){
    if (sqrt(pow(random() % r,2)+pow(random() % r,2))<=r){
        circ++;
    }
  }
  return 4*(circ/NPoints);
}

int main(void){
  double pi;
  // Seed setting
  srandom(4);

  pi = piCalculation();

  printf("Approximación de pi con %d puntos es: %'.10f\n",NPoints,pi);

  return 0;
}
