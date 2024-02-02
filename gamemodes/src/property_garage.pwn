#include <YSI-Includes\YSI\y_hooks>

#define MAX_GARAGES 4000

#define LABEL_GARAGE_EXT            "{"#PRIMARY_COLOR"}Garage #%d\n{ffffff}Pulsa {"#GREEN_COLOR"}[ Y ] {ffffff}para entrar a pie\nPulsa {"#GREEN_COLOR"}[ H ] {ffffff}para entrar con un vehiculo"
#define LABEL_GARAGE_INT            "{"#RED_COLOR"}Salida\n{ffffff}Pulsa {"#GREEN_COLOR"}[ Y ] {ffffff}para salir a pie\nPulsa {"#GREEN_COLOR"}[ H ] {ffffff}para salir con un vehiculo"
#define LABEL_GARAGE_PROPERTY_EXT   "{"#RED_COLOR"}Salida\n{ffffff}Pulsa {"#GREEN_COLOR"}[ Y ] {ffffff}para salir a la propiedad"

new GarageCreatorInfo[MAX_PLAYERS][3];
new Float:GarageCreatorPos[MAX_PLAYERS][4];
new Float:VehGarageExtCreator[MAX_PLAYERS][3];

enum E_GARAGE_TYPE
{
    PROPERTY_GARAGE_NORMAL,
    PROPERTY_GARAGE_VIP
}

new TOTAL_GARAGES_LOADED;
enum E_PROPERTY_GARAGE
{
    bool:pgarage_VALID,
    pgarage_ID,
    pgarage_PROPERTY_ID,

    pgarage_INTERIOR_ID,

    Float:pgarage_EXT_X,
    Float:pgarage_EXT_Y,
    Float:pgarage_EXT_Z,
    Float:pgarage_EXT_ANGLE,

    Float:pgarage_VEH_EXT_X,
    Float:pgarage_VEH_EXT_Y,
    Float:pgarage_VEH_EXT_Z,
    Float:pgarage_VEH_EXT_ANGLE,

    pgarage_EXT_INTERIOR,

	Text3D:pgarage_EXT_LABELID,
	Text3D:pgarage_INT_LABELID,

	pgarage_EXT_PICKUP_ID,
	pgarage_INT_PICKUP_ID,

    pgarage_EXT_PROPERTY_PICKUP_ID,
    Text3D:pgarage_EXT_PROPERTY_LABELID,
}
new PropertyGarage[MAX_GARAGES][E_PROPERTY_GARAGE];

enum E_GARAGE_INTERIOR
{
    E_GARAGE_TYPE:pgarage_TYPE,

    Float:pgarage_INT_X,
    Float:pgarage_INT_Y,
    Float:pgarage_INT_Z,
    Float:pgarage_INT_ANGLE,

    Float:pgarage_VEHICLE_SPAWN_X,
    Float:pgarage_VEHICLE_SPAWN_Y,
    Float:pgarage_VEHICLE_SPAWN_Z,
    Float:pgarage_VEHICLE_SPAWN_ANGLE,

    Float:pgarage_PROPERTY_INT_X,
    Float:pgarage_PROPERTY_INT_Y,
    Float:pgarage_PROPERTY_INT_Z,
    Float:pgarage_PROPERTY_INT_ANGLE,

    pgarage_INTERIOR,
}
new GarageInterior[][E_GARAGE_INTERIOR] =
{
    {PROPERTY_GARAGE_NORMAL, 124.5656, 348.0431, 932.3705, 360.0,   124.0627, 356.4754, 932.3705, 1.9372,   114.5376, 364.1675, 932.3705, 270.0, 1}, //garage Normal
    {PROPERTY_GARAGE_VIP, 208.3882, 360.7059, 931.3278, 90.0,     196.8604, 360.2587, 931.3135, 90.0,    187.1940, 380.9987, 931.3196, 270.0, 2} //garage VIP
};

forward OnGaragesLoaded();
stock LoadGarages()
{
    inline OnGaragesLoad()
    {
		new rows;
		if(cache_get_row_count(rows))
		{
			for(new i = 0; i != rows; i ++)
			{
				if(i >= MAX_GARAGES)
				{
					printf("---> Límite superado en array 'MAX_GARAGES' al intentar cargar de la base de datos.");
					break;
				}

                TOTAL_GARAGES_LOADED ++;

                PropertyGarage[i][pgarage_VALID] = true;
                reg_int(i, "id", PropertyGarage[i][pgarage_ID]);
                reg_int(i, "property_id", PropertyGarage[i][pgarage_PROPERTY_ID]);
                reg_int(i, "interior_id", PropertyGarage[i][pgarage_INTERIOR_ID]);
                reg_float(i, "ext_x", PropertyGarage[i][pgarage_EXT_X]);
                reg_float(i, "ext_y", PropertyGarage[i][pgarage_EXT_Y]);
                reg_float(i, "ext_z", PropertyGarage[i][pgarage_EXT_Z]);
                reg_float(i, "veh_ext_x", PropertyGarage[i][pgarage_VEH_EXT_X]);
                reg_float(i, "veh_ext_y", PropertyGarage[i][pgarage_VEH_EXT_Y]);
                reg_float(i, "veh_ext_z", PropertyGarage[i][pgarage_VEH_EXT_Z]);
                reg_float(i, "ext_angle", PropertyGarage[i][pgarage_EXT_ANGLE]);
                reg_int(i, "ext_interior", PropertyGarage[i][pgarage_EXT_INTERIOR]);

                new label_str[256]; format(label_str, 256, LABEL_GARAGE_EXT, PropertyGarage[i][pgarage_ID]);
                PropertyGarage[i][pgarage_EXT_LABELID] = CreateDynamic3DTextLabel(label_str, -1, PropertyGarage[i][pgarage_EXT_X], PropertyGarage[i][pgarage_EXT_Y], PropertyGarage[i][pgarage_EXT_Z] + 0.25, 5.0, .testlos = true, .worldid = 0, .interiorid = PropertyGarage[i][pgarage_EXT_INTERIOR]);
                PropertyGarage[i][pgarage_INT_LABELID] = CreateDynamic3DTextLabel(LABEL_GARAGE_INT, -1, GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_INT_X], GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_INT_Y], GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_INT_Z] + 0.25, 5.0, .testlos = true, .worldid = PropertyGarage[i][pgarage_ID], .interiorid = GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_INTERIOR]);
                PropertyGarage[i][pgarage_EXT_PROPERTY_LABELID] = CreateDynamic3DTextLabel(LABEL_GARAGE_PROPERTY_EXT, -1, GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_PROPERTY_INT_X], GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_PROPERTY_INT_Y], GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_PROPERTY_INT_Z] + 0.25, 5.0, .testlos = true, .worldid = PropertyGarage[i][pgarage_ID], .interiorid = GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_INTERIOR]);

                new info[3];
                PropertyGarage[i][pgarage_EXT_PICKUP_ID] = CreateDynamicPickup(0, 1, PropertyGarage[i][pgarage_EXT_X], PropertyGarage[i][pgarage_EXT_Y], PropertyGarage[i][pgarage_EXT_Z], 0, PropertyGarage[i][pgarage_EXT_INTERIOR]);
                PropertyGarage[i][pgarage_INT_PICKUP_ID] = CreateDynamicPickup(0, 1, GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_INT_X], GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_INT_Y], GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_INT_Z], PropertyGarage[i][pgarage_ID], GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_INTERIOR]);
                PropertyGarage[i][pgarage_EXT_PROPERTY_PICKUP_ID] = CreateDynamicPickup(0, 1, GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_PROPERTY_INT_X], GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_PROPERTY_INT_Y], GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_PROPERTY_INT_Z], PropertyGarage[i][pgarage_ID], GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_INTERIOR]);

                info[0] = PICKUP_TYPE_GARAGE;
                info[1] = i; // Index
                info[2] = 1; // Pickup Interior
                Streamer_SetArrayData(STREAMER_TYPE_PICKUP, PropertyGarage[i][pgarage_INT_PICKUP_ID], E_STREAMER_EXTRA_ID, info);

                info[0] = PICKUP_TYPE_GARAGE;
                info[1] = i; // Index
                info[2] = 2; // Pickup Exterior
                Streamer_SetArrayData(STREAMER_TYPE_PICKUP, PropertyGarage[i][pgarage_EXT_PICKUP_ID], E_STREAMER_EXTRA_ID, info);

                info[0] = PICKUP_TYPE_GARAGE;
                info[1] = i; // Index
                info[2] = 3; // Pickup Propiedad
                Streamer_SetArrayData(STREAMER_TYPE_PICKUP, PropertyGarage[i][pgarage_EXT_PROPERTY_PICKUP_ID], E_STREAMER_EXTRA_ID, info);
			}
			CallLocalFunction("OnGaragesLoaded", "");
            LoadSellVehicles();
		}
    }
    mysql_tquery_inline(handle_db, "SELECT * FROM garages;", using inline OnGaragesLoad);
}

stock ShowGarageIntSelector(playerid)
{
    new dialog[2048], listitem;
    for(new i = 0; i != sizeof GarageInterior; i ++)
    {
        if(GarageInterior[i][pgarage_TYPE] == PROPERTY_GARAGE_NORMAL)
        {
            strcat(dialog, "Espacio Normal\n");
        }

        if(GarageInterior[i][pgarage_TYPE] == PROPERTY_GARAGE_VIP)
        {
            strcat(dialog, "Espacio Grande (VIP)\n");
        }

        pTemp(playerid)[pt_PLAYER_LISTITEM][listitem] = i;
		listitem ++;
    }

    ShowPlayerDialog(playerid, DIALOG_GARAGE_SELECT_INTERIOR, DIALOG_STYLE_TABLIST, "Interior del Garage", dialog, "Seleccionar", "Cancelar");
    return 1;
}

GetEmptyGarageSlot()
{
	for(new i = 0; i != MAX_GARAGES; i ++)
	{
		if(!PropertyGarage[i][pgarage_VALID]) return i;
	}
	return -1;
}

stock VehicleEnterExitGarage(playerid)
{
	if(PI[playerid][pi_STATE] == ROLEPLAY_STATE_CRACK || PI[playerid][pi_STATE] == ROLEPLAY_STATE_JAIL || PI[playerid][pi_STATE] == ROLEPLAY_STATE_ARRESTED) return 1;
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
		
    new info[2], vehicleid = GetPlayerVehicleID(playerid);
    Loop(i, 2, 0) info[i] = 0;

    if(vehicleid == INVALID_VEHICLE_ID) return 1;

    LoopEx(i, MAX_GARAGES, 0)
    {
        if(!PropertyGarage[i][pgarage_VALID]) continue;
        if(IsPlayerInRangeOfPoint(playerid, 5.0, PropertyGarage[i][pgarage_EXT_X], PropertyGarage[i][pgarage_EXT_Y], PropertyGarage[i][pgarage_EXT_Z]))
        {
            info[0] = 2;
            info[1] = i;
            break;
        }
        if(IsPlayerInRangeOfPoint(playerid, 5.0, GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_INT_X], GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_INT_Y], GarageInterior[ PropertyGarage[i][pgarage_INTERIOR_ID] ][pgarage_INT_Z]))
        {
            info[0] = 1;
            info[1] = i;
            break;
        }
    }

	if(PLAYER_WORKS[playerid][WORK_POLICE][pwork_SET] && pTemp(playerid)[pt_WORKING_IN] == WORK_POLICE) pTemp(playerid)[pt_DISPENSARY] = GetNearestDispensaryForPlayer(playerid);
	else pTemp(playerid)[pt_HOSPITAL] = GetNearestHospitalForPlayer(playerid);
	
    new property_index = GetPropertyIndexByID(PropertyGarage[info[1]][pgarage_PROPERTY_ID]);

    if(info[0] == 1) // Está en el Pickup Interior y quiere ir al exterior
    {
        LoopEx(i, MAX_PLAYERS, 0)
        {
            new current_vehicle = GetPlayerVehicleID(i);
            if(current_vehicle == vehicleid)
            {
                PI[i][pi_STATE] = ROLEPLAY_STATE_NORMAL;
                PI[i][pi_LOCAL_INTERIOR] = 0;
                pTemp(i)[pt_INTERIOR_INDEX] = -1;

                SetPlayerInterior(i, PropertyGarage[info[1]][pgarage_EXT_INTERIOR]);
                SetPlayerVirtualWorld(i, 0);
            }
        }

        SetVehicleZAngle(vehicleid, PropertyGarage[info[1]][pgarage_EXT_ANGLE]);
        LinkVehicleToInteriorEx(vehicleid, PropertyGarage[info[1]][pgarage_EXT_INTERIOR]);
        SetVehicleVirtualWorldEx(vehicleid, 0);

        SetVehiclePosEx
        (
            vehicleid, 
            PropertyGarage[info[1]][pgarage_VEH_EXT_X], 
            PropertyGarage[info[1]][pgarage_VEH_EXT_Y], 
            PropertyGarage[info[1]][pgarage_VEH_EXT_Z]
        );
    }
	else if(info[0] == 2) // Está en el Pickup Exterior y quiere ir al interior
    {
        if(!PLAYER_VEHICLES[vehicleid][player_vehicle_VALID]) return SendMessage(playerid, "~r~Este no es tú vehículo.");
        if(PLAYER_VEHICLES[vehicleid][player_vehicle_OWNER_ID] != PI[playerid][pi_ID]) return SendMessage(playerid, "~r~Este no es tú vehículo.");

        PI[playerid][pi_STATE] = ROLEPLAY_STATE_OWN_GARAGE;
        PI[playerid][pi_LOCAL_INTERIOR] = PropertyGarage[info[1]][pgarage_ID];
        pTemp(playerid)[pt_GARAGE_INDEX] = info[1];

        if(PROPERTY_INFO[property_index][property_OWNER_ID] == PI[playerid][pi_ID])
        {
            LoopEx(i, MAX_PLAYERS, 0)
            {
                new current_vehicle = GetPlayerVehicleID(i);
                if(current_vehicle == vehicleid)
                {
                    if(PROPERTY_INFO[property_index][property_OWNER_ID] == PI[i][pi_ID]) PI[i][pi_STATE] = ROLEPLAY_STATE_OWN_GARAGE;
                    else PI[i][pi_STATE] = ROLEPLAY_STATE_GUEST_GARAGE;

                    PI[i][pi_LOCAL_INTERIOR] = PropertyGarage[ info[1] ][pgarage_ID];
                    pTemp(i)[pt_GARAGE_INDEX] = info[1];

                    SetPlayerInterior(i, GarageInterior[ PropertyGarage[info[1]][pgarage_INTERIOR_ID] ][pgarage_INTERIOR]);
                    SetPlayerVirtualWorld(i, PropertyGarage[info[1]][pgarage_ID]);
                }
            }

            SetVehicleZAngle(vehicleid, GarageInterior[ PropertyGarage[ info[1] ][pgarage_INTERIOR_ID] ][pgarage_VEHICLE_SPAWN_ANGLE]);
            LinkVehicleToInteriorEx(vehicleid, GarageInterior[ PropertyGarage[ info[1] ][pgarage_INTERIOR_ID] ][pgarage_INTERIOR]);
            SetVehicleVirtualWorldEx(vehicleid, PropertyGarage[ info[1] ][pgarage_ID]);

            SetVehiclePosEx
            (
                vehicleid, 
                GarageInterior[ PropertyGarage[ info[1] ][pgarage_INTERIOR_ID] ][pgarage_VEHICLE_SPAWN_X], 
                GarageInterior[ PropertyGarage[ info[1] ][pgarage_INTERIOR_ID] ][pgarage_VEHICLE_SPAWN_Y], 
                GarageInterior[ PropertyGarage[ info[1] ][pgarage_INTERIOR_ID] ][pgarage_VEHICLE_SPAWN_Z]
            );
        }
    }
    return 1;
}

stock EnterExitGarage(playerid)
{
	if(PI[playerid][pi_STATE] == ROLEPLAY_STATE_CRACK || PI[playerid][pi_STATE] == ROLEPLAY_STATE_JAIL || PI[playerid][pi_STATE] == ROLEPLAY_STATE_ARRESTED) return 1;
	if(pTemp(playerid)[pt_LAST_PICKUP_ID] == 0) return 1;
		
	new info[3];
	
	new Float:pos[3];
	Streamer_GetArrayData(STREAMER_TYPE_PICKUP, pTemp(playerid)[pt_LAST_PICKUP_ID], E_STREAMER_EXTRA_ID, info);
	if(info[0] == PICKUP_TYPE_NONE) return 1;

	Streamer_GetFloatData(STREAMER_TYPE_PICKUP, pTemp(playerid)[pt_LAST_PICKUP_ID], E_STREAMER_X, pos[0]);
	Streamer_GetFloatData(STREAMER_TYPE_PICKUP, pTemp(playerid)[pt_LAST_PICKUP_ID], E_STREAMER_Y, pos[1]);
	Streamer_GetFloatData(STREAMER_TYPE_PICKUP, pTemp(playerid)[pt_LAST_PICKUP_ID], E_STREAMER_Z, pos[2]);

	if(!IsPlayerInRangeOfPoint(playerid, 1.0, pos[0], pos[1], pos[2])) return 1;

    switch(info[0])
    {
        case PICKUP_TYPE_GARAGE:
        {
			if(PLAYER_WORKS[playerid][WORK_POLICE][pwork_SET] && pTemp(playerid)[pt_WORKING_IN] == WORK_POLICE) pTemp(playerid)[pt_DISPENSARY] = GetNearestDispensaryForPlayer(playerid);
			else pTemp(playerid)[pt_HOSPITAL] = GetNearestHospitalForPlayer(playerid);
			
            if(info[2] == 1) // Está en el Pickup Interior y quiere ir al exterior
            {
                PI[playerid][pi_STATE] = ROLEPLAY_STATE_NORMAL;
				PI[playerid][pi_LOCAL_INTERIOR] = 0;
				pTemp(playerid)[pt_INTERIOR_INDEX] = -1;
                
				SetPlayerPosEx
                (
                    playerid, 
                    PropertyGarage[info[1]][pgarage_EXT_X], 
                    PropertyGarage[info[1]][pgarage_EXT_Y], 
                    PropertyGarage[info[1]][pgarage_EXT_Z], 
                    PropertyGarage[info[1]][pgarage_EXT_ANGLE],
                    PropertyGarage[info[1]][pgarage_EXT_INTERIOR], 
                    0,
                    false
                );

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
				StopAudioStreamForPlayer(playerid);
				FreezePlayer(playerid);
            }
			else if(info[2] == 2) // Está en el Pickup Exterior y quiere ir al interior
            {
                new property_index = GetPropertyIndexByID(PropertyGarage[info[1]][pgarage_PROPERTY_ID]);

                if(PROPERTY_INFO[property_index][property_OWNER_ID] == PI[playerid][pi_ID])
                {
                    PI[playerid][pi_STATE] = ROLEPLAY_STATE_OWN_GARAGE;
					PI[playerid][pi_LOCAL_INTERIOR] = PropertyGarage[info[1]][pgarage_ID];
					pTemp(playerid)[pt_GARAGE_INDEX] = info[1];

                    SetPlayerPosEx
                    (
                        playerid, 
                        GarageInterior[ PropertyGarage[info[1]][pgarage_INTERIOR_ID] ][pgarage_INT_X], 
                        GarageInterior[ PropertyGarage[info[1]][pgarage_INTERIOR_ID] ][pgarage_INT_Y], 
                        GarageInterior[ PropertyGarage[info[1]][pgarage_INTERIOR_ID] ][pgarage_INT_Z], 
                        GarageInterior[ PropertyGarage[info[1]][pgarage_INTERIOR_ID] ][pgarage_INT_ANGLE], 
                        GarageInterior[ PropertyGarage[info[1]][pgarage_INTERIOR_ID] ][pgarage_INTERIOR], 
                        PropertyGarage[info[1]][pgarage_ID], 
                        false, 
                        true
                    );

					FreezePlayer(playerid);
                }
                else SendMessagef(playerid, "Este no es el garage de tu propiedad.");
            }
            else if(info[2] == 3)
            {
                new property_index = GetPropertyIndexByID(PropertyGarage[info[1]][pgarage_PROPERTY_ID]);

				if(PROPERTY_INFO[property_index][property_POLICE_FORCED] && (PLAYER_WORKS[playerid][WORK_POLICE][pwork_SET] && pTemp(playerid)[pt_WORKING_IN] == WORK_POLICE)) {
					
					SetPlayerPosEx(playerid, PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_X], PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_Y], PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_Z], PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_ANGLE], PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_INTERIOR], PROPERTY_INFO[property_index][property_ID], false /*PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_FREEZE]*/, true);
					FreezePlayer(playerid);
					return 1;
				}

				if(!PROPERTY_INFO[property_index][property_SOLD]) return SendClientMessagef(playerid, -1, "Esta propiedad está en venta.");

				if(PROPERTY_INFO[property_index][property_CREW])
				{
					if(!PI[playerid][pi_CREW]) return SendClientMessagef(playerid, -1, "Solo miembros de la banda pueden entrar.");
					if(PI[playerid][pi_CREW] != PROPERTY_INFO[property_index][property_CREW_ID]) return SendClientMessagef(playerid, -1, "Solo miembros de la banda pueden entrar.");
					
					PI[playerid][pi_STATE] = ROLEPLAY_STATE_GUEST_PROPERTY;
					PI[playerid][pi_LOCAL_INTERIOR] = PROPERTY_INFO[property_index][property_ID];
					pTemp(playerid)[pt_PROPERTY_INDEX] = property_index;

					
					SetPlayerPosEx(playerid, PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_X], PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_Y], PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_Z], PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_ANGLE], PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_INTERIOR], PROPERTY_INFO[property_index][property_ID], false /*PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_FREEZE]*/, true);
					FreezePlayer(playerid);
				}
				else
				{
					PI[playerid][pi_STATE] = ROLEPLAY_STATE_OWN_PROPERTY;
					PI[playerid][pi_LOCAL_INTERIOR] = PROPERTY_INFO[property_index][property_ID];
					pTemp(playerid)[pt_PROPERTY_INDEX] = property_index;
						
					SetPlayerPosEx(playerid, PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_X], PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_Y], PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_Z], PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_ANGLE], PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_INTERIOR], PROPERTY_INFO[property_index][property_ID], false /*PROPERTY_INTERIORS[ PROPERTY_INFO[property_index][property_ID_INTERIOR] ][property_INT_FREEZE]*/, true);
					FreezePlayer(playerid);
				}
            }
        }
    }

    return 1;
}

stock CreatePropertyGarage(playerid, property_id)
{
    new index = GetEmptyGarageSlot();
    if(index == -1)
	{
		SendClientMessagef(playerid, -1, "No hay mas slots.");
		return 1;
	}

    new interior;
    interior = GetPlayerInterior(playerid);

    PropertyGarage[index][pgarage_PROPERTY_ID] = property_id;

    PropertyGarage[index][pgarage_INTERIOR_ID] = GarageCreatorInfo[playerid][1];

    PropertyGarage[index][pgarage_EXT_X] = GarageCreatorPos[playerid][0];
    PropertyGarage[index][pgarage_EXT_Y] = GarageCreatorPos[playerid][1];
    PropertyGarage[index][pgarage_EXT_Z] = GarageCreatorPos[playerid][2];
    PropertyGarage[index][pgarage_EXT_ANGLE] = GarageCreatorPos[playerid][3];

    PropertyGarage[index][pgarage_VEH_EXT_X] = VehGarageExtCreator[playerid][0];
    PropertyGarage[index][pgarage_VEH_EXT_Y] = VehGarageExtCreator[playerid][1];
    PropertyGarage[index][pgarage_VEH_EXT_Z] = VehGarageExtCreator[playerid][2];

    PropertyGarage[index][pgarage_EXT_INTERIOR] = interior;

    inline OnGarageInserted()
    {
        PropertyGarage[index][pgarage_ID] = cache_insert_id();

        new property_index = GetPropertyIndexByID(property_id);
        PropertyGarage[index][pgarage_VALID] = true;
        PROPERTY_INFO[ property_index ][property_GARAGE_ID] = index;

        new label_str[256]; format(label_str, 256, LABEL_GARAGE_EXT, PropertyGarage[index][pgarage_ID]);
        PropertyGarage[index][pgarage_EXT_LABELID] = CreateDynamic3DTextLabel(label_str, -1, PropertyGarage[index][pgarage_EXT_X], PropertyGarage[index][pgarage_EXT_Y], PropertyGarage[index][pgarage_EXT_Z] + 0.25, 5.0, .testlos = true, .worldid = 0, .interiorid = PropertyGarage[index][pgarage_EXT_INTERIOR]);
        PropertyGarage[index][pgarage_INT_LABELID] = CreateDynamic3DTextLabel(LABEL_GARAGE_INT, -1, GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INT_X], GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INT_Y], GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INT_Z] + 0.25, 5.0, .testlos = true, .worldid = PropertyGarage[index][pgarage_ID], .interiorid = GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INTERIOR]);

        new info[3];
        PropertyGarage[index][pgarage_EXT_PICKUP_ID] = CreateDynamicPickup(0, 1, PropertyGarage[index][pgarage_EXT_X], PropertyGarage[index][pgarage_EXT_Y], PropertyGarage[index][pgarage_EXT_Z], 0, PropertyGarage[index][pgarage_EXT_INTERIOR]);
        PropertyGarage[index][pgarage_INT_PICKUP_ID] = CreateDynamicPickup(0, 1, GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INT_X], GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INT_Y], GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INT_Z], PropertyGarage[index][pgarage_ID], GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INTERIOR]);
        PropertyGarage[index][pgarage_EXT_PROPERTY_PICKUP_ID] = CreateDynamicPickup(0, 1, GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_PROPERTY_INT_X], GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_PROPERTY_INT_Y], GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_PROPERTY_INT_Z], PropertyGarage[index][pgarage_ID], GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INTERIOR]);

        info[0] = PICKUP_TYPE_GARAGE;
        info[1] = index; // Index
        info[2] = 1; // Pickup Interior
        Streamer_SetArrayData(STREAMER_TYPE_PICKUP, PropertyGarage[index][pgarage_INT_PICKUP_ID], E_STREAMER_EXTRA_ID, info);

        info[0] = PICKUP_TYPE_GARAGE;
        info[1] = index; // Index
        info[2] = 2; // Pickup Exterior
        Streamer_SetArrayData(STREAMER_TYPE_PICKUP, PropertyGarage[index][pgarage_EXT_PICKUP_ID], E_STREAMER_EXTRA_ID, info);

        info[0] = PICKUP_TYPE_GARAGE;
        info[1] = index; // Index
        info[2] = 3; // Pickup Propiedad
        Streamer_SetArrayData(STREAMER_TYPE_PICKUP, PropertyGarage[index][pgarage_EXT_PROPERTY_PICKUP_ID], E_STREAMER_EXTRA_ID, info);

        mysql_format(handle_db, QUERY_BUFFER, sizeof QUERY_BUFFER, "UPDATE properties SET garage_id = %d WHERE id = %d", PropertyGarage[index][pgarage_ID], property_id);
        mysql_tquery(handle_db, QUERY_BUFFER);

        SendClientMessagef(playerid, -1, "Garage creado, id: %d (%d/%d).", PropertyGarage[index][pgarage_ID], index, MAX_GARAGES);
    }
    mysql_format(
        handle_db, QUERY_BUFFER, sizeof QUERY_BUFFER, 
        "INSERT INTO garages (property_id, interior_id, ext_x, ext_y, ext_z, veh_ext_x, veh_ext_y, veh_ext_z, ext_angle, ext_interior) VALUES(%d, %d, %f, %f, %f, %f, %f, %f, %f, %d)",
        property_id, PropertyGarage[index][pgarage_INTERIOR_ID], PropertyGarage[index][pgarage_EXT_X], PropertyGarage[index][pgarage_EXT_Y], 
        PropertyGarage[index][pgarage_EXT_Z], PropertyGarage[index][pgarage_VEH_EXT_X], PropertyGarage[index][pgarage_VEH_EXT_Y], 
        PropertyGarage[index][pgarage_VEH_EXT_Z], PropertyGarage[index][pgarage_EXT_ANGLE], interior
    );
    mysql_tquery_inline(handle_db, QUERY_BUFFER, using inline OnGarageInserted);

    return 1;
}

GetGarageIndexByID(id)
{
	for(new i = 0; i != MAX_GARAGES; i ++)
	{
		if(!PropertyGarage[i][pgarage_VALID]) continue;
		if(PropertyGarage[i][pgarage_ID] == id) return i;
	}
	return -1;
}

stock SetPlayerGarageExtPos(playerid, index)
{
	PI[playerid][pi_POS_X] = PropertyGarage[index][pgarage_EXT_X];
	PI[playerid][pi_POS_Y] = PropertyGarage[index][pgarage_EXT_Y];
	PI[playerid][pi_POS_Z] = PropertyGarage[index][pgarage_EXT_Z];
	PI[playerid][pi_ANGLE] = PropertyGarage[index][pgarage_EXT_ANGLE];
	PI[playerid][pi_INTERIOR] = PropertyGarage[index][pgarage_EXT_INTERIOR];
    return 1;
}

stock SetPlayerGarageIntPos(playerid, index)
{
	PI[playerid][pi_POS_X] = GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INT_X];
	PI[playerid][pi_POS_Y] = GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INT_Y];
	PI[playerid][pi_POS_Z] = GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INT_Z];
	PI[playerid][pi_ANGLE] = GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INT_ANGLE];
	PI[playerid][pi_INTERIOR] = GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INTERIOR];
    return 1;
}

stock SetWorldInteriorPlayerGarage(playerid, index)
{
    SetPlayerInterior(playerid, GarageInterior[ PropertyGarage[index][pgarage_INTERIOR_ID] ][pgarage_INTERIOR]);
	SetPlayerVirtualWorld(playerid, PropertyGarage[index][pgarage_PROPERTY_ID]);
    return 1;
}

stock GetGarageExtPosX(index, &Float:x)
{
    x = PropertyGarage[index][pgarage_EXT_X];
}

stock GetGarageExtPosY(index, &Float:y)
{
    y = PropertyGarage[index][pgarage_EXT_Y];
}

stock GetGarageExtPosZ(index, &Float:z)
{
    z = PropertyGarage[index][pgarage_EXT_Z];
}

stock IsPropertyGarageOwner(playerid, index)
{
    new property_index = GetPropertyIndexByID(PropertyGarage[index][pgarage_PROPERTY_ID]);
    if(PROPERTY_INFO[property_index][property_OWNER_ID] == PI[playerid][pi_ID])
    {
        return 1;
    }
    return 0;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
    {
        case DIALOG_GARAGE_SELECT_INTERIOR:
        {
            if(response)
            {
                GarageCreatorInfo[playerid][1] = pTemp(playerid)[pt_PLAYER_LISTITEM][listitem];
                GetPlayerPos(playerid, GarageCreatorPos[playerid][0], GarageCreatorPos[playerid][1], GarageCreatorPos[playerid][2]);

                pTemp(playerid)[pt_EDITING_EXT_GPOS] = true;
                SendMessage(playerid, "Busca la posicion de salida del vehiculo, luego escribe /tgarage.");
            }

            return Y_HOOKS_BREAK_RETURN_1;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

CMD:cgarage(playerid, params[])
{
    if(TOTAL_GARAGES_LOADED >= MAX_GARAGES) return SendClientMessagef(playerid, -1, "Límite alcanzado.");
    if(sscanf(params, "d", GarageCreatorInfo[playerid][0])) return SendMessage(playerid, "Modo de uso: /cgarage [ID de la Propiedad]");
    
    new index = GetPropertyIndexByID(GarageCreatorInfo[playerid][0]);
    if(index == -1) return SendMessage(playerid, "Esta propiedad no es valida.");

    if(PROPERTY_INFO[index][property_GARAGE_ID] != -1) return SendMessage(playerid, "Esta propiedad ya tiene garage.");

    ShowGarageIntSelector(playerid);
    return 1;
}
flags:cgarage(CMD_OWNER);

CMD:tgarage(playerid, params[])
{
    if(pTemp(playerid)[pt_EDITING_EXT_GPOS] == false) return SendMessage(playerid, "No estas creando ningun garage.");

    GetPlayerPos(playerid, VehGarageExtCreator[playerid][0], VehGarageExtCreator[playerid][1], VehGarageExtCreator[playerid][2]);
    SendMessage(playerid, "La posicion donde saldra el vehiculo ha sido establecida.");
    pTemp(playerid)[pt_EDITING_EXT_GPOS] = false;

    CreatePropertyGarage(playerid, GarageCreatorInfo[playerid][0]);
    return 1;
}
flags:tgarage(CMD_OWNER);

CMD:dgarage(playerid, params[])
{
    if(sscanf(params, "d", GarageCreatorInfo[playerid][0])) return SendMessage(playerid, "Modo de uso: /dgarage [ID del garage]");
    
    new index = GetGarageIndexByID(GarageCreatorInfo[playerid][0]);
    if(index == -1) return SendMessage(playerid, "Este garage no es valido.");

    new property_index = GetPropertyIndexByID(PropertyGarage[index][pgarage_PROPERTY_ID]);
    PROPERTY_INFO[ property_index ][property_GARAGE_ID] = -1;

    mysql_format(handle_db, QUERY_BUFFER, sizeof QUERY_BUFFER, "DELETE FROM garages WHERE id = %d;", PropertyGarage[index][pgarage_ID]);
    mysql_tquery(handle_db, QUERY_BUFFER);

    mysql_format(handle_db, QUERY_BUFFER, sizeof QUERY_BUFFER, "UPDATE properties SET garage_id = '-1' WHERE id = %d;", PROPERTY_INFO[ property_index ][property_ID]);
	mysql_tquery(handle_db, QUERY_BUFFER);

    PropertyGarage[index][pgarage_VALID] = false;
    PropertyGarage[index][pgarage_PROPERTY_ID] = 0;

    PropertyGarage[index][pgarage_INTERIOR_ID] = 0;

    PropertyGarage[index][pgarage_EXT_X] = 0;
    PropertyGarage[index][pgarage_EXT_Y] = 0;
    PropertyGarage[index][pgarage_EXT_Z] = 0;
    PropertyGarage[index][pgarage_EXT_ANGLE] = 0;

    PropertyGarage[index][pgarage_VEH_EXT_X] = 0;
    PropertyGarage[index][pgarage_VEH_EXT_Y] = 0;
    PropertyGarage[index][pgarage_VEH_EXT_Z] = 0;

    PropertyGarage[index][pgarage_EXT_INTERIOR] = -1;
	
    DestroyDynamic3DTextLabel(PropertyGarage[index][pgarage_EXT_LABELID]);
    DestroyDynamic3DTextLabel(PropertyGarage[index][pgarage_INT_LABELID]);

    PropertyGarage[index][pgarage_EXT_LABELID] = Text3D:INVALID_STREAMER_ID;
    PropertyGarage[index][pgarage_INT_LABELID] = Text3D:INVALID_STREAMER_ID;

    DestroyDynamicPickup(PropertyGarage[index][pgarage_EXT_PICKUP_ID]);
    DestroyDynamicPickup(PropertyGarage[index][pgarage_INT_PICKUP_ID]);
    DestroyDynamicPickup(PropertyGarage[index][pgarage_EXT_PROPERTY_PICKUP_ID]);

    PropertyGarage[index][pgarage_EXT_PICKUP_ID] = INVALID_STREAMER_ID;
    PropertyGarage[index][pgarage_INT_PICKUP_ID] = INVALID_STREAMER_ID;
    PropertyGarage[index][pgarage_EXT_PROPERTY_PICKUP_ID] = INVALID_STREAMER_ID;

    PropertyGarage[index][pgarage_ID] = 0;

    SendMessage(playerid, "Garage eliminado.");
    return 1;
}
flags:dgarage(CMD_OWNER);

CMD:garage(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        VehicleEnterExitGarage(playerid);
    }
    else
    {
        if(PI[playerid][pi_STATE] == ROLEPLAY_STATE_OWN_PROPERTY || PI[playerid][pi_STATE] == ROLEPLAY_STATE_GUEST_PROPERTY)
        {
            new index = GetPropertyIndexByID(PI[playerid][pi_LOCAL_INTERIOR]);
            if(index == -1) return SendMessage(playerid, "No estás en el lugar adecuado.");

            if(PI[playerid][pi_STATE] == ROLEPLAY_STATE_OWN_PROPERTY)
            {	
                if(PROPERTY_INFO[index][property_OWNER_ID] == PI[playerid][pi_ID])
                {
                    new garage_index = GetGarageIndexByID(PROPERTY_INFO[index][property_GARAGE_ID]);
                    if(garage_index == -1) return SendMessage(playerid, "Esta propiedad no tiene garage.");

                    PI[playerid][pi_STATE] = ROLEPLAY_STATE_OWN_GARAGE;
                    PI[playerid][pi_LOCAL_INTERIOR] = PropertyGarage[garage_index][pgarage_ID];
                    pTemp(playerid)[pt_GARAGE_INDEX] = garage_index;

                    SetPlayerPosEx
                    (
                        playerid, 
                        GarageInterior[ PropertyGarage[garage_index][pgarage_INTERIOR_ID] ][pgarage_PROPERTY_INT_X], 
                        GarageInterior[ PropertyGarage[garage_index][pgarage_INTERIOR_ID] ][pgarage_PROPERTY_INT_Y], 
                        GarageInterior[ PropertyGarage[garage_index][pgarage_INTERIOR_ID] ][pgarage_PROPERTY_INT_Z], 
                        GarageInterior[ PropertyGarage[garage_index][pgarage_INTERIOR_ID] ][pgarage_PROPERTY_INT_ANGLE], 
                        GarageInterior[ PropertyGarage[garage_index][pgarage_INTERIOR_ID] ][pgarage_INTERIOR], 
                        PropertyGarage[garage_index][pgarage_ID], 
                        false, 
                        true
                    );

                    FreezePlayer(playerid);
                }
                else SendMessage(playerid, "No estás en tu casa.");
            }
            else if(PI[playerid][pi_STATE] == ROLEPLAY_STATE_GUEST_PROPERTY)
            {
                SendMessage(playerid, "No estás en tu casa.");
            }
        }
        else SendMessage(playerid, "Debes estar dentro de tu casa o en un auto.");
    }
    return 1;
}