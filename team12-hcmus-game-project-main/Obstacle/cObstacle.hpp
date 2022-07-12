#pragma once

#include "../dependancies.hpp"
#include "../ScreenControl/cScreen.hpp"

#pragma comment(lib, "winmm.lib")

class Obstacle{
    public:
        Obstacle();
        Obstacle(int x, int y, int speed, int color, bool LTR, int type);
        virtual void tell() = 0;
        virtual void Draw() = 0;
        int getX();
        int getY();
        string save();
        void setPosition(int x, int y);
        virtual void Move() = 0;
        int Speed;

    protected:
        int mX;
        int mY;
        bool LTR;
        int color;
        int type;
};