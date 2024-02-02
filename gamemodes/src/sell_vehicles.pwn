#include <YSI-Includes\YSI\y_hooks>

/* 
    VARIABLES

    -- Data
	pt_SV_MODELID
	pt_SV_COLOUR_0
	pt_SV_COLOUR_1
	pt_SV_VIP
	pt_SV_LEVEL
	pt_SV_PRICE
    pt_SV_SELECTED_PRICE
	pt_SV_EXTRA
	pt_SV_SHOP

    -- Dialogs
    DIALOG_SELL_VEHICLES_CREATOR
	DIALOG_SV_COLOUR_0
	DIALOG_SV_COLOUR_1
	DIALOG_SV_MODELID
	DIALOG_SV_PRICE
	DIALOG_SV_SELECT_PRICE
    DIALOG_SV_SET_LEVEL
    DIALOG_SV_SHOP

    DIALOG_BUY_VEHICLE
*/

#define SellVehicles(%0)[%1]    SELL_INFO_VEHICLES[%0][%1]

#define PRICE_COIN  1
#define PRICE_CASH  0

#define MAX_DEALER_SHIPS    10

new DealerShipListitem[MAX_LISTITEMS];

enum SELL_INFO_VEHICLES_Enum
{
	bool:sell_info_VALID,
	sell_info_ID,

	sell_info_MODELID,
	sell_info_COLOUR_1,
	sell_info_COLOUR_2,

    sell_info_VIP,
    sell_info_LEVEL,

    sell_info_PRICE,
    sell_info_EXTRA,

	Float:sell_info_SPAWN_X,
	Float:sell_info_SPAWN_Y,
	Float:sell_info_SPAWN_Z,
	Float:sell_info_SPAWN_ANGLE,
	sell_info_SHOP,

    Text3D:sell_info_LABEL
}
new SELL_INFO_VEHICLES[MAX_VEHICLES][SELL_INFO_VEHICLES_Enum];

enum E_DEALER_SHIP_INFO
{
    bool:Valid,
    ID,
    Name[32],
    Float:pos_x,
    Float:pos_y,
    Float:pos_z,
    Float:pos_angle,
    Text3D:Label
}
new SellVehiclesShopInfo[MAX_DEALER_SHIPS][E_DEALER_SHIP_INFO];

stock GetDealerShipValidSlot()
{
    LoopEx(i, MAX_DEALER_SHIPS, 0)
    {
        if(SellVehiclesShopInfo[i][Valid] == false) return i;
    }
    return -1;
}

stock GetDealerShipIndexFromID(id)
{
    LoopEx(i, MAX_DEALER_SHIPS, 0)
    {
        if(SellVehiclesShopInfo[i][Valid] == false) continue;
        if(SellVehiclesShopInfo[i][ID] == id)
        {
            return i;
        }
    }
    return -1;
}

stock ClearSellVehicle(vehicleid)
{
    SellVehicles(vehicleid)[sell_info_VALID] = false;
    SellVehicles(vehicleid)[sell_info_ID] = 0;
    SellVehicles(vehicleid)[sell_info_MODELID] = 0;
    SellVehicles(vehicleid)[sell_info_COLOUR_1] = 0;
    SellVehicles(vehicleid)[sell_info_COLOUR_2] = 0;
    SellVehicles(vehicleid)[sell_info_PRICE] = 0;
    SellVehicles(vehicleid)[sell_info_EXTRA] = 0;
    SellVehicles(vehicleid)[sell_info_VIP] = 0;
    SellVehicles(vehicleid)[sell_info_LEVEL] = 0;
    SellVehicles(vehicleid)[sell_info_SHOP] = 0;
    SellVehicles(vehicleid)[sell_info_SPAWN_X] = 0;
    SellVehicles(vehicleid)[sell_info_SPAWN_Y] = 0;
    SellVehicles(vehicleid)[sell_info_SPAWN_Z] = 0;
    SellVehicles(vehicleid)[sell_info_SPAWN_ANGLE] = 0;

    static const tmp_sell_vehicle[SELL_INFO_VEHICLES_Enum];
    SELL_INFO_VEHICLES[vehicleid] = tmp_sell_vehicle;
    return 1;
}

stock BuyVehicleShowDialog(playerid, vehicleid)
{
    if(SellVehicles(vehicleid)[sell_info_VALID] == false) return 1;
    if(GLOBAL_VEHICLES[vehicleid][gb_vehicle_TYPE] != VEHICLE_TYPE_SELL) return 1;
    if(vehicleid == INVALID_VEHICLE_ID) return 1;
    
    new dialog[2048], price_format[145];

    if(SellVehicles(vehicleid)[sell_info_PRICE] > 0) format(price_format, 145, "%s$", number_format_thousand(SellVehicles(vehicleid)[sell_info_PRICE]));
    if(SellVehicles(vehicleid)[sell_info_EXTRA] > 0) format(price_format, 145, "%s "SERVER_COIN"", number_format_thousand(SellVehicles(vehicleid)[sell_info_EXTRA]));
    
    format
    (
        dialog, 
        sizeof dialog, 
        
        "\
            \n\
            {d1d1d1}Vehículo: {"#PRIMARY_COLOR"}%s\n\
			{d1d1d1}Nivel necesario: {"#PRIMARY_COLOR"}%d\n\
			{d1d1d1}Precio del vehículo: {"#PRIMARY_COLOR"}%s\n\
            \n\
			{d1d1d1}Velocidad máxima: {"#PRIMARY_COLOR"}%d {d1d1d1}Km/h\n\
			{d1d1d1}Capacidad deposito: {"#PRIMARY_COLOR"}%.1f {d1d1d1}Litros\n\
			{d1d1d1}Espacio maletero: {"#PRIMARY_COLOR"}%d\n\
            \n\
			{d1d1d1}Seguro: {"#PRIMARY_COLOR"}%s$\n\
            \n\
        ", 
			VEHICLE_INFO[ GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] - 400 ][vehicle_info_NAME],
			SellVehicles(vehicleid)[sell_info_LEVEL],
			price_format,
			floatround(VEHICLE_INFO[ GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] - 400 ][vehicle_info_MAX_VEL]),
			VEHICLE_INFO[ GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] - 400 ][vehicle_info_MAX_GAS],
			VEHICLE_INFO[ GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] - 400 ][vehicle_info_BOOT_SLOTS],
			number_format_thousand(SellVehicles(vehicleid)[sell_info_PRICE] / 100)
    );

    if(SellVehicles(vehicleid)[sell_info_LEVEL] > PI[playerid][pi_LEVEL])
    {
        strcat(dialog, "{"#RED_COLOR"}No tienes el nivel suficiente para comprar este vehiculo.\n");
        ShowPlayerDialog(playerid, DIALOG_BUY_VEHICLE, DIALOG_STYLE_MSGBOX, "Comprar Vehiculo", dialog, "Cerrar", "");
        return 1;
    }

    if(SellVehicles(vehicleid)[sell_info_VIP] && !PI[playerid][pi_VIP])
    {
        strcat(dialog, "{"#RED_COLOR"}Necesitas ser VIP para poder comprar este vehiculo.\n");
        ShowPlayerDialog(playerid, DIALOG_BUY_VEHICLE, DIALOG_STYLE_MSGBOX, "Comprar Vehiculo", dialog, "Cerrar", "");
        return 1;
    }
    
    if(PI[playerid][pi_BANK_ACCOUNT] == 0)
    {
        strcat(dialog, "{"#RED_COLOR"}Necesitas tener una cuenta bancaria para comprar vehiculos. usa /gps\n");
        ShowPlayerDialog(playerid, DIALOG_BUY_VEHICLE, DIALOG_STYLE_MSGBOX, "Comprar Vehiculo", dialog, "Cerrar", "");
        return 1;
    }

    if(SellVehicles(vehicleid)[sell_info_PRICE] > PI[playerid][pi_BANK_MONEY])
    {
        strcat(dialog, "{"#RED_COLOR"}No tienes dinero suficiente en tu cuenta bancaria.\n");
        ShowPlayerDialog(playerid, DIALOG_BUY_VEHICLE, DIALOG_STYLE_MSGBOX, "Comprar Vehiculo", dialog, "Cerrar", "");
        return 1;
    }

    if(SellVehicles(vehicleid)[sell_info_EXTRA] > PI[playerid][pi_COINS])
    {
        strcat(dialog, "{"#RED_COLOR"}No tienes las "SERVER_COIN" suficientes para comprar este vehiculo.\n");
        ShowPlayerDialog(playerid, DIALOG_BUY_VEHICLE, DIALOG_STYLE_MSGBOX, "Comprar Vehiculo", dialog, "Cerrar", "");
        return 1;
    }

    ShowPlayerDialog(playerid, DIALOG_BUY_VEHICLE, DIALOG_STYLE_MSGBOX, "Comprar Vehiculo", dialog, "Comprar", "Cancelar");
    return 1;
}

stock ShowSellVehicleCreator(playerid)
{
    if(PI[playerid][pi_ID] == 0) return 0;
    if(!IsPlayerRegistered(playerid)) return 0;
    if(!IsPlayerLoggedIn(playerid)) return 0;

    new dialog[445], line_str[1024];
    format(dialog, 445, "{"#SILVER_COLOR"}Opcion\t{"#SILVER_COLOR"}Valor\n");

    if(pTemp(playerid)[pt_SV_MODELID] != 0) format(line_str, 1024, "{"#SILVER_COLOR"}Modelo del Vehiculo\t%s\n", VEHICLE_INFO[pTemp(playerid)[pt_SV_MODELID] - 400][vehicle_info_NAME]);
    else format(line_str, 1024, "{"#SILVER_COLOR"}Modelo del Vehiculo\tNo Definido\n");
    strcat(dialog, line_str);

    if(pTemp(playerid)[pt_SV_COLOUR_0] == -1) format(line_str, 1024, "{"#SILVER_COLOR"}Color #1\t{cccccc}Random\n");
    else format(line_str, 1024, "{"#SILVER_COLOR"}Color #1\t{%06x}%s\n", VEHICLE_COLORS[pTemp(playerid)[pt_SV_COLOUR_0]] >>> 8, number_format_thousand(pTemp(playerid)[pt_SV_COLOUR_0]));
    strcat(dialog, line_str);

    if(pTemp(playerid)[pt_SV_COLOUR_1] == -1) format(line_str, 1024, "{"#SILVER_COLOR"}Color #2\t{cccccc}Random\n");
    else format(line_str, 1024, "{"#SILVER_COLOR"}Color #2\t{%06x}%s\n", VEHICLE_COLORS[pTemp(playerid)[pt_SV_COLOUR_1]] >>> 8, number_format_thousand(pTemp(playerid)[pt_SV_COLOUR_1]));
    strcat(dialog, line_str);

    format(line_str, 1024, "{"#SILVER_COLOR"}VIP\t%s\n", pTemp(playerid)[pt_SV_VIP] ? "Si" : "No");
    strcat(dialog, line_str);

    format(line_str, 1024, "{"#SILVER_COLOR"}Nivel\t%d\n", pTemp(playerid)[pt_SV_LEVEL]);
    strcat(dialog, line_str);

    if(pTemp(playerid)[pt_SV_PRICE] > 0)
    {
        format(line_str, 1024, "{"#SILVER_COLOR"}Precio\t%s$\n", number_format_thousand(pTemp(playerid)[pt_SV_PRICE]));
    }
    else if(pTemp(playerid)[pt_SV_EXTRA] > 0)
    {
        format(line_str, 1024, "{"#SILVER_COLOR"}Precio\t%s "SERVER_COIN"\n", number_format_thousand(pTemp(playerid)[pt_SV_EXTRA]));
    }
    else format(line_str, 1024, "{"#SILVER_COLOR"}Precio\tNo Definido\n");
    strcat(dialog, line_str);

    format(line_str, 1024, "{"#SILVER_COLOR"}Lugar de venta\t%s #%d\n", SellVehiclesShopInfo[pTemp(playerid)[pt_SV_SHOP]][Name], SellVehiclesShopInfo[pTemp(playerid)[pt_SV_SHOP]][ID]);
    strcat(dialog, line_str);

    strcat(dialog, "{cccccc}Crear Vehiculo");

    ShowPlayerDialog(playerid, DIALOG_SELL_VEHICLES_CREATOR, DIALOG_STYLE_TABLIST_HEADERS, "Crear vehiculo de venta", dialog, "Confirmar", "Cerrar");
    return 1;
}

stock SellVehicleDialogCreator(playerid, dialogid)
{
    switch(dialogid)
    {
        case DIALOG_SV_MODELID: return ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, "Modelo del Vehiculo", "{ffffff}Encuentra los modelos de los vehiculos en ({8374b3}https://www.open.mp/docs/scripting/resources/vehicleid{ffffff})\n{ffffff}Escribe el modelid del vehiculo. es necesario un modelo valido para poder crear el vehiculo", "Establecer", "Atras");
        case DIALOG_SV_COLOUR_0, DIALOG_SV_COLOUR_1:
        {
            new dialog[20 * (sizeof(VEHICLE_COLORS) + 1) ], line_str[445];

            strcat(dialog, "{d1d1d1}Color Random\n");

            LoopEx(i, sizeof(VEHICLE_COLORS), 0)
            {
                format(line_str, 445, "{%06x}Color %d\n", VEHICLE_COLORS[i] >>> 8, i);
                strcat(dialog, line_str);
            }

            ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_TABLIST, "Seleccionar Color", dialog, "Confirmar", "Atras");
            return 1;
        }
        case DIALOG_SV_SET_LEVEL: return ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, "Seleccionar Nivel", "{d1d1d1}Escribe el nivel necesario para poder tener este vehiculo:", "Establecer", "Atras");
        case DIALOG_SV_SELECT_PRICE: return ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_TABLIST, "Tipo de Precio", "{"#GREEN_COLOR"}Dinero\n{"#YELLOW_COLOR"}"SERVER_COIN"", "Seleccionar", "Atras");
        case DIALOG_SV_PRICE: return ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, "Precio del vehiculo", "{d1d1d1}Escribe el precio en Dinero/"SERVER_COIN" que tendra el vehiculo:", "Confirmar", "Atras");
        case DIALOG_SV_SHOP:
        {
            new dialog[128 * (sizeof(SellVehiclesShopInfo) + 1) ], line_str[145], listitem;
            LoopEx(i, sizeof(SellVehiclesShopInfo), 0)
            {
                if(SellVehiclesShopInfo[i][Valid] == false) continue;
                format(line_str, sizeof line_str, "{d1d1d1}%s #%d\n", SellVehiclesShopInfo[i][Name], SellVehiclesShopInfo[i][ID]);
                strcat(dialog, line_str);

                pTemp(playerid)[pt_PLAYER_LISTITEM][listitem] = i;
                listitem ++;
            }
            ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_TABLIST, "Seleccionar Consecionaria", dialog, "Confirmar", "Atras");
            return 1;
        }
    }
    return 1;
}

stock SaveSellVehicle(playerid, vehicleid)
{
    new vehicle_id = INVALID_VEHICLE_ID, Float:x, Float:y, Float:z, Float:angle;

    GetVehiclePos(vehicleid, x, y, z);
    GetVehicleZAngle(vehicleid, angle);

    new tmp_colour_1, tmp_colour_2;
    tmp_colour_1 = SellVehicles(vehicleid)[sell_info_COLOUR_1];
    tmp_colour_2 = SellVehicles(vehicleid)[sell_info_COLOUR_2];
    if(SellVehicles(vehicleid)[sell_info_COLOUR_1] == -1) tmp_colour_1 = minrand(0, 255);
    if(SellVehicles(vehicleid)[sell_info_COLOUR_2] == -1) tmp_colour_2 = minrand(0, 255);

    vehicle_id = CreateVehicle(SellVehicles(vehicleid)[sell_info_MODELID], x, y, z, angle, tmp_colour_1, tmp_colour_2, -1, 0);
    
    if(vehicle_id)
    {
        SellVehicles(vehicle_id)[sell_info_MODELID] = SellVehicles(vehicleid)[sell_info_MODELID];
        SellVehicles(vehicle_id)[sell_info_COLOUR_1] = SellVehicles(vehicleid)[sell_info_COLOUR_1];
        SellVehicles(vehicle_id)[sell_info_COLOUR_2] = SellVehicles(vehicleid)[sell_info_COLOUR_2];
        SellVehicles(vehicle_id)[sell_info_PRICE] = SellVehicles(vehicleid)[sell_info_PRICE];
        SellVehicles(vehicle_id)[sell_info_EXTRA] = SellVehicles(vehicleid)[sell_info_EXTRA];
        SellVehicles(vehicle_id)[sell_info_VIP] = SellVehicles(vehicleid)[sell_info_VIP];
        SellVehicles(vehicle_id)[sell_info_LEVEL] = SellVehicles(vehicleid)[sell_info_LEVEL];
        SellVehicles(vehicle_id)[sell_info_SHOP] = SellVehicles(vehicleid)[sell_info_SHOP];

        SellVehicles(vehicle_id)[sell_info_SPAWN_X] = x;
        SellVehicles(vehicle_id)[sell_info_SPAWN_Y] = y;
        SellVehicles(vehicle_id)[sell_info_SPAWN_Z] = z;
        SellVehicles(vehicle_id)[sell_info_SPAWN_ANGLE] = angle;

        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_VALID] = true;
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_TYPE] = VEHICLE_TYPE_SELL;
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_MODELID] = SellVehicles(vehicle_id)[sell_info_MODELID];
        format(GLOBAL_VEHICLES[vehicle_id][gb_vehicle_NUMBER_PLATE], 32, "EN VENTA");
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_SPAWN_X] = SellVehicles(vehicle_id)[sell_info_SPAWN_X];
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_SPAWN_Y] = SellVehicles(vehicle_id)[sell_info_SPAWN_Y];
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_SPAWN_Z] = SellVehicles(vehicle_id)[sell_info_SPAWN_Z];
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_SPAWN_ANGLE] = SellVehicles(vehicle_id)[sell_info_SPAWN_ANGLE];
                    
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_POS][0] = GLOBAL_VEHICLES[vehicle_id][gb_vehicle_SPAWN_X];
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_POS][1] = GLOBAL_VEHICLES[vehicle_id][gb_vehicle_SPAWN_Y];
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_POS][2] = GLOBAL_VEHICLES[vehicle_id][gb_vehicle_SPAWN_Z];
                    
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_HEALTH] = 1000.0;
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_DAMAGE_PANELS] = 0;
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_DAMAGE_DOORS] = 0;
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_DAMAGE_LIGHTS] = 0;
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_DAMAGE_TIRES] = 0;
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_PARAMS_ENGINE] = 0;
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_COLOR_1] = tmp_colour_1;
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_COLOR_2] = tmp_colour_2;
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_PAINTJOB] = 3; // No paintjob
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_MAX_GAS] = 0.0;
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_GAS] = 0.0;
        GLOBAL_VEHICLES[vehicle_id][gb_vehicle_STATE] = VEHICLE_STATE_NORMAL;

        new label_str[256];
        if(SellVehicles(vehicle_id)[sell_info_VIP])
        {
            if(SellVehicles(vehicle_id)[sell_info_EXTRA])
            {
                format
                (
                    label_str, 
                    sizeof label_str, 
                    "\
                        {"#ORANGE_COLOR"}Membresía VIP requerida\n\
                        \n\
                        {"#PRIMARY_COLOR"}%s\n\n\
                        {FFFFFF}Coste: {"#YELLOW_COLOR"}%d "SERVER_COIN"\n\
                        {FFFFFF}Nivel: {"#PRIMARY_COLOR"}%d\n\
                        \n\
                    ", VEHICLE_INFO[GLOBAL_VEHICLES[vehicle_id][gb_vehicle_MODELID] - 400][vehicle_info_NAME], SellVehicles(vehicle_id)[sell_info_EXTRA], SellVehicles(vehicle_id)[sell_info_LEVEL]
                );
            }
            else
            {
                format
                (
                    label_str, 
                    sizeof label_str, 
                    "\
                        {"#ORANGE_COLOR"}Membresía VIP requerida\n\
                        \n\
                        {"#PRIMARY_COLOR"}%s\n\n\
                        {FFFFFF}Precio: {"#GREEN_COLOR"}%s$\n\
                        {FFFFFF}Nivel requerido: {"#PRIMARY_COLOR"}%d\n\
                        \n\
                    ", VEHICLE_INFO[GLOBAL_VEHICLES[vehicle_id][gb_vehicle_MODELID] - 400][vehicle_info_NAME], number_format_thousand(SellVehicles(vehicle_id)[sell_info_PRICE]), SellVehicles(vehicle_id)[sell_info_LEVEL]
                );
            }
        }
        else
        {
            if(SellVehicles(vehicle_id)[sell_info_EXTRA])
            {
                format
                (
                    label_str, 
                    sizeof label_str, 
                    "\
                        {"#PRIMARY_COLOR"}%s\n\n\
                        {FFFFFF}Coste: {"#YELLOW_COLOR"}%d "SERVER_COIN"\n\
                        {FFFFFF}Nivel requerido: {"#PRIMARY_COLOR"}%d\n\
                        \n\
                    ", VEHICLE_INFO[GLOBAL_VEHICLES[vehicle_id][gb_vehicle_MODELID] - 400][vehicle_info_NAME], SellVehicles(vehicle_id)[sell_info_EXTRA], SellVehicles(vehicle_id)[sell_info_LEVEL]
                );
            }
            else
            {
                format
                (
                    label_str, 
                    sizeof label_str, 
                    "\
                        {"#PRIMARY_COLOR"}%s\n\n\
                        {FFFFFF}Precio: {"#GREEN_COLOR"}%s$\n\
                        {FFFFFF}Nivel requerido: {"#PRIMARY_COLOR"}%d\n\
                        \n\
                    ", VEHICLE_INFO[GLOBAL_VEHICLES[vehicle_id][gb_vehicle_MODELID] - 400][vehicle_info_NAME], number_format_thousand(SellVehicles(vehicle_id)[sell_info_PRICE]), SellVehicles(vehicle_id)[sell_info_LEVEL]
                );
            }
        }

        SellVehicles(vehicle_id)[sell_info_LABEL] = CreateDynamic3DTextLabel(label_str, 0xFFFFFFFF, 0.0, 0.0, 1.5, 10.0, .attachedvehicle = vehicle_id, .testlos = true, .worldid = 0, .interiorid = 0);
    
        UpdateVehicleParams(vehicle_id);
        SetVehicleToRespawnEx(vehicle_id);
    }


    if(IsValidDynamic3DTextLabel(SellVehicles(vehicleid)[sell_info_LABEL]))
    {
        DestroyDynamic3DTextLabel(SellVehicles(vehicleid)[sell_info_LABEL]);
        SellVehicles(vehicleid)[sell_info_LABEL] = Text3D:INVALID_STREAMER_ID;
    }

    ClearSellVehicle(vehicleid);
    DestroyVehicleEx(vehicleid);

    inline OnDealerVehicleInserted()
    {
        SellVehicles(vehicle_id)[sell_info_VALID] = true;
        SellVehicles(vehicle_id)[sell_info_ID] = cache_insert_id();

        SendMessage(playerid, "El vehiculo ha sido guardado correctamente.");
    }
    mysql_format(
        Query_Data, 

        "\
            INSERT INTO sell_vehicles (modelid, colour1, colour2, vip, level, price, extra, pos_x, pos_y, pos_z, pos_angle, shop) \
            VALUES(%d, %d, %d, %d, %d, %d, %d, %f, %f, %f, %f, %d);\
        ",
            SellVehicles(vehicle_id)[sell_info_MODELID], SellVehicles(vehicle_id)[sell_info_COLOUR_1], SellVehicles(vehicle_id)[sell_info_COLOUR_2],
            SellVehicles(vehicle_id)[sell_info_VIP], SellVehicles(vehicle_id)[sell_info_LEVEL], SellVehicles(vehicle_id)[sell_info_PRICE],
            SellVehicles(vehicle_id)[sell_info_EXTRA], SellVehicles(vehicle_id)[sell_info_SPAWN_X], SellVehicles(vehicle_id)[sell_info_SPAWN_Y],
            SellVehicles(vehicle_id)[sell_info_SPAWN_Z], SellVehicles(vehicle_id)[sell_info_SPAWN_ANGLE], SellVehicles(vehicle_id)[sell_info_SHOP]
     );
    mysql_tquery_inline(Query_Data_Inline, using inline OnDealerVehicleInserted);
    return 1;
}

forward OnDealerShipsLoaded();
stock LoadDealerShips()
{
    inline OnDealerShipLoaded()
    {
        new rows;
        if(get_rows(rows))
        {
            LoopEx(i, rows, 0)
            {
                SellVehiclesShopInfo[i][Valid] = true;
                reg_int(i, "id", SellVehiclesShopInfo[i][ID]);
                reg_name(i, "name", SellVehiclesShopInfo[i][Name]);
                reg_float(i, "x", SellVehiclesShopInfo[i][pos_x]);
                reg_float(i, "y", SellVehiclesShopInfo[i][pos_y]);
                reg_float(i, "z", SellVehiclesShopInfo[i][pos_z]);
                reg_float(i, "angle", SellVehiclesShopInfo[i][pos_angle]);

                new label_str[256]; format(label_str, 256, "{"#PRIMARY_COLOR"}%s (%d)\n{ffffff}SALIDA DE VEHICULOS", SellVehiclesShopInfo[i][Name], SellVehiclesShopInfo[i][ID]);
                SellVehiclesShopInfo[i][Label] = CreateDynamic3DTextLabel(label_str, -1, SellVehiclesShopInfo[i][pos_x], SellVehiclesShopInfo[i][pos_y], SellVehiclesShopInfo[i][pos_z], 15, .testlos = true);
            }
            ResetDealersInfo();
        }
        CallLocalFunction("OnDealerShipsLoaded", "");
        CallLocalFunction("server_loaded_request", "");
    }
    mysql_tquery_inline(handle_db, "SELECT * FROM dealer_ships;", using inline OnDealerShipLoaded);
    return 1;
}

forward OnSellVehiclesLoaded();
stock LoadSellVehicles()
{
    inline OnSelectSvData()
    {
        new rows = 0;
        if(get_rows(rows))
        {
            LoopEx(i, rows, 0)
            {
                new 
                    id, modelid, colour1, colour2, price, extra, 
                    vip, level, Float:x, Float:y, Float:z, 
                    Float:angle, shop
                ;

                reg_int(i, "id", id);
                reg_int(i, "modelid", modelid);
                reg_int(i, "colour1", colour1);
                reg_int(i, "colour2", colour2);
                reg_int(i, "price", price);
                reg_int(i, "extra", extra);
                reg_int(i, "vip", vip);
                reg_int(i, "level", level);
                reg_float(i, "pos_x", x);
                reg_float(i, "pos_y", y);
                reg_float(i, "pos_z", z);
                reg_float(i, "pos_angle", angle);
                reg_int(i, "shop", shop);

                new tmp_colour_1 = colour1, tmp_colour_2 = colour2;
                if(tmp_colour_1 == -1) tmp_colour_1 = minrand(0, 255);
                if(tmp_colour_2 == -1) tmp_colour_2 = minrand(0, 255);
                
                new vehicleid = INVALID_VEHICLE_ID;
                vehicleid = CreateVehicle(modelid, x, y, z, angle, tmp_colour_1, tmp_colour_2, -1, false);
                
                if(vehicleid != INVALID_VEHICLE_ID)
                {
                    SellVehicles(i)[sell_info_VALID] = true;
                    SellVehicles(vehicleid)[sell_info_ID] = id;
                    SellVehicles(vehicleid)[sell_info_MODELID] = modelid;
                    SellVehicles(vehicleid)[sell_info_COLOUR_1] = colour1;
                    SellVehicles(vehicleid)[sell_info_COLOUR_2] = colour2;
                    SellVehicles(vehicleid)[sell_info_PRICE] = price;
                    SellVehicles(vehicleid)[sell_info_EXTRA] = extra;
                    SellVehicles(vehicleid)[sell_info_VIP] = vip;
                    SellVehicles(vehicleid)[sell_info_LEVEL] = level;
                    SellVehicles(vehicleid)[sell_info_SHOP] = shop;
                    SellVehicles(vehicleid)[sell_info_SPAWN_X] = x;
                    SellVehicles(vehicleid)[sell_info_SPAWN_Y] = y;
                    SellVehicles(vehicleid)[sell_info_SPAWN_Z] = z;
                    SellVehicles(vehicleid)[sell_info_SPAWN_ANGLE] = angle;

                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_VALID] = true;
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_TYPE] = VEHICLE_TYPE_SELL;
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] = SellVehicles(i)[sell_info_MODELID];
                    format(GLOBAL_VEHICLES[vehicleid][gb_vehicle_NUMBER_PLATE], 32, "EN VENTA");
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_X] = SellVehicles(i)[sell_info_SPAWN_X];
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_Y] = SellVehicles(i)[sell_info_SPAWN_Y];
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_Z] = SellVehicles(i)[sell_info_SPAWN_Z];
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_ANGLE] = SellVehicles(i)[sell_info_SPAWN_ANGLE];
                    
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_POS][0] = GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_X];
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_POS][1] = GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_Y];
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_POS][2] = GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_Z];
                    
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_HEALTH] = 1000.0;
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_DAMAGE_PANELS] = 0;
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_DAMAGE_DOORS] = 0;
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_DAMAGE_LIGHTS] = 0;
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_DAMAGE_TIRES] = 0;
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_COLOR_1] = tmp_colour_1;
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_COLOR_2] = tmp_colour_2;
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_PAINTJOB] = 3; // No paintjob
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_MAX_GAS] = 0.0;
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_GAS] = 0.0;
                    GLOBAL_VEHICLES[vehicleid][gb_vehicle_STATE] = VEHICLE_STATE_NORMAL;

                    SetVehicleToRespawnEx(vehicleid);
                    
                    new label_str[256];
                    if(SellVehicles(vehicleid)[sell_info_VIP])
                    {
                        if(SellVehicles(vehicleid)[sell_info_EXTRA])
                        {
                            format
                            (
                                label_str, 
                                    sizeof label_str, 
                                    "\
                                        {"#ORANGE_COLOR"}Membresía VIP requerida\n\
                                        \n\
                                        {"#PRIMARY_COLOR"}%s\n\n\
                                        {FFFFFF}Coste: {"#YELLOW_COLOR"}%d "SERVER_COIN"\n\
                                        {FFFFFF}Nivel: {"#PRIMARY_COLOR"}%d\
                                    ", VEHICLE_INFO[GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] - 400][vehicle_info_NAME], SellVehicles(vehicleid)[sell_info_EXTRA], SellVehicles(vehicleid)[sell_info_LEVEL]
                            );
                        }
                        else
                        {
                            format
                            (
                                label_str, 
                                    sizeof label_str, 
                                    "\
                                        {"#ORANGE_COLOR"}Membresía VIP requerida\n\
                                        \n\
                                        {"#PRIMARY_COLOR"}%s\n\n\
                                        {FFFFFF}Precio: {"#GREEN_COLOR"}%s$\n\
                                        {FFFFFF}Nivel requerido: {"#PRIMARY_COLOR"}%d\
                                    ", VEHICLE_INFO[GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] - 400][vehicle_info_NAME], number_format_thousand(SellVehicles(vehicleid)[sell_info_PRICE]), SellVehicles(vehicleid)[sell_info_LEVEL]
                            );
                        }
                    }
                    else
                    {
                        if(SellVehicles(vehicleid)[sell_info_EXTRA])
                        {
                            format
                            (
                                label_str, 
                                    sizeof label_str, 
                                    "\
                                        {"#PRIMARY_COLOR"}%s\n\n\
                                        {FFFFFF}Coste: {"#YELLOW_COLOR"}%d "SERVER_COIN"\n\
                                        {FFFFFF}Nivel requerido: {"#PRIMARY_COLOR"}%d\
                                    ", VEHICLE_INFO[GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] - 400][vehicle_info_NAME], SellVehicles(vehicleid)[sell_info_EXTRA], SellVehicles(vehicleid)[sell_info_LEVEL]
                            );
                        }
                        else
                        {
                            format
                            (
                                label_str, 
                                    sizeof label_str, 
                                    "\
                                        {"#PRIMARY_COLOR"}%s\n\n\
                                        {FFFFFF}Precio: {"#GREEN_COLOR"}%s$\n\
                                        {FFFFFF}Nivel requerido: {"#PRIMARY_COLOR"}%d\
                                    ", VEHICLE_INFO[GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] - 400][vehicle_info_NAME], number_format_thousand(SellVehicles(vehicleid)[sell_info_PRICE]), SellVehicles(vehicleid)[sell_info_LEVEL]
                            );
                        }
                    }

                    SellVehicles(vehicleid)[sell_info_LABEL] = CreateDynamic3DTextLabel(label_str, 0xFFFFFFFF, 0.0, 0.0, 1.5, 10.0, .attachedvehicle = vehicleid, .testlos = true, .worldid = 0, .interiorid = 0);
                }
            }
            CallLocalFunction("OnSellVehiclesLoaded", "");
            LoadDealerShips();
        }
    }
    mysql_format(Query_Data, "SELECT * FROM sell_vehicles;");
    mysql_tquery_inline(handle_db, QUERY_BUFFER, using inline OnSelectSvData);
}

stock ResetDealersInfo()
{
	new city[45], zone[45], Dialog_Lines_String[256], listitem;
	format(DIALOG_PLAYER_GPS_SITE_7_String, sizeof DIALOG_PLAYER_GPS_SITE_7_String, "{"#SILVER_COLOR"}Lugar\t{"#BLUE_COLOR"}Zona\n");
	for(new i = 0; i != sizeof(SellVehiclesShopInfo); i++ )
	{
        if(SellVehiclesShopInfo[i][Valid] == false) continue;
		GetPointZone(SellVehiclesShopInfo[i][pos_x], SellVehiclesShopInfo[i][pos_y], city, zone);
		format(Dialog_Lines_String, sizeof Dialog_Lines_String, "{FFFFFF}%s\t{"#BLUE_COLOR"}%s, %s\n", SellVehiclesShopInfo[i][Name], city, zone);
		strcat(DIALOG_PLAYER_GPS_SITE_7_String, Dialog_Lines_String);

        DealerShipListitem[listitem] = i;
        listitem ++;
	}
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_SELL_VEHICLES_CREATOR:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0: SellVehicleDialogCreator(playerid, DIALOG_SV_MODELID); //MODELID
                    case 1: SellVehicleDialogCreator(playerid, DIALOG_SV_COLOUR_0);
                    case 2: SellVehicleDialogCreator(playerid, DIALOG_SV_COLOUR_1);
                    case 3: //VIP
                    {
                        if(pTemp(playerid)[pt_SV_VIP]) pTemp(playerid)[pt_SV_VIP] = false;
                        else pTemp(playerid)[pt_SV_VIP] = true;
                        ShowSellVehicleCreator(playerid);
                    }
                    case 4: SellVehicleDialogCreator(playerid, DIALOG_SV_SET_LEVEL); //Nivel
                    case 5: SellVehicleDialogCreator(playerid, DIALOG_SV_SELECT_PRICE); //Precio
                    case 6: SellVehicleDialogCreator(playerid, DIALOG_SV_SHOP); //Lugar de venta
                    case 7: PC_EmulateCommand(playerid, "/csvehicle"); //crear auto
                }
            }

            return Y_HOOKS_BREAK_RETURN_1;
        }
        case DIALOG_SV_MODELID:
        {
            if(response)
            {
                if(strval(inputtext) < 400 || strval(inputtext) > 611)
                {
                    SellVehicleDialogCreator(playerid, DIALOG_SV_MODELID);
                    SendMessage(playerid, "Modelo no valido.");
                    return Y_HOOKS_BREAK_RETURN_1;
                }

                pTemp(playerid)[pt_SV_MODELID] = strval(inputtext);
                SendMessagef(playerid, "El auto ha sido establecido como: %s.", VEHICLE_INFO[pTemp(playerid)[pt_SV_MODELID] - 400][vehicle_info_NAME]);
                ShowSellVehicleCreator(playerid);
            }
            else
            {
                ShowSellVehicleCreator(playerid);
            }

            return Y_HOOKS_BREAK_RETURN_1;
        }
        case DIALOG_SV_COLOUR_0, DIALOG_SV_COLOUR_1:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0:
                    {
                        if(dialogid == DIALOG_SV_COLOUR_0) pTemp(playerid)[pt_SV_COLOUR_0] = -1;
                        else pTemp(playerid)[pt_SV_COLOUR_1] = -1;
                        ShowSellVehicleCreator(playerid);
                    }
                    default:
                    {
                        if(dialogid == DIALOG_SV_COLOUR_0) pTemp(playerid)[pt_SV_COLOUR_0] = (listitem - 1);
                        else pTemp(playerid)[pt_SV_COLOUR_1] = (listitem - 1);
                        ShowSellVehicleCreator(playerid);
                    }
                }
            }
            else
            {
                ShowSellVehicleCreator(playerid);
            }

            return Y_HOOKS_BREAK_RETURN_1;
        }
        case DIALOG_SV_SET_LEVEL:
        {
            if(response)
            {
                pTemp(playerid)[pt_SV_LEVEL] = strval(inputtext);
                ShowSellVehicleCreator(playerid);
            }
            else ShowSellVehicleCreator(playerid);
            
            return Y_HOOKS_BREAK_RETURN_1;
        }
        case DIALOG_SV_SELECT_PRICE:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0:
                    {
                        pTemp(playerid)[pt_SV_SELECTED_PRICE] = PRICE_CASH;
                        SellVehicleDialogCreator(playerid, DIALOG_SV_PRICE);
                    }
                    case 1:
                    {
                        pTemp(playerid)[pt_SV_SELECTED_PRICE] = PRICE_COIN;
                        SellVehicleDialogCreator(playerid, DIALOG_SV_PRICE);
                    }
                }
            }
            else ShowSellVehicleCreator(playerid);
            return Y_HOOKS_BREAK_RETURN_1;
        }
        case DIALOG_SV_PRICE:
        {
            if(response)
            {
                if(pTemp(playerid)[pt_SV_SELECTED_PRICE] == PRICE_CASH)
                {
                    pTemp(playerid)[pt_SV_EXTRA] = 0;
                    pTemp(playerid)[pt_SV_PRICE] = strval(inputtext);
                    ShowSellVehicleCreator(playerid);
                }
                else if(pTemp(playerid)[pt_SV_SELECTED_PRICE] == PRICE_COIN)
                {
                    pTemp(playerid)[pt_SV_EXTRA] = strval(inputtext);
                    pTemp(playerid)[pt_SV_PRICE] = 0;
                    ShowSellVehicleCreator(playerid);
                }
            }
            else SellVehicleDialogCreator(playerid, DIALOG_SV_SELECT_PRICE);
            return Y_HOOKS_BREAK_RETURN_1;
        }
        case DIALOG_SV_SHOP:
        {
            if(response)
            {
                pTemp(playerid)[pt_SV_SHOP] = pTemp(playerid)[pt_PLAYER_LISTITEM][listitem];
                ShowSellVehicleCreator(playerid);
            }
            else ShowSellVehicleCreator(playerid);
            return Y_HOOKS_BREAK_RETURN_1;
        }
        case DIALOG_BUY_VEHICLE:
        {
            if(response)
            {
                if(SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_LEVEL] > PI[playerid][pi_LEVEL]) return RemovePlayerFromVehicle(playerid);
                if(SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_VIP] && !PI[playerid][pi_VIP]) return RemovePlayerFromVehicle(playerid);
                if(PI[playerid][pi_BANK_ACCOUNT] == 0) return RemovePlayerFromVehicle(playerid);
                if(SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_PRICE] > PI[playerid][pi_BANK_MONEY]) return RemovePlayerFromVehicle(playerid);
                if(SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_EXTRA] > PI[playerid][pi_COINS]) return RemovePlayerFromVehicle(playerid);
                if(SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_VALID] == false) return RemovePlayerFromVehicle(playerid);
                if(GLOBAL_VEHICLES[ pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] ][gb_vehicle_TYPE] != VEHICLE_TYPE_SELL) return RemovePlayerFromVehicle(playerid);
                if(pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] == INVALID_VEHICLE_ID) return RemovePlayerFromVehicle(playerid);

				new vid = AddPersonalVehicle
				(
					playerid,
					GLOBAL_VEHICLES[ PlayerTemp[playerid][pt_SELECTED_BUY_VEHICLE_ID] ][gb_vehicle_MODELID],
					SellVehiclesShopInfo[ SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_SHOP] ][pos_x],
					SellVehiclesShopInfo[ SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_SHOP] ][pos_y],
					SellVehiclesShopInfo[ SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_SHOP] ][pos_z],
					SellVehiclesShopInfo[ SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_SHOP] ][pos_angle],
					GLOBAL_VEHICLES[ PlayerTemp[playerid][pt_SELECTED_BUY_VEHICLE_ID] ][gb_vehicle_COLOR_1],
					GLOBAL_VEHICLES[ PlayerTemp[playerid][pt_SELECTED_BUY_VEHICLE_ID] ][gb_vehicle_COLOR_2],
					VEHICLE_INFO[ GLOBAL_VEHICLES[ PlayerTemp[playerid][pt_SELECTED_BUY_VEHICLE_ID] ][gb_vehicle_MODELID] - 400 ][vehicle_info_MAX_GAS],
                    SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_PRICE]
				);
				if(!vid) return SendMessage(playerid, "Hubo un error interno y no se ha podido registar la compra.");
				
				if(SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_EXTRA])
				{
					PI[playerid][pi_COINS] -= SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_EXTRA];
					
					mysql_format(handle_db, QUERY_BUFFER, sizeof QUERY_BUFFER, "UPDATE player SET coins = %d WHERE id = %d;", PI[playerid][pi_COINS], PI[playerid][pi_ID]);
					mysql_tquery(handle_db, QUERY_BUFFER);
					
					SendMessagef(playerid, "Has gastado ~r~%d "SERVER_COIN"~w~ en la compra de este vehículo.", SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_EXTRA]);
				}
				else
				{
					if(PI[playerid][pi_PHONE_NUMBER])
					{
						new message[64]; format(message, sizeof message, "VEHICULO COMPRADO: -%s$", number_format_thousand(SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_PRICE]));
						RegisterPhoneMessage(0, PI[playerid][pi_ID], message);
						if(PI[playerid][pi_PHONE_STATE] == PHONE_STATE_ON) SendClientMessagef(playerid, -1, "{"#BLUE_COLOR"}[Nuevo mensaje recibido] {"#SILVER_COLOR"}Remitente: {FFFFFF}%s {"#SILVER_COLOR"}Mensaje: {FFFFFF}%s", convertPhoneNumber(playerid, 6740), message);
					}
					
					PI[playerid][pi_BANK_MONEY] -= SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_PRICE];

					mysql_format(handle_db, QUERY_BUFFER, sizeof QUERY_BUFFER, "UPDATE player SET bank_money = %d WHERE id = %d;", PI[playerid][pi_BANK_MONEY], PI[playerid][pi_ID]);
					mysql_tquery(handle_db, QUERY_BUFFER);

					RegisterBankAccountTransaction(PI[playerid][pi_ID], PI[playerid][pi_ID], BANK_TRANSACTION_BUY_VEHICLE, SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_PRICE]);
				}	
				
				SendClientMessagef(playerid, -1, "{"#ORANGE_COLOR"}¡Vehículo comprado! {ffffff}Utiliza {"#BLUE_COLOR"}/ayuda vehiculos{ffffff} para ver que puedes hacer con tu vehículo.");
				PlayerPlaySoundEx(playerid, 1058, 0.0, 0.0, 0.0);
				
				new Float:pos[4];
				pos[0] = SellVehiclesShopInfo[ SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_SHOP] ][pos_x];
				pos[1] = SellVehiclesShopInfo[ SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_SHOP] ][pos_y];
				pos[2] = SellVehiclesShopInfo[ SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_SHOP] ][pos_z];
				pos[3] = SellVehiclesShopInfo[ SellVehicles( pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] )[sell_info_SHOP] ][pos_angle];
				
				pos[0] += (2.0 * floatsin(-(pos[3] + 90.0), degrees));
				pos[1] += (2.0 * floatcos(-(pos[3] + 90.0), degrees));
				SetPlayerPosEx(playerid, pos[0], pos[1], pos[2], pos[3], 0, 0);
				
				if(!PI[playerid][pi_VIP]) ReLockPlayerVehicles(playerid);
            }
            else RemovePlayerFromVehicle(playerid);
            return Y_HOOKS_BREAK_RETURN_1;
        }
		case DIALOG_PLAYER_GPS_SITE_7: //Concesionarios
		{
			if(response)
            {
                if(SellVehiclesShopInfo[ DealerShipListitem[listitem] ][Valid] == false) return Y_HOOKS_BREAK_RETURN_0;
                SetPlayer_GPS_Checkpoint(playerid, SellVehiclesShopInfo[ DealerShipListitem[listitem] ][pos_x], SellVehiclesShopInfo[ DealerShipListitem[listitem] ][pos_y], SellVehiclesShopInfo[ DealerShipListitem[listitem] ][pos_z], 0, 0);
            }
			else ShowDialog(playerid, DIALOG_PLAYER_GPS_SITES);

			return Y_HOOKS_BREAK_RETURN_1;
		}
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

CMD:cdealer(playerid, params[])
{
    new name[32];
    if(sscanf(params, "s[32]", name)) return SendMessage(playerid, "Error: usa /cdealer [Nombre]");

    new Float:pos[4];
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, pos[3]);

    new slot = GetDealerShipValidSlot();
    if(slot == -1) return SendMessage(playerid, "No puedes crear mas concesionarias.");

    inline OnDealerShipInserted()
    {
        SellVehiclesShopInfo[slot][Valid] = true;
        SellVehiclesShopInfo[slot][ID] = cache_insert_id();

        format(SellVehiclesShopInfo[slot][Name], 32, "%s", name);

        SellVehiclesShopInfo[slot][pos_x] = pos[0];
        SellVehiclesShopInfo[slot][pos_y] = pos[1];
        SellVehiclesShopInfo[slot][pos_z] = pos[2];
        SellVehiclesShopInfo[slot][pos_angle] = pos[3];

        SendMessage(playerid, "El concesionario ha sido creado en tu posicion.");

        new label_str[256]; format(label_str, 256, "{"#PRIMARY_COLOR"}%s (%d)\n{ffffff}SALIDA DE VEHICULOS", SellVehiclesShopInfo[slot][Name], SellVehiclesShopInfo[slot][ID]);
        SellVehiclesShopInfo[slot][Label] = CreateDynamic3DTextLabel(label_str, -1, SellVehiclesShopInfo[slot][pos_x], SellVehiclesShopInfo[slot][pos_y], SellVehiclesShopInfo[slot][pos_z], 15, .testlos = true);

        ResetDealersInfo();
    }
    mysql_format(Query_Data, "INSERT INTO dealer_ships (name, x, y, z, angle) VALUES('%e', %f, %f, %f, %f);",
        name, pos[0], pos[1], pos[2], pos[3]
    );
    mysql_tquery_inline(Query_Data_Inline, using inline OnDealerShipInserted);
    return 1;
}
flags:cdealer(CMD_OWNER);

CMD:ddealer(playerid, params[])
{
    new id;
    if(sscanf(params, "d", id)) return SendMessage(playerid, "Error: usa /ddealer [ID]");

    new index = GetDealerShipIndexFromID(id);
    if(index == -1) return SendMessage(playerid, "La ID que escribiste no es valida.");

    mysql_format(Query_Data, "DELETE FROM dealer_ships WHERE id = %d;", id);
    mysql_tquery(Query_Data_Inline);

    LoopEx(i, MAX_VEHICLES, 0)
    {
        //if(SellVehicles(i)[sell_info_VALID] == false) continue;
        if(SellVehicles(i)[sell_info_SHOP] != index) continue;

        if(IsValidDynamic3DTextLabel(SellVehicles(i)[sell_info_LABEL]))
        {
            DestroyDynamic3DTextLabel(SellVehicles(i)[sell_info_LABEL]);
            SellVehicles(i)[sell_info_LABEL] = Text3D:INVALID_STREAMER_ID;
        }

        mysql_format(Query_Data, "DELETE FROM sell_vehicles WHERE id = %d;", SellVehicles(i)[sell_info_ID]);
        mysql_tquery(Query_Data_Inline);

        ClearSellVehicle(i);
        DestroyVehicleEx(i);
    }

    if(IsValidDynamic3DTextLabel(SellVehiclesShopInfo[index][Label]))
    {
        DestroyDynamic3DTextLabel(SellVehiclesShopInfo[index][Label]);
        SellVehiclesShopInfo[index][Label] = Text3D:INVALID_STREAMER_ID;
    }

    SellVehiclesShopInfo[index][Valid] = false;
    SellVehiclesShopInfo[index][ID] = 0;
    Loop(i, 32, 0) SellVehiclesShopInfo[index][Name][i] = 0;
    SellVehiclesShopInfo[index][pos_x] = 0;
    SellVehiclesShopInfo[index][pos_y] = 0;
    SellVehiclesShopInfo[index][pos_z] = 0;
    SellVehiclesShopInfo[index][pos_angle] = 0;

    ResetDealersInfo();
    SendMessage(playerid, "La concesionaria ha sido eliminada.");
    return 1;
}
flags:ddealer(CMD_OWNER);

CMD:vshopinfo(playerid, params[])
{
    ShowSellVehicleCreator(playerid);
    return 1;
}
flags:vshopinfo(CMD_OWNER);

CMD:dsvehicle(playerid, params[])
{
    new vehicleid = INVALID_VEHICLE_ID;
    if(sscanf(params, "d", vehicleid)) return SendMessage(playerid, "Error: /dsvehicle [ID del /dl del vehiculo]");

    if(vehicleid == INVALID_VEHICLE_ID) return SendMessage(playerid, "Id del vehiculo no encontrada.");
    if(SellVehicles(vehicleid)[sell_info_VALID] == false)  return SendMessage(playerid, "Este vehiculo no esta a la venta.");

    if(IsValidDynamic3DTextLabel(SellVehicles(vehicleid)[sell_info_LABEL]))
    {
        DestroyDynamic3DTextLabel(SellVehicles(vehicleid)[sell_info_LABEL]);
        SellVehicles(vehicleid)[sell_info_LABEL] = Text3D:INVALID_STREAMER_ID;
    }

    mysql_format(Query_Data, "DELETE FROM sell_vehicles WHERE id = %d;", SellVehicles(vehicleid)[sell_info_ID]);
    mysql_tquery(Query_Data_Inline);

    ClearSellVehicle(vehicleid);
    DestroyVehicleEx(vehicleid);
    return 1;
}
flags:dsvehicle(CMD_OWNER);

CMD:csvehicle(playerid, params[])
{
    if(pTemp(playerid)[pt_SV_MODELID] == 0) return SendMessage(playerid, "Error, modelo indefinido.");
    if(GetPlayerInterior(playerid) != 0) return SendMessage(playerid, "Error, necesitas estar en interior 0.");
    if(GetPlayerVirtualWorld(playerid) != 0) return SendMessage(playerid, "Error, necesitas estar en Mundo 0.");

    new Float:x, Float:y, Float:z, Float:angle;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);

    new tmp_colour_1, tmp_colour_2;
    tmp_colour_1 = pTemp(playerid)[pt_SV_COLOUR_0];
    tmp_colour_2 = pTemp(playerid)[pt_SV_COLOUR_1];
    if(pTemp(playerid)[pt_SV_COLOUR_0] == -1) tmp_colour_1 = minrand(0, 255);
    if(pTemp(playerid)[pt_SV_COLOUR_1] == -1) tmp_colour_2 = minrand(0, 255);

    new vehicleid = CreateVehicle(pTemp(playerid)[pt_SV_MODELID], x, y, z, angle, tmp_colour_1, tmp_colour_2, -1);
    
    SellVehicles(vehicleid)[sell_info_VALID] = false;
    SellVehicles(vehicleid)[sell_info_ID] = -1;
    SellVehicles(vehicleid)[sell_info_MODELID] = pTemp(playerid)[pt_SV_MODELID];
    SellVehicles(vehicleid)[sell_info_COLOUR_1] = tmp_colour_1;
    SellVehicles(vehicleid)[sell_info_COLOUR_2] = tmp_colour_2;
    SellVehicles(vehicleid)[sell_info_PRICE] = pTemp(playerid)[pt_SV_PRICE];
    SellVehicles(vehicleid)[sell_info_EXTRA] = pTemp(playerid)[pt_SV_EXTRA];
    SellVehicles(vehicleid)[sell_info_VIP] = pTemp(playerid)[pt_SV_VIP];
    SellVehicles(vehicleid)[sell_info_LEVEL] = pTemp(playerid)[pt_SV_LEVEL];
    SellVehicles(vehicleid)[sell_info_SHOP] = pTemp(playerid)[pt_SV_SHOP];

    SellVehicles(vehicleid)[sell_info_SPAWN_X] = x;
    SellVehicles(vehicleid)[sell_info_SPAWN_Y] = y;
    SellVehicles(vehicleid)[sell_info_SPAWN_Z] = z;
    SellVehicles(vehicleid)[sell_info_SPAWN_ANGLE] = angle;
    
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_VALID] = true;
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_TYPE] = VEHICLE_TYPE_SELL_INGAME;
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] = SellVehicles(vehicleid)[sell_info_MODELID];
    format(GLOBAL_VEHICLES[vehicleid][gb_vehicle_NUMBER_PLATE], 32, "EN VENTA");
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_X] = SellVehicles(vehicleid)[sell_info_SPAWN_X];
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_Y] = SellVehicles(vehicleid)[sell_info_SPAWN_Y];
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_Z] = SellVehicles(vehicleid)[sell_info_SPAWN_Z];
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_ANGLE] = SellVehicles(vehicleid)[sell_info_SPAWN_ANGLE];
                
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_POS][0] = GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_X];
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_POS][1] = GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_Y];
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_POS][2] = GLOBAL_VEHICLES[vehicleid][gb_vehicle_SPAWN_Z];
                
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_HEALTH] = 1000.0;
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_DAMAGE_PANELS] = 0;
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_DAMAGE_DOORS] = 0;
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_DAMAGE_LIGHTS] = 0;
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_DAMAGE_TIRES] = 0;
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE] = 0;
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_COLOR_1] = tmp_colour_1;
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_COLOR_2] = tmp_colour_2;
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_PAINTJOB] = 3; // No paintjob
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_MAX_GAS] = 1000.0;
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_GAS] = 1000.0;
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_STATE] = VEHICLE_STATE_NORMAL;

	SetVehicleToRespawnEx(vehicleid);

    new label_str[256];
    if(SellVehicles(vehicleid)[sell_info_VIP])
    {
        if(SellVehicles(vehicleid)[sell_info_EXTRA])
        {
            format
            (
                label_str, 
                sizeof label_str, 
                "\
                    {"#ORANGE_COLOR"}Membresía VIP requerida\n\
                    \n\
                    {"#PRIMARY_COLOR"}%s\n\n\
                    {FFFFFF}Coste: {"#YELLOW_COLOR"}%d "SERVER_COIN"\n\
                    {FFFFFF}Nivel: {"#PRIMARY_COLOR"}%d\
                ", VEHICLE_INFO[GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] - 400][vehicle_info_NAME], SellVehicles(vehicleid)[sell_info_EXTRA], SellVehicles(vehicleid)[sell_info_LEVEL]
            );
        }
        else
        {
            format
            (
                label_str, 
                sizeof label_str, 
                "\
                    {"#ORANGE_COLOR"}Membresía VIP requerida\n\
                    \n\
                    {"#PRIMARY_COLOR"}%s\n\n\
                    {FFFFFF}Precio: {"#GREEN_COLOR"}%s$\n\
                    {FFFFFF}Nivel requerido: {"#PRIMARY_COLOR"}%d\
                ", VEHICLE_INFO[GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] - 400][vehicle_info_NAME], number_format_thousand(SellVehicles(vehicleid)[sell_info_PRICE]), SellVehicles(vehicleid)[sell_info_LEVEL]
            );
        }
    }
    else
    {
        if(SellVehicles(vehicleid)[sell_info_EXTRA])
        {
            format
            (
                label_str, 
                sizeof label_str, 
                "\
                    {"#PRIMARY_COLOR"}%s\n\n\
                    {FFFFFF}Coste: {"#YELLOW_COLOR"}%d "SERVER_COIN"\n\
                    {FFFFFF}Nivel requerido: {"#PRIMARY_COLOR"}%d\
                ", VEHICLE_INFO[GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] - 400][vehicle_info_NAME], SellVehicles(vehicleid)[sell_info_EXTRA], SellVehicles(vehicleid)[sell_info_LEVEL]
            );
        }
        else
        {
            format
            (
                label_str, 
                sizeof label_str, 
                "\
                    {"#PRIMARY_COLOR"}%s\n\n\
                    {FFFFFF}Precio: {"#GREEN_COLOR"}%s$\n\
                    {FFFFFF}Nivel requerido: {"#PRIMARY_COLOR"}%d\
                ", VEHICLE_INFO[GLOBAL_VEHICLES[vehicleid][gb_vehicle_MODELID] - 400][vehicle_info_NAME], number_format_thousand(SellVehicles(vehicleid)[sell_info_PRICE]), SellVehicles(vehicleid)[sell_info_LEVEL]
            );
        }
    }

    SellVehicles(vehicleid)[sell_info_LABEL] = CreateDynamic3DTextLabel(label_str, 0xFFFFFFFF, 0.0, 0.0, 1.5, 10.0, .attachedvehicle = vehicleid, .testlos = true, .worldid = 0, .interiorid = 0);

    PutPlayerInVehicleEx(playerid, vehicleid, 0);
    return 1;
}
flags:csvehicle(CMD_OWNER);