#pragma once
#include "cAnimal.hpp"

class cDinasour : public cAnimal
{
public:
    cDinasour();
    cDinasour(int x, int y, int speed, int color, bool LTR);
    void Draw();
    void tell();
};

