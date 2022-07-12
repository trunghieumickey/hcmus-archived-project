#include "../dependancies.hpp"
#include "../cGame.hpp"

#define Width 80
#define Height 25


#define key_Enter		13
#define Ctrl_V			22
#define key_Backspace	8
#define key_DownArrow	80
#define key_UpArrow		72
#define key_LeftArrow	75
#define key_RightArrow	77

void GotoXY(int x, int y, string s);
void introMenu(cGame& level);
void FixConsoleWindow();
void ShowCur(bool CursorVisibility);
void SetWindowSize(SHORT width, SHORT height);
void SetScreenBufferSize(SHORT width, SHORT height);
void resizeConsole(int width, int height);
void showMenu(cGame& level);
string pathMenu();