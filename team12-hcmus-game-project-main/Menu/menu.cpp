#include"menu.hpp"



void GotoXY(int x, int y, string s)
{
	GotoXY(x, y);
	cout << s;
}




void introMenu(cGame& level) {


	//loading();
	int left = 35;

	GotoXY(18,7,  "|$$\\   /$$| |$$$$$$  |$$\\   |$|  |$|    |$|");
	GotoXY(18, 8, "|$|\\\\_//|$| |$|      |$|\\\\  |$|  |$|    |$|");
	GotoXY(18, 9, "|$| \\_/ |$| |$$$$$   |$| \\\\ |$|  |$|    |$|");
	GotoXY(18, 10,"|$|     |$| |$|      |$|  \\\\|$|  |$|    |$|");
	GotoXY(18, 11,"|$|     |$| |$$$$$$  |$|   \\$$|  |$$$$$$|$|");
	
	/*for (int i = left - 3; i <= left + 15; i++) ColorPrint(i, 16, 7, char(203));
	for (int i = left - 3; i <= left + 15; i++) ColorPrint(i, 21, 7, char(196));
	for (int i = 17; i <= 20; i++) ColorPrint(32, i, 7, char(179));
	for (int i = 17; i <= 20; i++) ColorPrint(50, i, 7, char(179));*/

	
	string s[4] = { "3. Settings","","","3. Save Game" };
	string menu[4] = { "1. New Game","2. Load Game","","4. Exit" };
	if(level.state==3) menu[0]="1. Continue Game";
	else menu[0]="1. New game";
	menu[2] = s[level.state];
	for (int i = 17; i <= 17 + 3; i++) {
		GotoXY(left, i, menu[i - 17]);
	}
	int choice;
	string c;
	GotoXY(left,22,"Your choice: ");
	GotoXY(50,22,"     ");
	GotoXY(50,22); cin>>choice;
	GotoXY(50,22,"     ");

	if(choice==1) {
		system("cls");
		level.startGame();
	}
	else if(choice == 3 && level.state==3) {
		level.saveGame(pathMenu());
		level.state =0;
		level.lvl =1;
		showMenu(level);
	}
	else if(choice == 2) {
		level.loadGame(pathMenu());
	}
	else if(choice==4) exit(0);
}
	




void FixConsoleWindow()
{
	HWND consoleWindow = GetConsoleWindow();
	LONG style = GetWindowLong(consoleWindow, GWL_STYLE);
	style = style & ~(WS_MAXIMIZEBOX) & ~(WS_THICKFRAME);
	SetWindowLong(consoleWindow, GWL_STYLE, style);
}

void ShowCur(bool CursorVisibility)
{
	HANDLE handle = GetStdHandle(STD_OUTPUT_HANDLE);
	CONSOLE_CURSOR_INFO ConCurInf;

	ConCurInf.dwSize = 10;
	ConCurInf.bVisible = CursorVisibility;

	SetConsoleCursorInfo(handle, &ConCurInf);
}

void SetWindowSize(SHORT width, SHORT height)
{
	HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE);
	SMALL_RECT WindowSize;
	WindowSize.Top = 0;
	WindowSize.Left = 0;
	WindowSize.Bottom = height;
	WindowSize.Right = width;

	SetConsoleWindowInfo(hStdout, 1, &WindowSize);
}
void SetScreenBufferSize(SHORT width, SHORT height)
{
	HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE);

	COORD NewSize;
	NewSize.X = width;
	NewSize.Y = height;

	SetConsoleScreenBufferSize(hStdout, NewSize);
}
void resizeConsole(int width, int height)
{
	HWND console = GetConsoleWindow();
	RECT r;
	GetWindowRect(console, &r);
	MoveWindow(console, r.left, r.top, width, height, TRUE);
}
void showMenu(cGame& level)
{
	SetConsoleTitle(TEXT("Road Crossing"));
	FixConsoleWindow();
	ShowCur(0);
	SetWindowSize(Width, Height);
	SetScreenBufferSize(Width, Height);
	
	introMenu(level);
	int x=1;
	while (x==1)
	{
		if (!level.GameProceed()) {
            if(level.state == 2) 
                if(level.lvl==3) {
                    level.state =0;
                    level.lvl = 1;
					system("cls");
                    showMenu(level);
                }
                else  {
                    system("cls");
                    level.lvl ++;
                    level.loadGame("Levels/level" + to_string(level.lvl) +".txt");
                }
            else if(level.state==1) {
                system("cls");
                level.loadGame("Levels/level" + to_string(level.lvl) +".txt");
            }
            else if(level.state==3){
				x=2;
                system("cls");
                showMenu(level);
            }
        }
	}

}