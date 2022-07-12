#pragma once
#include "cVehicle.hpp"

class cCar : public Vehicle
{
public:
    cCar();
    cCar(int x, int y, int speed, int color, bool LTR);
    void Draw();
    void tell();
};
