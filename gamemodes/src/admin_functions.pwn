#include <YSI-Includes\YSI\y_hooks>

new InvisibleUpdater[MAX_PLAYERS] = {-1, ...};

hook OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
    if(damagedid != INVALID_PLAYER_ID)
    {
        if(PlayerTemp[damagedid][pt_ADMIN_SERVICE])
        {
            if(PI[damagedid][pi_ADMIN_LEVEL] >= CMD_MODERATOR)
            {
                if(PI[damagedid][pi_ARMOUR]) SetPlayerArmourEx(damagedid, 100.0);
                else SetPlayerHealthEx(damagedid, 100.0);

                SendClientMessagef(damagedid, 0xFF0000FF, "Aviso: %s (%d) te ha hecho daño.", PI[playerid][pi_NAME], playerid);

                FreezePlayer(playerid);
                SetPlayerArmedWeapon(playerid, 0);
                ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Advertencia", "Evita pegar a Administradores en servicio.\nPodrias ser sancionado.", "Cerrar", "");
                return Y_HOOKS_BREAK_RETURN_1;
            }
        }

    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    new Float:sx, Float:sy, Float:sz;
	GetPlayerPos(playerid, sx, sy, sz);

    if(PlayerTemp[playerid][pt_PLAYER_INVISIBLE])
    {
        SendMessage(playerid, "No puedes subir a vehiculos estando invisible.");
        
		RemovePlayerFromVehicle(playerid);
		SetPlayerPos(playerid, sx, sy, sz);
        return Y_HOOKS_BREAK_RETURN_1;
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerSpawn(playerid)
{
    if(PlayerTemp[playerid][pt_GAME_STATE] == GAME_STATE_CONNECTED)
    {
        PlayerTemp[playerid][pt_PLAYER_INVISIBLE] = false;
        KillTimer(InvisibleUpdater[playerid]); 
    }
}

hook OnPlayerStateChange(playerid, newstate, oldstate) 
{
    if(newstate == PLAYER_STATE_DRIVER) 
	{
        if(PlayerTemp[playerid][pt_PLAYER_INVISIBLE])
        {
            SendMessage(playerid, "No puedes subir a vehiculos estando invisible.");
            RemovePlayerFromVehicle(playerid);
        }
    }
    else if(oldstate == PLAYER_STATE_DRIVER) 
	{
        if(PlayerTemp[playerid][pt_PLAYER_INVISIBLE])
        {
            KillTimer(InvisibleUpdater[playerid]);
            InvisibleUpdater[playerid] = SetTimerEx("UpdatePlayerInvisible", 5000, false, "i", playerid);
        }
    }
}

callbackp:UpdatePlayerInvisible(playerid)
{
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
    {
        HidePlayerForPlayer(i, playerid);
    }

    if(PlayerTemp[playerid][pt_PLAYER_INVISIBLE])
    {
        KillTimer(InvisibleUpdater[playerid]);
        InvisibleUpdater[playerid] = SetTimerEx("UpdatePlayerInvisible", 5000, false, "i", playerid);
    }
    return 1;
}

CMD:invis(playerid, params[])
{
    if(PlayerTemp[playerid][pt_PLAYER_INVISIBLE])
    {
        PlayerTemp[playerid][pt_PLAYER_INVISIBLE] = false;
        SendMessage(playerid, "Ya no eres invisible");

        KillTimer(InvisibleUpdater[playerid]);

        for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
        {
            ShowPlayerForPlayer(i, playerid, true);
        }

        for(new i = 0; i < 2; i++) TextDrawHideForPlayer(playerid, Textdraws[textdraw_STAFF_INVIS][i]);
    }
    else
    {
        PlayerTemp[playerid][pt_PLAYER_INVISIBLE] = true;
        SendMessage(playerid, "Ahora nadie te puede ver");

        RemovePlayerFromVehicle(playerid);
        ClearAnimations(playerid);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

        for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
        {
            HidePlayerForPlayer(i, playerid);
        }

        for(new i = 0; i < 2; i++) TextDrawShowForPlayer(playerid, Textdraws[textdraw_STAFF_INVIS][i]);

        KillTimer(InvisibleUpdater[playerid]);
        InvisibleUpdater[playerid] = SetTimerEx("UpdatePlayerInvisible", 5000, false, "i", playerid);
    }
    return 1;
}

flags:invis(CMD_SUPERVISOR);