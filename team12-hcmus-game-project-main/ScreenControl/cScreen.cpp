#include "cScreen.hpp"

void GotoXY(int x, int y) {
	COORD coord;
	coord.X = x;
	coord.Y = y;
	SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord);
}

void textcolor(int color) {// chỉnh màu theo mã được gán vào biến color
	HANDLE hConsoleColor;
	hConsoleColor = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleTextAttribute(hConsoleColor, color);
}

void ColorPrint(int x, int y, int color, char text) {
	GotoXY(x, y);
	textcolor(color);
	cout << text;
	textcolor(7);
}

void ClearScreen() {
	system("cls");
}