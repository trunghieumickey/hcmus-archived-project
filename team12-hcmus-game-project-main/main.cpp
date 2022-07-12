#include "Obstacle/IncludePath.hpp"
#include "dependancies.hpp"
#include "People/cPeople.hpp"
#include "ScreenControl/cScreen.hpp"
#include "cGame.hpp"
#include "Menu/menu.hpp"


int main()
{
	cGame level;
	level.loadGame("Levels/level1.txt");
    showMenu(level);
    return 0;	
}