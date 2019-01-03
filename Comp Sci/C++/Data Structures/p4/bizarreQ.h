// William Ah Tou
// bizarreQ.h
// 11/13/15

#include <iostream>
#include <fstream>
#ifndef BIZARREQ
#define BIZARREQ
using namespace std;

class bizarreQ
{
 private:
  int* array;
  int size;
  int numItems;
  void heapifyDown(int arr[], int numItems);
  void resize(int*& array);
  void swap(int& numA, int& numB);
  bool oddCheck(int num);
  bool oddArrCheck();
 public:
  bizarreQ(int size);
  ~bizarreQ();
  bizarreQ(const bizarreQ&);
  void operator=(const bizarreQ&);
  void enqueue(int num);
  void dequeue();
  void flush();
  bool isEmpty();
  void clear();
  void printArr();
  void outputArr(ofstream& outputFile);
};

#endif
