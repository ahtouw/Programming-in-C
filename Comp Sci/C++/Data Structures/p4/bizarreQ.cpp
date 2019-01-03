// William Ah Tou
// bizarreQ.cpp
// 11/13/15

#include <iostream>
#include <fstream>
#include "bizarreQ.h"
using namespace std;

// Private functions

// Goes through the heap and swaps values to maintain priority queue properties
void bizarreQ::heapifyDown(int arr[], int numItems)
{
  int k = 1;
  bool done = false;
  while (2*k <= numItems && !done)
	{
	  int lrg = k;
	  if (arr[2*k] > arr[k])
		lrg = 2*k;  //left child > parent
	  if (2*k+1 <= numItems && arr[2*k+1] > arr[lrg]) // rtchild largest
		lrg = 2*k + 1;
	  if (lrg != k)  // parent not largest
		{
		  swap(arr[k], arr[lrg]);
		  k = lrg;
		}
	  else done = true;
	}
}

// Doubles the size of the array to prevent the array from overflowing
void bizarreQ::resize(int*& array)
{
  if(numItems == size)
	{
	  int* oldArray = array;
	  
	  size *= 2;
	  array = new int[size];
	  for(int i = 1; i < size/2 + 1; i++)
		array[i] = oldArray[i];
	  delete[] oldArray;
	}
  return;  
}

// Swaps inputted values
void bizarreQ::swap(int& numA, int& numB)
{
  int local = numA;
  numA = numB;
  numB = local;
}

// Checks whether input is an odd value
bool bizarreQ::oddCheck(int num)
{
  return (num % 2 != 0);
}

// Checks whether the heap contains odd values
bool bizarreQ::oddArrCheck()
{
  bool oddsRemain = false;
  for(int i = 1; i < size/2 + 1; i++)
	if (oddCheck(array[i]))
	  oddsRemain = true;

  return oddsRemain;
}

// Public Functions

// Constructor
bizarreQ::bizarreQ(int size)
{
  size = 4;
  numItems = 0;
  this->size = size;
  array = new int[size];
}

// Destructor
bizarreQ::~bizarreQ()
{  delete[] array;}

// Copy Constructor
bizarreQ::bizarreQ(const bizarreQ& src)
{
  numItems = src.numItems;
  size = src.size;
  array = new int[size];
  for(int i = 0; i < size; i++)
	array[i] = src.array[i];
}

// Overloaded assignment operator
void bizarreQ::operator=(const bizarreQ& src)
{
  if(this != &src)
	{
	  delete[] array;
	  numItems = src.numItems;
	  size = src.size;
	  array = new int[size];
	  for(int i = 0; i < size; i++)
		array[i] = src.array[i];
	}
}

// Inserts input value into queue
void bizarreQ::enqueue(int num)
{
  resize(array);
  numItems++;
  array[numItems] = num;
  int k = numItems;
  while (k > 1 && array[k] > array[k/2])
	{
	  swap(array[k], array[k/2]);
	  k = k/2;
	}
}

// Removes the first, highest, value in the queue
void bizarreQ::dequeue()
{
  int k = numItems;
  array[1] = array[k];
  numItems--;
  heapifyDown(array, numItems);
  
}

// Removes all odd values in queue while maintaining properties of queue
void bizarreQ::flush()
{
  while (oddArrCheck())
	{
	  for (int i = 1; i < numItems; i++)
		{
		  if (oddCheck(array[i]))
			{
			  swap(array[1], array[i]);
			  dequeue();
			}
		}
	}
}

// Checks whether array is empty
bool bizarreQ::isEmpty()
{  return(numItems == 0);}

// Clears the array
void bizarreQ::clear()
{ numItems = 0;}

// Outputs array contents
void bizarreQ::printArr()
{
  for (int i = 0; i < numItems; i++)
	std::cout << array[i+1] << " ";

  std::cout << endl;
}

// Outputs array contents to .txt file
void bizarreQ::outputArr(ofstream& outputFile)
{
  for (int i = 0; i < numItems; i++)
	{
	  outputFile << array[1] << " ";
	  dequeue();
	}
  outputFile << endl;
}

