#pragma once

#include "Obstacle/IncludePath.hpp"
#include "dependancies.hpp"
#include "People/cPeople.hpp"
#include "ScreenControl/cScreen.hpp"

class cGame
{
	vector<Obstacle*> mObstacle;
	cPeople mPeople;
	int frame = 0;
public:
	int lvl = 0;
	int state = 0;
	cGame(); //Chuẩn bị dữ liệu cho tất cả các đối tượng
	void setLevel(int level);
	void addObstacle(Obstacle* a);
	bool GameProceed();
	int startGame(); // Thực hiện bắt đầu vào trò chơi
	void loadGame(string); // Thực hiện tải lại trò chơi đã lưu
	void saveGame(string); // Thực hiện lưu lại dữ liệu trò chơi
};

