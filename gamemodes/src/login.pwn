#include <YSI-Includes\YSI\y_hooks>

#define MAX_PLAYER_LOGIN_TEXTDRAWS      7
#define MAX_LOGIN_TEXTDRAWS             13

new
    Text:LoginTextdraws[MAX_LOGIN_TEXTDRAWS] = {Text:INVALID_TEXT_DRAW, ...},
    PlayerText:PlayerLoginTextdraws[MAX_PLAYERS][MAX_PLAYER_LOGIN_TEXTDRAWS] = {{PlayerText:INVALID_TEXT_DRAW, ...}, ...}
;

#define NOTICE_TEXTDRAW                 LoginTextdraws[12]

stock MayusShortName()
{
    new name[64]; format(name, 64, SERVER_SHORT_NAME);
    StrToUpper(name);
    return name;
}

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

    LoginTextdraws[1] = TextDrawCreate(538.000000, 90.000000, "_");
    TextDrawFont(LoginTextdraws[1], 1);
    TextDrawLetterSize(LoginTextdraws[1], 0.000000, 30.000000);
    TextDrawTextSize(LoginTextdraws[1], 0.000000, 175.000000);
    TextDrawSetOutline(LoginTextdraws[1], 1);
    TextDrawSetShadow(LoginTextdraws[1], 0);
    TextDrawAlignment(LoginTextdraws[1], 2);
    TextDrawColor(LoginTextdraws[1], -1);
    TextDrawBackgroundColor(LoginTextdraws[1], 255);
    TextDrawBoxColor(LoginTextdraws[1], 55);
    TextDrawUseBox(LoginTextdraws[1], 1);
    TextDrawSetProportional(LoginTextdraws[1], 1);
    TextDrawSetSelectable(LoginTextdraws[1], 0);

    LoginTextdraws[2] = TextDrawCreate(102.000000, 90.000000, "_");
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

    LoginTextdraws[3] = TextDrawCreate(538.000000, 100.000000, "Informacion");
    TextDrawFont(LoginTextdraws[3], 1);
    TextDrawLetterSize(LoginTextdraws[3], 0.200000, 1.299998);
    TextDrawTextSize(LoginTextdraws[3], 0.000000, 1000.000000);
    TextDrawSetOutline(LoginTextdraws[3], 0);
    TextDrawSetShadow(LoginTextdraws[3], 1);
    TextDrawAlignment(LoginTextdraws[3], 2);
    TextDrawColor(LoginTextdraws[3], -1);
    TextDrawBackgroundColor(LoginTextdraws[3], 255);
    TextDrawBoxColor(LoginTextdraws[3], 50);
    TextDrawUseBox(LoginTextdraws[3], 0);
    TextDrawSetProportional(LoginTextdraws[3], 1);
    TextDrawSetSelectable(LoginTextdraws[3], 0);

    LoginTextdraws[4] = TextDrawCreate(305.000000, 84.000000, MayusShortName());
    TextDrawFont(LoginTextdraws[4], 0);
    TextDrawLetterSize(LoginTextdraws[4], 1.499997, 5.500000);
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

    LoginTextdraws[5] = TextDrawCreate(360.000000, 125.000000, "Roleplay");
    TextDrawFont(LoginTextdraws[5], 0);
    TextDrawLetterSize(LoginTextdraws[5], 0.666665, 2.000000);
    TextDrawTextSize(LoginTextdraws[5], 0.000000, 0.000000);
    TextDrawSetOutline(LoginTextdraws[5], 2);
    TextDrawSetShadow(LoginTextdraws[5], 0);
    TextDrawAlignment(LoginTextdraws[5], 2);
    TextDrawColor(LoginTextdraws[5], PRIMARY_COLOR2);
    TextDrawBackgroundColor(LoginTextdraws[5], 255);
    TextDrawBoxColor(LoginTextdraws[5], 50);
    TextDrawUseBox(LoginTextdraws[5], 0);
    TextDrawSetProportional(LoginTextdraws[5], 1);
    TextDrawSetSelectable(LoginTextdraws[5], 0);

    LoginTextdraws[6] = TextDrawCreate(454.000000, 119.000000, "HUD:fist");
    TextDrawFont(LoginTextdraws[6], 4);
    TextDrawLetterSize(LoginTextdraws[6], 0.200000, 1.299998);
    TextDrawTextSize(LoginTextdraws[6], 13.000000, 14.500000);
    TextDrawSetOutline(LoginTextdraws[6], 0);
    TextDrawSetShadow(LoginTextdraws[6], 1);
    TextDrawAlignment(LoginTextdraws[6], 1);
    TextDrawColor(LoginTextdraws[6], -1);
    TextDrawBackgroundColor(LoginTextdraws[6], 255);
    TextDrawBoxColor(LoginTextdraws[6], 50);
    TextDrawUseBox(LoginTextdraws[6], 0);
    TextDrawSetProportional(LoginTextdraws[6], 1);
    TextDrawSetSelectable(LoginTextdraws[6], 0);

    LoginTextdraws[7] = TextDrawCreate(454.000000, 138.000000, "HUD:radar_girlfriend");
    TextDrawFont(LoginTextdraws[7], 4);
    TextDrawLetterSize(LoginTextdraws[7], 0.200000, 1.299998);
    TextDrawTextSize(LoginTextdraws[7], 13.000000, 14.500000);
    TextDrawSetOutline(LoginTextdraws[7], 0);
    TextDrawSetShadow(LoginTextdraws[7], 1);
    TextDrawAlignment(LoginTextdraws[7], 1);
    TextDrawColor(LoginTextdraws[7], -1);
    TextDrawBackgroundColor(LoginTextdraws[7], 255);
    TextDrawBoxColor(LoginTextdraws[7], 50);
    TextDrawUseBox(LoginTextdraws[7], 0);
    TextDrawSetProportional(LoginTextdraws[7], 1);
    TextDrawSetSelectable(LoginTextdraws[7], 0);

    LoginTextdraws[8] = TextDrawCreate(454.000000, 157.000000, "HUD:radar_tshirt");
    TextDrawFont(LoginTextdraws[8], 4);
    TextDrawLetterSize(LoginTextdraws[8], 0.200000, 1.299998);
    TextDrawTextSize(LoginTextdraws[8], 13.000000, 14.500000);
    TextDrawSetOutline(LoginTextdraws[8], 0);
    TextDrawSetShadow(LoginTextdraws[8], 1);
    TextDrawAlignment(LoginTextdraws[8], 1);
    TextDrawColor(LoginTextdraws[8], -1);
    TextDrawBackgroundColor(LoginTextdraws[8], 255);
    TextDrawBoxColor(LoginTextdraws[8], 50);
    TextDrawUseBox(LoginTextdraws[8], 0);
    TextDrawSetProportional(LoginTextdraws[8], 1);
    TextDrawSetSelectable(LoginTextdraws[8], 0);

    LoginTextdraws[9] = TextDrawCreate(454.000000, 175.000000, "HUD:radar_waypoint");
    TextDrawFont(LoginTextdraws[9], 4);
    TextDrawLetterSize(LoginTextdraws[9], 0.200000, 1.299998);
    TextDrawTextSize(LoginTextdraws[9], 13.000000, 14.500000);
    TextDrawSetOutline(LoginTextdraws[9], 0);
    TextDrawSetShadow(LoginTextdraws[9], 1);
    TextDrawAlignment(LoginTextdraws[9], 1);
    TextDrawColor(LoginTextdraws[9], -1);
    TextDrawBackgroundColor(LoginTextdraws[9], 255);
    TextDrawBoxColor(LoginTextdraws[9], 50);
    TextDrawUseBox(LoginTextdraws[9], 0);
    TextDrawSetProportional(LoginTextdraws[9], 1);
    TextDrawSetSelectable(LoginTextdraws[9], 0);

    LoginTextdraws[10] = TextDrawCreate(538.000000, 199.000000, "Noticias");
    TextDrawFont(LoginTextdraws[10], 1);
    TextDrawLetterSize(LoginTextdraws[10], 0.200000, 1.299998);
    TextDrawTextSize(LoginTextdraws[10], 0.000000, 1000.000000);
    TextDrawSetOutline(LoginTextdraws[10], 0);
    TextDrawSetShadow(LoginTextdraws[10], 1);
    TextDrawAlignment(LoginTextdraws[10], 2);
    TextDrawColor(LoginTextdraws[10], -1);
    TextDrawBackgroundColor(LoginTextdraws[10], 255);
    TextDrawBoxColor(LoginTextdraws[10], 50);
    TextDrawUseBox(LoginTextdraws[10], 0);
    TextDrawSetProportional(LoginTextdraws[10], 1);
    TextDrawSetSelectable(LoginTextdraws[10], 0);

    LoginTextdraws[11] = TextDrawCreate(538.000000, 217.000000, "_");
    TextDrawFont(LoginTextdraws[11], 1);
    TextDrawLetterSize(LoginTextdraws[11], 0.000000, 15.550005);
    TextDrawTextSize(LoginTextdraws[11], 0.000000, 170.500000);
    TextDrawSetOutline(LoginTextdraws[11], 1);
    TextDrawSetShadow(LoginTextdraws[11], 0);
    TextDrawAlignment(LoginTextdraws[11], 2);
    TextDrawColor(LoginTextdraws[11], -1);
    TextDrawBackgroundColor(LoginTextdraws[11], 255);
    TextDrawBoxColor(LoginTextdraws[11], 55);
    TextDrawUseBox(LoginTextdraws[11], 1);
    TextDrawSetProportional(LoginTextdraws[11], 1);
    TextDrawSetSelectable(LoginTextdraws[11], 0);

    LoginTextdraws[12] = TextDrawCreate(455.000000, 217.000000, "-");
    TextDrawFont(LoginTextdraws[12], 1);
    TextDrawLetterSize(LoginTextdraws[12], 0.200000, 1.299998);
    TextDrawTextSize(LoginTextdraws[12], 1000.000000, 0.000000);
    TextDrawSetOutline(LoginTextdraws[12], 0);
    TextDrawSetShadow(LoginTextdraws[12], 1);
    TextDrawAlignment(LoginTextdraws[12], 1);
    TextDrawColor(LoginTextdraws[12], -1);
    TextDrawBackgroundColor(LoginTextdraws[12], 255);
    TextDrawBoxColor(LoginTextdraws[12], 50);
    TextDrawUseBox(LoginTextdraws[12], 0);
    TextDrawSetProportional(LoginTextdraws[12], 1);
    TextDrawSetSelectable(LoginTextdraws[12], 0);
}

stock CreatePlayerLoginTextdraws(playerid)
{
    PlayerLoginTextdraws[playerid][0] = CreatePlayerTextDraw(playerid, 19.000000, 160.000000, "SKIN");
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
    PlayerTextDrawSetPreviewRot(playerid, PlayerLoginTextdraws[playerid][0], -10.000000, 0.000000, 20.000000, 0.899999);
    PlayerTextDrawSetPreviewVehCol(playerid, PlayerLoginTextdraws[playerid][0], 0, 0);

    PlayerLoginTextdraws[playerid][1] = CreatePlayerTextDraw(playerid, 102.000000, 138.000000, "Bienvenido de nuevo Nombre_Apellido.");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][1], 0.200000, 1.299998);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][1], 1000.000000, 0.000000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][1], 1);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][1], 2);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][1], 0);

    PlayerLoginTextdraws[playerid][2] = CreatePlayerTextDraw(playerid, 468.000000, 120.000000, "0000-00-00 00:00:00");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][2], 1);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][2], 0.200000, 1.299998);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][2], 1000.000000, 0.000000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][2], 1);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][2], 1);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][2], 0);

    PlayerLoginTextdraws[playerid][3] = CreatePlayerTextDraw(playerid, 469.000000, 139.000000, "Vida");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][3], 1);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][3], 0.200000, 1.299998);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][3], 0.000000, 1000.000000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][3], 1);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][3], 1);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][3], 255);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][3], 50);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][3], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][3], 0);

    PlayerLoginTextdraws[playerid][4] = CreatePlayerTextDraw(playerid, 469.000000, 158.000000, "Chaleco");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][4], 1);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][4], 0.200000, 1.299998);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][4], 0.000000, 1000.000000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][4], 0);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][4], 1);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][4], 1);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][4], 255);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][4], 50);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][4], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][4], 0);

    PlayerLoginTextdraws[playerid][5] = CreatePlayerTextDraw(playerid, 469.000000, 176.000000, "San Andreas, Desconocida");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][5], 1);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][5], 0.200000, 1.299998);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][5], 1000.000000, 0.000000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][5], 0);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][5], 1);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][5], 1);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][5], 255);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][5], 50);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][5], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][5], 0);

    PlayerLoginTextdraws[playerid][6] = CreatePlayerTextDraw(playerid, 195.000000, 346.000000, "TIP:_");
    PlayerTextDrawFont(playerid, PlayerLoginTextdraws[playerid][6], 1);
    PlayerTextDrawLetterSize(playerid, PlayerLoginTextdraws[playerid][6], 0.200000, 1.200000);
    PlayerTextDrawTextSize(playerid, PlayerLoginTextdraws[playerid][6], 0.000000, 1000.000000);
    PlayerTextDrawSetOutline(playerid, PlayerLoginTextdraws[playerid][6], 0);
    PlayerTextDrawSetShadow(playerid, PlayerLoginTextdraws[playerid][6], 1);
    PlayerTextDrawAlignment(playerid, PlayerLoginTextdraws[playerid][6], 1);
    PlayerTextDrawColor(playerid, PlayerLoginTextdraws[playerid][6], PRIMARY_COLOR2);
    PlayerTextDrawBackgroundColor(playerid, PlayerLoginTextdraws[playerid][6], 255);
    PlayerTextDrawBoxColor(playerid, PlayerLoginTextdraws[playerid][6], 50);
    PlayerTextDrawUseBox(playerid, PlayerLoginTextdraws[playerid][6], 0);
    PlayerTextDrawSetProportional(playerid, PlayerLoginTextdraws[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerLoginTextdraws[playerid][6], 0);
}

stock ShowPlayerLogin(playerid)
{
    new str_text[445];
    PlayerTextDrawSetPreviewModel(playerid, PlayerLoginTextdraws[playerid][0], PI[playerid][pi_SKIN]);

    format(str_text, 445, "~y~%s", PI[playerid][pi_LAST_CONNECTION]);
    FixTextDrawString(str_text, true);
    PlayerTextDrawSetString(playerid, PlayerLoginTextdraws[playerid][2], str_text);

    format(str_text, 445, "~r~%s", number_format_thousand(floatround(PI[playerid][pi_HEALTH])));
    FixTextDrawString(str_text, true);
    PlayerTextDrawSetString(playerid, PlayerLoginTextdraws[playerid][3], str_text);

    format(str_text, 445, "~b~%s", number_format_thousand(floatround(PI[playerid][pi_ARMOUR])));
    FixTextDrawString(str_text, true);
    PlayerTextDrawSetString(playerid, PlayerLoginTextdraws[playerid][4], str_text);

    new city[145], zone[145];
    GetPointZone(PI[playerid][pi_POS_X], PI[playerid][pi_POS_Y], city, zone);
    format(str_text, 445, "%s, %s", city, zone);
    FixTextDrawString(str_text, true);
    PlayerTextDrawSetString(playerid, PlayerLoginTextdraws[playerid][5], str_text);

    format(str_text, 445, "Bienvenido de nuevo %s.", pTemp(playerid)[pt_NAME]);
    FixTextDrawString(str_text, true);
    PlayerTextDrawSetString(playerid, PlayerLoginTextdraws[playerid][1], str_text);

    format(str_text, 128, "TIPS:_%s", RandomTipsMessages[ random(sizeof(RandomTipsMessages)) ]);
    FixTextDrawString(str_text, true);

    PlayerTextDrawSetString(playerid, PlayerLoginTextdraws[playerid][6], str_text);

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
    TextDrawSetString(NOTICE_TEXTDRAW, Notice_Textdraw_Format[0]);
    
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