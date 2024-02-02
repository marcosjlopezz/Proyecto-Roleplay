#include <YSI-Includes\YSI\y_hooks>

#define PAYDAY_NOTF_HIDE_TIMER 30 //segundos

new
    Text:NotfPaydayTextdraws[3] = {Text:INVALID_TEXT_DRAW, ...},

    PaydayNotificationHideTimer[MAX_PLAYERS] = PAYDAY_NOTF_HIDE_TIMER,
    PaydayFunctionTimers[MAX_PLAYERS][2] = {-1, ...},

    bool:AvailablePlayerPayday[MAX_PLAYERS]
;

enum e_payday_dialog_data
{
    pdd_HEADER[4096],
    pdd_BODY[4096],
}
new PAYDAY_DIALOG_DATA[MAX_PLAYERS][e_payday_dialog_data];

stock CreatePaydayNotfTextdraws()
{
    NotfPaydayTextdraws[0] = TextDrawCreate(555.000000, 340.000000, "_");
    TextDrawFont(NotfPaydayTextdraws[0], 1);
    TextDrawLetterSize(NotfPaydayTextdraws[0], 0.000000, 5.699999);
    TextDrawTextSize(NotfPaydayTextdraws[0], 0.000000, 100.000000);
    TextDrawSetOutline(NotfPaydayTextdraws[0], 1);
    TextDrawSetShadow(NotfPaydayTextdraws[0], 0);
    TextDrawAlignment(NotfPaydayTextdraws[0], 2);
    TextDrawColor(NotfPaydayTextdraws[0], -1);
    TextDrawBackgroundColor(NotfPaydayTextdraws[0], 255);
    TextDrawBoxColor(NotfPaydayTextdraws[0], 50);
    TextDrawUseBox(NotfPaydayTextdraws[0], 1);
    TextDrawSetProportional(NotfPaydayTextdraws[0], 1);
    TextDrawSetSelectable(NotfPaydayTextdraws[0], 0);

    NotfPaydayTextdraws[1] = TextDrawCreate(507.000000, 340.000000, "Notificacion_(0s)");
    TextDrawFont(NotfPaydayTextdraws[1], 1);
    TextDrawLetterSize(NotfPaydayTextdraws[1], 0.320833, 1.550000);
    TextDrawTextSize(NotfPaydayTextdraws[1], 400.000000, 17.000000);
    TextDrawSetOutline(NotfPaydayTextdraws[1], 0);
    TextDrawSetShadow(NotfPaydayTextdraws[1], 0);
    TextDrawAlignment(NotfPaydayTextdraws[1], 1);
    TextDrawColor(NotfPaydayTextdraws[1], -1);
    TextDrawBackgroundColor(NotfPaydayTextdraws[1], 255);
    TextDrawBoxColor(NotfPaydayTextdraws[1], 50);
    TextDrawUseBox(NotfPaydayTextdraws[1], 0);
    TextDrawSetProportional(NotfPaydayTextdraws[1], 1);
    TextDrawSetSelectable(NotfPaydayTextdraws[1], 0);

    NotfPaydayTextdraws[2] = TextDrawCreate(506.000000, 359.000000, "Te ha llegado un payday. Usa el comando (/pay) para verlo.");
    TextDrawFont(NotfPaydayTextdraws[2], 1);
    TextDrawLetterSize(NotfPaydayTextdraws[2], 0.220833, 1.000000);
    TextDrawTextSize(NotfPaydayTextdraws[2], 605.000000, 0.000000);
    TextDrawSetOutline(NotfPaydayTextdraws[2], 0);
    TextDrawSetShadow(NotfPaydayTextdraws[2], 0);
    TextDrawAlignment(NotfPaydayTextdraws[2], 1);
    TextDrawColor(NotfPaydayTextdraws[2], -1);
    TextDrawBackgroundColor(NotfPaydayTextdraws[2], 255);
    TextDrawBoxColor(NotfPaydayTextdraws[2], 50);
    TextDrawUseBox(NotfPaydayTextdraws[2], 0);
    TextDrawSetProportional(NotfPaydayTextdraws[2], 1);
    TextDrawSetSelectable(NotfPaydayTextdraws[2], 0);
    return 1;
}

hook OnScriptInit()
{
    CreatePaydayNotfTextdraws();
}

hook OnPlayerDisconnect(playerid, reason)
{
    ClosePaydayNotf(playerid);
}

stock PlayerPayday(playerid)
{
    static const tmp_pdd[e_payday_dialog_data];
    PAYDAY_DIALOG_DATA[playerid] = tmp_pdd;

	new 
		date[24],
        dialog_string[1024],
		money = 150 * PI[playerid][pi_LEVEL]
    ;

	if(money > 2500) money = 2500;
	money += minrand(25, 40);
	
	getDateTime(date);

	format(PAYDAY_DIALOG_DATA[playerid][pdd_BODY], 4096, "{"#SILVER_COLOR"}Pago diario (%s)", date);

	strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], "{"#BLUE_COLOR"}>> Gobierno\n");

	format(dialog_string, sizeof dialog_string, "{FFFFFF}Paga del gobierno: {"#GREEN_COLOR"}%s {FFFFFF}dólares\n", number_format_thousand(money));
	strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], dialog_string);
	
	if(!PI[playerid][pi_VIP])
	{
		strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], "{"#BLUE_COLOR"}>> Vehiculos\n");

		LoopEx(i, MAX_VEHICLES, 0)
		{
			if(!PLAYER_VEHICLES[i][player_vehicle_VALID]) continue;
			if(PLAYER_VEHICLES[i][player_vehicle_OWNER_ID] != PI[playerid][pi_ID]) continue;
			
			new veh_money = PLAYER_VEHICLES[i][player_vehicle_PRICE] / 100;
			money -= veh_money;
			
			format(dialog_string, sizeof dialog_string, "{FFFFFF}Seguro del vehículo %s: {"#RED_COLOR"}-%s {FFFFFF}dólares\n", VEHICLE_INFO[GLOBAL_VEHICLES[i][gb_vehicle_MODELID] - 400][vehicle_info_NAME], number_format_thousand(veh_money));
			strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], dialog_string);
		}

		strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], "{"#BLUE_COLOR"}>> Propiedades\n");
		
		for(new i = 0; i != MAX_PROPERTIES; i ++)
		{
			if(!PROPERTY_INFO[i][property_VALID]) continue;
			if(PROPERTY_INFO[i][property_OWNER_ID] != PI[playerid][pi_ID]) continue;
		
			if(PROPERTY_INFO[i][property_VIP_LEVEL]) format(dialog_string, sizeof dialog_string, "{FFFFFF}Seguro de la propiedad %s: {"#YELLOW_COLOR"}PROPIEDAD VIP, NO SE PAGA SEGURO.\n", PROPERTY_INFO[i][property_NAME]);
			else
			{
				new property_money = PROPERTY_INFO[i][property_PRICE] / 200;
				money -= property_money;
				
				format(dialog_string, sizeof dialog_string, "{FFFFFF}Seguro de la propiedad %s: {"#RED_COLOR"}-%s {FFFFFF}dólares\n", PROPERTY_INFO[i][property_NAME], number_format_thousand(property_money));
			}
			strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], dialog_string);
		}
	}
	
    if(PLAYER_WORKS[playerid][WORK_POLICE][pwork_SET]) strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], "{"#BLUE_COLOR"}>> Trabajos\n");

	if(PLAYER_WORKS[playerid][WORK_POLICE][pwork_SET])
	{
		new work_payment;
		if(work_info[WORK_POLICE][work_info_EXTRA_PAY] > 0 && work_info[WORK_POLICE][work_info_EXTRA_PAY_EXP] > 0)
		{
			work_payment = (work_info[WORK_POLICE][work_info_EXTRA_PAY] * floatround(floatdiv(PLAYER_WORKS[playerid][WORK_POLICE][pwork_LEVEL], work_info[WORK_POLICE][work_info_EXTRA_PAY_EXP])));
			if(work_info[WORK_POLICE][work_info_EXTRA_PAY_LIMIT] != 0) if(work_payment > work_info[WORK_POLICE][work_info_EXTRA_PAY_LIMIT]) work_payment = work_info[WORK_POLICE][work_info_EXTRA_PAY_LIMIT];
		}
		
		money += work_payment;
		
		format(dialog_string, sizeof dialog_string, "{FFFFFF}Paga por ser policía: {"#GREEN_COLOR"}%s {FFFFFF}dólares\n", number_format_thousand(work_payment));
		strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], dialog_string);
	}

	if(PI[playerid][pi_CREW])
	{
		new 
			territories = GetCrewTerritories(PI[playerid][pi_CREW]),
			graffitis = CountCrewGraffitis(PI[playerid][pi_CREW]);

		if(territories > 0 || graffitis > 0)
		{
			money += territories * 1000;//paga banda
			money += graffitis * 200;//paga grafitis

			strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], "{"#BLUE_COLOR"}>> Territorios\n");

			if(territories > 0) format(dialog_string, sizeof dialog_string, "{FFFFFF}Paga por territorios en posesión (%d): {"#PRIMARY_COLOR"}%d {FFFFFF}dólares\n", territories, territories * 1000);
			if(graffitis > 0) format(dialog_string, sizeof dialog_string, "{FFFFFF}Paga por graffitis (%d): {"#PRIMARY_COLOR"}%d {FFFFFF}dólares\n", graffitis, graffitis * 200);
			strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], dialog_string);
		}
	}
	
    if(PI[playerid][pi_ADMIN_LEVEL])
    {
        strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], "{"#BLUE_COLOR"}>> Servicio Administracion\n");
        
        new admin_money = 5000 * PI[playerid][pi_ADMIN_LEVEL];
        money += admin_money;

        format(dialog_string, sizeof dialog_string, "{FFFFFF}Paga por ser STAFF: {"#PRIMARY_COLOR"}%d {FFFFFF}dólares\n", admin_money);
        strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], dialog_string);
    }   

	if(money + PI[playerid][pi_CASH] <= 0)
	{
		money = 0;
		PI[playerid][pi_CASH] = 0;
	}

	strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], "{"#BLUE_COLOR"}>> Resumen\n");

	if(money > 0) format(dialog_string, sizeof dialog_string, "{FFFFFF}Has ganado: {"#GREEN_COLOR"}%s {FFFFFF}dólares", number_format_thousand(money));
	else format(dialog_string, sizeof dialog_string, "{FFFFFF}Has perdido: {"#RED_COLOR"}%s {FFFFFF}dólares", number_format_thousand(money));
	
	strcat(PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], dialog_string);
	
	GivePlayerCash(playerid, money, true, money < 0 ? true : false);

    ShowPlayerPayday(playerid);
	return 1;
}

stock ShowPlayerPayday(playerid)
{
    for(new i = 0; i < 3; i ++)
    {
        TextDrawShowForPlayer(playerid, NotfPaydayTextdraws[i]);
    }

    PaydayNotificationHideTimer[playerid] = PAYDAY_NOTF_HIDE_TIMER;
    AvailablePlayerPayday[playerid] = true;

    KillTimer(PaydayFunctionTimers[playerid][0]);
    PaydayFunctionTimers[playerid][0] = SetTimerEx("_HidePaydayNotfTimer", 1000, false, "i", playerid);
}

stock ClosePaydayNotf(playerid)
{
    for(new i = 0; i < 3; i ++)
    {
        TextDrawHideForPlayer(playerid, NotfPaydayTextdraws[i]);
    }

    PaydayNotificationHideTimer[playerid] = PAYDAY_NOTF_HIDE_TIMER;
    AvailablePlayerPayday[playerid] = false;

    KillTimer(PaydayFunctionTimers[playerid][0]);
    CancelSelectTextDrawEx(playerid);
    return 1;
}

forward _HidePaydayNotfTimer(playerid);
hook _HidePaydayNotfTimer(playerid)
{
    PaydayNotificationHideTimer[playerid] --;
    TextDrawSetStringForPlayer(NotfPaydayTextdraws[1], playerid, "Notificacion_(%02ds)", PaydayNotificationHideTimer[playerid]);

    if(PaydayNotificationHideTimer[playerid] <= 0)
    {
        ClosePaydayNotf(playerid);
        return Y_HOOKS_BREAK_RETURN_1;
    }

    KillTimer(PaydayFunctionTimers[playerid][0]);
    PaydayFunctionTimers[playerid][0] = SetTimerEx("_HidePaydayNotfTimer", 1000, false, "i", playerid);
    return Y_HOOKS_BREAK_RETURN_1;
}

CMD:pay(playerid)
{
    if(!AvailablePlayerPayday[playerid]) return SendClientMessagef(playerid, 0xCCCCCCCC, "Todavia no te ha llegado el payday.");

    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, PAYDAY_DIALOG_DATA[playerid][pdd_BODY], PAYDAY_DIALOG_DATA[playerid][pdd_HEADER], "Cerrar", "");
    ClosePaydayNotf(playerid);
    return 1;
}