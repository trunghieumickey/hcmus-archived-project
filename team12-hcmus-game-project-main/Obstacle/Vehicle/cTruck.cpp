#include "cTruck.hpp"

cTruck::cTruck() : Vehicle()
{
	type =2;
}

cTruck::cTruck(int x, int y, int speed, int color, bool LTR) : Vehicle(x, y, speed, color, LTR, 2)
{
	
}


void cTruck::Draw()
{
	textcolor(color);
	if(LTR) // left to right
	{
		GotoXY(mX, mY);
		cout << char(219);
		GotoXY(mX + 1, mY);
		cout << char(219);
		GotoXY(mX + 2, mY);
		cout << char(220);
	}
	else {
		GotoXY(mX, mY);
		cout << char(219);
		GotoXY(mX - 1, mY);
		cout << char(219);
		GotoXY(mX - 2, mY);
		cout << char(220);
	}
	textcolor(7);
}

void cTruck::tell(){
	return;
}