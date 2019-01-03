// William Ah Tou
// P2.cpp
// 10/21/15


#include <iostream>
#include <cstdlib>
#include <cmath>
using namespace std; 

struct Node
{
  int data;
  Node* link;
};

bool numCheck(int num);
bool traverseList(Node* head, int num);
void printList(Node* head);
void deleteNode(Node*& head, int num);
void insertNode(Node*& head, int num);
int randomNum();

// Tests functions associated with linked lists
int main()
{
  Node* head = new Node;
  
  head -> link = 0;
  head -> data = 1;
 
  for (int i = 0; i < randomNum(); i++)
	{
	  insertNode(head, randomNum());
	  deleteNode(head, randomNum());
	}
  printList(head);
}

// Function which checks whether the input number is prime
bool numCheck(int num)
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

// Changes the inputted number to that numbers closest prior prime number and then adds a number to that prime
int numChange(int num)
{
  const int NUMCHANGE = -1;
  int prevPrime = 2;

  if(num == 3)
	{
	  return prevPrime + NUMCHANGE;
	}
  else
	{
	  for(int i = 3; i < num; i++)
		{
		  if(numCheck(i))
			prevPrime = i;
		}
	  return prevPrime + NUMCHANGE;
	}
}
// Function which reads the list to determine whether input number has already been input
bool traverseList(Node* head, int num)
{
  Node* nodePtr;
  nodePtr = head;
  
  while(nodePtr -> data != num)
	{
	  if(nodePtr -> link == 0)
		return false;
	  
	  nodePtr = nodePtr -> link;
	}
  return true;
}

// Function which prints out the linked list data
void printList(Node* head)
{
  Node* nodePtr;
  nodePtr = head;
  
  while(nodePtr)
	{
	  cout << nodePtr -> data << "  ";
	  nodePtr = nodePtr -> link;
	}
  cout << endl;
}

// Function which deletes a specified number from the linked list
void deleteNode(Node*& head, int num)
{
  Node *nodePtr;
  Node *prevNode;
  
  if(!head)
	return;
  if(head -> data == num)
	{
	  nodePtr = head -> link;
	  delete head;
	  head = nodePtr;
	}
  else
	{
	  nodePtr = head;
	  while(nodePtr != 0 && nodePtr -> data != num)
		{
		  prevNode = nodePtr;
		  nodePtr = nodePtr -> link;
		}
	  if(nodePtr)
		{
		  prevNode -> link = nodePtr -> link;
		  delete nodePtr;
		}
	}
}

// Function which inserts a specified number to the linked list, provided it is prime and unique to the list
void insertNode(Node*& head, int num)
{
  Node* newNode;
  Node* nodePtr;
  Node* prevNode;

  newNode = new Node;
  if(numCheck(num) && !traverseList(head,num))
	{
	  newNode -> data = numChange(num);
	  if(!head)
		{
		  head = newNode;
		  newNode -> link = 0;
		}
	  else
		{
		  nodePtr = head;
	   	  prevNode = 0;
		  while(nodePtr != 0 && nodePtr -> data < num)
			{
			  prevNode = nodePtr; 
			  nodePtr = nodePtr -> link;
			}
		  if(prevNode == 0)
			{
			  head = newNode;
			  newNode -> link = nodePtr;
			}
		  else
			{
			  prevNode -> link = newNode;
			  newNode -> link = nodePtr;
			}
		}
	}
}

// Generates a random number
int randomNum()
{
  int randVal;
  randVal = rand() % 2500 + 1;
  return randVal;
}
