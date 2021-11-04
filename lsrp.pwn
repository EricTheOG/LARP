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
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	IsSpawned[playerid] = false;
	TogglePlayerSpectating(playerid, true);
    TogglePlayerControllable(playerid, false);
    return 1;
}

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
	if(IsSpawned[playerid] == false) return SendClientMessage(playerid, COLOR_REALRED, "You are not logged in!");
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(IsSpawned[playerid] == false) return SendClientMessage(playerid, COLOR_REALRED, "You are not logged in!");
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

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
