#include <iostream>
#include <fstream>
using namespace std;

struct TrieNode
{
    TrieNode* child[26];
    bool End = false;
    TrieNode();
};

bool searchItem(TrieNode* Root, string Key);
int countItem(TrieNode* Root);
bool isEmpty(TrieNode* Root);
void insertItem(TrieNode *&root, string key);
TrieNode* removeItem(TrieNode* &root, string key, int depth = 0);
void removeAll(TrieNode *&root);
TrieNode* buildTrie(TrieNode *&root,istream &input = cin);
void printTrie(TrieNode *root,ostream &output = cout,string word = "");
void suggestItem(TrieNode *root, string word,ostream &output = cout);
void printTrieInorder(TrieNode* root, int letter = -1);