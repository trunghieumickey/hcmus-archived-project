# I. Team Information

## Group Members

- Lê Trần Trung Hiếu [20127158] [@trunghieumickey](https://github.com/trunghieumickey)
- Nguyễn Lê Sơn [20127309] [@quanlinhson](https://github.com/quanlinhson)
- Lê Phan Duy Tùng [20127661] [@TungAlter](https://github.com/TungAlter)
- Trần Nguyễn Minh Khôi [20127538] [@Minh-Kop](https://github.com/Minh-Kop)

*github accounts included to tracking commits on github

## Class Info
- Class ID: **20CLC01**.
- Subject: 	Data Structure & Algorithms.
- Instructors: Bùi Huy Thông, Nguyễn Ngọc Thảo.
- Project subject: Advanced Tree 1 - Trie

## Group ID
- Group ID : **E**
- Topic ID : **16**

# II. Introduction
## Build Status
[![C/C++ CI](https://github.com/trunghieumickey/at1-hcmus-trie-project/actions/workflows/build.yml/badge.svg)](https://github.com/trunghieumickey/at1-hcmus-trie-project/actions/workflows/build.yml) https://github.com/trunghieumickey/at1-hcmus-trie-project
## Building Project
There are many ways this project can be built.

GNU C++
```bash
g++ **.cpp -o trie
```

Clang++
```bash
Clang++ **.cpp -o trie
```

Visual C++
```bash
cl -Fe: trie.exe **.cpp 
```

## Program Usage
The project contain a basic trie processing algorithm that you can include into your project (Please ask project owner for public license). 
We also include a demo to demonstrate how it work, the demo search the trie and return all similar words.


# III. Project Report
Trie is a special data structure of the tree. Every node of Trie consists of multiple branches. Each branch represents a possible character of keys and we using a trie node field isEnd is used to distinguish the node as end of word node. Below is our study on basic operations of trie.

## Insertion
To demonstrate how it work. we will add a few short string into our trie. Initially, our trie has a root whose branches are empty and its boolean is false
### Step 1 : Insert "abc"
At first, we start at the trie node named “root”, then we check if key “a” is presented in this node. Because this node is just newly created so “a” is not presented in this node , so we will create a trie node which is presented as key “a” whose boolean is false and find a suitable branch in node “root” point to the node we have created.And then we move to the trie node which represents key “a”.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example001.png)

Next, we check if key “a” is presented in the node which we are tracking,because this node is just newly created so “b” is not presented in this node, so we will create a trie node which is presented as key “b” whose boolean is false and find a suitable branch in node which is represent key “a” point to the node we have created.And then we move to the trie node which represents key “b”.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example002.png)

So again this node is just newly created so “c” doesn’t exist in this node, so we will create a trie node which is presented as key “c” whose boolean is false and find a suitable branch in node which is represent key “b” point to the node we have created.And then we move to the trie node which represents key “c”.Because key “c” is the last character in string “abc”, we will mark the boolean of the node which represents key “c” is true.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example003.png)

### Step 2 : Insert "abgl"
At first, we start at the node root , then we check if key “a” is presented in this node. Key “a” is presented in this node so we move to the next node to insert key “b”

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example004.png)

At this node, we continue to check  “b” if the key “b” is present in this node. Key “b” is presented in this node so we move to the next node to insert key “g”

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example005.png)

Because key “g” is not presented in this node so we create a new node which is presented as key “g” whose boolean is false and find a suitable branch in the node we are tracking point to the node we have created. And then we move to the trie node which represents key “g”.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example006.png)

Key “l” is not presented in this node so we create a new node which is presented as key “l” whose boolean is false and find a suitable branch in the node we are tracking point to the node we have created. And then we move to the trie node which represents key “l”.Because key “l” is the last character in string “abgl”, we will mark the boolean of the node which represents key “l” as true.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example007.png)

### Step 3 : Insert "cdf"
At first, we start at the node root , then we check if key “c” is presented in this node. “c” is not presented in this node so we creat a new node which is presented as key “c” whose boolean is false and find a suitable branch in the node we are tracking point to the node we have created.And then we move to the trie node which represents key “c”.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example008.png)

Next, we check if key “d” is presented in the node which we are tracking,because this node is just newly created so “d” is not presented in this node, so we will create a trie node which is presented as key “d” whose boolean is false and find a suitable branch in the node we are tracking point to the node we have created.And then we move to the trie node which represents key “d”.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example009.png)

Key “f” is not presented in this node so we create a new node which is presented as key “f” whose boolean is false and find a suitable branch in the node we are tracking point to the node we have created. And then we move to the trie node which represents key “f”.Because “f” is the last character in string “cdf”, we will mark the boolean of the node which represents key “f” is true.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example010.png)

### Step 4 : Insert "abcd"
At first, we start at the node root , then we check if key “a” is presented in this node. Key “a” is presented in this node so we move to the next node to insert key “b”.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example011.png)

At this node, we continue to check  “b” if the key “b” is present in this node. Key “b” is presented in this node so we move to the next node to insert key “c”

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example012.png)

At this node, we continue to check if the key “c” is present in this node. Key “c” is presented in this node so we move to the next node which represent key “c” to insert key “d”.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example013.png)

Key “d” is not presented in this node so we create a new node which is presented as key “d” whose boolean is false and find a suitable branch in the node we are tracking point to the node we have created. And then we move to the trie node which represents key “d”.Because “d” is the last character in string “abcd”, we will mark the boolean of the node which represents key “d” as true.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example014.png)

### Time Complexity

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/chart1.png)

The time complexity of this basic operation is Θ(1m). with m is length of word. 

## Deletion
We will now return to the trie we created back in "Insertion". To demonstrate how it work, we will remove words one by one until it empty.

### Step 1 : Delete "abc"
At first, we start at the node root, “a” is not the last character of the string “abc” so we follow the link to move to the next node.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example015.png)

At this node, “b” is not the last character of the string “abc” so we follow the link to the next node.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example016.png)

At this node, “c” is the last character of the string “abc”, so we follow the link to the node which represent key “c”. We can’t remove this node because we will also lose the string “abcd” so we just mark the boolean of this node as false to make the string “abc” doesn’t exist in this trie, and then we stop here.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example017.png)

### Step 2 : Delete "abgl"
At first, we start at the node root, “a” is not the last character of the string “abgl” so we follow the link to move to the next node.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example018.png)

At this node, “b” is not the last character of the string “abgl” so we follow the link to the next node.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example019.png)

At this node, “g” is not the last character of the string “abgl” so we follow the link to the next node.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example020.png)

At this node, “l” is the last character of the string “abgl”, so we follow the link to the node which represent key “l”. We can remove this node because its branches are empty and then we comeback to higher level node to remove it.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example021.png)

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example022.png)

We can remove this node because its branches are empty and then we comeback to higher level node to remove it. 

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example023.png)

Because its branches is not empty so we stop here.

### Step 3 : Delete "cdf"
At first, we start at the node root, “c” is not the last character of the string “cdf” so we follow the link to move to the next node.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example024.png)

At this node, “d” is not the last character of the string “cdf” so we follow the link to the next node.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example025.png)

At this node, “f” is the last character of the string “cdf”, so we follow the link to the node which represent key “f”. We can remove this node because its branches are empty and then we comeback to higher level node to remove it.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example026.png)

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example027.png)

We can remove this node because its branches are empty and then we comeback to higher level node to remove it.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example028.png)

We can remove this node because its branches are empty and then we comeback to higher level node to remove it.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example029.png)

Because its branches is not empty so we stop here.

### Step 4 : Delete "abcd"
At first, we start at the node root, “a” is not the last character of the string “abcd” so we follow the link to move to the next node

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example030.png)

At this node, “b” is not the last character of the string “abcd” so we follow the link to the next node.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example031.png)

At this node, “c” is not the last character of the string “abcd” so we follow the link to the next node.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example032.png)

At this node, “d” is the last character of the string “cdf”, so we follow the link to the node which represent key “f”. We can remove this node because its branches are empty and then we comeback to higher level node to remove it.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example033.png)

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example034.png)

We can remove this node because its branches are empty and then we comeback to higher level node to remove it

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example035.png)

We can remove this node because its branches are empty and then we comeback to higher level node to remove it. 

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example036.png)

We can remove this node because its branches are empty and then we comeback to higher level node to remove it. 

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Example037.png)

Finally, because all the branches of the root are empty and its boolean is false we will delete this root.

### Time Complexity

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/chart1.png)

m is the length of the item.

The best case runing time is Θ(1) when the trie is empty.

The worst case running time is Θ(m) when the trie has that item to delete or when the trie doesn’t have the last letter of that item.

The average case running time Θ(m) (include all situations from the best case, lacking the letters… of that item to situation in worst case)

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Eq2.png)

The time complexity of this basic operation is O(m)

## Check a trie is empty
This function check if the root of trie is NULL or contain no child.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/chart1.png)

The time complexity of this basic operation is Θ(1). since it only have a simple if statement.

## Get the number of items in a trie
This function go through every single node in a trie. Looking for "End" mark then print all the words.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/chart2.png)

The best case runing time is Θ(1) when the trie is empty. 

The worst case running time is Θ(n) when the trie has n nodes in it. 

The time complexity of this basic oeration is O(n).

## Find the item in a trie
This function check if the inputted is appeared inside the trie.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/chart1.png)

m is the length of the item.

The best case runing time is Θ(1) when the trie is empty.

The worst case running time is Θ(m) when the trie has that item or when the trie doesn’t have the last letter of that item.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Eq2.png)

The average case running time Θ(m) (include all situations from the best case, lacking the letters… of that item to situation in worst case)

The time complexity of this basic operation is O(m).

## Build a trie from given list of items.
This function insert every words in the given list.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/chart3.png)

n is the number of items in the file.

m is the length of an item.

The best case runing time is Θ(1) when the file can’t be opened or empty. 

The worst case running time is Θ(nm) when all items in the file have the same highest m.

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/Eq1.png)

The average case running time is Θ(km) (k is all different situations of all m)

The time complexity of this basic operation is O(nm)

## Remove all elements from the trie
This function remove every single node from the trie

![](https://github.com/trunghieumickey/at1-hcmus-trie-project/raw/main/picture/chart2.png)

n is the number of nodes in the trie.

The best case runing time is Θ(1) when the trie is empty. 

The worst case running time is Θ(n) when the trie has n nodes in it. 

The time complexity of this basic operation is O(n).

# IV. Application
## Dictionary Representation
Common applications of tries include storing a predictive text or autocomplete dictionary and implementing approximate matching algorithms, such as those used in spell checking and hyphenation software. Such applications take advantage of a trie's ability to quickly search for, insert, and delete entries. However, if storing dictionary words is all that is required (i.e. there is no need to store metadata associated with each word), a minimal deterministic acyclic finite state automaton (DAFSA) or radix tree would use less storage space than a trie. This is because DAFSAs and radix trees can compress identical branches from the trie which correspond to the same suffixes (or parts) of different words being stored.

## Replacement for Hash Tables
A trie can be used to replace a hash table, over which it has the following advantages:
- Looking up data in a trie is faster in the worst case, O(m) time (where m is the length of a search string), compared to an imperfect hash table. The worst-case lookup speed in an imperfect hash table is O(N) time, but far more typically is O(1), with O(m) time spent evaluating the hash.
- There are no collisions of different keys in a trie. (An imperfect hash table can have key collisions. A key collision is the hash function mapping of different keys to the same position in a hash table.)
-	Buckets in a trie, which are analogous to hash table buckets that store key collisions, are necessary only if a single key is associated with more than one value.
-	There is no need to provide a hash function or to change hash functions as more keys are added to a trie.
-	A trie can provide an alphabetical ordering of the entries by key.

However, a trie also has some drawbacks compared to a hash table:
-	Trie lookup can be slower than hash table lookup, especially if the data is directly accessed on a hard disk drive or some other secondary storage device where the random-access time is high compared to main memory.
-	Some keys, such as floating point numbers, can lead to long chains and prefixes that are not particularly meaningful. Nevertheless, a bitwise trie can handle standard IEEE single and double format floating point numbers.
-	Some tries can require more space than a hash table, as memory may be allocated for each character in the search string, rather than a single chunk of memory for the whole entry, as in most hash tables.

## DFSA Representation
A trie can be seen as a tree-shaped deterministic finite automaton. Each finite language is generated by a trie automaton, and each trie can be compressed into a deterministic acyclic finite state automaton.

## Word break
Given an input string and a dictionary of words, find out if the input string can be segmented into a space-separated sequence of dictionary words. This is a famous Google interview question, also being asked by many other companies nowadays. The idea is simple, we consider each prefix and search it in dictionary. If the prefix is present in dictionary, we recur for rest of the string (or suffix). We can use a array to store the dictionary. But with trie, we can do that easy.

## Spell check
This is very common when you're texting on your computer or searching on the internet. To make sure your text is grammatically correct, they run an algorithm that saved a dictionary into a trie then checkking if your word are vaild. If not, they might try to suggest you the correct word by searching all similar word in dictionary and sort by the frequency it being mistaken.

# V. Project organization and Programming notes
## Github structure

We organized our soure codes and interact with it by using github

| Folder            | Usages                                                             |
|-------------------|--------------------------------------------------------------------|
| .github/workflows | Scripts that check for any errors before committing.               |
| picture           | Folder of images that used in this report.                         |
| trie.cpp          | Contain algorithms of trie processing                              |
| trie.hpp          | List of usable library, functions and prototype of trie            |
| main.cpp          | Main program that utilize all other functions                      |
| words.txt         | English dictionary (107k words)                                    |

## Used library

| Library              | Usages                                                 |
|----------------------|--------------------------------------------------------|
| `iostream`           | Basic functions for C++ programing.                    |
| `fstream`            | Used for files processing.                             |

# VI. Reference Sources
- https://www.geeksforgeeks.org
- https://en.wikipedia.org/wiki/Trie
- https://github.com/dwyl/english-words
