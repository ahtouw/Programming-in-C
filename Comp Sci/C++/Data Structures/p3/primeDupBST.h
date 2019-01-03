// William Ah Tou
// primeDupBST.h
// 11/2/15

#include <iostream>
#ifndef PRIMEDUPBST
#define PRIMEDUPBST
using namespace std;

class primeDupBST
{
 private:
  struct TNode
  {
	TNode* left;
	TNode* right;
	int data;
	int count;
  };
  
  TNode* root;
  
  void destroy(TNode* root);
  bool numCheck(int num);
  void operator=(const primeDupBST&);
  primeDupBST(primeDupBST&);
  void inRecur(TNode* root, ofstream& outputFile);
  void preIter(TNode* root, ofstream& outputFile);
  void insert(int num, TNode* auxPtr);
 public:
  primeDupBST() { root = 0;};
  ~primeDupBST() { destroy(root);};
  
  void inRecur(ofstream& outputFile);
  void preIter(ofstream& outputFile);
  void clear() {destroy(root); root = 0;};
  void insert(int num);
  void remove(int num);
  bool find(int num);
};
#endif
