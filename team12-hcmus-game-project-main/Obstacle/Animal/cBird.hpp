#pragma once
#include "cAnimal.hpp"

class cBird: public cAnimal
{
public:
    cBird();
    cBird(int x, int y, int speed, int color, bool LTR);
    void Draw();
    void tell();
};

