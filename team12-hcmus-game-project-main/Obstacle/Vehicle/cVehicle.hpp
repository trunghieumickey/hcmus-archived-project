#pragma once
#include "../cObstacle.hpp"

class Vehicle : public Obstacle
{
public:
	Vehicle();
	Vehicle(int x, int y, int speed, int color, bool LTR, int type);
	void Move();
};


