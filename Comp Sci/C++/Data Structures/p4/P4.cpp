// William Ah Tou
// P4.cpp
// 11/13/15

#include <iostream>
#include <fstream>
#include <cstdlib>
#include "bizarreQ.h"
using namespace std;

int randomNum();

int main()
{
  ofstream outputFile;
  bizarreQ bizQ(6);

  for(int i = 0; i < 14; i++)
	bizQ.enqueue(randomNum());

  bizQ.flush();                          // Testing flush function

  outputFile.open("P4Output.txt");
  if (outputFile)
	{
	  bizQ.outputArr(outputFile);
	  
	  for(int i = 0; i < 5; i++)
		bizQ.enqueue(randomNum());
	  
	  bizQ.clear();                       // Testing clear function
	  
	  if(bizQ.isEmpty())                  // Testing isEmpty function
		cout << "Queue empty\n";
	  
	  for(int i = 0; i < 10; i++)
		bizQ.enqueue(randomNum());
	  
	  bizQ.dequeue();	                  // Testing dequeue function
	  
	  bizQ.outputArr(outputFile);         
	  
	  outputFile.close();
	}
  else
	{
	  cout << "\nError opening output file. \n";
	}
}

int randomNum()
{
  int randVal;
  randVal = rand() % 50 + 1;
  return randVal;
}
