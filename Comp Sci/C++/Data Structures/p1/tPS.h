// William Ah Tou
// tPS.h
// 10/1/15

#include <iostream>
#ifndef TPS
#define TPS
using namespace std;

class tPS
{
 private:
  int size, top;
  int* arrayPS;
  bool numCheck(int num);
  void resize(int*& array);
 public:
  tPS(int size);
  tPS(const tPS& src);
  ~tPS();
  bool empty();
  void clear();
  void push(int num);
  int pop();
};
#endif
