// William Ah Tou
// hashTable.cpp
// 12/2/15

// main file 3 hashtable
// hash function
// change put function with capacity
#include <iostream>
#include <string>
#include <locale>
#include "hashTable.h"
using namespace std;


hashTable::hashTable()
{
  capacity = 0;
  table = new LinkedHash*[TABLE_SIZE];
  for (int i = 0; i < TABLE_SIZE; i++)
		table[i] = 0;
}

int hashTable::get(string key)
{
  int hash = hashIt(key);
  if (!table[hash])
	return 0;
  else
	{
	  LinkedHash *entry = table[hash];
	  while (entry != 0 && entry -> getKey() != key)
		entry = entry -> getNext();
	  if (entry == 0)
		return 0;
	  else
		return entry -> getCount();
	}
}

void hashTable::put(string key)
{
  if (check(key))
	{
	  int hash = hashIt(key);
	  
	  if (table[hash] == 0)
		{
		  table[hash] = new LinkedHash(key);
		  capacity++;
		}
	  else
		{
		  LinkedHash *entry = table[hash];
		  while (entry -> getNext() != 0)
			entry = entry -> getNext();
		  
		  if (entry->getKey() == key)
			entry -> setCount(entry->getCount()+1);
		  else
			{
			  entry -> setNext(new LinkedHash(key));
			  capacity++;
			}
		}
	}
}

void hashTable::remove(string key)
{
  int hash = hashIt(key);
  if (table[hash] != 0)
	{
	  LinkedHash *prevEntry = 0;
	  LinkedHash *entry = table[hash];
	  while (entry->getNext() != 0 && entry -> getKey() != key)
		{
		  prevEntry = entry;
		  entry = entry -> getNext();
		}
	  if (entry -> getKey() == key)
		{
		  entry -> setCount(entry->getCount()-1);
		  if (entry->getCount() == 0)
			{
			  if (prevEntry == 0)
				{
				  LinkedHash *nextEntry = entry->getNext();
				  table[hash] = nextEntry;
				}
			  else
				{
				  LinkedHash *next = entry->getNext();
				  prevEntry->setNext(next);
				}
			}
		}
	}
}

bool hashTable::check(string& str)
{
  bool pass = true;
  if (str.length() >= 5)
	{
	  for (string::iterator i = str.begin(); i != str.end(); i++)
		{
		  if (std::isalpha(*i))
			{
			  *i = tolower(*i);
			}
		  else { str.erase(*i); }
		}
	}
  else { pass = false; }
  return (pass && !str.empty());
}

int hashTable::hashIt(string const& str)
{
  const unsigned long int FNVPRIME = 16777619;
  const unsigned long int FNVOFFSET = 2166136261;
  
  unsigned long int hash = FNVOFFSET;
  
  for(string::const_iterator i = str.begin(); i != str.end(); i++)
	{
	  hash *= FNVPRIME;
	  hash ^= *i;
	}
  return hash;
}

hashTable::~hashTable()
{
  for (int i = 0; i < TABLE_SIZE; i++)
	if (table[i] != 0)
	  {
		LinkedHash *prevEntry = 0;
		LinkedHash *entry = table[i];
		while (entry != 0)
		  {
			prevEntry = entry;
			entry = entry -> getNext();
			delete prevEntry;
		  }
	  }
  delete[] table;
}

