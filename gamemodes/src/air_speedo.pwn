#include <YSI-Includes\YSI\y_hooks>

new
    PlayerText:pAirSpeedoTd[MAX_PLAYERS][4] = {{PlayerText:INVALID_TEXT_DRAW, ...}, ...},
    bool:pAirSpeedo[MAX_PLAYERS],
    pAirSpeedoTimer[MAX_PLAYERS] = {-1, ...}
;

forward OnAirSpeedoRequestUpdate(playerid, vehicleid);

hook OnPlayerDisconnect(playerid, reason) 
{
    DestroyPlayerAirSpeedo(playerid);
}

hook OnPlayerStateChange(playerid, newstate, oldstate) 
{
    if(newstate == PLAYER_STATE_DRIVER) 
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(!VEHICLE_INFO[GetVehicleModel(vehicleid) - 400][vehicle_info_NORMAL_SPEEDO] && (Vehicle_IsPlane(vehicleid) || Vehicle_IsHelicopter(vehicleid))) 
        {
            CreatePlayerAirSpeedo(playerid, vehicleid);
        }
    }
    else if(oldstate == PLAYER_STATE_DRIVER && pAirSpeedo[playerid]) 
    {
        DestroyPlayerAirSpeedo(playerid);
    }
}

public OnAirSpeedoRequestUpdate(playerid, vehicleid) 
{
    new string[128], Float:pos[3];
    GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);

    new Float:vel = GetVehicleAirSpeed(vehicleid);
    format(string, sizeof string, "%.0f", vel);
    PlayerTextDrawSetString(playerid, pAirSpeedoTd[playerid][2], string);
}

CreatePlayerAirSpeedo(playerid, vehicleid) 
{
    DestroyPlayerAirSpeedo(playerid);

    pAirSpeedoTd[playerid][0] = CreatePlayerTextDraw(playerid, 320.000000, 357.000000, "_");
    PlayerTextDrawFont(playerid, pAirSpeedoTd[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid, pAirSpeedoTd[playerid][0], 0.000000, 3.400000);
    PlayerTextDrawTextSize(playerid, pAirSpeedoTd[playerid][0], 0.000000, 80.000000);
    PlayerTextDrawSetOutline(playerid, pAirSpeedoTd[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, pAirSpeedoTd[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, pAirSpeedoTd[playerid][0], 2);
    PlayerTextDrawColor(playerid, pAirSpeedoTd[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, pAirSpeedoTd[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, pAirSpeedoTd[playerid][0], 75);
    PlayerTextDrawUseBox(playerid, pAirSpeedoTd[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, pAirSpeedoTd[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, pAirSpeedoTd[playerid][0], 0);

    pAirSpeedoTd[playerid][1] = CreatePlayerTextDraw(playerid, 320.000000, 395.000000, "_");
    PlayerTextDrawFont(playerid, pAirSpeedoTd[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, pAirSpeedoTd[playerid][1], 0.000000, 1.700000);
    PlayerTextDrawTextSize(playerid, pAirSpeedoTd[playerid][1], 0.000000, 80.000000);
    PlayerTextDrawSetOutline(playerid, pAirSpeedoTd[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, pAirSpeedoTd[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, pAirSpeedoTd[playerid][1], 2);
    PlayerTextDrawColor(playerid, pAirSpeedoTd[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, pAirSpeedoTd[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, pAirSpeedoTd[playerid][1], 75);
    PlayerTextDrawUseBox(playerid, pAirSpeedoTd[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, pAirSpeedoTd[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, pAirSpeedoTd[playerid][1], 0);

    pAirSpeedoTd[playerid][2] = CreatePlayerTextDraw(playerid, 320.000000, 353.000000, "000");
    PlayerTextDrawFont(playerid, pAirSpeedoTd[playerid][2], 2);
    PlayerTextDrawLetterSize(playerid, pAirSpeedoTd[playerid][2], 0.370831, 2.799998);
    PlayerTextDrawTextSize(playerid, pAirSpeedoTd[playerid][2], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, pAirSpeedoTd[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, pAirSpeedoTd[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, pAirSpeedoTd[playerid][2], 2);
    PlayerTextDrawColor(playerid, pAirSpeedoTd[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, pAirSpeedoTd[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, pAirSpeedoTd[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, pAirSpeedoTd[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, pAirSpeedoTd[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, pAirSpeedoTd[playerid][2], 0);

    pAirSpeedoTd[playerid][3] = CreatePlayerTextDraw(playerid, 320.000000, 375.000000, "KTS");
    PlayerTextDrawFont(playerid, pAirSpeedoTd[playerid][3], 2);
    PlayerTextDrawLetterSize(playerid, pAirSpeedoTd[playerid][3], 0.200000, 1.299998);
    PlayerTextDrawTextSize(playerid, pAirSpeedoTd[playerid][3], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, pAirSpeedoTd[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, pAirSpeedoTd[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, pAirSpeedoTd[playerid][3], 2);
    PlayerTextDrawColor(playerid, pAirSpeedoTd[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, pAirSpeedoTd[playerid][3], 255);
    PlayerTextDrawBoxColor(playerid, pAirSpeedoTd[playerid][3], 50);
    PlayerTextDrawUseBox(playerid, pAirSpeedoTd[playerid][3], 0);
    PlayerTextDrawSetProportional(playerid, pAirSpeedoTd[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, pAirSpeedoTd[playerid][3], 0);

    new color1;
    GetVehicleColor(vehicleid, color1);

    new r, g, b, a, Vehicle_Colour, UseOutLine = 0;
    HexToRGBA(VEHICLE_COLORS[color1], r, g, b, a);
    Vehicle_Colour = RGBAToHex(r, g, b, 75);

    PlayerTextDrawBoxColor(playerid, pAirSpeedoTd[playerid][0], Vehicle_Colour);
    PlayerTextDrawBoxColor(playerid, pAirSpeedoTd[playerid][1], Vehicle_Colour);

    switch(color1)
    {
        case 1: UseOutLine = 1;
        default: UseOutLine = 0;
    }

    PlayerTextDrawSetOutline(playerid, pAirSpeedoTd[playerid][2], UseOutLine);
    PlayerTextDrawSetOutline(playerid, pAirSpeedoTd[playerid][3], UseOutLine);

    for(new i = 0; i < sizeof pAirSpeedoTd[]; i ++) 
    {
        PlayerTextDrawShow(playerid, pAirSpeedoTd[playerid][i]);
    }

    pAirSpeedoTimer[playerid] = SetTimerEx("OnAirSpeedoRequestUpdate", 250, true, "ii", playerid, vehicleid);
    pAirSpeedo[playerid] = true;
}

DestroyPlayerAirSpeedo(playerid) 
{
    for(new i = 0; i < sizeof pAirSpeedoTd[]; i ++) 
    {
        PlayerTextDrawDestroy(playerid, pAirSpeedoTd[playerid][i]);
    }

    if(pAirSpeedoTimer[playerid] != -1) 
    {
        KillTimer(pAirSpeedoTimer[playerid]);
        pAirSpeedoTimer[playerid] = -1;
    }

    pAirSpeedo[playerid] = false;
}

stock Float:GetVehicleAirSpeed(vehicleid)
{
    new Float:vel = GetVehicleSpeed(vehicleid);
	return vel * 1.2;
}