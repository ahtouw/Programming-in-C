// William Ah Tou
// P5.cpp
// 12/2/15

#include <iostream>
#include <string>
#include <fstream>
#include <locale>
#include "hashTable.h"
using namespace std;

void sortArr(int array[], int size);    // Sorts the array holding word frequency

int main()
{
  hashTable WaP;           // Hash table for War and Peace
  hashTable GE;            // Hash table for Great Expectations
  hashTable combined;      // Hash table combining both books
  string str;              // string or word variable traversing the books
  ifstream inputFileW;     
  ifstream inputFileG;
  ofstream outputFile;

  const int ARRSIZE = 15;
  int arr[ARRSIZE] = {};  // Array for finding word frequency
  
  inputFileW.open("WarAndPeace.txt");
  inputFileG.open("GreatExpectations.txt");
  
  if (inputFileW && inputFileG)
	{
	  while (inputFileW >> str)
		{
		  WaP.put(str);
		  combined.put(str);
		  if (combined.get(str) > arr[0])
			{
			  arr[0] = combined.get(str);
			  sortArr(arr, ARRSIZE);
			}
		}
	  while (inputFileG >> str)
		{
		  GE.put(str);
		  combined.put(str);
		  if (combined.get(str) > arr[0])
			{
			  arr[0] = combined.get(str);
			  sortArr(arr, ARRSIZE);
			}
		}
	  

	  outputFile.open("P5Output.txt");

	  while (inputFileW >> str)
		{
		  for (int i = 0; i < ARRSIZE; i++)
			{
			  if (combined.get(str) == arr[i])
				{
				  outputFile << "Word: " << str << "     Frequency: " << arr[i] << endl;
				  arr[i] = -1;
				}
			}
		}
	  
	  while (inputFileG >> str)
		{
		  for (int i = 0; i < ARRSIZE; i++)
			{
			  if (combined.get(str) == arr[i])
				{
				  outputFile << "Word: " << str << "     Frequency: " << arr[i] << endl;
				  arr[i] = -1;
				}
			}
		}
	  
	  if (outputFile)
		{
		  outputFile << "Number of distinct words >5 letters in War and Peace: " << WaP.getCapacity() << endl;
		  outputFile << "Number of distinct words >5 letters in Great Expectations: " << GE.getCapacity() << endl;
		  
		  outputFile.close();
		}
	  
   
	  inputFileW.close();
	  inputFileG.close();
	}
  else
	cout << "\nError opening input file.\n";
}

void sortArr(int array[], int size)
{
  bool swap;
  int temp;

  do
	{
	  swap = false;
	  for (int count = 0; count < (size - 1); count++)
		{
		  if (array[count] > array[count + 1])
			{
			  temp = array[count];
			  array[count] = array[count + 1];
			  array[count + 1] = temp;
			  swap = true;
			}
		}
	} while (swap);
}
