#ifndef CSCI2041_HWK07_RUNTIME_H
#define CSCI2041_HWK07_RUNTIME_H 1

#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// Uncomment the following line to disable multithreading.
// #define NO_CILK 1

#ifndef NO_CILK
#define spawn _Cilk_spawn
#define sync _Cilk_sync
#else
#define spawn /* spawn */
#define sync /* sync */
#endif

typedef struct {
  int* data;
  size_t size;
} array;

array make_array(size_t size, ...) {
  va_list ap;
  va_start(ap, size);
  int* data = (int*) malloc(size * sizeof(int));
  for(size_t i = 0; i < size; i++)
    data[i] = va_arg(ap, int);
  va_end(ap);
  return (array) { data, size };
}

void print_array(array arr) {
  printf("[");
  if(arr.size != 0)
    printf("%d", arr.data[0]);
  for(size_t i = 1; i < arr.size; i++)
    printf(", %d", arr.data[i]);
  printf("]");
}

void array_bounds_check(array arr, int idx, bool write) {
  if(idx > arr.size) {
    printf("\x1b[1;31mArray access out of bounds!\nTried to %s index %d in ",
      write ? "write to" : "read from",
      idx);
    print_array(arr);
    printf("\n\x1b[0m");
    abort();
  }
}

int array_get(array arr, int idx) {
  array_bounds_check(arr, idx, false);
  return arr.data[idx];
}

#define declare_main_returning_int()                                           \
int main() {                                                                   \
  printf("\x1b[1;32mReturned %d.\x1b[0m\n", init());                           \
  return 0;                                                                    \
}

#define declare_main_returning_array()                                         \
int main() {                                                                   \
  array out = init();                                                          \
  printf("\x1b[1;32mReturned ");                                               \
  print_array(out);                                                            \
  printf(".\x1b[0m\n");                                                        \
  return 0;                                                                    \
}

#endif // CSCI2041_HWK07_RUNTIME_H
