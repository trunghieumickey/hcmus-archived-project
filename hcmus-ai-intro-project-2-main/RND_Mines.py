import random 

def printM(A):
    for i in range(0,len(A)):
        for j in range(0,len(A[0])):
            print(A[i][j], end=" ")
        print()
    print()

def random_Matrix(n,m):
    l = random.sample(range(0,n*m),n*m)
    RMatrix = []
    for i in range(0,n):
        RMatrix.append([])
        for j in range(0,m):
            RMatrix[i].append(l[i*m+j])
    return RMatrix

def RandomPlaceforNumbers_Matrix(A):
    TF = []
    for i in range(0,len(A)):
        TF.append([])
        for j in range(0,len(A[0])):
            #percentage of number cells
            if A[i][j] < (len(A)*len(A[0])*0.25):
                TF[i].append(1)
            else:
                TF[i].append(0)
    return TF

def Draw_Matrix(A):
    Draw_M = []
    for i in range(0,len(A)):
        Draw_M.append([])
        for j in range(0,len(A[0])):
            #percentage of colored cells
            if A[i][j] < (len(A)*len(A[0])*0.5):
                Draw_M[i].append(1)
            else:
                Draw_M[i].append(0)
    return Draw_M

def Range_of_Color_Matrix(Random_Place_for_Numbers_Matrix, Draw_M):
    Range_of_Color = []
    for i in range(0,len(Random_Place_for_Numbers_Matrix)):
        Range_of_Color.append([])
        for j in range(0,len(Random_Place_for_Numbers_Matrix[0])):
            if Random_Place_for_Numbers_Matrix[i][j] == 1:
                count = 0
                if i-1 >= 0 and j-1 >= 0 and Draw_M[i-1][j-1] == 1: count += 1
                if i-1 >= 0 and Draw_M[i-1][j] == 1: count += 1
                if i-1 >= 0 and j+1 < len(Draw_M[0]) and Draw_M[i-1][j+1] == 1: count += 1
                if j-1 >= 0 and Draw_M[i][j-1] == 1: count += 1
                if Draw_M[i][j] == 1: count += 1
                if j+1 < len(Draw_M[0]) and Draw_M[i][j+1] == 1: count += 1
                if i+1 < len(Draw_M) and j-1 >= 0 and Draw_M[i+1][j-1] == 1: count += 1
                if i+1 < len(Draw_M) and Draw_M[i+1][j] == 1: count += 1
                if i+1 < len(Draw_M) and j+1 < len(Draw_M[0]) and Draw_M[i+1][j+1] == 1: count += 1
                Range_of_Color[i].append(count)
            else : 
                Range_of_Color[i].append(-1)
    return Range_of_Color

def out(Random_Place_for_Numbers_Matrix, Range_of_Color_Matrix, Draw_W):
    #print Random_Place_for_Numbers_Matrix
    with open("RandomPlaceforNumber.txt","w") as fr:
        for i in range(0,len(Random_Place_for_Numbers_Matrix)):
            for j in range(0,len(Random_Place_for_Numbers_Matrix[0])):
                if Random_Place_for_Numbers_Matrix[i][j] == 1:
                    #The value with the number 1 is placed (N)
                    fr.write("N")
                    fr.write(" ")
                else:
                    #The value with the number 0 is not placed (.)
                    fr.write(".")
                    fr.write(" ")
            fr.write("\n")

    #print Range_of_Color_Matrix
    with open("out.txt", "w") as f:
        for i in range(0,len(Range_of_Color_Matrix)):
            for j in range(0,len(Range_of_Color_Matrix[0])):
                    f.write(str(Range_of_Color_Matrix[i][j]))
                    f.write(" ")
            f.write("\n")

    #print Draw_W
    with open("color.txt", "w") as fc:
        for i in range(0,len(Draw_W)):
            for j in range(0,len(Draw_W[0])):
                    if Draw_W[i][j] == 1:
                        #The value with the number 1 is colored (D)
                        fc.write("D")
                        fc.write(" ")
                    else:
                        #The value with the number 0 is not colored (.)
                        fc.write(".")
                        fc.write(" ")
            fc.write("\n")

def InputMatrix():
    n = int(input("Enter the number of rows of Matrix: "))
    m = int(input("Enter the number of columns of Matrix: "))
    
    A = random_Matrix(n,m)
    #print("Matrix A:")
    #printM(A)

    #Random_Place_for_Numbers_Matrix use to determine the position of the numbers in the matrix A
    Random_Place_for_Numbers_Matrix = RandomPlaceforNumbers_Matrix(A)
    print("Matrix of Random place for numbers:")
    printM(Random_Place_for_Numbers_Matrix)

    #Draw_M use to determine the color in random place in the matrix A
    Draw_W = Draw_Matrix(A)
    print("Matrix of Draw Random:")
    printM(Draw_W)

    #Range_of_Color_Matrix use to determine the range of color of each position in the matrix A
    RoC_Matrix = Range_of_Color_Matrix(Random_Place_for_Numbers_Matrix,Draw_W)
    print("Matrix Range of Color:")
    printM(RoC_Matrix)

    out(Random_Place_for_Numbers_Matrix,RoC_Matrix,Draw_W)
    print("The output is in out.txt, color.txt and RandomPlaceforNumber.txt")

def onRandomClick(width,height,filename = "output.txt"):
    A = random_Matrix(width,height)
    A = Range_of_Color_Matrix(RandomPlaceforNumbers_Matrix(A),Draw_Matrix(A))
    with open(filename, "w") as f:
        for i in A:
            print(*i, sep=" ", file=f)
    return filename
