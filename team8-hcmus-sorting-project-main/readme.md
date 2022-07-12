# I. Team Information

## Group Members

- Lê Trần Trung Hiếu 	[20127158] [@trunghieumickey](https://github.com/trunghieumickey)
- Nguyễn Thái Bảo 		[20127448] [@baobao1911](https://github.com/baobao1911)
- Phạm Nguyễn Gia Bảo 	[20127119] [@PHAMNGUYENGIABAO](https://github.com/PHAMNGUYENGIABAO)
- Nguyễn Hoàng Phúc 	[20127282] [@phuc4570](https://github.com/phuc4570)

*github accounts included to tracking commits on github

## Class Info
- Class ID: **20CLC01**.
- Subject: 	Data Structure & Algorithms.
- Instructors: Bùi Huy Thông, Nguyễn Ngọc Thảo.
- Project set: 2 (Include 11 Algorithms).

# II. Introduction
## Build Status
[![C/C++ CI](https://github.com/trunghieumickey/team8-hcmus-sorting-project/actions/workflows/c-cpp.yml/badge.svg)](https://github.com/trunghieumickey/team8-hcmus-sorting-project/actions/workflows/c-cpp.yml) https://github.com/trunghieumickey/team8-hcmus-sorting-project
## Building Project
There are many ways this project can be built.

GNU C++
```bash
g++ **.cpp runtime/**.cpp comparison/**.cpp -o sort
```

Clang++
```bash
Clang++ **.cpp runtime/**.cpp comparison/**.cpp -o sort
```

Visual C++
```bash
cl -Fe: sort.exe **.cpp runtime/**.cpp comparison/**.cpp
```

## Program Usage
### Algorithm mode
In this mode, you are asked to run a specified sorting algorithm on the input data, which is either given or generated automatically, and present the resulting running time and/or number of comparisons:

- Command 1: Run a sorting algorithm on the given input data.
```
[Execution file] -a [Algorithm] [Given input] [Output parameter(s)]
```
- Command 2: Run a sorting algorithm on the data generated automatically with specified
size and order.
```
[Execution file] -a [Algorithm] [Input size] [Input order] [Output parameter(s)]
```

- Command 3: Run a sorting algorithm on ALL data arrangements of a specified size.
```
[Execution file] -a [Algorithm] [Input size] [Output parameter(s)]
```
### Comparison mode
In this mode, you have to run TWO specified sorting algorithms on the input data, which is either given or generated automatically, and present the resulting running times and/or numbers of comparisons:
- Command 4: Run two sorting algorithms on the given input.
```
[Execution file] -c [Algorithm 1] [Algorithm 2] [Given input]
```
- Command 5: Run two sorting algorithms on the data generated automatically.
```
[Execution file] -c [Algorithm 1] [Algorithm 2] [Input size] [Input order]
```
### Available sorting algorithms list
`selection-sort` `insertion-sort` `bubble-sort` `shaker-sort` `shell-sort` `heap-sort` `merge-sort` `quick-sort` `counting-sort` `radix-sort` and `flash-sort`

### Available input order list
`-rand` `-sorted` `-nsorted` and `-rev`


# III. Algorithm infomation
## 1. Selection sort
Complexity: O(n^2)

The selection sort algorithm sorts an array by repeatedly finding the minimum element (considering ascending order) from unsorted part and putting it at the beginning. The algorithm maintains two subarrays in a given array.

1. The subarray which is already sorted. 
2. Remaining subarray which is unsorted

In every iteration of selection sort, the minimum element (considering ascending order) from the unsorted subarray is picked and moved to the sorted subarray.

## 2. Insertion Sort
Complexity: O(n^2)

Insertion sort is a simple sorting algorithm that works similar to the way you sort playing cards in your hands. The array is virtually split into a sorted and an unsorted part. Values from the unsorted part are picked and placed at the correct position in the sorted part. 

## 3. Bubble Sort
Complexity: O(n^2)

Bubble sort is a simple sorting algorithm, with the basic operation of comparing two adjacent elements, if they are not in the correct order, swap them (swap). It can be done from top down (left to right) or bottom up (right side). Bubble sort is also known as direct comparison sort. It uses element comparison, so it is a comparison sort algorithm.

## 4. Shaker Sort
Shaker sort (Cocktail Sort) is a variation of Bubble sort. The Bubble sort algorithm always traverses elements from left and moves the largest element to its correct position in first iteration and second largest in second iteration and so on. Shaker sort traverses through a given array in both directions alternatively.

## 5. Shell Sort
ShellSort is mainly a variation of Insertion Sort. In insertion sort, we move elements only one position ahead. When an element has to be moved far ahead, many movements are involved. The idea of shellSort is to allow exchange of far items. In shellSort, we make the array h-sorted for a large value of h. We keep reducing the value of h until it becomes one. An array is said to be h-sorted if all sublists of every h’th element is sorted.

## 6. Heap Sort
Heap sort is a comparison-based sorting technique based on Binary Heap data structure. It is similar to selection sort where we first find the minimum element and place the minimum element at the beginning. We repeat the same process for the remaining elements.

## 7. Merge Sort
Complexity: O(nlog(n))

Need 1 array memory ( no auxiliary memory needed )

Merge Sort is one of the most efficient sorting algorithms. It works on the principle of Divide and Conquer. Merge sort repeatedly breaks down a list into several sublists until each sublist consists of a single element and merging those sublists in a manner that results into a sorted list.

1. Divide the unsorted list into n sublists, each comprising 1 element
2. Repeatedly merge sublists to produce newly sorted sublists until there is only 1 sublist remaining. This will be the sorted list.

## 8. Quick Sort
Complexity: O(nlog(n))

Quicksort, also known as part sort, is a sorting algorithm developed by C.A.R. Hoarec sorts into two sublists. Unlike merge sort, split the list to be sorted a[1..n] into two sublists of relatively equal size thanks to the vertical index. between the list, quick sort splits it into two lists by comparing each element of the list with a selected element called the latch element. Elements less than or equal to the pin are moved forward and are in the first sublist, those greater than the pin are moved to the back and are in the latter list. Keep dividing like this until all the sublists are 1 in length.

## 9. Counting Sort
Counting sort is a sorting technique based on keys between a specific range. It works by counting the number of objects having distinct key values (kind of hashing). Then doing some arithmetic to calculate the position of each object in the output sequence.

## 10. Radix Sort
Complexity: O((n+b) * logb(k)) (b is the base for representing numbers, k is the maximum possible value) or O(n).

Need b more arrays of digits of base

Radix Sort algorithm will start sorting from the beginning to the end of the array by counting sort, in precedence from least significant digit to most significant digit. After each counting sort, it will in turn retrieve each element from the arrays of digits in order of precedence from highest to lowest, first to last. Repeat this until sorted as many times as the number of digits of the maximum value. The array will be sorted.

## 11. Flash Sort:
Flashsort is an efficient in-place implementation of histogram sort, itself a type of bucket sort. It assigns each of the n input elements to one of m buckets, efficiently rearranges the input to place the buckets in the correct order, then sorts each bucket.

# IV. Experimental results and comments
We have created 4 group of data tables corresponding to 4 data orders for running time and comparision. The data is collected from the test runs using the commands above. In addition, we also have graphs for each test mode, namely algorithm(running time testing) mode and comparison mode. A total of 8 charts with comments for each chart.
## Table 1: Randomized Data
### Runing time
| Data size         | 10000        | 30000        | 50000        | 100000       | 300000       | 500000       |
|-------------------|--------------|--------------|--------------|--------------|--------------|--------------|
| Resulting statics | Running time | Running time | Running time | Running time | Running time | Running time |
| Selection Sort    | 155          | 1336         | 3833         | 15300        | 137560       | 386072       |
| Insertion Sort    | 79           | 712          | 1991         | 7919         | 71715        | 200604       |
| Bubble Sort       | 409          | 3890         | 10560        | 42741        | 379753       | 1042084      |
| Shaker Sort       | 1090         | 9844         | 27157        | 108118       | 997249       | 1276530      |
| Shell Sort        | 2            | 10           | 20           | 45           | 148          | 307          |
| Heap Sort         | 5            | 11           | 20           | 40           | 130          | 226          |
| Merge Sort        | 5            | 17           | 26           | 52           | 145          | 240          |
| Quick Sort        | 3            | 7            | 20           | 35           | 106          | 182          |
| Counting Sort     | 1            | 1            | 2            | 2            | 5            | 8            |
| Radix Sort        | 2            | 7            | 11           | 21           | 63           | 102          |
| Flash Sort        | 0            | 2            | 3            | 6            | 21           | 35           |

![](https://github.com/trunghieumickey/team8-hcmus-sorting-project/raw/main/chart/rand1.png)

On our observations, the fastest algorithm
- in case 10000 data size: Flash Sort(0ms)
- in case 30000 data size: Counting Sort(1ms)
- in case 50000 data size: Counting Sort(2ms)
- in case 1000000 data size: Counting Sort(2ms)
- in case 3000000 data size: Counting Sort(5ms)
- in case 5000000 data size: Counting Sort(8ms)

The slowest algorithm
- in case 10000 data size: Shaker Sort(1090ms)
- in case 30000 data size: Shaker Sort(9844ms)
- in case 50000 data size: Shaker Sort(27157ms)
- in case 1000000 data size: Shaker Sort(108118ms)
- in case 3000000 data size: Shaker Sort(997249ms)
- in case 5000000 data size: Shaker Sort(1276530ms)

Shaker Sort's algorithm acceleration is the highest.

### Comparision
| Data size         | 10000       | 30000       | 50000       | 100000      | 300000      | 500000       |
|-------------------|-------------|-------------|-------------|-------------|-------------|--------------|
| Resulting statics | Comparision | Comparision | Comparision | Comparision | Comparision | Comparision  |
| Selection Sort    | 100010000   | 900030000   | 2500049999  | 10000099999 | 90000299999 | 250000500000 |
| Insertion Sort    | 49552401    | 453023608   | 1252260592  | 4992738183  | 44960592125 | 124875521035 |
| Bubble Sort       | 100010000   | 900030000   | 2500050001  | 10000100001 | 90000300001 | 250000500000 |
| Shaker Sort       | 66423752    | 601037890   | 1668823552  | 6644355162  | 59974681662 | 166528210803 |
| Shell Sort        | 639899      | 2241093     | 4345560     | 10067867    | 33916822    | 66711570     |
| Heap Sort         | 520511      | 1750813     | 2985421     | 6369926     | 20996928    | 37284589     |
| Merge Sort        | 841269      | 2765366     | 3383210     | 7165506     | 23383927    | 57814985     |
| Quick Sort        | 271072      | 900605      | 1503044     | 3150671     | 10394460    | 18866065     |
| Counting Sort     | 70003       | 210002      | 315539      | 565539      | 1565539     | 2565539      |
| Radix Sort        | 140058      | 510072      | 850072      | 1700072     | 5100072     | 8500072      |
| Flash Sort        | 94583       | 294914      | 418936      | 790016      | 2370024     | 5925822      |

![](https://github.com/trunghieumickey/team8-hcmus-sorting-project/raw/main/chart/rand2.png)

On our observations, the most comparisons algorithm
- in case 10000 data size: Selection Sort(100010000) and Bubble Sort(100010000)
- in case 30000 data size: Selection Sort (900030000) and Bubble Sort(900030000)
- in case 50000 data size: Selection Sort(2500049999) and Bubble Sort(2500050001)
- in case 1000000 data size: Selection Sort(10000099999) and Bubble Sort(10000100001)
- in case 3000000 data size: Selection Sort(90000299999) and Bubble Sort(90000300001)
- in case 5000000 data size: Selection Sort(250000500000) and Bubble Sort(250000500000)

The least comparisons algorithm
- in case 10000 data size: Counting Sort(70003)
- in case 30000 data size: Counting Sort(210002)
- in case 50000 data size: Counting Sort(315539)
- in case 1000000 data size: Counting Sort(565539)
- in case 3000000 data size: Counting Sort(1565539)
- in case 5000000 data size: Counting Sort(2565539)

## Table 2: Nearly Sorted Data
### Runing time
| Data size         | 10000        | 30000        | 50000        | 100000       | 300000       | 500000       |
|-------------------|--------------|--------------|--------------|--------------|--------------|--------------|
| Resulting statics | Running time | Running time | Running time | Running time | Running time | Running time |
| Selection Sort    | 71           | 741          | 2032         | 8283         | 81985        | 266072       |
| Insertion Sort    | 105          | 1416         | 2510         | 4641         | 7048         | 17681        |
| Bubble Sort       | 5            | 9            | 15           | 11           | 37           | 24           |
| Shaker Sort       | 4            | 15           | 16           | 14           | 12           | 14           |
| Shell Sort        | 3            | 11           | 8            | 12           | 8            | 18           |
| Heap Sort         | 4            | 7            | 7            | 11           | 12           | 16           |
| Merge Sort        | 8            | 12           | 10           | 11           | 15           | 23           |
| Quick Sort        | 4            | 12           | 9            | 15           | 17           | 21           |
| Counting Sort     | 3            | 12           | 8            | 14           | 16           | 13           |
| Radix Sort        | 3            | 12           | 8            | 16           | 12           | 15           |
| Flash Sort        | 4            | 9            | 11           | 13           | 20           | 14           |

![](https://github.com/trunghieumickey/team8-hcmus-sorting-project/raw/main/chart/nsort1.png)

On our observations, the fastest algorithm
- in case 10000 data size: Shell Sort(3ms), Counting Sort(3ms) and Radix Sort(3ms)
- in case 30000 data size: Heap Sort(7ms)
- in case 50000 data size: Heap Sort(7ms)
- in case 1000000 data size: Bubble Sort(11ms), Heap Sort(11ms) and Merge Sort(11ms)
- in case 3000000 data size: Shell Sort(8ms)
- in case 5000000 data size: Counting Sort(13ms)

The slowest algorithm
- in case 10000 data size: Insertion Sort(105ms)
- in case 30000 data size: Insertion Sort(1416ms)
- in case 50000 data size: Insertion Sort(2510ms)
- in case 1000000 data size: Selection Sort(8283ms)
- in case 3000000 data size: Selection Sort(81985ms)
- in case 5000000 data size: Selection Sort(266072ms)

Selection Sort's algorithm acceleration is the highest.

### Comparision
| Data size         | 10000       | 30000       | 50000       | 100000      | 300000      | 500000       |
|-------------------|-------------|-------------|-------------|-------------|-------------|--------------|
| Resulting statics | Comparision | Comparision | Comparision | Comparision | Comparision | Comparision  |
| Selection Sort    | 100009999   | 900029999   | 2500049999  | 1410040049  | 4097600155  | 250000500000 |
| Insertion Sort    | 119734013   | 1546114231  | 2793572064  | 1032806065  | 3573419590  | 2961997038   |
| Bubble Sort       | 201650      | 381198      | 653090      | 661166      | 1664402     | 2344234      |
| Shaker Sort       | 179078      | 574418      | 643306      | 766034      | 1234994     | 1997370      |
| Shell Sort        | 134102      | 466882      | 433030      | 752678      | 1139142     | 2013486      |
| Heap Sort         | 140798      | 340530      | 367458      | 722610      | 1305866     | 2035058      |
| Merge Sort        | 157342      | 485834      | 483590      | 637414      | 23383927    | 1903942      |
| Quick Sort        | 167678      | 518850      | 436870      | 660202      | 1408366     | 1958190      |
| Counting Sort     | 135478      | 509082      | 435090      | 565539      | 1374254     | 1904554      |
| Radix Sort        | 215030      | 518878      | 429334      | 862074      | 1300086     | 1971762      |
| Flash Sort        | 94583       | 407602      | 532394      | 779366      | 1443914     | 1914798      |

![](https://github.com/trunghieumickey/team8-hcmus-sorting-project/raw/main/chart/nsort2.png)

On our observations, the most comparisons algorithm
- in case 10000 data size: Insertion Sort(119734013)
- in case 30000 data size: Insertion Sort(1546114231)
- in case 50000 data size: Insertion Sort(2793572064)
- in case 1000000 data size: Selection Sort(1410040049)
- in case 3000000 data size: Selection Sort(4097600155)
- in case 5000000 data size: Selection Sort(250000500000)

The least comparison algorithm
- in case 10000 data size: Flash Sort(94583)
- in case 30000 data size: Heap Sort(340530)
- in case 50000 data size: Heap Sort(367458)
- in case 1000000 data size: Counting Sort(565539)
- in case 3000000 data size: Shell Sort(1139142)
- in case 5000000 data size: Merge Sort(1903942)

## Table 3: Sorted Data
### Running time
| Data size         | 10000        | 30000        | 50000        | 100000       | 300000       | 500000       |
|-------------------|--------------|--------------|--------------|--------------|--------------|--------------|
| Resulting statics | Running time | Running time | Running time | Running time | Running time | Running time |
| Selection Sort    | 103          | 836          | 2599         | 10384        | 93273        | 257481       |
| Insertion Sort    | 1            | 1            | 1            | 0            | 2            | 2            |
| Bubble Sort       | 116          | 1070         | 2871         | 11477        | 103017       | 285536       |
| Shaker Sort       | 1            | 2            | 2            | 2            | 4            | 4            |
| Shell Sort        | 1            | 3            | 3            | 5            | 17           | 22           |
| Heap Sort         | 4            | 15           | 22           | 43           | 146          | 238          |
| Merge Sort        | 7            | 25           | 39           | 69           | 200          | 334          |
| Quick Sort        | 2            | 3            | 4            | 9            | 25           | 42           |
| Counting Sort     | 0            | 1            | 1            | 2            | 6            | 8            |
| Radix Sort        | 1            | 4            | 7            | 12           | 37           | 55           |
| Flash Sort        | 0            | 1            | 2            | 3            | 9            | 13           |

![](https://github.com/trunghieumickey/team8-hcmus-sorting-project/raw/main/chart/sort1.png)

On our observations, the fastest algorithm
- in case 10000 data size: Counting Sort(0ms) and Flash Sort(0ms)
- in case 30000 data size: Insertion Sort(1ms), Counting Sort(1ms) and Flash Sort(1ms)
- in case 50000 data size: Insertion Sort(1ms) and Counting Sort(1ms)
- in case 1000000 data size: Insertion Sort(0ms)
- in case 3000000 data size: Insertion Sort(2ms)
- in case 5000000 data size: Insertion Sort(2ms)

The slowest algorithm
- in case 10000 data size: Bubble Sort(116ms)
- in case 30000 data size: Bubble Sort(1070ms)
- in case 50000 data size: Bubble Sort(2871ms)
- in case 1000000 data size: Bubble Sort(11477ms)
- in case 3000000 data size: Bubble Sort(103017ms)
- in case 5000000 data size: Bubble Sort(285536ms)

Bubble Sort's algorithm acceleration is the highest.

### Comparision
| Data size         | 10000       | 30000       | 50000       | 100000      | 300000      | 500000      |
|-------------------|-------------|-------------|-------------|-------------|-------------|-------------|
| Resulting statics | Comparision | Comparision | Comparision | Comparision | Comparision | Comparision |
| Selection Sort    | 250024998   | 2250074998  | 6250124998  | 25000249998 | 2,25001E+11 | 5,00001E+11 |
| Insertion Sort    | 49743337    | 453344523   | 1252883969  | 4993483604  | 44962326694 | 1,24895E+11 |
| Bubble Sort       | 250025003   | 2250075003  | 6250125003  | 25000250003 | 2,25001E+11 | 6,25001E+11 |
| Shaker Sort       | 66535615    | 601839690   | 1669578905  | 6645431047  | 59976966569 | 1,66317E+11 |
| Shell Sort        | 1225588     | 4114032     | 7672510     | 16997125    | 57009088    | 105963113   |
| Heap Sort         | 1282335     | 4315170     | 7577339     | 16158954    | 53189467    | 92227018    |
| Merge Sort        | 1328470     | 4365182     | 7567491     | 15891063    | 51440748    | 88518977    |
| Quick Sort        | 547318      | 1798518     | 3113373     | 6521308     | 17613868    | 36278697    |
| Counting Sort     | 175008      | 525008      | 840544      | 1615544     | 4715544     | 7815544     |
| Radix Sort        | 350145      | 1275180     | 2125180     | 4250180     | 14100201    | 23500201    |
| Flash Sort        | 234039      | 982054      | 1161412     | 2274992     | 6825000     | 11375002    |

![](https://github.com/trunghieumickey/team8-hcmus-sorting-project/raw/main/chart/sort2.png)

On our observations, the most comparisons algorithm
- in case 10000 data size: Selection Sort(250024998) and Bubble Sort(250025003)
- in case 30000 data size: Bubble Sort(2250075003)
- in case 50000 data size: Selection Sort(6250124998) and Bubble Sort(6250125003)
- in case 1000000 data size: Selection Sort(25000249998) and Bubble Sort(25000250003)
- in case 3000000 data size: Selection Sort(225001000000) and Bubble Sort(225001000000)
- in case 5000000 data size: Bubble Sort(625001000000)

The least comparison algorithm
- in case 10000 data size: Counting Sort(175008)
- in case 30000 data size: Counting Sort(525008)
- in case 50000 data size: Counting Sort(840544)
- in case 1000000 data size: Counting Sort(1615544)
- in case 3000000 data size: Counting Sort(4715544)
- in case 5000000 data size: Counting Sort(7815544)

## Table 4: Revert Sorted Data
### Running time
| Data size         | 10000        | 30000        | 50000        | 100000       | 300000       | 500000       |
|-------------------|--------------|--------------|--------------|--------------|--------------|--------------|
| Resulting statics | Running time | Running time | Running time | Running time | Running time | Running time |
| Selection Sort    | 80           | 901          | 1973         | 7846         | Timed Out    | 214016       |
| Insertion Sort    | 165          | 978          | 2702         | 10859        | 95190        | 269417       |
| Bubble Sort       | 190          | 1709         | 5643         | 23786        | Timed Out    | 2263510      |
| Shaker Sort       | 988          | 8688         | 23388        | 94837        | 848026       | 2287941      |
| Shell Sort        | 2            | 7            | 10           | 23           | 66           | 110          |
| Heap Sort         | 4            | 13           | 19           | 40           | 138          | 238          |
| Merge Sort        | 9            | 25           | 34           | 76           | 195          | 333          |
| Quick Sort        | 1            | 3            | 5            | 9            | 27           | 45           |
| Counting Sort     | 1            | 1            | 1            | 2            | 5            | 8            |
| Radix Sort        | 1            | 3            | 7            | 10           | 33           | 56           |
| Flash Sort        | 0            | 1            | 2            | 3            | 9            | 14           |

![](https://github.com/trunghieumickey/team8-hcmus-sorting-project/raw/main/chart/rev1.png)

On our observations, the fastest algorithm
- in case 10000 data size: Counting Sort(0ms) and Flash Sort(0ms)
- in case 30000 data size: Counting Sort(1ms) and Flash Sort(1ms)
- in case 50000 data size: Counting Sort(2ms)
- in case 1000000 data size: Counting Sort(3ms)
- in case 3000000 data size: Counting Sort(13ms)
- in case 5000000 data size: Counting Sort(15ms)

The slowest algorithm
- in case 10000 data size: Shaker Sort(882ms)
- in case 30000 data size: Shaker Sort(8688ms)
- in case 50000 data size: Shaker Sort(23388ms)
- in case 1000000 data size: Shaker Sort(94837ms)
- in case 3000000 data size: Shaker Sort(848026ms)
- in case 5000000 data size: Shaker Sort(2287941ms)

Shaker Sort's algorithm acceleration is the highest.

### Comparision
| Data size         | 10000       | 30000       | 50000       | 100000      | 300000      | 500000      |
|-------------------|-------------|-------------|-------------|-------------|-------------|-------------|
| Resulting statics | Comparision | Comparision | Comparision | Comparision | Comparision | Comparision |
| Selection Sort    | 100010000   | 900029999   | 2500049999  | 1410040049  | 90000299999 | 2,5E+11     |
| Insertion Sort    | 100009999   | 1353419521  | 3753008967  | 14993733602 | 1,34963E+11 | 3,74896E+11 |
| Bubble Sort       | 100010001   | 900030001   | 2500050001  | 10000100001 | 3,60001E+11 | 1E+12       |
| Shaker Sort       | 166560616   | 1501914691  | 4169703906  | 16645681048 | 90000150001 | 4,16318E+11 |
| Shell Sort        | 1880784     | 6253108     | 11567162    | 25336340    | 84660970    | 152570723   |
| Heap Sort         | 2047331     | 6894007     | 12099309    | 25804958    | 84983695    | 147391835   |
| Merge Sort        | 2042532     | 6718604     | 11662849    | 24531789    | 79472034    | 136864311   |
| Quick Sort        | 839785      | 2746168     | 4748679     | 7644847     | 32202675    | 55111187    |
| Counting Sort     | 280012      | 840012      | 1365548     | 2665548     | 7865548     | 13065548    |
| Radix Sort        | 560232      | 2040288     | 3400288     | 6800288     | 23100330    | 38500330    |
| Flash Sort        | 374539      | 1125196     | 1863912     | 3679992     | 11040000    | 18400002    |

![](https://github.com/trunghieumickey/team8-hcmus-sorting-project/raw/main/chart/rev2.png)

On our observations, the most comparisons algorithm
- in case 10000 data size: Shaker Sort(166560616)
- in case 30000 data size: Shaker Sort(1501914691)
- in case 50000 data size: Shaker Sort(4169703906)
- in case 1000000 data size: Shaker Sort(16645681048);
- in case 3000000 data size: Bubble Sort(360001000000)
- in case 5000000 data size: Shaker Sort(416318000000)

The least comparison algorithm
- in case 10000 data size: Counting Sort(280012)
- in case 30000 data size: Counting Sort(840012)
- in case 50000 data size: Counting Sort(1365548)
- in case 1000000 data size: Counting Sort(2665548)
- in case 3000000 data size: Counting Sort(7865548)
- in case 5000000 data size: Counting Sort(13065548)

# V. Project organization and Programming notes
## Github structure

We organized our soure codes and interact with it by using github

| Folder            | Usages                                                             |
|-------------------|--------------------------------------------------------------------|
| .github/workflows | Scripts that check for any errors before committing.               |
| comparisons       | Set of sorting functions. designed to count number of comparisons. |
| runtime           | Set of sorting functions. designed to calculate run time.          |
| chart             | Folder of chart images that used in this report.                   |
| ArrayIO.cpp       | functions used for input/output of the main program                |
| DataGenerator.cpp | function used to generate random sets of numbers.                  |
| main.cpp          | Main program that utilize all other functions                      |
| main.h            | List of usable library and functions                               |

## Used library

| Library              | Usages                                                 |
|----------------------|--------------------------------------------------------|
| `iostream` `cstdlib` | Basic functions for C++ programing.                    |
| `cstream`            | Used for files processing.                             |
| `cmath`              | Used for various calculations.                         |
| `ctime`              | Used to generate random numbers and calculate runtime. |
| `cstring`            | Used to process parameters and file’s name.            |

# VI. Citation
In the end we’d like to provide the following sites that we have referenced to deal with researching and building the project

`wikipedia.org`
`www.w3schools.com`
`www.geeksforgeeks.org`
`www.cplusplus.com`
`nguyenvanhieu.vn`
`simplesnippets.tech`
`www.stdio.vn`
`codelearn.io`
`stackoverflow.com`
`geeksforgeeks.org`
