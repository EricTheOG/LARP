/*				     
							   ---------------------------------------------------
							   		   I
									   L 					   SSSSSSSSSS
					     			  LLL					  SSSSSSSSSSSS
					     			 LLLLL  				 SSSSSSSSSSSSSS
					     			LLLLLLL					SSSS        SSSS	
					     			LLLLLLL 				SSSS        SSSS
					     			LLLLLLL 				SSSSSSSSSSSSSSSS
					     			LLLLLLL 				SSSSSSSSSSSSSSSS	
					     			LLLLLLL 				SSSSSS    SSSSSS
					     			LLLLLLLLLLLLLLLLL        SSSSS 	  SSSSS
					     			LLLLLLLLLLLLLLLLL	      SSSS    SSSS
                    				____ ______    ____ ___  _    ____ _   _
				                    |__/ |  | |    |___ |__] |    |__|  \_/
				                    |  \ |__| |___ |___ |    |___ |  |   |

                     
							   			  * Copyright (c) 2021 - Eric *
			                    ---------------------------------------------------
*/
#include <a_samp>
#include <a_mysql>
#include <zCMD>
#include <sscanf2>
#include <crashdetect>
#include <streamer>
main(){}

/* LOCAL HOST */
#define SQL_Host    	"localhost"
#define SQL_User    	"root"
#define SQL_DB    		"larp"
#define SQL_Password    ""

/* SERVER HOST 
#define SQL_Host    	"X"
#define SQL_User    	"X"
#define SQL_DB    		"X"
#define SQL_Password    ""
*/

#define TEAM_ARES_COLOR 0x1C77B300
#define TEAM_HIT_COLOR 0xFFFFFF00
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_RED 0xAA3333AA
#define COLOR_ORANGE 0xFF8000FF
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_FORSTATS 0xFFFF91AA
#define COLOR_HOUSEGREEN 0x00E605AA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_LIGHTSLATEGRAY 0xAAC5E300
#define COLOR_CYAN 0x40FFFFFF
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_BLACK 0x000000AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_NEWS  0xFFA500AA
#define COLOR_TWWHITE 0xFFFFFFAA
#define TEAM_NEWS_COLOR 0x049C7100
#define COLOR_TWYELLOW 0xFFFF00AA
#define COLOR_TWPINK 0xE75480AA
#define COLOR_TWRED 0xFF0000AA
#define COLOR_TWBROWN 0x654321AA
#define COLOR_TWGRAY 0xB0B0AEFF
#define COLOR_TWOLIVE 0x808000AA
#define COLOR_TWPURPLE 0x800080AA
#define COLOR_TWTAN 0xD2B48CAA
#define COLOR_TWAQUA 0x00FFFFAA
#define COLOR_TWORANGE 0xFF8C00AA
#define COLOR_TWAZURE 0x007FFFAA
#define COLOR_TWGREEN 0x008000AA
#define COLOR_TWBLUE 0x0000FFAA
#define COLOR_TWBLACK 0x000000AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define TEAM_CYAN_COLOR 0xFF8282AA
#define FIND_COLOR 0xB90000FF
#define TEAM_AZTECAS_COLOR 0x01FCFFC8
#define TEAM_TAXI_COLOR 0xF2FF0000
#define TEAM_CYAN_COLOR 0xFF8282AA
#define DEPTRADIO 0xFFD7004A
#define RADIO 0x8D8DFFFF
#define COLOR_DBLUE 0x2641FEAA
#define COLOR_ALLDEPT 0xFF8282AA
#define TEAM_BLUE_COLOR 0x2641FE00
#define TEAM_FBI_COLOR 0x8D8DFF00
#define TEAM_MED_COLOR 0xFF828200
#define TEAM_APRISON_COLOR 0x9C791200
#define COLOR_NG 0x9ACD3200
#define COLOR_REPORT 0xFFFF91FF
#define COLOR_NEWBIE 0x7DAEFFFF
#define TEAM_ORANGE_COLOR 0xFF800000
#define COLOR_PINK 0xFF66FFAA
#define COLOR_OOC 0xE0FFFFAA
#define COP_GREEN_COLOR 0x33AA33AA
#define PUBLICRADIO_COLOR 0x6DFB6DFF
#define TEAM_GROVE_COLOR 0x00D900C8
#define COLOR_REALRED 0xFF0606FF
#define TEAM_GREEN_COLOR 0xFFFFFFAA
#define TEAM_ORANGE_COLOR 0xFF800000
#define WANTED_COLOR 0xFF0000FF
#define COLOR_GOV 0xE8E79BAA
#define COLOR_RADIO 0x8080FFFF

/* DIALOGS */
#define DIALOG_PASSWORD 1
#define DIALOG_EMAIL 2
#define DIALOG_DISCORD 3

/* DEFINES AS NEW */
new bool:IsSpawned[MAX_PLAYERS];

enum pInfo
{
	pName[100],
    pPass[100],
    pDiscord[20],
    pEmail[50],
    pAge,
    pRP[100],
    pdRP[200],
    pdMG[200],
    pdPG[200],
    pQuizCorrect,
    pQuizFalse
}
new pinfo[MAX_PLAYERS][pInfo];

new MySQL:Connection;
new PlayerText:fLoginTD[MAX_PLAYERS][37];

public OnGameModeInit()
{
	SetGameModeText("LA:RP v1.0.0 BETA");
	Connection = mysql_connect(SQL_Host, SQL_User, SQL_Password, SQL_DB);
	if(mysql_errno(Connection) != 0)
	{
		print("Failed MySql connection");
		}else{
        print("Success in MySql connection");
	}
	return 1;
}

public OnGameModeExit()
{
	mysql_close(Connection);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

stock LoadPlayerTextdraws(playerid)
{
	fLoginTD[playerid][0] = CreatePlayerTextDraw(playerid, 1.000000, 57.000000, "_");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][0], 0.600000, 28.500000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][0], 650.000000, 67.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][0], 1296911871);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][0], 0);

	fLoginTD[playerid][1] = CreatePlayerTextDraw(playerid, 0.000000, 310.000000, "_");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][1], 0.708333, 16.150001);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][1], 650.000000, 107.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][1], 255);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][1], 0);

	fLoginTD[playerid][2] = CreatePlayerTextDraw(playerid, 2.000000, 338.000000, "_");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][2], 0.516664, -1.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][2], 655.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][2], -1);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][2], 0);

	/*fLoginTD[playerid][3] = CreatePlayerTextDraw(playerid, 320.000000, 63.000000, "_");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][3], 3);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][3], 0.612500, 25.199996);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][3], 449.500000, 226.500000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][3], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][3], 0);*/

	fLoginTD[playerid][4] = CreatePlayerTextDraw(playerid, 2.000000, 308.000000, "_");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][4], 0.600000, -1.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][4], 655.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][4], -1);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][4], -1);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][4], 0);

	fLoginTD[playerid][5] = CreatePlayerTextDraw(playerid, 0.000000, -99.000000, "_");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][5], 0.708333, 16.150001);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][5], 650.000000, 107.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][5], 255);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][5], 0);

	fLoginTD[playerid][6] = CreatePlayerTextDraw(playerid, 2.000000, 55.000000, "_");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][6], 0.600000, -1.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][6], 655.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][6], -1);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][6], -1);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][6], 0);

	fLoginTD[playerid][7] = CreatePlayerTextDraw(playerid, 218.000000, 11.000000, "MAX PLAYERS: 999");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][7], 3);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][7], 0.433333, 2.500000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][7], 244.500000, 142.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][7], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][7], 0);

	fLoginTD[playerid][8] = CreatePlayerTextDraw(playerid, 426.000000, 18.000000, "PLAYERS ONLINE: 999");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][8], 3);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][8], 0.433333, 2.500000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][8], 295.000000, 192.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][8], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][8], 0);

	fLoginTD[playerid][9] = CreatePlayerTextDraw(playerid, 483.000000, 315.000000, "DISCORD");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][9], 0.224998, 0.899999);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][9], 4.500000, 40.500000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][9], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][9], 255);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][9], -1);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][9], 1483076241);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][9], 1);

	fLoginTD[playerid][10] = CreatePlayerTextDraw(playerid, 611.000000, 315.000000, "RULES");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][10], 0.224998, 0.899999);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][10], 4.500000, 42.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][10], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][10], 255);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][10], -1);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][10], -1962934137);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][10], 1);

	fLoginTD[playerid][11] = CreatePlayerTextDraw(playerid, 548.000000, 315.000000, "WEBSITE");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][11], 0.224998, 0.899999);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][11], 4.500000, 40.500000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][11], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][11], 255);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][11], -1);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][11], -764862831);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][11], 1);

	fLoginTD[playerid][12] = CreatePlayerTextDraw(playerid, 148.000000, 331.000000, "TextDraw");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][12], 5);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][12], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][12], 140.000000, 127.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][12], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][12], 0);
	PlayerTextDrawSetPreviewModel(playerid, fLoginTD[playerid][12], 250);
	PlayerTextDrawSetPreviewRot(playerid, fLoginTD[playerid][12], -12.000000, 0.000000, 9.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, fLoginTD[playerid][12], 1, 1);

	fLoginTD[playerid][13] = CreatePlayerTextDraw(playerid, 427.000000, 359.000000, "LOS ANGELES");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][13], 3);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][13], 1.708335, 6.399997);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][13], 530.000000, 492.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][13], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][13], 0);

	fLoginTD[playerid][14] = CreatePlayerTextDraw(playerid, 538.000000, 410.000000, "ROLEPLAY");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][14], 3);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][14], 0.833333, 2.349997);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][14], 410.000000, 322.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][14], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][14], -764862721);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][14], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][14], 0);

	fLoginTD[playerid][15] = CreatePlayerTextDraw(playerid, 127.000000, 331.000000, "TextDraw");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][15], 5);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][15], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][15], 140.000000, 127.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][15], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][15], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][15], 0);
	PlayerTextDrawSetPreviewModel(playerid, fLoginTD[playerid][15], 102);
	PlayerTextDrawSetPreviewRot(playerid, fLoginTD[playerid][15], -12.000000, 0.000000, -2.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, fLoginTD[playerid][15], 1, 1);

	fLoginTD[playerid][16] = CreatePlayerTextDraw(playerid, 106.000000, 331.000000, "TextDraw");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][16], 5);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][16], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][16], 140.000000, 127.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][16], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][16], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][16], 0);
	PlayerTextDrawSetPreviewModel(playerid, fLoginTD[playerid][16], 300);
	PlayerTextDrawSetPreviewRot(playerid, fLoginTD[playerid][16], -12.000000, 0.000000, 10.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, fLoginTD[playerid][16], 1, 1);

	fLoginTD[playerid][17] = CreatePlayerTextDraw(playerid, 83.000000, 335.000000, "TextDraw");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][17], 5);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][17], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][17], 140.000000, 127.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][17], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][17], 0);
	PlayerTextDrawSetPreviewModel(playerid, fLoginTD[playerid][17], 260);
	PlayerTextDrawSetPreviewRot(playerid, fLoginTD[playerid][17], -12.000000, 0.000000, -2.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, fLoginTD[playerid][17], 1, 1);

	fLoginTD[playerid][18] = CreatePlayerTextDraw(playerid, 59.000000, 333.000000, "TextDraw");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][18], 5);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][18], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][18], 140.000000, 127.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][18], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][18], 0);
	PlayerTextDrawSetPreviewModel(playerid, fLoginTD[playerid][18], 180);
	PlayerTextDrawSetPreviewRot(playerid, fLoginTD[playerid][18], -12.000000, 0.000000, -14.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, fLoginTD[playerid][18], 1, 1);

	fLoginTD[playerid][19] = CreatePlayerTextDraw(playerid, 538.000000, 336.000000, "TextDraw");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][19], 5);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][19], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][19], 140.000000, 127.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][19], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][19], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][19], 0);
	PlayerTextDrawSetPreviewModel(playerid, fLoginTD[playerid][19], 231);
	PlayerTextDrawSetPreviewRot(playerid, fLoginTD[playerid][19], -12.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, fLoginTD[playerid][19], 1, 1);

	fLoginTD[playerid][20] = CreatePlayerTextDraw(playerid, 286.000000, 330.000000, "TextDraw");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][20], 5);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][20], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][20], 140.000000, 127.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][20], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][20], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][20], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][20], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][20], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][20], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][20], 0);
	PlayerTextDrawSetPreviewModel(playerid, fLoginTD[playerid][20], 160);
	PlayerTextDrawSetPreviewRot(playerid, fLoginTD[playerid][20], -12.000000, 0.000000, 45.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, fLoginTD[playerid][20], 1, 1);

	fLoginTD[playerid][21] = CreatePlayerTextDraw(playerid, -39.000000, 327.000000, "TextDraw");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][21], 5);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][21], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][21], 140.000000, 127.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][21], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][21], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][21], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][21], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][21], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][21], 0);
	PlayerTextDrawSetPreviewModel(playerid, fLoginTD[playerid][21], 120);
	PlayerTextDrawSetPreviewRot(playerid, fLoginTD[playerid][21], -12.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, fLoginTD[playerid][21], 1, 1);

	fLoginTD[playerid][22] = CreatePlayerTextDraw(playerid, -24.000000, 334.000000, "TextDraw");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][22], 5);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][22], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][22], 140.000000, 127.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][22], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][22], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][22], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][22], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][22], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][22], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][22], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][22], 0);
	PlayerTextDrawSetPreviewModel(playerid, fLoginTD[playerid][22], 56);
	PlayerTextDrawSetPreviewRot(playerid, fLoginTD[playerid][22], -12.000000, 0.000000, -12.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, fLoginTD[playerid][22], 1, 1);

	fLoginTD[playerid][23] = CreatePlayerTextDraw(playerid, -5.000000, 333.000000, "TextDraw");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][23], 5);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][23], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][23], 140.000000, 127.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][23], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][23], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][23], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][23], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][23], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][23], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][23], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][23], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][23], 0);
	PlayerTextDrawSetPreviewModel(playerid, fLoginTD[playerid][23], 249);
	PlayerTextDrawSetPreviewRot(playerid, fLoginTD[playerid][23], -12.000000, 0.000000, -16.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, fLoginTD[playerid][23], 1, 1);

	fLoginTD[playerid][24] = CreatePlayerTextDraw(playerid, 16.000000, 334.000000, "TextDraw");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][24], 5);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][24], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][24], 140.000000, 127.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][24], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][24], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][24], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][24], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][24], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][24], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][24], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][24], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][24], 0);
	PlayerTextDrawSetPreviewModel(playerid, fLoginTD[playerid][24], 275);
	PlayerTextDrawSetPreviewRot(playerid, fLoginTD[playerid][24], -12.000000, 0.000000, -18.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, fLoginTD[playerid][24], 1, 1);

	fLoginTD[playerid][25] = CreatePlayerTextDraw(playerid, 34.000000, 333.000000, "TextDraw");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][25], 5);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][25], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][25], 140.000000, 127.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][25], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][25], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][25], 1);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][25], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][25], 0);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][25], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][25], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][25], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][25], 0);
	PlayerTextDrawSetPreviewModel(playerid, fLoginTD[playerid][25], 188);
	PlayerTextDrawSetPreviewRot(playerid, fLoginTD[playerid][25], -12.000000, 0.000000, -8.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, fLoginTD[playerid][25], 1, 1);

	/* LOGIN */
	fLoginTD[playerid][26] = CreatePlayerTextDraw(playerid, 320.000000, 66.000000, "_");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][26], 3);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][26], 0.612500, 24.599990);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][26], 449.500000, 221.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][26], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][26], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][26], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][26], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][26], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][26], 255);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][26], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][26], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][26], 0);

	fLoginTD[playerid][27] = CreatePlayerTextDraw(playerid, 424.000000, 64.000000, "X");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][27], 2);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][27], 0.508333, 1.850000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][27], 14.500000, 22.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][27], 4);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][27], 1);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][27], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][27], -1962934017);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][27], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][27], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][27], 0);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][27], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][27], 1);

	fLoginTD[playerid][28] = CreatePlayerTextDraw(playerid, 320.000000, 73.000000, "REGISTRATION");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][28], 2);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][28], 0.320833, 1.500000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][28], 398.000000, 102.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][28], 0);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][28], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][28], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][28], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][28], -1);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][28], -764862721);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][28], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][28], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][28], 0);

	fLoginTD[playerid][29] = CreatePlayerTextDraw(playerid, 240.000000, 135.000000, "PASSWORD");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][29], 3);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][29], 0.225000, 1.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][29], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][29], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][29], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][29], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][29], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][29], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][29], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][29], 0);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][29], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][29], 0);

	fLoginTD[playerid][30] = CreatePlayerTextDraw(playerid, 319.000000, 150.000000, "type here...");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][30], 2);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][30], 0.141666, 0.649999);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][30], 9.000000, 196.500000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][30], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][30], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][30], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][30], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][30], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][30], -206);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][30], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][30], 0);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][30], 1);

	fLoginTD[playerid][31] = CreatePlayerTextDraw(playerid, 319.000000, 188.000000, "type here...");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][31], 2);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][31], 0.141666, 0.649999);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][31], 9.000000, 196.500000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][31], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][31], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][31], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][31], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][31], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][31], -206);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][31], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][31], 0);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][31], 1);

	fLoginTD[playerid][32] = CreatePlayerTextDraw(playerid, 249.000000, 174.000000, "EMAIL ADDRESS");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][32], 3);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][32], 0.225000, 1.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][32], 429.000000, 87.500000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][32], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][32], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][32], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][32], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][32], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][32], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][32], 0);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][32], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][32], 0);

	fLoginTD[playerid][33] = CreatePlayerTextDraw(playerid, 319.000000, 228.000000, "type here...");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][33], 2);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][33], 0.141666, 0.649999);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][33], 9.000000, 196.500000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][33], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][33], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][33], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][33], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][33], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][33], -206);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][33], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][33], 0);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][33], 1);

	fLoginTD[playerid][34] = CreatePlayerTextDraw(playerid, 261.000000, 213.000000, "DISCORD USERNAME____");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][34], 3);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][34], 0.225000, 1.000000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][34], 400.000000, 111.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][34], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][34], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][34], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][34], -1);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][34], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][34], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][34], 0);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][34], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][34], 0);

	fLoginTD[playerid][35] = CreatePlayerTextDraw(playerid, 397.000000, 268.000000, "NEXT >");
	PlayerTextDrawFont(playerid, fLoginTD[playerid][35], 1);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][35], 0.224998, 1.399999);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][35], 10.500000, 55.500000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][35], 1);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][35], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][35], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][35], 255);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][35], -1);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][35], 9109759);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][35], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][35], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][35], 1);
	new rname[50];
	GetPlayerName(playerid, rname, sizeof(rname));
	fLoginTD[playerid][36] = CreatePlayerTextDraw(playerid, 319.000000, 102.000000, rname);
	PlayerTextDrawFont(playerid, fLoginTD[playerid][36], 2);
	PlayerTextDrawLetterSize(playerid, fLoginTD[playerid][36], 0.258333, 1.350000);
	PlayerTextDrawTextSize(playerid, fLoginTD[playerid][36], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, fLoginTD[playerid][36], 0);
	PlayerTextDrawSetShadow(playerid, fLoginTD[playerid][36], 0);
	PlayerTextDrawAlignment(playerid, fLoginTD[playerid][36], 2);
	PlayerTextDrawColor(playerid, fLoginTD[playerid][36], 1687547391);
	PlayerTextDrawBackgroundColor(playerid, fLoginTD[playerid][36], 255);
	PlayerTextDrawBoxColor(playerid, fLoginTD[playerid][36], 50);
	PlayerTextDrawUseBox(playerid, fLoginTD[playerid][36], 1);
	PlayerTextDrawSetProportional(playerid, fLoginTD[playerid][36], 1);
	PlayerTextDrawSetSelectable(playerid, fLoginTD[playerid][36], 0);
}

stock ShowPlayerTextDraws(playerid)
{
	PlayerTextDrawShow(playerid, fLoginTD[playerid][0]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][1]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][2]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][3]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][4]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][5]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][6]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][7]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][8]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][9]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][10]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][11]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][12]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][13]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][14]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][15]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][16]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][17]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][18]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][19]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][20]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][21]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][22]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][23]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][24]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][25]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][26]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][27]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][28]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][29]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][30]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][31]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][32]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][33]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][34]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][35]);
	PlayerTextDrawShow(playerid, fLoginTD[playerid][36]);
	SelectTextDraw(playerid, 0xFF0000FF);
}

public OnPlayerConnect(playerid)
{
	pinfo[playerid][pPass] = 0;
	pinfo[playerid][pEmail] = 0;
	pinfo[playerid][pDiscord] = 0;
	PlayAudioStreamForPlayer(playerid, "http://www.hzgaming.net/zhao/sounds/asg.mp3");
	new Query1[500], pname[100];
	IsSpawned[playerid] = false;
	TogglePlayerSpectating(playerid, true);
    TogglePlayerControllable(playerid, false);
    LoadPlayerTextdraws(playerid);
    ShowPlayerTextDraws(playerid);
    SetTimerEx("ClearChat", 2000, false, "d", playerid);
    mysql_format(Connection, Query1, sizeof(Query1), "SELECT Name FROM la_users WHERE Name='%e'", GetPlayerName(playerid, pname, sizeof(pname)));
    mysql_tquery(Connection, Query1, "PlayerExistanceCheck", "d", playerid);
    return 1;
}

forward ClearChat(playerid);public ClearChat(playerid){for(new i; i < 100; i++){SendClientMessage(playerid, -1, "");}}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(IsSpawned[playerid] == false)
	{
		SendClientMessage(playerid, COLOR_REALRED, "You are not logged in!");
		return 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(IsSpawned[playerid] == false)
	{
		SendClientMessage(playerid, COLOR_REALRED, "You are not logged in!");
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(playertextid == fLoginTD[playerid][27]) return Kick(playerid);
	if(playertextid == fLoginTD[playerid][30]) return 
	ShowPlayerDialog(playerid, DIALOG_PASSWORD, DIALOG_STYLE_PASSWORD, "Los Angeles Roleplay - Account Registration (PASSWORD)", "{b11111}[*] {F0F0F0}Type your account password down below after you read the information below...\n\n\n{B4B5B7}* Please use a STRONG password where it's nearly impossible to find it out by any other person.\n\n* You are prohibited to leak this password for any reason!\n\n* Notice that a staff member will NEVER ask for your password!", "Done", "Cancel");
	if(playertextid == fLoginTD[playerid][31]) return
	ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, "Los Angeles Roleplay - Account Registration (EMAIL)", "{b11111}[*] {F0F0F0}Type your account E-mail (Gmail/Hotmail/Yahoo) where we can contact you!\n\n\n{B4B5B7}* Your E-mail should be a real one so you can get notified for any updates concerning your account!\n* Only the founders of the server have access to your email address, so it's safe to write it down.\n* Example: losangelesroleplay@gmail.com", "Done", "Cancel");
	if(playertextid == fLoginTD[playerid][33]) return
	ShowPlayerDialog(playerid, DIALOG_DISCORD, DIALOG_STYLE_INPUT, "Los Angeles Roleplay - Account Registration (DISCORD)", "{b11111}[*] {F0F0F0}Type your Discord where we can indentify you!\n\n\n{B4B5B7}* Your Discord should be a real one so you can get notified for any updates concerning your character!\n* You must include your four digits hashtag to identify yourself.\n* Example: Eric#5500", "Done", "Cancel");
	if(playertextid == fLoginTD[playerid][35])
	{
		if(strlen(pinfo[playerid][pPass]) > 0 && strlen(pinfo[playerid][pEmail]) > 0 && strlen(pinfo[playerid][pDiscord]) > 0)
		{
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][0]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][1]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][2]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][3]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][4]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][5]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][6]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][7]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][8]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][9]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][10]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][11]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][12]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][13]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][14]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][15]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][16]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][17]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][18]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][19]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][20]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][21]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][22]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][23]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][24]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][25]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][26]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][27]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][28]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][29]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][30]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][31]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][32]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][33]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][34]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][35]);
			PlayerTextDrawDestroy(playerid, fLoginTD[playerid][36]);
			TogglePlayerSpectating(playerid, false);
			TogglePlayerControllable(playerid, true);
			SetSpawnInfo(playerid, -1, 2, 1651.1899,-2243.8733,-2.6883, 175.8523, 0, 0, 0, 0, 0, 0);
			SpawnPlayer(playerid);
			SetCameraBehindPlayer(playerid);
			CancelSelectTextDraw(playerid);
		}
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_PASSWORD:
		{
			if(response)
			{
				if(strlen(inputtext) < 6) return 
				ShowPlayerDialog(playerid, DIALOG_PASSWORD, DIALOG_STYLE_PASSWORD, "Los Angeles Roleplay - Account Registration (PASSWORD)", "{b11111}[*] {F0F0F0}Type your password down below...\n\n\n{B4B5B7}* Please use a STRONG password where it's nearly impossible to find it out by any other person.\n\n* You are prohibited to leak this password for any reason!\n\n* Notice that a staff member will NEVER ask for your password!\n\n** The password your entered is weak!", "Done", "Cancel");
				SHA256_PassHash(inputtext, "A48AD15", pinfo[playerid][pPass], 65);
	            PlayerPlaySound(playerid, 5202, 0, 0, 0);
				PlayerTextDrawSetString(playerid, fLoginTD[playerid][30], "++++++++++");
				PlayerTextDrawHide(playerid, fLoginTD[playerid][30]);
				PlayerTextDrawShow(playerid, fLoginTD[playerid][30]);
			}
		}
		case DIALOG_EMAIL:
		{
			if(response)
			{
				if(strlen(inputtext) < 6 || strfind(inputtext, "@", false) == -1 || strfind(inputtext, ".", false) == -1 && strfind(inputtext, "gmail", false) == -1 && strfind(inputtext, "yahoo", false) == -1 && strfind(inputtext, "hotmail", false) == -1) return 
				ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, "Los Angeles Roleplay - Account Registration (EMAIL)", "{b11111}[*] {F0F0F0}Type your account E-mail (Gmail/Hotmail/Yahoo) where we can contact you!\n\n\n{B4B5B7}* Your E-mail should be a real one so you can get notified for any updates concerning your account!\n* Only the founders of the server have access to your email address, so it's safe to write it down.\n* Example: losangelesroleplay@gmail.com", "Done", "Cancel");
				strmid(pinfo[playerid][pEmail], inputtext, 0, strlen(inputtext), 255);
	            PlayerPlaySound(playerid, 5202, 0, 0, 0);
				PlayerTextDrawSetString(playerid, fLoginTD[playerid][31], pinfo[playerid][pEmail]);
				PlayerTextDrawHide(playerid, fLoginTD[playerid][31]);
				PlayerTextDrawShow(playerid, fLoginTD[playerid][31]);
			}
		}
		case DIALOG_DISCORD:
		{
			if(response)
			{
				if(strlen(inputtext) < 6 || strfind(inputtext, "#", false) == -1 && strfind(inputtext, "1", false) == -1 && strfind(inputtext, "2", false) == -1 && strfind(inputtext, "3", false) == -1 && strfind(inputtext, "4", false) == -1 && strfind(inputtext, "5", false) == -1 && strfind(inputtext, "6", false) == -1 && strfind(inputtext, "7", false) == -1 && strfind(inputtext, "8", false) == -1 && strfind(inputtext, "9", false) == -1 || strfind(inputtext, "0", false) == -1) return 
				ShowPlayerDialog(playerid, DIALOG_DISCORD, DIALOG_STYLE_INPUT, "Los Angeles Roleplay - Account Registration (DISCORD)", "{b11111}[*] {F0F0F0}Type your Discord where we can indentify you!\n\n\n{B4B5B7}* Your Discord should be a real one so you can get notified for any updates concerning your character!\n* You must include your four digits hashtag to identify yourself.\n* Example: Eric#5500", "Done", "Cancel");
				strmid(pinfo[playerid][pDiscord], inputtext, 0, strlen(inputtext), 255);
	            PlayerPlaySound(playerid, 5202, 0, 0, 0);
				PlayerTextDrawSetString(playerid, fLoginTD[playerid][33], pinfo[playerid][pDiscord]);
				PlayerTextDrawHide(playerid, fLoginTD[playerid][33]);
				PlayerTextDrawShow(playerid, fLoginTD[playerid][33]);
			}
		}
	}
	return 1;
}