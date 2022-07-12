#pragma once
#include "../Obstacle/IncludePath.hpp"
#include "../ScreenControl/cScreen.hpp"

class cPeople
{
	int mX,mY;
public:
	cPeople();
	cPeople(int x, int y);
	void setPosition(int x, int y);
	void Up();
	void Left();
	void Right();
	void Down();

	void DrawPeople();
	bool isImpact(vector <Obstacle*> a);
	bool isFinish();
	void DrawImpact();
	string save();
};


