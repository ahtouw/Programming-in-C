// William Ah Tou
// tPS.cpp
// 10/1/15

#include <iostream>
#include <cmath>
#include "tPS.h"
using namespace std;

// Private function which checks whether the input number is prime
bool tPS::numCheck(int num)
{
  bool prime = true;

  if(num % 2)
	{
	  for(int i = 2; i <= sqrt(num); i++)
	    {
		  if(num % i == 0)
			prime = false;
		}
	  return prime;
	}
  else
	{
	  return false;
	}
}

// Private function which doubles the size of an array when it reaches max capacity
void tPS::resize(int*& array)
{
  if(top == size)
	{
	  int* oldArray = array;

	  size *= 2;
	  array = new int[size];
	  for(int i = 0; i < size/2; i++)
		array[i] = oldArray[i];
	  delete[] oldArray;
	}
  return;
}

// Constructor
tPS::tPS(int size)
{
  size = 100;
  top = 0;
  this->size = size;
  arrayPS = new int[size];
  std::cout << "\nConstructor called";
}

// Copy constructor
tPS::tPS(const tPS& src)
{
  top = src.top;
  size = src.size;
  arrayPS = new int[size];
  for(int i = 0; i < size; i++)
	arrayPS[i] = src.arrayPS[i];
}

// Deconstructor
tPS::~tPS(){delete[] arrayPS;
  std::cout << "\nDestructor called\n";}

// Returns true when array is empty
bool tPS::empty()
{return(top == 0);}

// Clears the array of stored integers
void tPS::clear()
{top = 0;}

// Pushes an integer only if the passed integer was prime
void tPS::push(int num)
{
  const int NUMCHANGE = -1;
  int prevPrime = 2;

  resize(arrayPS);
  if(num == 3)
	{
	  arrayPS[top] = prevPrime + NUMCHANGE;
	  top++;
	}
  else if(numCheck(num))
	{
	  for(int i = 3; i < num; i++)
		{
		  if(numCheck(i))
			prevPrime = i;
		}
	  arrayPS[top] = prevPrime + NUMCHANGE;
	  top++;
	}
  return;
}

// Takes the last integer out of the array
int tPS::pop()
{
  int holder;
  if(empty())
	  cout << "The stack is empty. \n";
  else
	{
	  top--;
	  holder = arrayPS[top];
	}
  return holder;
}
