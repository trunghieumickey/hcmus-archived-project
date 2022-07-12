#include "cDinasour.hpp"

cDinasour::cDinasour():cAnimal(){type = 4;}
cDinasour::cDinasour(int x, int y, int speed, int color, bool LTR) : cAnimal(x,y,speed, color, LTR, 4){}


void cDinasour::Draw()
{
	textcolor(color);
	if(LTR) // left to right
	{
    	GotoXY(mX, mY);
		cout << char(220);
		GotoXY(mX - 1, mY + 1);
		cout << char(219);
		GotoXY(mX - 2, mY + 2);
		cout << char(219);
	}
	else// right to left
	{
		GotoXY(mX, mY);
		cout << char(220);
		GotoXY(mX + 1, mY + 1);
		cout << char(219);
		GotoXY(mX + 2, mY + 2);
		cout << char(219);
	}
}

void cDinasour::tell(){
	return;
}