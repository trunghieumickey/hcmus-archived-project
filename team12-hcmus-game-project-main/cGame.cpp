#include "cGame.hpp"

cGame::cGame() = default;

void cGame::addObstacle(Obstacle* a)
{
	mObstacle.push_back(a);
}

bool cGame::GameProceed(){
	state = 0;
	if (GetKeyState('W') & 0x8000 || GetKeyState('w') & 0x8000 || GetKeyState(VK_UP) & 0x8000) { mPeople.Up(); }
	else if (GetKeyState('S') & 0x8000 || GetKeyState('s') & 0x8000 || GetKeyState(VK_DOWN) & 0x8000) { mPeople.Down(); }
	else if (GetKeyState('A') & 0x8000 || GetKeyState('a') & 0x8000 || GetKeyState(VK_LEFT) & 0x8000) { mPeople.Left(); }
	else if (GetKeyState('D') & 0x8000 || GetKeyState('d') & 0x8000 || GetKeyState(VK_RIGHT) & 0x8000) { mPeople.Right(); }

	if (GetKeyState('P') & 0x8000 || GetKeyState('p') & 0x8000 || GetKeyState(VK_ESCAPE) & 0x8000){
		state = 3;
		return false;
	}

	for (auto i : mObstacle) {
		if (frame % i->Speed == 0) i->Move();
	}
	if (mPeople.isImpact(mObstacle)) {
		mPeople.DrawImpact();
		state = 1;
		return false;
	}
	else if (mPeople.isFinish()) {
		state = 2;
		return false;
	}
	ClearScreen();
	GotoXY(0,0);
	cout << "Level " << lvl;
	for (auto i : mObstacle) {
		i->Draw();
	}
	mPeople.DrawPeople();
	frame++;
	return true;
}

int cGame::startGame(){
	ClearScreen();
	while (true)
	{
		Sleep(50);
		if (!GameProceed()) break;
	}
	return state;
}

void cGame::saveGame(string output)
{
   ofstream out(output);
   out << lvl << " " << frame << endl;
   out << mPeople.save() << endl;
   out << mObstacle.size() << endl;
   for (auto i : mObstacle)
   {
	   out << i->save() << endl;
   }
}

void cGame::loadGame(string input)
{
	ifstream in(input);
	mObstacle.clear();
	in >> lvl >> frame;
	int x,y;
	in >> x >> y;
	mPeople.setPosition(x,y);
	int size;
	in >> size;
	for (int i = 0; i < size; i++)
	{
		int type, x, y, speed, color, LTR;
		in >> type >> x >> y >> speed >> color >> LTR;
		switch (type)
		{
		case 1:
			mObstacle.push_back(new cCar(x, y, speed, color, LTR));
			break;
		case 2:
			mObstacle.push_back(new cTruck(x, y, speed, color, LTR));
			break;
		case 3:
			mObstacle.push_back(new cBird(x, y, speed, color, LTR));
			break;
		case 4:
			mObstacle.push_back(new cDinasour(x, y, speed, color, LTR));
			break;
		}
	}
}

void cGame::setLevel(int level){
	lvl = level;
}



