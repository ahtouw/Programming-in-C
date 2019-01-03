// William Ah Tou
// hashTable.h
// 12/2/15


#include <iostream>
#include <string>
#ifndef HASHTABLE
#define HASHTABLE
using namespace std;


const int TABLE_SIZE = 1543;

class hashTable
{
 private:
  
  struct LinkedHash
  {
  private:
	string key;
	int count;
	LinkedHash *next;
	
  public:
	LinkedHash(string key)                                    // Constructor for the linked list portion of the hash table
	{
	  this -> key = key;
	  this -> count = 1;
	  this -> next = 0;
	}
	string getKey() { return key; }                           // Returns the key value to user
	int getCount() { return count; }                          // Returns the count value of the amount of times a particular key has been entered to user
	void setCount(int count) { this->count = count; }         // Allows user to set the count
	LinkedHash *getNext() { return next; }                    // Used for traversing the linked list
	void setNext(LinkedHash *next) { this->next = next; }     // Used to add to linked list
  };
  
  LinkedHash **table;
  int capacity;                        
  bool check(string&);                 // Check function for internally checking whether input fits within criteria
  int hashIt(string const&);           // Hash function to give index to inputted sting
  void operator=(const hashTable&);    // Copying hash table via equals sign suppressed
  hashTable(const hashTable&);         // Copying hash table via constructor suppressed
  
 public:
  hashTable();                               // Constructor for hash table
  ~hashTable();                              // Destructor for hash table
  int getCapacity() { return capacity; }     // Returns capacity to user
  int get(string);                           // Returns the frequency count of the inputted string to user
  void put(string);                          // Inputs string into hash table if within criteria
  void remove(string);                       // Removes string when possible
};
#endif
