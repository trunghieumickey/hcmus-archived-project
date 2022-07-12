#pragma once
#include "cVehicle.hpp"

class cTruck : public Vehicle
{
public:
    cTruck();
    cTruck(int x, int y, int speed, int color, bool LTR);
    void Draw();    
    void tell();
};