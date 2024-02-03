#include <YSI-Includes\YSI\y_hooks>

#define	VEHICLE_FORKLIFT			530

new
	MECHANIC_STOCK_PIECES = 0,
	MECHANIC_GARAGE_PIECES = 500
;

new Float:Mechanic_Pieces_Start_Work[] = {-587.7748, -517.3298, 25.5441, 270.0};
new Float:Mechanic_Pieces_Trailer[] = {-595.5101, -516.7543, 26.2011, 270.0};
new Float:Mechanic_Pieces_Truck[] = {-586.4796, -517.2444, 26.5648, 270.0};

new MechanicForkLiftPieces[MAX_VEHICLES] = 0;

new Float:Mechanic_Pieces_Routes[][] = 
{
	{-1733.8464, 155.5775, 3.5547}, //sf
	{-315.8508, 1568.4552, 75.3594}, //lv
	{2530.4822, -2081.0566, 13.5469} //ls
};

stock IsVehicleForkLift(vehicleid)
{
	if(GetVehicleModel(vehicleid) == VEHICLE_FORKLIFT) return 1;
	return 0;
}

stock SetMechanicCrate(vehicleid)
{
	if(!IsVehicleForkLift(vehicleid)) return 0;
	DestroyDynamicObject(GLOBAL_VEHICLES[vehicleid][gb_vehicle_OBJECTID]);
	GLOBAL_VEHICLES[vehicleid][gb_vehicle_OBJECTID] = INVALID_STREAMER_ID;

	GLOBAL_VEHICLES[vehicleid][gb_vehicle_OBJECTID] = CreateDynamicObject(2912, 0.0, 0.0, -1000.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0, 300.0);
    AttachDynamicObjectToVehicle(GLOBAL_VEHICLES[vehicleid][gb_vehicle_OBJECTID], vehicleid, -0.010, 0.639, -0.050, 0.000, 0.000, 0.000);
	return 1;
}

stock RemoveMechanicCrate(vehicleid)
{
	if(!IsVehicleForkLift(vehicleid)) return 0;
	DestroyDynamicObject(GLOBAL_VEHICLES[vehicleid][gb_vehicle_OBJECTID]);
	GLOBAL_VEHICLES[vehicleid][gb_vehicle_OBJECTID] = INVALID_STREAMER_ID;
	return 1;
}

stock UpdateMechanicPieces()
{
	new str_text[445]; format(str_text, 445, "{"#PRIMARY_COLOR"}Piezas de mecánico\n{ffffff}Escribe {"#BLUE_COLOR"}/piezas [cantidad] {FFFFFF}para comprar piezas\nPrecio de pieza: {"#GREEN_COLOR"}50$\n{ffffff}Cantidad de piezas almacenadas: {"#ORANGE_COLOR"}%d", MECHANIC_GARAGE_PIECES);
	for(new i; i != sizeof MechanicBuyPiecesCoords; i++)
	{
		UpdateDynamic3DTextLabelText(MechanicBuyPiecesLabel[i], -1, str_text);
	}
	return 1;
}

stock UpdateCrateMechanicPieces()
{
	new str_text[445]; format(str_text, 445, "{"#PRIMARY_COLOR"}Cajas de Piezas\n{ffffff}Pulsa {"#BLUE_COLOR"}'H' {FFFFFF}para tomar una caja\nPiezas en la caja: {"#ORANGE_COLOR"}%d", MECHANIC_STOCK_PIECES);
	for(new i; i != sizeof MechanicPiecesForklift; i++)
	{
		UpdateDynamic3DTextLabelText(MechanicPiecesForkliftLabel[i], -1, str_text);
	}
	return 1;
}

stock SetPlayerMechanicTrailerCP(playerid, vehicleid)
{
	if(IsValidDynamicCP(pTemp(playerid)[pt_TRAILER_CHECKPOINT]))
	{
		DestroyDynamicCP(pTemp(playerid)[pt_TRAILER_CHECKPOINT]);
		pTemp(playerid)[pt_TRAILER_CHECKPOINT] = INVALID_STREAMER_ID;
	}

	if(TrailerVehicle(vehicleid)[trailer_DELIVERED])
	{
		pTemp(playerid)[pt_TRAILER_CHECKPOINT] = CreateDynamicCP(Mechanic_Pieces_Start_Work[0], Mechanic_Pieces_Start_Work[1], Mechanic_Pieces_Start_Work[2], 5.0, 0, 0, playerid, 9999999999.0);
		
		new info[1];
		info[0] = CHECKPOINT_TYPE_FINISH_MECHANIC;
		Streamer_SetArrayData(STREAMER_TYPE_CP, pTemp(playerid)[pt_TRAILER_CHECKPOINT], E_STREAMER_EXTRA_ID, info);
	}
	else
	{
		pTemp(playerid)[pt_TRAILER_CHECKPOINT] = CreateDynamicCP(Mechanic_Pieces_Routes[ TrailerVehicle(vehicleid)[trailer_ROUTE] ][0], Mechanic_Pieces_Routes[ TrailerVehicle(vehicleid)[trailer_ROUTE] ][1], Mechanic_Pieces_Routes[ TrailerVehicle(vehicleid)[trailer_ROUTE] ][2], 5.0, 0, 0, playerid, 9999999999.0);
		
		new info[1];
		info[0] = CHECKPOINT_TYPE_MECHANIC;
		Streamer_SetArrayData(STREAMER_TYPE_CP, pTemp(playerid)[pt_TRAILER_CHECKPOINT], E_STREAMER_EXTRA_ID, info);
	}
	Streamer_Update(playerid, STREAMER_TYPE_CP);
	return 1;
}

AddMechanicGaragePieces(amount, bool:negative)
{
	if(amount == 0) return 1;
	if(!negative && amount < 0) return 0;
	if(negative && amount > 0) return 0;
	if(negative && (MECHANIC_GARAGE_PIECES + amount) < 0) return 0;

	MECHANIC_GARAGE_PIECES += amount;
	return 1;
}

GetMechanicPieces()
{
	return MECHANIC_GARAGE_PIECES;
}

hook OnScriptInit()
{
	for(new i; i != sizeof MechanicBuyPiecesCoords; i++)
	{
		new str_text[445]; format(str_text, 445, "{"#PRIMARY_COLOR"}Piezas de mecánico\n{ffffff}Escribe {"#BLUE_COLOR"}/piezas [cantidad] {FFFFFF}para comprar piezas\nPrecio de pieza: {"#GREEN_COLOR"}50$\n{ffffff}Cantidad de piezas almacenadas: {"#ORANGE_COLOR"}%d", MECHANIC_GARAGE_PIECES);
		MechanicBuyPiecesLabel[i] = CreateDynamic3DTextLabel(str_text, 0xFFFFFFFF, MechanicBuyPiecesCoords[i][0], MechanicBuyPiecesCoords[i][1], MechanicBuyPiecesCoords[i][2], 5.0, .testlos = true, .interiorid = 0);
	}

	for(new i; i != sizeof MechanicPiecesForklift; i++)
	{
		new str_text[445]; format(str_text, 445, "{"#PRIMARY_COLOR"}Cajas de Piezas\n{ffffff}Pulsa {"#BLUE_COLOR"}'H' {FFFFFF}para tomar una caja\nPiezas en la caja: {"#ORANGE_COLOR"}%d", MECHANIC_STOCK_PIECES);
		MechanicPiecesForkliftLabel[i] = CreateDynamic3DTextLabel(str_text, 0xFFFFFFFF, MechanicPiecesForklift[i][0], MechanicPiecesForklift[i][1], MechanicPiecesForklift[i][2], 5.0, .testlos = true, .interiorid = 0);
	}

	CreateDynamic3DTextLabel("Encargo de Piezas\nPulsa {"#PRIMARY_COLOR"}'H'{ffffff} para obtener un encargo de piezas", -1, Mechanic_Pieces_Start_Work[0], Mechanic_Pieces_Start_Work[1], Mechanic_Pieces_Start_Work[2], 15.0, .testlos = true);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_CROUCH)
	{
		Loop(i, sizeof(MechanicPiecesForklift), 0)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, MechanicPiecesForklift[i][0], MechanicPiecesForklift[i][1], MechanicPiecesForklift[i][2]))
			{
				if(GetPlayerWork(playerid, WORK_MECHANIC))
				{
					if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
					new vehicleid = GetPlayerVehicleID(playerid);
					if(!IsVehicleForkLift(vehicleid)) return 1;
					if(MECHANIC_STOCK_PIECES <= 0) return 1;
					if(MechanicForkLiftPieces[vehicleid] >= 100) return 1;

					MechanicForkLiftPieces[vehicleid] += 100;
					MECHANIC_STOCK_PIECES -= 100;
					UpdateCrateMechanicPieces();

					SetMechanicCrate(vehicleid);
					SendMessage(playerid, "Lleva las piezas dentro del taller.");
				}
				return Y_HOOKS_BREAK_RETURN_1;
			}
		}

		Loop(i, sizeof(MechanicGaragePieces), 0)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, MechanicGaragePieces[i][0], MechanicGaragePieces[i][1], MechanicGaragePieces[i][2]))
			{
				if(GetPlayerWork(playerid, WORK_MECHANIC))
				{
					if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
					new vehicleid = GetPlayerVehicleID(playerid);
					if(!IsVehicleForkLift(vehicleid)) return 1;
					if(MechanicForkLiftPieces[vehicleid] <= 0) return 1;

					MechanicForkLiftPieces[vehicleid] -= 100;
					if(MechanicForkLiftPieces[vehicleid] <= 0) RemoveMechanicCrate(vehicleid);

					MECHANIC_GARAGE_PIECES += 100;
					UpdateMechanicPieces();

					SendMessage(playerid, "Bien hecho, has ganado 100$.");
					GivePlayerCash(playerid, 100, true, false);
				}
				return Y_HOOKS_BREAK_RETURN_1;
			}
		}

		if(IsPlayerInRangeOfPoint(playerid, 15.0, Mechanic_Pieces_Start_Work[0], Mechanic_Pieces_Start_Work[1], Mechanic_Pieces_Start_Work[2]))
		{
            if(GetPlayerWork(playerid, WORK_TRAILER) || GetPlayerWork(playerid, WORK_MECHANIC))
			{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;

				new modelid = 435;

				new vehicleid = GetPlayerVehicleID(playerid);
				if(!IsVehicleTrailer_Truck(vehicleid)) return SendMessage(playerid, "Necesitas una gandola.");
				if(TrailerVehicle(vehicleid)[trailer_TRAILER] != -1) return SendMessage(playerid, "Ya tienes un trailer.");

				new trailer_id = CreateVehicle(
						modelid, 
						Mechanic_Pieces_Trailer[0], 
						Mechanic_Pieces_Trailer[1], 
						Mechanic_Pieces_Trailer[2], 
						Mechanic_Pieces_Trailer[3], 
						1, 1, 
						-1, false
					);
				
				gVehicle(trailer_id)[gb_vehicle_VALID] = true;
				gVehicle(trailer_id)[gb_vehicle_TYPE] = VEHICLE_TYPE_WORK;
				gVehicle(trailer_id)[gb_vehicle_MODELID] = modelid;
				format(gVehicle(trailer_id)[gb_vehicle_NUMBER_PLATE], 32, "%c%c%c-%04d", getRandomLetter(), getRandomLetter(), getRandomLetter(), random(9999));
				gVehicle(trailer_id)[gb_vehicle_SPAWN_X] = Mechanic_Pieces_Trailer[0];
				gVehicle(trailer_id)[gb_vehicle_SPAWN_Y] = Mechanic_Pieces_Trailer[1];
				gVehicle(trailer_id)[gb_vehicle_SPAWN_Z] = Mechanic_Pieces_Trailer[2];
				gVehicle(trailer_id)[gb_vehicle_SPAWN_ANGLE] = Mechanic_Pieces_Trailer[3];
				
				gVehicle(trailer_id)[gb_vehicle_POS][0] = gVehicle(trailer_id)[gb_vehicle_SPAWN_X];
				gVehicle(trailer_id)[gb_vehicle_POS][1] = gVehicle(trailer_id)[gb_vehicle_SPAWN_Y];
				gVehicle(trailer_id)[gb_vehicle_POS][2] = gVehicle(trailer_id)[gb_vehicle_SPAWN_Z];
				
				gVehicle(trailer_id)[gb_vehicle_HEALTH] = 1000.0;
				gVehicle(trailer_id)[gb_vehicle_DAMAGE_PANELS] = 0;
				gVehicle(trailer_id)[gb_vehicle_DAMAGE_DOORS] = 0;
				gVehicle(trailer_id)[gb_vehicle_DAMAGE_LIGHTS] = 0;
				gVehicle(trailer_id)[gb_vehicle_DAMAGE_TIRES] = 0;
				gVehicle(trailer_id)[gb_vehicle_COLOR_1] = 1;
				gVehicle(trailer_id)[gb_vehicle_COLOR_2] = 1;
				gVehicle(trailer_id)[gb_vehicle_PAINTJOB] = 3; // No paintjob
				gVehicle(trailer_id)[gb_vehicle_MAX_GAS] = VEHICLE_INFO[modelid - 400][vehicle_info_MAX_GAS];
				gVehicle(trailer_id)[gb_vehicle_GAS] = gVehicle(trailer_id)[gb_vehicle_MAX_GAS];
				gVehicle(trailer_id)[gb_vehicle_STATE] = VEHICLE_STATE_NORMAL;
				gVehicle(trailer_id)[gb_vehicle_INTERIOR] = 0;
				gVehicle(trailer_id)[gb_vehicle_WORLD] = 0;

				WORK_VEHICLES[trailer_id][work_vehicle_VALID] = true;
				WORK_VEHICLES[trailer_id][work_vehicle_WORK] = WORK_MECHANIC;
				WORK_VEHICLES[trailer_id][work_vehicle_EXP] = 0;
				WORK_VEHICLES[trailer_id][work_vehicle_NEED_DUTY] = work_info[ WORK_VEHICLES[trailer_id][work_vehicle_WORK] ][work_info_NEED_DUTY];

				SetVehicleVirtualWorldEx(trailer_id, 0);
				SetVehicleToRespawnEx(trailer_id);

				SetVehiclePosEx(vehicleid, Mechanic_Pieces_Truck[0], Mechanic_Pieces_Truck[1], Mechanic_Pieces_Truck[2]);
				SetVehicleZAngle(vehicleid, Mechanic_Pieces_Truck[3]);

				GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE] = 0;
				UpdateVehicleParams(vehicleid);

				SetTimerEx("AttachMechanicTrailerToTruck", 500, false, "iii", playerid, vehicleid, trailer_id);
			}
			else SendMessage(playerid, "Necesitas ser mecanico o gandolero para poder hacer encargos.");
			return Y_HOOKS_BREAK_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

callbackp:AttachMechanicTrailerToTruck(playerid, vehicleid, trailerid)
{
    TrailerVehicle(vehicleid)[trailer_TRAILER] = trailerid;
    AttachTrailerToVehicleEx(trailerid, vehicleid);

    TrailerVehicle(vehicleid)[trailer_LOADING] = true;
    TrailerVehicle(vehicleid)[trailer_DRIVER] = PI[playerid][pi_ID];
                                
    SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
                                    
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE] = 0;
    UpdateVehicleParams(vehicleid);

    TrailerVehicle(vehicleid)[trailer_DELIVERED] = false;

    new index = random(sizeof(Mechanic_Pieces_Routes));
    TrailerVehicle(vehicleid)[trailer_ROUTE] = index;

    PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][0], "");
    PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][0]);
    PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][1]);
    PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][2]);
    PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][3]);

    PlayerTemp[playerid][pt_TRUCK_LOADING_VALUE] = 35.0;
    UpdatePlayerLoadingTruckSize(playerid);
    KillTimer(PlayerTemp[playerid][pt_TIMERS][7]);
    KillTimer(PlayerTemp[playerid][pt_TIMERS][9]);
    PlayerTemp[playerid][pt_TIMERS][9] = SetTimerEx("MechanicTrailerLoadUp", 1000, false, "ii", playerid, vehicleid);

    SendInfoMessage(playerid, "Aviso~n~~n~La gandola se está preparando, si sales de élla se cancelará el viaje.~n~~n~");
    return 1;
}

forward MechanicTrailerLoadUp(playerid, vehicleid);
public MechanicTrailerLoadUp(playerid, vehicleid)
{
	if(pTemp(playerid)[pt_TRUCK_LOADING_VALUE] < 100.0)
	{
		pTemp(playerid)[pt_TRUCK_LOADING_VALUE] += 10.0;
		if(pTemp(playerid)[pt_TRUCK_LOADING_VALUE] > 100.0) pTemp(playerid)[pt_TRUCK_LOADING_VALUE] = 100.0;
		
		GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE] = 0;
		UpdateVehicleParams(vehicleid);

		UpdatePlayerLoadingTruckSize(playerid);
		KillTimer(pTemp(playerid)[pt_TIMERS][9]);
		pTemp(playerid)[pt_TIMERS][9] = SetTimerEx("MechanicTrailerLoadUp", 1000, false, "ii", playerid, vehicleid);
		return 1;
	}
	
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][0]);
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][1]);
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][2]);
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][3]);
	
	GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE] = 1;
	UpdateVehicleParams(vehicleid);
	
	TrailerVehicle(vehicleid)[trailer_LOADED] = true;
	TrailerVehicle(vehicleid)[trailer_LOADING] = false;
	TrailerVehicle(vehicleid)[trailer_DELIVERED] = false;
	
	SendInfoMessage(playerid, "Encargo de Piezas~n~~n~El trailer ha sido preparado, ve al ~r~punto de carga~w~ para recoger las piezas.~n~~n~");
	SetPlayerMechanicTrailerCP(playerid, vehicleid);
	return 1;
}

forward MechanicTrailerUnLoadUp(playerid, vehicleid);
public MechanicTrailerUnLoadUp(playerid, vehicleid)
{
	if(pTemp(playerid)[pt_TRUCK_LOADING_VALUE] < 100.0)
	{
		pTemp(playerid)[pt_TRUCK_LOADING_VALUE] += 10.0;
		if(pTemp(playerid)[pt_TRUCK_LOADING_VALUE] > 100.0) pTemp(playerid)[pt_TRUCK_LOADING_VALUE] = 100.0;
		
		UpdatePlayerLoadingTruckSize(playerid);
		KillTimer(pTemp(playerid)[pt_TIMERS][9]);
		pTemp(playerid)[pt_TIMERS][9] = SetTimerEx("MechanicTrailerUnLoadUp", 1000, false, "ii", playerid, vehicleid);
		return 1;
	}
	
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][0]);
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][1]);
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][2]);
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][3]);
	
	GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE] = 1;
	UpdateVehicleParams(vehicleid);
	
	TrailerVehicle(vehicleid)[trailer_UNLOADING] = false;
	TrailerVehicle(vehicleid)[trailer_DELIVERED] = true;
	
	SendInfoMessagef(playerid, "Encargo de Piezas~n~~n~La mercancia ha sido recogida, ve al ~r~Taller mecanico~w~ para finalizar y recibir tu paga.~n~~n~");
	SetPlayerMechanicTrailerCP(playerid, vehicleid);
	return 1;
}

hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	new info[1];
	Streamer_GetArrayData(STREAMER_TYPE_CP, checkpointid, E_STREAMER_EXTRA_ID, info);

	switch(info[0])
    {
        case CHECKPOINT_TYPE_MECHANIC:
        {
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
			if(GetPlayerWork(playerid, WORK_TRAILER) || GetPlayerWork(playerid, WORK_MECHANIC))
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetTrailerDriver(vehicleid) != PI[playerid][pi_ID]) return 1;
				if(TrailerVehicle(vehicleid)[trailer_DELIVERED]) return 1;
				if(!GetTrailerInfoLoaded(vehicleid)) return 1;
				if(GetTrailerInfoUnLoading(vehicleid)) return 1;
				if(GetTrailerInfoLoading(vehicleid)) return 1;

				new trailerid = GetVehicleTrailer(vehicleid);
				if(!IsTrailerAttachedToVehicle(vehicleid)) return 1;
				if(TrailerVehicle(vehicleid)[trailer_TRAILER] != trailerid) return 1;

				if(gVehicle(trailerid)[gb_vehicle_TYPE] != VEHICLE_TYPE_WORK) return 1;
				if(GetVehicleWork(trailerid) != WORK_MECHANIC) return 1;
				
				DestroyDynamicCP(pTemp(playerid)[pt_TRAILER_CHECKPOINT]);
				pTemp(playerid)[pt_TRAILER_CHECKPOINT] = INVALID_STREAMER_ID;
				
				SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);

				gVehicle(vehicleid)[gb_vehicle_PARAMS_ENGINE] = 0;
				UpdateVehicleParams(vehicleid);
				
				TrailerVehicle(vehicleid)[trailer_UNLOADING] = true;
				PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][0], "");
				PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][0]);
				PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][1]);
				PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][2]);
				PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][3]);
					
				pTemp(playerid)[pt_TRUCK_LOADING_VALUE] = 40.0;
				UpdatePlayerLoadingTruckSize(playerid);
				KillTimer(pTemp(playerid)[pt_TIMERS][7]);
				KillTimer(pTemp(playerid)[pt_TIMERS][9]);
				pTemp(playerid)[pt_TIMERS][9] = SetTimerEx("MechanicTrailerUnLoadUp", 1000, false, "ii", playerid, vehicleid);
				return 1;
			}
            return Y_HOOKS_BREAK_RETURN_1;
        }
        case CHECKPOINT_TYPE_FINISH_MECHANIC:
        {
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
			if(GetPlayerWork(playerid, WORK_TRAILER) || GetPlayerWork(playerid, WORK_MECHANIC))
			{
				new vehicleid = GetPlayerVehicleID(playerid);

				if(GetTrailerDriver(vehicleid) != PI[playerid][pi_ID]) return 1;
				if(!TrailerVehicle(vehicleid)[trailer_DELIVERED]) return 1;
				if(!GetTrailerInfoLoaded(vehicleid)) return 1;
				if(GetTrailerInfoUnLoading(vehicleid)) return 1;
				if(GetTrailerInfoLoading(vehicleid)) return 1;

				new trailerid = GetVehicleTrailer(vehicleid);
				if(gVehicle(trailerid)[gb_vehicle_TYPE] != VEHICLE_TYPE_WORK) return 1;
				if(GetVehicleWork(trailerid) != WORK_MECHANIC) return 1;

				if(!IsTrailerAttachedToVehicle(vehicleid)) return 1;
				if(TrailerVehicle(vehicleid)[trailer_TRAILER] != trailerid) return 1;
				
				DestroyDynamicCP(pTemp(playerid)[pt_TRAILER_CHECKPOINT]);
				pTemp(playerid)[pt_TRAILER_CHECKPOINT] = INVALID_STREAMER_ID;
				
				SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);

				ClearTrailerInfo(trailerid);
				DestroyVehicleEx(trailerid);

				TrailerVehicle(vehicleid)[trailer_TRAILER] = -1;
				TrailerVehicle(vehicleid)[trailer_DELIVERED] = false;
				TrailerVehicle(vehicleid)[trailer_ROUTE] = -1;

				new payment = 6500;
				MECHANIC_STOCK_PIECES += 300;
				UpdateCrateMechanicPieces();
				
				if(GetVehicleWork(vehicleid) == WORK_TRAILER)
				{
					if(IsRentedTrailer(vehicleid))
					{
						if(IsVehicleTrailer_Truck(vehicleid))
						{
							new rent_payment = minrand(500, 700);
							SendInfoMessagef(playerid, "Aviso~n~~n~Se te ha descontado ~r~%s$~w~ por la renta de la gandola.~n~~n~", number_format_thousand(rent_payment));
							payment -= rent_payment;
						}
					}
				}

				if(GetVehicleWork(vehicleid) == WORK_MECHANIC)
				{
					if(IsVehicleTrailer_Truck(vehicleid))
					{
						ClearTrailerInfo(vehicleid);
						SetVehicleToRespawnEx(vehicleid);
					}
				}

				if(GivePlayerCash(playerid, payment, true, false)) 
				{
					if(GetPlayerWork(playerid, WORK_TRAILER))
					{
						SendInfoMessagef(playerid, "Gandolero~n~~n~~g~+~y~1~w~ de Experiencia~n~~n~");
						PLAYER_WORKS[playerid][WORK_TRAILER][pwork_LEVEL] ++;
					}

					new string[64];
					format(string, sizeof string, "+%s$", number_format_thousand(payment));
					GameTextForPlayer(playerid, string, 5000, 1);
				}

				return 1;
			}
            return Y_HOOKS_BREAK_RETURN_1;
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new Float:sx, Float:sy, Float:sz;
	GetPlayerPos(playerid, sx, sy, sz);

	if(!ispassenger)
	{
		if(GetVehicleWork(vehicleid) == WORK_MECHANIC || GetVehicleWork(vehicleid) == WORK_TRAILER)
		{
			if(IsVehicleTrailer_Truck(vehicleid))
			{
				if(TrailerVehicle(vehicleid)[trailer_DRIVER] != 0 && TrailerVehicle(vehicleid)[trailer_DRIVER] != PI[playerid][pi_ID])
				{
					SendMessagef(playerid, "No eres el conductor de esta gandola.");
					RemovePlayerFromVehicle(playerid);
					SetPlayerPos(playerid, sx, sy, sz);
					return Y_HOOKS_BREAK_RETURN_1;
				}
			}
		}
	}

	return Y_HOOKS_CONTINUE_RETURN_1;
}