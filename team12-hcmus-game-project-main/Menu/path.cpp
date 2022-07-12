#include "../dependancies.hpp"
#include "menu.hpp"

string pathMenu() {
	system("cls");
	string path = "", temp;
	GotoXY(35, 7, "Enter path:");
	GotoXY(19, 8, " _____________________________________");
	GotoXY(19, 9, "|                                     |");
	GotoXY(19, 10, "|                                     |");
	GotoXY(19, 11, "|                                     |");
	GotoXY(19, 12, "|-------------------------------------|");
	GotoXY(20, 10);
	while (temp == "") {
		getline(cin, temp);
		for (int i = 0; i < temp.length(); i++)
			if (temp[i] == ' ') {
				temp = "";
				GotoXY(23, 13, "Invalid path!!!!!!");
				GotoXY(20, 10,"                              ");
				GotoXY(20, 10);
			}
		path = temp;
	}
	return path;
}