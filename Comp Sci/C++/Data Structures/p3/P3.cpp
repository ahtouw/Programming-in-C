// William Ah Tou
// P3.cpp
// 11/2/15

#include <iostream>
#include <fstream>
#include <cstdlib>
#include "primeDupBST.h"
using namespace std;

int randomNum();

int main()
{
  ifstream inputFile;    // Opens a file to read data to tPS
  ofstream outputFile;    // Opens a file to receive data to tPS
  primeDupBST BST;

  for (int i = 0; i < 1000; i++)
	{
	  BST.insert(randomNum());
	}

  BST.insert(50);
  BST.insert(100);
  BST.insert(1000);
  BST.insert(4);
  BST.insert(4);

  BST.remove(7);
  BST.remove(4);
  BST.remove(100);
  BST.remove(31);

  outputFile.open("P3out.txt");
  if (outputFile)
	{
	  BST.preIter(outputFile);
	  outputFile << endl;
	  BST.inRecur(outputFile);

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
  randVal = rand() % 2500 + 1;
  return randVal;
}
