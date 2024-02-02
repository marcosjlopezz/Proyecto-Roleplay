#include <YSI-Includes\YSI\y_hooks>

#define MAX_PLAYER_LOGIN_TEXTDRAWS      8
#define MAX_LOGIN_TEXTDRAWS             5

new
    Text:LoginTextdraws[MAX_LOGIN_TEXTDRAWS] = {Text:INVALID_TEXT_DRAW, ...},
    PlayerText:PlayerLoginTextdraws[MAX_PLAYERS][MAX_PLAYER_LOGIN_TEXTDRAWS] = {{PlayerText:INVALID_TEXT_DRAW, ...}, ...}
;

stock CreateLoginTextdraws()
{
    LoginTextdraws[0] = TextDrawCreate(320.000000, 90.000000, "_");
    TextDrawFont(LoginTextdraws[0], 1);
    TextDrawLetterSize(LoginTextdraws[0], 0.000000, 30.000000);
    TextDrawTextSize(LoginTextdraws[0], 0.000000, 250.000000);
    TextDrawSetOutline(LoginTextdraws[0], 1);
    TextDrawSetShadow(LoginTextdraws[0], 0);
    TextDrawAlignment(LoginTextdraws[0], 2);
    TextDrawColor(LoginTextdraws[0], -1);
    TextDrawBackgroundColor(LoginTextdraws[0], 255);
    TextDrawBoxColor(LoginTextdraws[0], 55);
    TextDrawUseBox(LoginTextdraws[0], 1);
    TextDrawSetProportional(LoginTextdraws[0], 1);
    TextDrawSetSelectable(LoginTextdraws[0], 0);

    LoginTextdraws[1] = TextDrawCreate(522.000000, 90.000000, "_");
    TextDrawFont(LoginTextdraws[1], 1);
    TextDrawLetterSize(LoginTextdraws[1], 0.000000, 30.000000);
    TextDrawTextSize(LoginTextdraws[1], 0.000000, 140.000000);
    TextDrawSetOutline(LoginTextdraws[1], 1);
    TextDrawSetShadow(LoginTextdraws[1], 0);
    TextDrawAlignment(LoginTextdraws[1], 2);
    TextDrawColor(LoginTextdraws[1], -1);
    TextDrawBackgroundColor(LoginTextdraws[1], 255);
    TextDrawBoxColor(LoginTextdraws[1], 55);
    TextDrawUseBox(LoginTextdraws[1], 1);
    TextDrawSetProportional(LoginTextdraws[1], 1);
    TextDrawSetSelectable(LoginTextdraws[1], 0);

    LoginTextdraws[2] = TextDrawCreate(98.000000, 90.000000, "_");
    TextDrawFont(LoginTextdraws[2], 1);
    TextDrawLetterSize(LoginTextdraws[2], 0.000000, 30.000000);
    TextDrawTextSize(LoginTextdraws[2], 0.000000, 175.000000);
    TextDrawSetOutline(LoginTextdraws[2], 1);
    TextDrawSetShadow(LoginTextdraws[2], 0);
    TextDrawAlignment(LoginTextdraws[2], 2);
    TextDrawColor(LoginTextdraws[2], -1);
    TextDrawBackgroundColor(LoginTextdraws[2], 255);
    TextDrawBoxColor(LoginTextdraws[2], 55);
    TextDrawUseBox(LoginTextdraws[2], 1);
    TextDrawSetProportional(LoginTextdraws[2], 1);
    TextDrawSetSelectable(LoginTextdraws[2], 0);

    LoginTextdraws[3] = TextDrawCreate(305.000000, 84.000000, SERVER_SHORT_NAME2);
    TextDrawFont(LoginTextdraws[3], 0);
    TextDrawLetterSize(LoginTextdraws[3], 1.499998, 5.500000);
    TextDrawTextSize(LoginTextdraws[3], 0.000000, 0.000000);
    TextDrawSetOutline(LoginTextdraws[3], 2);
    TextDrawSetShadow(LoginTextdraws[3], 0);
    TextDrawAlignment(LoginTextdraws[3], 2);
    TextDrawColor(LoginTextdraws[3], PRIMARY_COLOR2);
    TextDrawBackgroundColor(LoginTextdraws[3], 255);
    TextDrawBoxColor(LoginTextdraws[3], 50);
    TextDrawUseBox(LoginTextdraws[3], 0);
    TextDrawSetProportional(LoginTextdraws[3], 1);
    TextDrawSetSelectable(LoginTextdraws[3], 0);

    LoginTextdraws[4] = TextDrawCreate(360.000000, 125.000000, "Roleplay");
    TextDrawFont(LoginTextdraws[4], 0);
    TextDrawLetterSize(LoginTextdraws[4], 0.666665, 2.000000);
    TextDrawTextSize(LoginTextdraws[4], 0.000000, 0.000000);
    TextDrawSetOutline(LoginTextdraws[4], 2);
    TextDrawSetShadow(LoginTextdraws[4], 0);
    TextDrawAlignment(LoginTextdraws[4], 2);
    TextDrawColor(LoginTextdraws[4], PRIMARY_COLOR2);
    TextDrawBackgroundColor(LoginTextdraws[4], 255);
    TextDrawBoxColor(LoginTextdraws[4], 50);
    TextDrawUseBox(LoginTextdraws[4], 0);
    TextDrawSetProportional(LoginTextdraws[4], 1);
    TextDrawSetSelectable(LoginTextdraws[4], 0);
}

stock CreatePlayerLoginTextdraws(playerid)
{
    PlayerLoginTextdraws[playerid][0] = CreatePlayerTextDraw(playerid, 13.000000, 146.000000, "SKIN");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][0], 5);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][0], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][0], 162.500000, 180.500000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][0], 2);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][0], 0);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][0], 0);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][0], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][0], 0);
    PlayerTextDrawSetPreviewModel(playerid, PlayerLoginTextdraws[playerid][0], 0);
    PlayerTextDrawSetPreviewRot(playerid, PlayerLoginTextdraws[playerid][0], -10.000000, 0.000000, -20.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, PlayerLoginTextdraws[playerid][0], 1, 1);

    PlayerLoginTextdraws[playerid][1] = CreatePlayerTextDraw(playerid, 98.000000, 135.000000, "Bienvenido de nuevo Nombre_Apellido.");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][1], 0.200000, 1.300000);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][1], 10000.000000, 1000.000000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][1], 1);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][1], 2);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][1], 0);

    PlayerLoginTextdraws[playerid][2] = CreatePlayerTextDraw(playerid, 524.000000, 110.000000, "Informacion");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][2], 1);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][2], 0.200000, 1.300000);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][2], 10000.000000, 10000.000000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][2], 1);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][2], 2);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][2], 0);

    PlayerLoginTextdraws[playerid][3] = CreatePlayerTextDraw(playerid, 458.000000, 125.000000, "Ultimo_Ingreso:");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][3], 1);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][3], 0.200000, 1.300000);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][3], 10000.000000, 10000.000000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][3], 1);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][3], 1);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][3], 255);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][3], 50);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][3], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][3], 0);

    PlayerLoginTextdraws[playerid][4] = CreatePlayerTextDraw(playerid, 458.000000, 142.000000, "Salud:");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][4], 1);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][4], 0.200000, 1.300000);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][4], 10000.000000, 10000.000000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][4], 0);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][4], 1);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][4], 1);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][4], 255);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][4], 50);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][4], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][4], 0);

    PlayerLoginTextdraws[playerid][5] = CreatePlayerTextDraw(playerid, 458.000000, 158.000000, "Chaleco:");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][5], 1);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][5], 0.200000, 1.300000);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][5], 10000.000000, 10000.000000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][5], 0);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][5], 1);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][5], 1);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][5], 255);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][5], 50);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][5], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][5], 0);

    PlayerLoginTextdraws[playerid][6] = CreatePlayerTextDraw(playerid, 458.000000, 173.000000, "Ultima_Ubicacion:");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][6], 1);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][6], 0.200000, 1.300000);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][6], 10000.000000, 10000.000000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][6], 0);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][6], 1);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][6], 1);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][6], 255);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][6], 50);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][6], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][6], 0);

    PlayerLoginTextdraws[playerid][7] = CreatePlayerTextDraw(playerid, 200.000000, 343.000000, "TIP:_");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][7], 1);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][7], 0.200000, 1.300000);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][7], 10000.000000, 10000.000000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][7], 0);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][7], 1);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][7], 1);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][7], PRIMARY_COLOR2);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][7], 255);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][7], 50);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][7], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][7], 0);
}

stock ShowPlayerLogin(playerid)
{
    new tips_message[128];
    format(tips_message, 128, "TIPS:_%s", RandomTipsMessages[ random(sizeof(RandomTipsMessages)) ]);
    FixTextDrawString(tips_message, true);

    new str_text[445];
    PlayerTextDrawSetString(playerid, PlayerLoginTextdraws[playerid][7], tips_message);
    PlayerTextDrawSetPreviewModel(playerid, PlayerLoginTextdraws[playerid][0], PI[playerid][pi_SKIN]);

    format(str_text, 445, "Ultimo Ingreso: ~y~%s", PI[playerid][pi_LAST_CONNECTION]);
    FixTextDrawString(str_text, true);

    PlayerTextDrawSetString(playerid, PlayerLoginTextdraws[playerid][3], str_text);

    format(str_text, 445, "Salud: ~r~%s", number_format_thousand(floatround(PI[playerid][pi_HEALTH])));
    FixTextDrawString(str_text, true);

    PlayerTextDrawSetString(playerid, PlayerLoginTextdraws[playerid][4], str_text);

    format(str_text, 445, "Chaleco: ~b~%s", number_format_thousand(floatround(PI[playerid][pi_ARMOUR])));
    FixTextDrawString(str_text, true);

    PlayerTextDrawSetString(playerid, PlayerLoginTextdraws[playerid][5], str_text);

    new city[145], zone[145];
    GetPointZone(PI[playerid][pi_POS_X], PI[playerid][pi_POS_Y], city, zone);
    format(str_text, 445, "Ultima Ubicacion: ~g~%s, %s", city, zone);
    FixTextDrawString(str_text, true);

    PlayerTextDrawSetString(playerid, PlayerLoginTextdraws[playerid][6], str_text);

    format(str_text, 445, "Bienvenido de nuevo %s.", pTemp(playerid)[pt_NAME]);
    FixTextDrawString(str_text, true);
    
    PlayerTextDrawSetString(playerid, PlayerLoginTextdraws[playerid][1], str_text);

    for(new i; i < MAX_PLAYER_LOGIN_TEXTDRAWS; i++)
    {
        PlayerTextDrawShow(playerid, PlayerLoginTextdraws[playerid][i]);
    }

    for(new i; i < MAX_LOGIN_TEXTDRAWS; i++)
    {
        TextDrawShowForPlayer(playerid, LoginTextdraws[i]);
    }

    ShowDialog(playerid, DIALOG_PASSWORD);
}

stock HidePlayerLoginTextdraws(playerid)
{
    for(new i; i < MAX_PLAYER_LOGIN_TEXTDRAWS; i++)
    {
        PlayerTextDrawHide(playerid, PlayerLoginTextdraws[playerid][i]);
    }

    for(new i; i < MAX_LOGIN_TEXTDRAWS; i++)
    {
        TextDrawHideForPlayer(playerid, LoginTextdraws[i]);
    }
}

hook OnScriptInit()
{
    CreateLoginTextdraws();
}

hook OnPlayerConnect(playerid)
{
    CreatePlayerLoginTextdraws(playerid);
}

callbackp:OnPlayerInputPassword(playerid, bool:success)
{
    if(success)
    {
        HidePlayerLoginTextdraws(playerid);
        LoadPlayerGameData(playerid);
    }
    else // Error
	{
		PlayerTemp[playerid][pt_BAD_LOGIN_ATTEMP] ++;
		if(PlayerTemp[playerid][pt_BAD_LOGIN_ATTEMP] > MAX_BAD_LOGIN_ATTEMPS) return KickEx(playerid);

		SendMessagef(playerid, "Contraseña incorrecta, aviso %d/%d.", PlayerTemp[playerid][pt_BAD_LOGIN_ATTEMP], MAX_BAD_LOGIN_ATTEMPS);
        ShowDialog(playerid, DIALOG_PASSWORD);
    }
    return 1;
}