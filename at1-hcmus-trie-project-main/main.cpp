#include "trie.hpp"
using namespace std;

void demo2()
{
    string continuity, word;
    ifstream input("words.txt");
    TrieNode *root = new TrieNode;
    buildTrie(root, input);
    do
    {
        cout << "Choice: \n1. Print all trie \n2. Search a word \n3. Search all similar words \n4. Delete a word \n5. Count item \n";

        int choice;
        do
        {
            cout << "\nInput your choice: ";
            cin >> choice;
        } while (choice > 5 || choice < 1);

        switch (choice)
        {
        case 1:
        {
            printTrieInorder(root);
            cout << endl;
            break;
        }
        case 2:
        {
            cout << "Input a word that you want to search: ";
            cin >> word;
            if (searchItem(root, word))
            {
                cout << word << " is in the dictionary.\n";
            }
            else
            {
                cout << word << " isn't in the dictionary.\n";
            }
            break;
        }
        case 3:
        {
            cout << "Input a word that you want to search all similar words with that word: ";
            cin >> word;
            suggestItem(root, word);
            break;
        }
        case 4:
        {
            cout << "Input a word that you want delete: ";
            cin >> word;
            removeItem(root, word);
            if (searchItem(root, word))
            {
                cout << word << " is in the dictionary.\n";
            }
            else
            {
                cout << word << " is no longer in the dictionary.\n";
            }
            break;
        }
        case 5:
        {
            cout << "There are " << countItem(root) << " words.\n";
        }
        }
        cout << "\nDo you want to stop? [y/n] ";
        cin >> continuity;
        cout << endl;
    } while (continuity == "no" || continuity == "n");
    removeAll(root);
}

void demo1()
{
    string suggest;
    cout << "Search: ";
    cin >> suggest;
    ifstream wordlist("words.txt");
    TrieNode *a = new TrieNode;
    buildTrie(a, wordlist);
    suggestItem(a, suggest);
    removeAll(a);
}

int main(int argc, char *argv[])
{
    demo2();
    return 0;
}