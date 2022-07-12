#pragma once
#include "../cObstacle.hpp"
class cAnimal : public Obstacle
{
	public:
		cAnimal();
		cAnimal(int x, int y, int speed, int color, bool LTR, int type);
		void Move();
};

