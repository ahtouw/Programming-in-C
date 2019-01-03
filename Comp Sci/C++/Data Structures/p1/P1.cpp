// William Ah Tou
// P1.cpp
// 10/1/15

#include <iostream>
#include <fstream>
#include "tPS.h"
using namespace std;

int main()
{
  ifstream inputFile;    // Opens a file to read data to tPS
  ofstream outputFile;    // Opens a file to receive data to tPS
  int number;    
  tPS primeStack(1);    // Holds and transforms data between files

  inputFile.open("P1input.txt");
  if (inputFile)
	{
	  while (inputFile >> number)
		{
		  primeStack.push(number);
		}
	  inputFile.close();
	}
  else
	{
	  cout << "\nError opening input file. \n";
	}

  outputFile.open("P1output.txt");
  if (outputFile)
	{
	  while(!primeStack.empty())
		outputFile << primeStack.pop() << endl;

	  outputFile.close();
	}
  else
	{
	  cout << "\nError opening output file. \n";
	}
}
