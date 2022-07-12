# Game Project : Road Crossing
Build Status : [![C++ Build](https://github.com/trunghieumickey/team12-hcmus-game-project/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/trunghieumickey/team12-hcmus-game-project/actions/workflows/build.yml)

## I. Project Overview

### Building the game
You can use any compiler that support C++20 and Windows API Library to build this project

#### GNU C++
```pwsh
g++ -std=c++2a **.cpp ScreenControl/cScreen.cpp Obstacle/cObstacle.cpp Obstacle/Animal/**.cpp Obstacle/Vehicle/**.cpp People/cPeople.cpp -o main
```
#### Clang++

```pwsh
clang++ -std=c++2a **.cpp ScreenControl/cScreen.cpp Obstacle/cObstacle.cpp Obstacle/Animal/**.cpp Obstacle/Vehicle/**.cpp People/cPeople.cpp -o main
```
#### Visual C++
```pwsh
cl /std:c++latest /Zi /EHsc /nologo /Fe:main.exe **.cpp ScreenControl/cScreen.cpp Obstacle/cObstacle.cpp Obstacle/Animal/**.cpp Obstacle/Vehicle/**.cpp People/cPeople.cpp user32.lib gdi32.lib
```
### Playing the Game

#### Menu
When the game is started, you can choose up to 4 options:
![](https://raw.githubusercontent.com/trunghieumickey/team12-hcmus-game-project/main/Picture/Picture1.png)

1. New Game
2. Load Game
3. Setting (Currently not available)
4. Exit

#### New Game
![](https://raw.githubusercontent.com/trunghieumickey/team12-hcmus-game-project/main/Picture/Picture2.png)

Your character will be spawned in the middle bottom of the screen. If your character is hit by an obstacle, you will lose the game and the game will be restarted.<br>
![](https://raw.githubusercontent.com/trunghieumickey/team12-hcmus-game-project/main/Picture/Picture3.png)

Press "P" to pause the game.

#### Save & Load Game

You have to enter the path of the file that you want to load or save. type "exit" to cancel the process.
![](https://raw.githubusercontent.com/trunghieumickey/team12-hcmus-game-project/main/Picture/Picture4.png)


## II. Design Of the Project
![](https://raw.githubusercontent.com/trunghieumickey/team12-hcmus-game-project/main/Picture/Diagram.png)

## III. About Our Team

### Credits

- Lê Trần Trung Hiếu [20127158] [@trunghieumickey](https://github.com/trunghieumickey) (Project Leader, Setup Github workflows, Writer of `ScreenControl`, `cGame` and most of this report)
  
- Nguyễn Hoàng Gia Huy [20127186] [@giahuyday](https://github.com/giahuyday) (Designer of `cObstacle`, movement part of `cPeople`, Writer of the Instruction part of this report)
- Thái Văn Thiên [20127631] [@thienhk15](https://github.com/thienhk15) (Designer of UI including Main Menu and Pause Menu)
- Lê Phan Duy Tùng [20127661] [@TungAlter](https://github.com/TungAlter) (Designer of `cPeople` and Levels)

*github accounts included to tracking commits on github

### Class Info
- Class ID: **20CLC01**
- Subject: 	Object Oriented Programming
- Instructors: Đinh Bá Tiến
- Project subject: Road Crossing
