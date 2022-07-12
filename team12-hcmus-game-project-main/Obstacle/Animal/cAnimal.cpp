#include "cAnimal.hpp"

cAnimal::cAnimal() : Obstacle(){};
cAnimal::cAnimal(int x, int y, int speed, int color, bool LTR, int type) : Obstacle(x, y, speed, color, LTR, type){}

void cAnimal::Move()
{
    if (LTR) // left to right
    {
        mX++;
        if (mX == Width)
        {
            LTR = false;
        }
    }
    else
    {
        mX--;
        if (mX == 0)
        {
            LTR = true;
        }
    }
}