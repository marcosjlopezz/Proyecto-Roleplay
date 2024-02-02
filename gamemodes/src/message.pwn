#include <YSI-Includes\YSI\y_hooks>

#define MAX_MESSAGE_TD  2

#define DEFAULT_MESSAGE_POS_X   320.000000
#define DEFAULT_MESSAGE_POS_Y   380.000000

new 
    PlayerText:PlayerMessageTD[MAX_PLAYERS][MAX_MESSAGE_TD] = {{PlayerText:INVALID_TEXT_DRAW, ...}, ...},
    pMessageTimer[MAX_PLAYERS] = {-1, ...}
;

hook OnPlayerConnect(playerid)
{
    for(new i = 0; i < MAX_MESSAGE_TD; i++)
    {
        PlayerMessageTD[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
    }
    KillTimer(pMessageTimer[playerid]);

    PlayerMessageTD[playerid][0] = CreatePlayerTextDraw(playerid, DEFAULT_MESSAGE_POS_X, DEFAULT_MESSAGE_POS_Y, "_");
    PlayerTextDrawLetterSize(playerid, PlayerMessageTD[playerid][0], 0.320999, 1.736888);
    PlayerTextDrawAlignment(playerid, PlayerMessageTD[playerid][0], 2);
    PlayerTextDrawColor(playerid, PlayerMessageTD[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, PlayerMessageTD[playerid][0], 1);
    PlayerTextDrawSetOutline(playerid, PlayerMessageTD[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, PlayerMessageTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, PlayerMessageTD[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, PlayerMessageTD[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, PlayerMessageTD[playerid][0], 1);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

stock _ShwNtTextdraws(playerid)
{
    for(new i = 0; i < MAX_MESSAGE_TD; i++)
    {
        PlayerTextDrawShow(playerid, PlayerMessageTD[playerid][i]);
    }
}

stock _HdeNtTextdraws(playerid)
{
    for(new i = 0; i < MAX_MESSAGE_TD; i++)
    {
        PlayerTextDrawHide(playerid, PlayerMessageTD[playerid][i]);
    }
}

callbackp:_ShowNotificationTextdraws(playerid, const text[])
{
    new tmp_text[512]; format(tmp_text, 512, "%s", text);

    _ShwNtTextdraws(playerid);
    FixTextDrawString(tmp_text, true);
    PlayerTextDrawSetString(playerid, PlayerMessageTD[playerid][0], tmp_text);
    return 1;
}

callbackp:_HideNotificationTextdraws(playerid)
{
    _HdeNtTextdraws(playerid);
    PlayerTextDrawSetString(playerid, PlayerMessageTD[playerid][0], "_");
    return 1;
}

stock SendMessage(playerid, const text[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        PlayerTextDrawSetPos(playerid, PlayerMessageTD[playerid][0], DEFAULT_MESSAGE_POS_X, DEFAULT_MESSAGE_POS_Y - 42.0);
    }
    else PlayerTextDrawSetPos(playerid, PlayerMessageTD[playerid][0], DEFAULT_MESSAGE_POS_X, DEFAULT_MESSAGE_POS_Y);

    _ShowNotificationTextdraws(playerid, text);

    KillTimer(pMessageTimer[playerid]);
    pMessageTimer[playerid] = SetTimerEx("_HideNotificationTextdraws", 3 * 1000, false, "i", playerid);
    return 1;
}

stock SendMessagef(playerid, const text[], {Float,_}:...)
{
    static
        args,
        str[192];

    if((args = numargs()) <= 2)
    {
        SendMessage(playerid, text);
    }
    else
    {
        while(--args >= 2)
        {
            #emit LCTRL 5
            #emit LOAD.alt args
            #emit SHL.C.alt 2
            #emit ADD.C 12
            #emit ADD
            #emit LOAD.I
            #emit PUSH.pri
        }
        #emit PUSH.S text
        #emit PUSH.C 192
        #emit PUSH.C str
        #emit LOAD.S.pri 8
        #emit CONST.alt 4
        #emit ADD
        #emit PUSH.pri
        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        SendMessage(playerid, str);

        #emit RETN
    }
    return 1;
}