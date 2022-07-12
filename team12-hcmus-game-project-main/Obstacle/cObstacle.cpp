#include "cObstacle.hpp"

Obstacle::Obstacle() = default;

Obstacle::Obstacle(int x, int y, int speed, int color, bool LTR, int type)
{
    mX= x;
    mY= y;
    Speed = speed;
    this->color = color;
    this->LTR = LTR;
    this->type = type;
}

int Obstacle::getX()
{
    return mX;
}

int Obstacle::getY()
{
    return mY;
}

void Obstacle::setPosition(int x, int y)
{
    mX=x;
    mY=y;
}

string Obstacle::save()
{
    string ss;
    ss = to_string(type) + " " + to_string(mX) + " " + to_string(mY) + " " + to_string(Speed) + " " + to_string(color) + " " + to_string(LTR);
    return ss;
}

