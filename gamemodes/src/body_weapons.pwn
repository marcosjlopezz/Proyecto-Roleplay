#include <YSI-Includes\YSI\y_hooks>

new bool:pUpdateWeaponsInBody[MAX_PLAYERS];

hook OnPlayerConnect(playerid) 
{
	pUpdateWeaponsInBody[playerid] = true;
	return true;
}

hook OnPlayerUpdate(playerid) 
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && pUpdateWeaponsInBody[playerid]) 
	{
        UpdateWeaponsInBody(playerid);
    }
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate) 
{
    if(oldstate == PLAYER_STATE_ONFOOT) {
		new vehicleid = GetPlayerVehicleID(playerid);
		if(vehicleid && Vehicle_IsBike(vehicleid)) return Y_HOOKS_CONTINUE_RETURN_1;
		RemovePlayerArmedWeapons(playerid);
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

stock RemovePlayerArmedWeapons(playerid) 
{
	RemovePlayerAttachedObject(playerid, 4);
	RemovePlayerAttachedObject(playerid, 5);
	RemovePlayerAttachedObject(playerid, 6);
	RemovePlayerAttachedObject(playerid, 7);
	RemovePlayerAttachedObject(playerid, 8);
	RemovePlayerAttachedObject(playerid, 9);
}

stock IsPlayerArmedWeaponsEnabled(playerid) 
{
	return pUpdateWeaponsInBody[playerid];
}

stock DisablePlayerArmedWeapons(playerid) 
{
	pUpdateWeaponsInBody[playerid] = false;
	RemovePlayerArmedWeapons(playerid);
}

stock EnablePlayerArmedWeapons(playerid) 
{
	pUpdateWeaponsInBody[playerid] = true;
}

UpdateWeaponsInBody(playerid) 
{
	RemovePlayerArmedWeapons(playerid);
	for(new i = 0; i != sizeof PLAYER_WEAPONS[]; i ++) 
	{
		if(!PLAYER_WEAPONS[playerid][i][player_weapon_VALID]) continue;

		new weaponId;
		weaponId = PLAYER_WEAPONS[playerid][i][player_weapon_ID];
		if(GetPlayerWeapon(playerid) == weaponId) continue;
		switch(weaponId) 
		{
			case 3: SetPlayerAttachedObject(playerid, 6, 334, 7, 0, 0, -0.114, 90.9, 66.6, 0, 1.000000, 1.000000, 1.000000);
			case 4: SetPlayerAttachedObject(playerid, 6, 335, 7, 0, 0, -0.114, 90.9, 66.6, 0, 1.000000, 1.000000, 1.000000);
			case 9: SetPlayerAttachedObject(playerid, 9, 341, 1, -0.037, -0.132, 0.164, -172.9, 52.2, 170.1, 1.000000, 1.000000, 1.000000);
			case 10: SetPlayerAttachedObject(playerid, 6, 321, 7, 0, 0, -0.114, 90.9, 66.6, 0, 1.000000, 1.000000, 1.000000);
			case 23: SetPlayerAttachedObject(playerid, 5, 346, 8, -0.052, -0.062, 0.131, -93.0, 0, 2.4, 1.000000, 1.000000, 1.000000);
			case 22: SetPlayerAttachedObject(playerid, 5, 347, 8, -0.052, -0.062, 0.131, -93.0, 0, 2.4, 1.000000, 1.000000, 1.000000);
			case 24: SetPlayerAttachedObject(playerid, 5, 348, 8, -0.052, -0.062, 0.131, -93.0, 0, 2.4, 1.000000, 1.000000, 1.000000);
			case 25: SetPlayerAttachedObject(playerid, 8, 349, 1, 0.094, -0.147, 0.098, 0, 157.8, 4.4, 1.000000, 1.000000, 1.000000);
			case 27: SetPlayerAttachedObject(playerid, 8, 351, 1, 0.094, -0.147, 0.098, 0, 157.8, 4.4, 1.000000, 1.000000, 1.000000);
			case 29: SetPlayerAttachedObject(playerid, 6, 353, 7, 0, -0.128, -0.093, -75.1, 8.6, 9.30001, 1.000000, 1.000000, 1.000000);
			case 30: SetPlayerAttachedObject(playerid, 7, 355, 1, -0.013, 0.163, 0.125, 0, 69.9, 7.3, 1.000000, 1.000000, 1.000000);
			case 31: SetPlayerAttachedObject(playerid, 7, 356, 1, -0.013, 0.163, 0.125, 0, 69.9, 7.3, 1.000000, 1.000000, 1.000000);
			case 32: SetPlayerAttachedObject(playerid, 6, 372, 7, 0, -0.128, -0.093, -75.1, 8.6, 9.30001, 1.000000, 1.000000, 1.000000);
			case 33: SetPlayerAttachedObject(playerid, 4, 357, 1, -0.034, -0.162, 0.033, 0, 38.9, 5.7, 1.000000, 1.000000, 1.000000);
			case 34: SetPlayerAttachedObject(playerid, 4, 358, 1, -0.034, -0.162, 0.033, 0, 38.9, 5.7, 1.000000, 1.000000, 1.000000);
			case 35: SetPlayerAttachedObject(playerid, 9, 359, 1, -0.037, -0.132, 0.164, -172.9, 52.2, 170.1, 1.000000, 1.000000, 1.000000);
			case 36: SetPlayerAttachedObject(playerid, 9, 360, 1, -0.037, -0.132, 0.164, -172.9, 52.2, 170.1, 1.000000, 1.000000, 1.000000);
			case 37: SetPlayerAttachedObject(playerid, 9, 361, 1, -0.037, -0.132, 0.164, -172.9, 52.2, 170.1, 1.000000, 1.000000, 1.000000);
			case 38: SetPlayerAttachedObject(playerid, 9, 362, 1, -0.037, -0.132, 0.164, -172.9, 52.2, 170.1, 1.000000, 1.000000, 1.000000);
		}
	}
}