#include "cCar.hpp"

cCar::cCar() :Vehicle() { type = 1;}
cCar::cCar(int x, int y, int speed, int color, bool LTR) :Vehicle(x, y, speed, color, LTR, 1) {}



void cCar::Draw()
{
	textcolor(color);
	if (LTR){ // left to right
		GotoXY(mX, mY);
		cout << char(220);
		GotoXY(mX + 1, mY);
		cout << char(219);
		GotoXY(mX + 2, mY);
		cout << char(220);
	}
	else {
		GotoXY(mX, mY);
		cout << char(220);
		GotoXY(mX + 1, mY);
		cout << char(219);
		GotoXY(mX + 2, mY);
		cout << char(220);
	}
	textcolor(7);
}
void cCar::tell(){
	//bool isPlay = PlaySound(TEXT("birds.wav"), NULL, SND_FILENAME);
	return;
}