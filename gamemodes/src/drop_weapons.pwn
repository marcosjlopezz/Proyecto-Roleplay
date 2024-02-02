#include <YSI-Includes\YSI\y_hooks>

#define MAX_DROPPED_WEAPONS 1000

enum _:E_DroppedWeapons 
{
    dw_WEAPONID,
    dw_AMMO,
    dw_OBJECTID,
    Text3D:dw_LABELID,
    dw_WORLD,
    dw_INTERIOR,
    Float:dw_X,
    Float:dw_Y,
    Float:dw_Z
};

new List:DroppedWeapons;

hook OnScriptInit() 
{
    DroppedWeapons = list_new();
}

hook OnPlayerDeath(playerid, killerid, reason) 
{
    DropPlayerHandWeapon(playerid);
}

forward DropPlayerHandWeapon(playerid, bool:show_error_message = false);
stock DropPlayerHandWeapon(playerid, bool:show_error_message = false)
{
    if(GetPlayerWork(playerid, WORK_POLICE) && IsPlayerWorking(playerid, WORK_POLICE)) return -1;

    new weaponid = GetPlayerWeapon(playerid);
    if(weaponid > 0) 
    {
        new slot = WEAPON_INFO[weaponid][weapon_info_SLOT], ammo;
        GetPlayerWeaponData(playerid, slot, weaponid, ammo);
        if(weaponid > 0 && ammo > 0 && WEAPON_INFO[weaponid][weapon_info_DROP] && PLAYER_WEAPONS[playerid][slot][player_weapon_VALID] && PLAYER_WEAPONS[playerid][slot][player_weapon_ID] == weaponid) {
            RemovePlayerSlotWeapon(playerid, slot, true);

            new weaponInfo[E_DroppedWeapons];
            weaponInfo[dw_WEAPONID] = weaponid;
            weaponInfo[dw_AMMO] = ammo;
            weaponInfo[dw_WORLD] = GetPlayerVirtualWorld(playerid);
            weaponInfo[dw_INTERIOR] = GetPlayerInterior(playerid);
            GetPlayerPos(playerid, weaponInfo[dw_X], weaponInfo[dw_Y], weaponInfo[dw_Z]);

            weaponInfo[dw_OBJECTID] = CreateDynamicObject(WEAPON_INFO[weaponid][weapon_info_MODEL], weaponInfo[dw_X], weaponInfo[dw_Y], weaponInfo[dw_Z] - 1.0, 90.0, 0.0, float(random(360)), weaponInfo[dw_WORLD], weaponInfo[dw_INTERIOR]);

            new label_str[256];
            format(label_str, sizeof label_str, "{"#GREEN_COLOR"}%s\n{FFFFFF}Presiona {"#PRIMARY_COLOR"}[ H ] {FFFFFF}para recoger el objeto", WEAPON_INFO[weaponid][weapon_info_NAME]);
            weaponInfo[dw_LABELID] = CreateDynamic3DTextLabel(label_str, 0xFFFFFFFF, weaponInfo[dw_X], weaponInfo[dw_Y], weaponInfo[dw_Z] - 0.7, 5.0, .testlos = true, .interiorid = weaponInfo[dw_INTERIOR], .worldid = weaponInfo[dw_WORLD]);

            list_add_arr(DroppedWeapons, weaponInfo);
            Streamer_Update(playerid);
        } 
        return 1;
    }

    if(show_error_message) SendClientMessagef(playerid, -1, "No tienes ningun arma en la mano");
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) 
{
    if(newkeys &  KEY_CTRL_BACK)
	{
        if(PI[playerid][pi_STATE] != ROLEPLAY_STATE_CRACK && PI[playerid][pi_STATE] != ROLEPLAY_STATE_JAIL) {
            for(new i = 0; i < list_size(DroppedWeapons); i ++) {
                new weaponInfo[E_DroppedWeapons];
                list_get_arr(DroppedWeapons, i, weaponInfo);

                if(GetPlayerInterior(playerid) == weaponInfo[dw_INTERIOR] && GetPlayerVirtualWorld(playerid) == weaponInfo[dw_WORLD] && IsPlayerInRangeOfPoint(playerid, 1.0, weaponInfo[dw_X], weaponInfo[dw_Y], weaponInfo[dw_Z])) 
                {
                    if(PI[playerid][pi_LEVEL] < 3) SendClientMessagef(playerid, -1, "Deber ser nivel 3 o superior para poder recoger armas del suelo.");
                    else 
                    {
                        new weapon_slot = WEAPON_INFO[ weaponInfo[dw_WEAPONID] ][weapon_info_SLOT];
                        if(PLAYER_WEAPONS[playerid][weapon_slot][player_weapon_ID] != 0) 
                        {
                            SendClientMessagef(playerid, -1, "Para recoger esta arma debes deshacerte de tu %s (%d) para tener espacio.", WEAPON_INFO[ PLAYER_WEAPONS[playerid][weapon_slot][player_weapon_ID] ][weapon_info_NAME], weapon_slot);						
                        }
                        else 
                        {
                            ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 1, 1, 0, 0, 1);
                            DestroyDynamicObject(weaponInfo[dw_OBJECTID]);
                            DestroyDynamic3DTextLabel(weaponInfo[dw_LABELID]);
                            list_remove(DroppedWeapons, i);

                            GivePlayerWeaponEx(playerid, weaponInfo[dw_WEAPONID], weaponInfo[dw_AMMO]);
                            RegisterNewPlayerWeapon(playerid, weapon_slot);
                            Auto_SendPlayerAction(playerid, "recoge un objeto del suelo.");
                            Streamer_Update(playerid);
                        }
                    }
                    return Y_HOOKS_BREAK_RETURN_1;
                }
            }
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}