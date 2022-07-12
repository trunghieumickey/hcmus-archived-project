#include "cVehicle.hpp"


Vehicle::Vehicle() : Obstacle(){}
Vehicle::Vehicle(int x, int y, int speed, int color, bool LTR, int type) : Obstacle(x,y,speed, color, LTR,type){}

void Vehicle::Move()
{
    if (LTR){ // left to right
        mX++;
        if(mX == Width)
        {
            mX = 0;
        }
    }
    else{
        mX--;
        if (mX == 0)
        {
            mX = Width;
        }
    }
}