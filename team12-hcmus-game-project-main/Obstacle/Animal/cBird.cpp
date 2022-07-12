#include "cBird.hpp"

cBird::cBird() : cAnimal(){type = 3;}
cBird::cBird(int x, int y, int speed, int color, bool LTR) : cAnimal(x, y, speed, color, LTR, 3){} 


void cBird::Draw()
{
	textcolor(color);
	if (LTR) // left to right
	{
		GotoXY(mX, mY);
		cout << char(220);
		GotoXY(mX - 1, mY - 1);
		cout << char(220);
		GotoXY(mX + 1, mY - 1);
		cout << char(220);
	}
	else {
		GotoXY(mX, mY);
		cout << char(220);
		GotoXY(mX - 1, mY - 1);
		cout << char(220);
		GotoXY(mX + 1, mY - 1);
		cout << char(220);
	}
}

void cBird::tell(){
	return;
}