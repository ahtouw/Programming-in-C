// William Ah Tou
// primeDupBST.cpp
// 11/2/15

#include <iostream>
#include <fstream>
#include <stack>
#include <cmath>
#include "primeDupBST.h"
using namespace std;

// Private function which assists in deleting nodes for use in destructor and clear functions
void primeDupBST::destroy(TNode* root)
{
  if(!root) return;
  destroy (root -> left);
  destroy (root -> right);
  delete root;
  return;
}

// Private function which check whether the input number is prime
bool primeDupBST::numCheck(int num)
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

// Public function to access the private inRecur function
void primeDupBST::inRecur(ofstream& outputFile)
{
  if(root)
	preIter(root, outputFile);
  else
	{
	  cout << "Empty tree";
	}
}

// Private function which recursively outputs BST data inorder
void primeDupBST::inRecur(TNode* root, ofstream& outputFile)
{
  if (!root) return;
  inRecur(root -> left, outputFile);
  outputFile << root -> data << "  ";
  inRecur(root -> right, outputFile);
  return;
}

// Public function to access the private preIter function
void primeDupBST::preIter(ofstream& outputFile)
{
  if(root)
	preIter(root, outputFile);
  else
	{
	  cout << "Empty tree";
	}
}

// Private function which iteratively outputs BST data preorder
void primeDupBST::preIter(TNode* root, ofstream& outputFile)
{
  stack <TNode*> s;
  if(!root) return;
  s.push(root);

  while(!s.empty())
	{
	  TNode* top = s.top();
	  s.pop();
	  outputFile << top -> data << "  ";
	  if (top -> right)
		s.push(top -> right);
	  if (top -> left)
		s.push(top -> left);
	}
}

// Public function to access the private insert function
void primeDupBST::insert(int num)
{
  if(root)
	insert(num, root);
  else
	{
	  root = new TNode;
	  root -> data = num;
	  root -> left = 0;
	  root -> right = 0;
	}
}

// Private function which inserts an input number recursively according to BST rules
void primeDupBST::insert(int num, TNode* auxPtr)
{
  if (num < auxPtr -> data)
	{
	  if (auxPtr -> left != 0)
		insert(num, auxPtr -> left);
	  else
		{
		  auxPtr -> left = new TNode;
		  auxPtr -> left -> data = num;
		  auxPtr -> left -> left = 0;
		  auxPtr -> left -> right = 0;
		  if(numCheck(num))
			(auxPtr -> left -> count)++;
		}
	}
  else if (num > auxPtr -> data)
	{
	  if (auxPtr -> right != 0)
		insert(num, auxPtr -> right);
	  else
		{
		  auxPtr -> right = new TNode;
		  auxPtr -> right -> data = num;
		  auxPtr -> right -> left = 0;
		  auxPtr -> right -> right = 0;
		  if(numCheck(num))
			(auxPtr -> right -> count)++;
		}
	}
  else
	if(numCheck(num))
	  (auxPtr -> count)++;

}

// Public function for removing a number while also maintaining the BST
void primeDupBST::remove(int num)
{
  TNode* prev = 0;
  TNode* auxPtr = root;

  while ((auxPtr) && (num != auxPtr -> data))
	{
	  prev = auxPtr;

	  if (num < auxPtr -> data)
		auxPtr = auxPtr -> left;
	  else
		auxPtr = auxPtr -> right;
	}
  if (!auxPtr) return;
  else
	{
	  (auxPtr -> count)--;
	  if (auxPtr -> count <= 0)
		return;
	  if (auxPtr == root)
		{
		  auxPtr = root;
		  prev = 0;
		}
	}

  // 0 or 1 children
  if (!(auxPtr -> right))
	{
	  if(!prev)
		{
		  root = auxPtr -> right;
		  delete auxPtr;
		}
	  else
		{
		  if (prev -> left == auxPtr)
			prev -> left = auxPtr -> right;
		  else
			prev -> right = auxPtr -> left;
		  delete auxPtr;
		}
	}
  else
	{
	  if (!(auxPtr -> left))
		{
		  if (!prev)
			{
			  root = auxPtr -> right;
			  delete auxPtr;
			}
		  else
			{
			  if (prev -> left == auxPtr)
				prev -> left = auxPtr -> right;
			  else
				prev -> right = auxPtr -> left;
			  delete auxPtr;
			}
		}
	  else // 2 children
		{
		  TNode* holdPtr = auxPtr;
		  prev = auxPtr;
		  auxPtr = auxPtr -> left;
		  while (!(auxPtr -> right))
			{
			  prev = auxPtr;
			  auxPtr = auxPtr -> right;
			}
		  holdPtr -> data = auxPtr -> data;
		  holdPtr -> count = auxPtr -> count;

		  if (prev == holdPtr)
			prev -> left = auxPtr -> left;
		  else
			prev -> right = auxPtr -> left;
		  delete auxPtr;
		}
	}
}

// Public function for searching for a number in BST
bool primeDupBST::find(int num)
{
  TNode* auxPtr = root;
  
  while ((auxPtr) && (num != auxPtr -> data))
	{
	  if (num < auxPtr -> data)
		auxPtr = auxPtr -> left;
	  else 
		auxPtr = auxPtr -> right;
	}
  return (num == auxPtr -> data);
}
