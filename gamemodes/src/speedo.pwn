#include <YSI-Includes\YSI\y_hooks>

new
    pLastFuelSubtraction[MAX_PLAYERS],
	bool:pSpeedoShown[MAX_PLAYERS],
    pSpeedoTimer[MAX_PLAYERS] = {-1, ...},
    PlayerText:pSpeedoTd[MAX_PLAYERS][7] = {{PlayerText:INVALID_TEXT_DRAW, ...}, ...};

hook OnPlayerConnect(playerid) 
{
    pSpeedoTd[playerid][0] = CreatePlayerTextDraw(playerid, 320.000000, 357.000000, "_");
    PlayerTextDrawFont(playerid, pSpeedoTd[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid, pSpeedoTd[playerid][0], 0.000000, 3.400000);
    PlayerTextDrawTextSize(playerid, pSpeedoTd[playerid][0], 0.000000, 80.000000);
    PlayerTextDrawSetOutline(playerid, pSpeedoTd[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, pSpeedoTd[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, pSpeedoTd[playerid][0], 2);
    PlayerTextDrawColor(playerid, pSpeedoTd[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, pSpeedoTd[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, pSpeedoTd[playerid][0], 75);
    PlayerTextDrawUseBox(playerid, pSpeedoTd[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, pSpeedoTd[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, pSpeedoTd[playerid][0], 0);

    pSpeedoTd[playerid][1] = CreatePlayerTextDraw(playerid, 320.000000, 395.000000, "_");
    PlayerTextDrawFont(playerid, pSpeedoTd[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, pSpeedoTd[playerid][1], 0.000000, 1.700000);
    PlayerTextDrawTextSize(playerid, pSpeedoTd[playerid][1], 0.000000, 80.000000);
    PlayerTextDrawSetOutline(playerid, pSpeedoTd[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, pSpeedoTd[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, pSpeedoTd[playerid][1], 2);
    PlayerTextDrawColor(playerid, pSpeedoTd[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, pSpeedoTd[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, pSpeedoTd[playerid][1], 75);
    PlayerTextDrawUseBox(playerid, pSpeedoTd[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, pSpeedoTd[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, pSpeedoTd[playerid][1], 0);

    pSpeedoTd[playerid][2] = CreatePlayerTextDraw(playerid, 320.000000, 353.000000, "000");
    PlayerTextDrawFont(playerid, pSpeedoTd[playerid][2], 2);
    PlayerTextDrawLetterSize(playerid, pSpeedoTd[playerid][2], 0.370831, 2.799998);
    PlayerTextDrawTextSize(playerid, pSpeedoTd[playerid][2], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, pSpeedoTd[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, pSpeedoTd[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, pSpeedoTd[playerid][2], 2);
    PlayerTextDrawColor(playerid, pSpeedoTd[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, pSpeedoTd[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, pSpeedoTd[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, pSpeedoTd[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, pSpeedoTd[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, pSpeedoTd[playerid][2], 0);

    pSpeedoTd[playerid][3] = CreatePlayerTextDraw(playerid, 320.000000, 375.000000, "KM/H");
    PlayerTextDrawFont(playerid, pSpeedoTd[playerid][3], 2);
    PlayerTextDrawLetterSize(playerid, pSpeedoTd[playerid][3], 0.200000, 1.299998);
    PlayerTextDrawTextSize(playerid, pSpeedoTd[playerid][3], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, pSpeedoTd[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, pSpeedoTd[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, pSpeedoTd[playerid][3], 2);
    PlayerTextDrawColor(playerid, pSpeedoTd[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, pSpeedoTd[playerid][3], 255);
    PlayerTextDrawBoxColor(playerid, pSpeedoTd[playerid][3], 50);
    PlayerTextDrawUseBox(playerid, pSpeedoTd[playerid][3], 0);
    PlayerTextDrawSetProportional(playerid, pSpeedoTd[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, pSpeedoTd[playerid][3], 0);

    pSpeedoTd[playerid][4] = CreatePlayerTextDraw(playerid, 280.000000, 389.000000, "0.000");
    PlayerTextDrawFont(playerid, pSpeedoTd[playerid][4], 2);
    PlayerTextDrawLetterSize(playerid, pSpeedoTd[playerid][4], 0.349999, 2.549998);
    PlayerTextDrawTextSize(playerid, pSpeedoTd[playerid][4], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, pSpeedoTd[playerid][4], 0);
    PlayerTextDrawSetShadow(playerid, pSpeedoTd[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, pSpeedoTd[playerid][4], 1);
    PlayerTextDrawColor(playerid, pSpeedoTd[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, pSpeedoTd[playerid][4], 255);
    PlayerTextDrawBoxColor(playerid, pSpeedoTd[playerid][4], 50);
    PlayerTextDrawUseBox(playerid, pSpeedoTd[playerid][4], 0);
    PlayerTextDrawSetProportional(playerid, pSpeedoTd[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, pSpeedoTd[playerid][4], 0);

    pSpeedoTd[playerid][5] = CreatePlayerTextDraw(playerid, 358.000000, 393.000000, "Litros");
    PlayerTextDrawFont(playerid, pSpeedoTd[playerid][5], 2);
    PlayerTextDrawLetterSize(playerid, pSpeedoTd[playerid][5], 0.200000, 1.299998);
    PlayerTextDrawTextSize(playerid, pSpeedoTd[playerid][5], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, pSpeedoTd[playerid][5], 0);
    PlayerTextDrawSetShadow(playerid, pSpeedoTd[playerid][5], 0);
    PlayerTextDrawAlignment(playerid, pSpeedoTd[playerid][5], 3);
    PlayerTextDrawColor(playerid, pSpeedoTd[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, pSpeedoTd[playerid][5], 255);
    PlayerTextDrawBoxColor(playerid, pSpeedoTd[playerid][5], 50);
    PlayerTextDrawUseBox(playerid, pSpeedoTd[playerid][5], 0);
    PlayerTextDrawSetProportional(playerid, pSpeedoTd[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, pSpeedoTd[playerid][5], 0);

    pSpeedoTd[playerid][6] = CreatePlayerTextDraw(playerid, 380.000000, 400.000000, "E");
    PlayerTextDrawFont(playerid, pSpeedoTd[playerid][6], 2);
    PlayerTextDrawLetterSize(playerid, pSpeedoTd[playerid][6], 0.200000, 1.299998);
    PlayerTextDrawTextSize(playerid, pSpeedoTd[playerid][6], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, pSpeedoTd[playerid][6], 0);
    PlayerTextDrawSetShadow(playerid, pSpeedoTd[playerid][6], 0);
    PlayerTextDrawAlignment(playerid, pSpeedoTd[playerid][6], 2);
    PlayerTextDrawColor(playerid, pSpeedoTd[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, pSpeedoTd[playerid][6], 255);
    PlayerTextDrawBoxColor(playerid, pSpeedoTd[playerid][6], 50);
    PlayerTextDrawUseBox(playerid, pSpeedoTd[playerid][6], 0);
    PlayerTextDrawSetProportional(playerid, pSpeedoTd[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, pSpeedoTd[playerid][6], 0);
}

hook OnPlayerDisconnect(playerid, reason) 
{
    for(new i = 0; i < sizeof pSpeedoTd[]; i ++) 
	{
        PlayerTextDrawDestroy(playerid, pSpeedoTd[playerid][i]);
    }

	pSpeedoShown[playerid] = false;
    pLastFuelSubtraction[playerid] = 0;
    if(pSpeedoTimer[playerid] != -1) {
	    KillTimer(pSpeedoTimer[playerid]);
        pSpeedoTimer[playerid] = -1;
    }
}

hook OnPlayerStateChange(playerid, newstate, oldstate) 
{
    if(newstate == PLAYER_STATE_DRIVER) 
	{
        new vehicleid = GetPlayerVehicleID(playerid);
        if(VEHICLE_INFO[GetVehicleModel(vehicleid) - 400][vehicle_info_NORMAL_SPEEDO]) ShowPlayerSpeedoMeter(playerid);
    }
    else if(oldstate == PLAYER_STATE_DRIVER) 
	{
        HidePlayerSpeedoMeter(playerid);
    }
}

ShowPlayerSpeedoMeter(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 0;
	new vehicleid = GetPlayerVehicleID(playerid), modelid = GetVehicleModel(vehicleid), color1;
	if(!VEHICLE_INFO[modelid - 400][vehicle_info_NORMAL_SPEEDO]) return 0;

    if(pSpeedoTimer[playerid] != -1) 
	{
	    KillTimer(pSpeedoTimer[playerid]);
        pSpeedoTimer[playerid] = -1;
    }
	
	new td_str[64];
	format(td_str, sizeof td_str, "%.1f", GLOBAL_VEHICLES[vehicleid][gb_vehicle_GAS]);
	PlayerTextDrawSetString(playerid, pSpeedoTd[playerid][4], td_str);
	
	PlayerTextDrawSetString(playerid, pSpeedoTd[playerid][2], "000");

    GetVehicleColor(vehicleid, color1);

    new r, g, b, a, Vehicle_Colour, UseOutLine = 0;
    HexToRGBA(VEHICLE_COLORS[color1], r, g, b, a);
    Vehicle_Colour = RGBAToHex(r, g, b, 75);

    PlayerTextDrawBoxColor(playerid, pSpeedoTd[playerid][0], Vehicle_Colour);
    PlayerTextDrawBoxColor(playerid, pSpeedoTd[playerid][1], Vehicle_Colour);

    switch(color1)
    {
        case 1: UseOutLine = 1;
        default: UseOutLine = 0;
    }

    for(new i = 2; i != 7; i ++) 
    {
        PlayerTextDrawSetOutline(playerid, pSpeedoTd[playerid][i], UseOutLine);
    }
	
	for(new i = 0; i < sizeof pSpeedoTd[]; i ++) 
	{
		PlayerTextDrawShow(playerid, pSpeedoTd[playerid][i]);
	}
	pSpeedoShown[playerid] = true;

	pLastFuelSubtraction[playerid] = gettime();
	pSpeedoTimer[playerid] = SetTimerEx("UpdatePlayerSpeedo", 250, true, "iif", playerid, vehicleid, VEHICLE_INFO[modelid - 400][vehicle_info_MAX_VEL]);
	return 1;
}

HidePlayerSpeedoMeter(playerid)
{
    pLastFuelSubtraction[playerid] = 0;
	pSpeedoShown[playerid] = false;
	if(pSpeedoTimer[playerid] != -1) {
	    KillTimer(pSpeedoTimer[playerid]);
        pSpeedoTimer[playerid] = -1;
    }
	for(new i = 0; i < sizeof pSpeedoTd[]; i ++) {
        PlayerTextDrawHide(playerid, pSpeedoTd[playerid][i]);
    }
	return 1;
}

forward UpdatePlayerSpeedo(playerid, vehicleid, Float:maxvel);
public UpdatePlayerSpeedo(playerid, vehicleid, Float:maxvel)
{
	if(!pSpeedoShown[playerid]) 
	{
		for(new i = 0; i < sizeof pSpeedoTd[]; i ++) 
		{
			PlayerTextDrawShow(playerid, pSpeedoTd[playerid][i]);
		}
		pSpeedoShown[playerid] = true;
	}

	if(vehicleid != GetPlayerVehicleID(playerid))
	{
		HidePlayerSpeedoMeter(playerid);
		ShowPlayerSpeedoMeter(playerid);
		
		GLOBAL_VEHICLES[vehicleid][gb_vehicle_DRIVER] = INVALID_PLAYER_ID;
		GLOBAL_VEHICLES[vehicleid][gb_vehicle_LAST_DRIVER] = playerid;
		GLOBAL_VEHICLES[vehicleid][gb_vehicle_OCCUPIED] = false;
		PlayerTemp[playerid][pt_LAST_VEHICLE_ID] = GetPlayerVehicleID(playerid);
		GLOBAL_VEHICLES[ PlayerTemp[playerid][pt_LAST_VEHICLE_ID] ][gb_vehicle_OCCUPIED] = true;
		return 0;
	}
	
	new Float:vel = GetVehicleSpeed(vehicleid);
	
	if(ac_Info[CHEAT_VEHICLE_SPEED_HACK][ac_Enabled])
	{
		if(gettime() > PLAYER_AC_INFO[playerid][CHEAT_VEHICLE_SPEED_HACK][p_ac_info_IMMUNITY])
		{
			if(vel > maxvel + 100.0)
			{
				if(!ac_Info[CHEAT_VEHICLE_SPEED_HACK][ac_Interval]) OnPlayerCheatDetected(playerid, CHEAT_VEHICLE_SPEED_HACK);
				else
				{
					if(gettime() - PLAYER_AC_INFO[playerid][CHEAT_VEHICLE_SPEED_HACK][p_ac_info_LAST_DETECTION] > ac_Info[CHEAT_VEHICLE_SPEED_HACK][ac_Interval]) PLAYER_AC_INFO[playerid][CHEAT_VEHICLE_SPEED_HACK][p_ac_info_DETECTIONS] = 0;
					else PLAYER_AC_INFO[playerid][CHEAT_VEHICLE_SPEED_HACK][p_ac_info_DETECTIONS] ++;
					
					PLAYER_AC_INFO[playerid][CHEAT_VEHICLE_SPEED_HACK][p_ac_info_LAST_DETECTION] = gettime();
					if(PLAYER_AC_INFO[playerid][CHEAT_VEHICLE_SPEED_HACK][p_ac_info_DETECTIONS] >= ac_Info[CHEAT_VEHICLE_SPEED_HACK][ac_Detections]) OnPlayerCheatDetected(playerid, CHEAT_VEHICLE_SPEED_HACK);
				}
			}
		}
	}
	
    GetVehicleHealth(vehicleid, GLOBAL_VEHICLES[vehicleid][gb_vehicle_HEALTH]);

    if(GLOBAL_VEHICLES[vehicleid][gb_vehicle_HEALTH] <= 699.9)
    {
        PlayerTextDrawSetString(playerid, pSpeedoTd[playerid][6], "~r~R");
    }
    else PlayerTextDrawSetString(playerid, pSpeedoTd[playerid][6], "_");

	if(GLOBAL_VEHICLES[vehicleid][gb_vehicle_STATE] == VEHICLE_STATE_NORMAL)
	{
		if(GLOBAL_VEHICLES[vehicleid][gb_vehicle_HEALTH] < MIN_VEHICLE_HEALTH)
		{	
			GLOBAL_VEHICLES[vehicleid][gb_vehicle_STATE] = VEHICLE_STATE_DAMAGED;
			GLOBAL_VEHICLES[vehicleid][gb_vehicle_HEALTH] = MIN_VEHICLE_HEALTH;
			SetVehicleHealthEx(vehicleid, GLOBAL_VEHICLES[vehicleid][gb_vehicle_HEALTH], playerid);
				
			GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE] = 0;
			UpdateVehicleParams(vehicleid);
			SendClientMessage(playerid, 0xCCCCCCCC, "El motor del vehículo está demasiado dañado.");
		}
	}
	
	if(gettime() > pLastFuelSubtraction[playerid] + 5)
	{
		if(GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE])
		{
			GLOBAL_VEHICLES[vehicleid][gb_vehicle_GAS] -= floatmul(floatdiv(vel, maxvel), 0.1);
			
			if(GLOBAL_VEHICLES[vehicleid][gb_vehicle_GAS] <= 0.1)
			{
				PLAYER_AC_INFO[playerid][CHEAT_VEHICLE_NOFUEL][p_ac_info_IMMUNITY] = gettime() + 15;
				GLOBAL_VEHICLES[vehicleid][gb_vehicle_GAS] = 0.0;
				GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE] = 0;
				UpdateVehicleParams(vehicleid);
				
				SendClientMessage(playerid, 0x99999999, "El vehículo se ha quedado sin gasolina...");
			}
		}
		pLastFuelSubtraction[playerid] = gettime();
	}
	
	new td_str[64];
	format(td_str, 64, "%.1f", GLOBAL_VEHICLES[vehicleid][gb_vehicle_GAS]);
	PlayerTextDrawSetString(playerid, pSpeedoTd[playerid][4], td_str);
	
	format(td_str, 64, "%03d", floatround(vel));
	PlayerTextDrawSetString(playerid, pSpeedoTd[playerid][2], td_str);
	
	GetVehiclePos(vehicleid, GLOBAL_VEHICLES[vehicleid][gb_vehicle_POS][0], GLOBAL_VEHICLES[vehicleid][gb_vehicle_POS][1], GLOBAL_VEHICLES[vehicleid][gb_vehicle_POS][2]);
	return 1;
}

stock Float:GetVehicleSpeed(vehicleid)
{
    new Float:vx, Float:vy, Float:vz;
    GetVehicleVelocity(vehicleid, vx, vy, vz);
	new Float:vel = floatmul(floatsqroot(floatadd(floatadd(floatpower(vx, 2), floatpower(vy, 2)),  floatpower(vz, 2))), 181.5);
	return vel;
}