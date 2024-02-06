#include <YSI-Includes\YSI\y_hooks>

#define MAX_TRAILER_ROUTES          100

#define TrailerVehicle(%0)[%1]      TRAILER_VEHICLE[%0][%1]

enum e_TRAILER_INFO
{
    bool:trailer_VALID,
    bool:trailer_LOADED,
    bool:trailer_UNLOADING,
    bool:trailer_LOADING,
    bool:trailer_DELIVERED,
    trailer_ROUTE,
    trailer_DRIVER,
    trailer_TRAILER,
    bool:trailer_RENT
}
new TRAILER_VEHICLE[MAX_VEHICLES][e_TRAILER_INFO];

new Float:Trailer_Exit_Pos[] = {1094.5790, 1231.9805, 11.4768, 1.6755};
new Float:Truck_Exit_Pos[] = {1094.6788, 1242.6011, 11.8395, 0.5843};
new Float:Trailer_StartJob_Pos[] = {1094.7360, 1239.2645, 10.8203};
new Random_Trailer_ModelID[] = {435, 450, 584, 591};

/*enum E_TRAILER_ROUTES
{
    bool:route_VALID,
    route_PAYMENT,
    Float:route_X,
    Float:route_Y,
    Float:route_Z,
    Float:route_ANGLE
};*/
new Float:Trailer_Routes[][] = 
{
    {558.4927, 1679.2808, 8.0128, 122.5777}, //Trailero 1
    {827.8138, 881.7650, 14.3430, 21.1239}, //Trailero 2
    {2850.3525, 908.9291, 11.7713, 270.7846}, //Trailero 3
    {2890.7815, 2389.9792, 11.8417, 0.4900}, //Trailero 4
    {2249.2656, 2749.4431, 11.8354, 359.4870}, //Trailero 5
    {2126.3796, 2720.2888, 11.8393, 179.7311}, //Trailero 6
    {1362.7999, 2663.8103, 11.8392, 271.8498}, //Trailero 7
    {-274.3815, 2729.2820, 63.4319, 267.6748}, //Trailero 8
    {1610.4584, 1313.9775, 11.8470, 178.7200}, //Trailero 9
    {1645.5739, 1608.5126, 11.8432, 268.9828}, //Trailero 10
    {2615.0969, 1667.1990, 11.8318, 269.9151}, //Trailero 11
    {2549.2593, 1807.7865, 11.8388, 89.4350}, //Trailero 12
    {2724.6189, 844.2164, 11.7690, 180.5505}, //Trailero 13
    {1880.7380, 2244.4578, 11.8386, 88.2979}, //Trailero 14
    {2042.7708, 2226.7466, 11.8402, 181.2429}, //Trailero 15
    {2279.2534, -81.8274, 27.5412, 177.5374}, //Trailero 16
    {2437.2944, 114.2882, 27.4920, 90.4098}, //Trailero 17
    {1367.7606, 461.8178, 20.9980, 65.0816}, //Trailero 18
    {1209.7925, 191.2797, 21.2085, 336.6670}, //Trailero 19
    {1307.6132, 375.6104, 20.4282, 67.1695}, //Trailero 20
    {152.9368, -68.8402, 2.4487, 90.7148}, //Trailero 21
    {88.8455, -204.2908, 2.6110, 87.8179}, //Trailero 22
    {44.3642, -241.6651, 2.6803, 175.8287}, //Trailero 23
    {-69.2813, -35.4487, 4.1362, 341.2289}, //Trailero 24
    {-96.8090, -386.2839, 2.4490, 263.2885}, //Trailero 25
    {163.3313, -287.4623, 2.5958, 65.2118}, //Trailero 26
    {313.1518, -239.6511, 2.5935, 178.3203}, //Trailero 27
    {326.3068, -39.6793, 2.5690, 0.7595}, //Trailero 28
    {-2093.0825, -2243.2732, 31.8301, 321.6132}, //Trailero 29
    {-2135.9666, -2257.6240, 31.6513, 52.5531}, //Trailero 30
    {-2195.7971, -2435.7605, 31.6449, 231.5589}, //Trailero 31
    {-2118.3584, -2497.0642, 31.6441, 231.6839}, //Trailero 32
    {-1922.8378, -2454.3760, 31.7175, 316.5790}, //Trailero 33
    {-1551.8149, -2766.1025, 49.5532, 236.5401}, //Trailero 34
    {-2105.9285, 208.1850, 36.2788, 89.7496}, //Trailero 35
    {-2308.8091, -89.2265, 36.3376, 359.9427}, //Trailero 36
    {-1730.9799, 121.4336, 4.5718, 1.3455}, //Trailero 37
    {-1843.6483, 170.9646, 16.1343, 90.1068}, //Trailero 38
    {-1669.5988, 404.9354, 8.1920, 315.3907}, //Trailero 39
    {-1865.7761, 1412.2562, 8.1620, 49.0574}, //Trailero 40
    {-2642.6821, 1340.4335, 8.1782, 179.8738}, //Trailero 41
    {-2430.8176, 2313.5654, 6.0011, 359.9703}, //Trailero 42
    {-2295.5571, 2410.5942, 5.9305, 44.0802}, //Trailero 43
    {-857.4033, 1556.0908, 24.9709, 180.5035}, //Trailero 44
    {-796.3324, 1617.3398, 28.1337, 85.1608}, //Trailero 45
    {-1471.2135, 1854.7775, 33.6935, 95.7032}, //Trailero 46
    {-1927.7935, 2384.6877, 50.5107, 21.6168}, //Trailero 47
    {1444.5186, 992.1268, 11.8393, 269.6013}, //Trailero 48
    {1444.7036, 1107.3566, 11.8412, 89.8653}, //Trailero 49
    {1298.7842, 1104.6729, 11.8285, 179.7289}, //Trailero 50
    {2751.0627, -2479.7747, 14.6688, 180.4993}, //Trailero 51
    {2620.0862, -2448.0486, 14.6542, 90.2243}, //Trailero 52
    {2692.0007, -2452.2864, 14.6566, 180.0571}, //Trailero 53
    {2455.8506, -2544.3706, 14.6748, 179.4531}, //Trailero 54
    {2299.7256, -2383.6880, 14.5659, 313.7910}, //Trailero 55
    {1923.3036, -1791.2782, 14.4037, 89.6247}, //Trailero 56
    {1776.2915, -2033.5527, 14.5290, 180.8559}, //Trailero 57
    {1699.1205, -1519.9158, 14.4059, 180.9468}, //Trailero 58
    {1601.4895, -1551.4532, 14.6035, 90.3844}, //Trailero 59
    {1480.5985, -1497.3898, 14.5694, 90.5657}, //Trailero 60
    {994.1107, -1365.0601, 14.3543, 359.2578}, //Trailero 61
    {808.2496, -608.0873, 17.3560, 270.4110}, //Trailero 62
    {658.9498, -559.1866, 17.3460, 359.3984}, //Trailero 63
    {1129.8074, -1207.6315, 19.2264, 271.1347}, //Trailero 64
    {1142.0723, -1342.5970, 14.6779, 179.9607}, //Trailero 65
    {598.9575, -1508.8009, 16.1087, 90.6074}, //Trailero 66
    {2475.1448, -1783.7399, 14.5796, 269.9936}, //Trailero 67
    {2331.9531, -2096.9490, 14.5660, 89.4502}, //Trailero 68
    {1931.2935, -2105.1753, 14.5935, 90.2296}, //Trailero 69
    {1338.0511, -885.1326, 39.4267, 359.8221}, //Trailero 70
    {403.8020, -1309.4276, 15.9160, 30.1343}, //Trailero 71
    {2170.5122, -2653.0955, 14.5659, 89.9862}, //Trailero 72
    {2513.8889, -2434.4111, 14.6308, 224.8943}, //Trailero 73
    {2679.2856, -2531.1782, 14.3743, 178.7513}, //Trailero 74
    {-1041.4867, -1182.8142, 129.9834, 1.3370}, //Trailero 75
    {-571.7838, -533.0566, 26.5615, 178.3518}, //Trailero 76
    {-99.3453, -1165.3184, 3.4665, 155.0169}, //Trailero 77
    {2147.4160, -1177.9784, 24.8444, 180.8930}, //Trailero 78
    {2036.7620, -1939.7360, 14.3525, 269.6179}, //Trailero 79
    {2347.8213, -2001.9399, 14.4964, 177.4007}, //Trailero 80
    {1594.1896, 2187.6416, 11.8384, 270.5564}, //Trailero 81
    {1670.2050, 2211.2637, 11.8324, 359.4204}, //Trailero 82
    {2204.9077, 2014.6293, 11.8338, 271.4988}, //Trailero 83
    {2371.7708, 2547.9844, 11.8326, 0.0054}, //Trailero 84
    {1514.9182, 2370.2405, 11.8421, 271.3715}, //Trailero 85
    {1745.4080, 2220.5374, 11.8282, 341.2933}, //Trailero 86
    {2557.1677, 1047.1879, 11.8341, 179.1602}, //Trailero 87
    {2402.7727, 1032.2003, 11.8311, 91.8528}, //Trailero 88
    {1979.4930, 2454.7139, 11.8327, 357.3623}, //Trailero 89
    {-546.7468, -86.6275, 64.4183, 83.0518}, //Trailero 90
    {636.0937, 1210.4792, 12.7355, 274.7817}, //Trailero 91
    {275.4961, 1355.5228, 11.6055, 178.5724}, //Trailero 92
    {-2856.3665, 1034.6874, 36.8642, 203.6275}, //Trailero 93
    {-2710.8804, 1332.8617, 8.0966, 0.2496}, //Trailero 94
    {-1640.2147, 1193.6373, 8.0963, 269.7488}, //Trailero 95
    {-2032.0089, 386.8932, 36.1949, 269.7305}, //Trailero 96
    {-2018.3187, 157.0018, 29.1167, 180.1446}, //Trailero 97
    {-2070.5310, 12.1418, 36.3300, 91.4882}, //Trailero 98
    {-2131.4089, -246.8278, 36.3354, 181.1541}, //Trailero 99
    {237.2796, -239.6378, 2.5223, 0.0157} //Trailero 100
};

stock ClearTrailerInfo(vehicleid)
{
    static const tmp_TRAILER[e_TRAILER_INFO]; TRAILER_VEHICLE[vehicleid] = tmp_TRAILER;
    return 1;
}

stock IsVehicleTrailer_Truck(vehicleid)
{
    if(GetVehicleModel(vehicleid) == 403) return 1;
    else if(GetVehicleModel(vehicleid) == 514) return 1;
    else if(GetVehicleModel(vehicleid) == 515) return 1;
    return 0;
}

stock SetTrailerRentInfo(vehicleid)
{
    if(vehicleid == INVALID_VEHICLE_ID) return 1;
    if(!IsVehicleTrailer_Truck(vehicleid)) return 1;
    if(GetVehicleWork(vehicleid) != WORK_TRAILER) return 1;
    if(!IsValidWorkVehicle(vehicleid)) return 1;
    if(IsValidTrailerVehicle(vehicleid)) return 1;
    if(GetTrailerDriver(vehicleid)) return 1;
    if(IsRentedTrailer(vehicleid)) return 1;

    gVehicle(vehicleid)[gb_vehicle_LABEL] = CreateDynamic3DTextLabel("{"#PRIMARY_COLOR"}RENTA\nEste trailer esta disponible para la renta\nSubete para mas informacion.", -1, 0.0, 0.0, 0.5, 15.0, .attachedvehicle = vehicleid);
    return 1;
}

stock LoadTrailer(vehicleid, playerid)
{
    TrailerVehicle(vehicleid)[trailer_LOADING] = true;
    TrailerVehicle(vehicleid)[trailer_DRIVER] = PI[playerid][pi_ID];
                                
    SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
                                    
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE] = 0;
    UpdateVehicleParams(vehicleid);

    TrailerVehicle(vehicleid)[trailer_DELIVERED] = false;

    new index = random(sizeof(Trailer_Routes));
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
    PlayerTemp[playerid][pt_TIMERS][9] = SetTimerEx("TrailerLoadUp", 1000, false, "ii", playerid, vehicleid);

    SendInfoMessage(playerid, "Aviso~n~~n~el trailer se está preparando, si sales de élla se cancelará el viaje.~n~~n~");
    return 1;
}

SetPlayerTrailerCheckpoint(playerid, vehicleid)
{
	if(IsValidDynamicCP(pTemp(playerid)[pt_TRAILER_CHECKPOINT]))
	{
		DestroyDynamicCP(pTemp(playerid)[pt_TRAILER_CHECKPOINT]);
		pTemp(playerid)[pt_TRAILER_CHECKPOINT] = INVALID_STREAMER_ID;
	}

	if(TrailerVehicle(vehicleid)[trailer_DELIVERED])
	{
		pTemp(playerid)[pt_TRAILER_CHECKPOINT] = CreateDynamicCP(Trailer_StartJob_Pos[0], Trailer_StartJob_Pos[1], Trailer_StartJob_Pos[2], 5.0, 0, 0, playerid, 9999999999.0);
		
		new info[1];
		info[0] = CHECKPOINT_TYPE_FINISH_TRAILER;
		Streamer_SetArrayData(STREAMER_TYPE_CP, pTemp(playerid)[pt_TRAILER_CHECKPOINT], E_STREAMER_EXTRA_ID, info);
	}
	else
	{
		pTemp(playerid)[pt_TRAILER_CHECKPOINT] = CreateDynamicCP(Trailer_Routes[ TrailerVehicle(vehicleid)[trailer_ROUTE] ][0], Trailer_Routes[ TrailerVehicle(vehicleid)[trailer_ROUTE] ][1], Trailer_Routes[ TrailerVehicle(vehicleid)[trailer_ROUTE] ][2], 5.0, 0, 0, playerid, 9999999999.0);
		
		new info[1];
		info[0] = CHECKPOINT_TYPE_TRAILER;
		Streamer_SetArrayData(STREAMER_TYPE_CP, pTemp(playerid)[pt_TRAILER_CHECKPOINT], E_STREAMER_EXTRA_ID, info);
	}
	Streamer_Update(playerid, STREAMER_TYPE_CP);
	return 1;
}

stock IsValidTrailerVehicle(vehicleid)
{
    return TrailerVehicle(vehicleid)[trailer_VALID];
}

stock GetTrailerDriver(vehicleid)
{
    return TrailerVehicle(vehicleid)[trailer_DRIVER];
}

stock IsRentedTrailer(vehicleid)
{
    return TrailerVehicle(vehicleid)[trailer_RENT];
}

stock GetTrailerInfoLoaded(vehicleid)
{
    return TrailerVehicle(vehicleid)[trailer_LOADED];
}

stock GetTrailerInfoUnLoading(vehicleid)
{
    return TrailerVehicle(vehicleid)[trailer_UNLOADING];
}

stock GetTrailerInfoLoading(vehicleid)
{
    return TrailerVehicle(vehicleid)[trailer_LOADING];
}

stock SetTrailerInfoUnLoading(vehicleid, bool:set)
{
    TrailerVehicle(vehicleid)[trailer_UNLOADING] = set;
}

stock SetTrailerInfoLoading(vehicleid, bool:set)
{
    TrailerVehicle(vehicleid)[trailer_LOADING] = set;
}

stock GetTrailerTrailer(vehicleid)
{
    return TrailerVehicle(vehicleid)[trailer_TRAILER];
}

stock SetTrailerInfo(vehicleid, set)
{
    TrailerVehicle(vehicleid)[trailer_TRAILER] = set;
}

stock AttachTrailerToVehicleEx(trailerid, vehicleid)
{
    gVehicle(trailerid)[gb_vehicle_ATTACHED_TO] = vehicleid;
    AttachTrailerToVehicle(trailerid, vehicleid);
    return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
    if(IsVehicleTrailer_Truck(vehicleid))
    {
        if(GetVehicleWork(vehicleid) == WORK_TRAILER)
        {
            if(!IsRentedTrailer(vehicleid))
            {
                SetVehicleToRespawnEx(vehicleid);
            }
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	new info[1];
	Streamer_GetArrayData(STREAMER_TYPE_CP, checkpointid, E_STREAMER_EXTRA_ID, info);

	switch(info[0])
    {
        case CHECKPOINT_TYPE_TRAILER:
        {
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
			if(!GetPlayerWork(playerid, WORK_TRAILER)) return 1;
	
			new vehicleid = GetPlayerVehicleID(playerid);

			if(!GetTrailerInfoLoaded(vehicleid)) return 1;
			if(GetTrailerInfoUnLoading(vehicleid)) return 1;
            if(GetTrailerInfoLoading(vehicleid)) return 1;

			if(GetTrailerDriver(vehicleid) != PI[playerid][pi_ID]) return 1;
            if(TrailerVehicle(vehicleid)[trailer_DELIVERED]) return 1;

            new trailerid = GetVehicleTrailer(vehicleid);
            if(!IsTrailerAttachedToVehicle(vehicleid)) return 1;
            if(TrailerVehicle(vehicleid)[trailer_TRAILER] != trailerid) return 1;

            if(gVehicle(trailerid)[gb_vehicle_TYPE] != VEHICLE_TYPE_WORK) return 1;
            if(GetVehicleWork(trailerid) != WORK_TRAILER) return 1;
			
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
			pTemp(playerid)[pt_TIMERS][9] = SetTimerEx("TrailerUnLoadUp", 1000, false, "ii", playerid, vehicleid);
            return Y_HOOKS_BREAK_RETURN_1;
        }
        case CHECKPOINT_TYPE_FINISH_TRAILER:
        {
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
			if(!GetPlayerWork(playerid, WORK_TRAILER)) return 1;
	
			new vehicleid = GetPlayerVehicleID(playerid);

			if(!GetTrailerInfoLoaded(vehicleid)) return 1;
			if(GetTrailerInfoUnLoading(vehicleid)) return 1;
            if(GetTrailerInfoLoading(vehicleid)) return 1;

			if(GetTrailerDriver(vehicleid) != PI[playerid][pi_ID]) return 1;
            if(!TrailerVehicle(vehicleid)[trailer_DELIVERED]) return 1;

            new trailerid = GetVehicleTrailer(vehicleid);
			if(gVehicle(trailerid)[gb_vehicle_TYPE] != VEHICLE_TYPE_WORK) return 1;
			if(GetVehicleWork(trailerid) != WORK_TRAILER) return 1;

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
			
			new work_extra_payment;
			if(work_info[WORK_TRAILER][work_info_EXTRA_PAY] > 0 && work_info[WORK_TRAILER][work_info_EXTRA_PAY_EXP] > 0)
			{
				work_extra_payment = (work_info[WORK_TRAILER][work_info_EXTRA_PAY] * floatround(floatdiv(PLAYER_WORKS[playerid][WORK_TRAILER][pwork_LEVEL], work_info[WORK_TRAILER][work_info_EXTRA_PAY_EXP])));
				if(work_info[WORK_TRAILER][work_info_EXTRA_PAY_LIMIT] != 0) if(work_extra_payment > work_info[WORK_TRAILER][work_info_EXTRA_PAY_LIMIT]) work_extra_payment = work_info[WORK_TRAILER][work_info_EXTRA_PAY_LIMIT];
			
				if(PI[playerid][pi_VIP]) work_extra_payment += VIP_WORK_EXTRA_PAY;
			}

            new payment = 5700 + work_extra_payment;
            
            if(GetVehicleWork(vehicleid) == WORK_TRAILER)
            {
                if(IsRentedTrailer(vehicleid))
                {
                    if(IsVehicleTrailer_Truck(vehicleid))
                    {
                        new rent_payment = minrand(500, 700);
                        SendInfoMessagef(playerid, "Aviso~n~~n~Se te ha descontado ~r~%s$~w~ por la renta de este trailer.~n~~n~", number_format_thousand(rent_payment));
                        payment -= rent_payment;
                    }
                }
            }

			if(GivePlayerCash(playerid, payment, true, false)) 
			{
                SendInfoMessagef(playerid, "Trailero~n~~n~~g~+~y~1~w~ de Experiencia~n~~n~");
				PLAYER_WORKS[playerid][WORK_TRAILER][pwork_LEVEL] ++;

				new string[64];
				format(string, sizeof string, "+%s$", number_format_thousand(payment));
				GameTextForPlayer(playerid, string, 5000, 1);
			}
            return Y_HOOKS_BREAK_RETURN_1;
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

forward TrailerLoadUp(playerid, vehicleid);
public TrailerLoadUp(playerid, vehicleid)
{
	if(pTemp(playerid)[pt_TRUCK_LOADING_VALUE] < 100.0)
	{
		pTemp(playerid)[pt_TRUCK_LOADING_VALUE] += 10.0;
		if(pTemp(playerid)[pt_TRUCK_LOADING_VALUE] > 100.0) pTemp(playerid)[pt_TRUCK_LOADING_VALUE] = 100.0;
		
		UpdatePlayerLoadingTruckSize(playerid);
		KillTimer(pTemp(playerid)[pt_TIMERS][9]);
		pTemp(playerid)[pt_TIMERS][9] = SetTimerEx("TrailerLoadUp", 1000, false, "ii", playerid, vehicleid);
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
	
	SendInfoMessage(playerid, "Trailero~n~~n~La mercancia ha sido cargada, ve al ~r~punto de entrega~w~ para entregar la mercancia.~n~~n~");
	SetPlayerTrailerCheckpoint(playerid, vehicleid);
	return 1;
}

forward TrailerUnLoadUp(playerid, vehicleid);
public TrailerUnLoadUp(playerid, vehicleid)
{
	if(pTemp(playerid)[pt_TRUCK_LOADING_VALUE] < 100.0)
	{
		pTemp(playerid)[pt_TRUCK_LOADING_VALUE] += 10.0;
		if(pTemp(playerid)[pt_TRUCK_LOADING_VALUE] > 100.0) pTemp(playerid)[pt_TRUCK_LOADING_VALUE] = 100.0;
		
		UpdatePlayerLoadingTruckSize(playerid);
		KillTimer(pTemp(playerid)[pt_TIMERS][9]);
		pTemp(playerid)[pt_TIMERS][9] = SetTimerEx("TrailerUnLoadUp", 1000, false, "ii", playerid, vehicleid);
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
	
	SendInfoMessagef(playerid, "Trailero~n~~n~La mercancia ha sido entregada, ve a ~r~la compañia~w~ para finalizar y recibir tu paga.~n~~n~");
	SetPlayerTrailerCheckpoint(playerid, vehicleid);
	return 1;
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_CROUCH)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, Trailer_StartJob_Pos[0], Trailer_StartJob_Pos[1], Trailer_StartJob_Pos[2]))
        {
            if(!GetPlayerWork(playerid, WORK_TRAILER)) return SendMessage(playerid, "No eres Trailero.");
            if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;

            new modelid = Random_Trailer_ModelID[random(sizeof(Random_Trailer_ModelID))];

            new vehicleid = GetPlayerVehicleID(playerid);
            if(!IsVehicleTrailer_Truck(vehicleid)) return SendMessage(playerid, "Necesitas un trailer.");
            if(TrailerVehicle(vehicleid)[trailer_TRAILER] != -1) return SendMessage(playerid, "Ya tienes un trailer.");

            new trailer_id = CreateVehicle(
                    modelid, 
                    Trailer_Exit_Pos[0], 
                    Trailer_Exit_Pos[1], 
                    Trailer_Exit_Pos[2], 
                    Trailer_Exit_Pos[3], 
                    1, 1, 
                    -1, false
                );
            
            gVehicle(trailer_id)[gb_vehicle_VALID] = true;
            gVehicle(trailer_id)[gb_vehicle_TYPE] = VEHICLE_TYPE_WORK;
            gVehicle(trailer_id)[gb_vehicle_MODELID] = modelid;
            format(gVehicle(trailer_id)[gb_vehicle_NUMBER_PLATE], 32, "%c%c%c-%04d", getRandomLetter(), getRandomLetter(), getRandomLetter(), random(9999));
            gVehicle(trailer_id)[gb_vehicle_SPAWN_X] = Trailer_Exit_Pos[0];
            gVehicle(trailer_id)[gb_vehicle_SPAWN_Y] = Trailer_Exit_Pos[1];
            gVehicle(trailer_id)[gb_vehicle_SPAWN_Z] = Trailer_Exit_Pos[2];
            gVehicle(trailer_id)[gb_vehicle_SPAWN_ANGLE] = Trailer_Exit_Pos[3];
            
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
			WORK_VEHICLES[trailer_id][work_vehicle_WORK] = WORK_TRAILER;
			WORK_VEHICLES[trailer_id][work_vehicle_EXP] = 0;
			WORK_VEHICLES[trailer_id][work_vehicle_NEED_DUTY] = work_info[ WORK_VEHICLES[trailer_id][work_vehicle_WORK] ][work_info_NEED_DUTY];

            SetVehicleVirtualWorldEx(trailer_id, 0);
            SetVehicleToRespawnEx(trailer_id);

            SetVehiclePosEx(vehicleid, Truck_Exit_Pos[0], Truck_Exit_Pos[1], Truck_Exit_Pos[2]);
            SetVehicleZAngle(vehicleid, Truck_Exit_Pos[3]);

            SetTimerEx("AttachTrailerToTruck", 1000, false, "iii", playerid, vehicleid, trailer_id);
            return Y_HOOKS_BREAK_RETURN_1;
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

callbackp:AttachTrailerToTruck(playerid, vehicleid, trailerid)
{
    TrailerVehicle(vehicleid)[trailer_TRAILER] = trailerid;
    AttachTrailerToVehicleEx(trailerid, vehicleid);

    LoadTrailer(vehicleid, playerid);
    return 1;
}

hook OnScriptInit()
{
    CreateDynamic3DTextLabel("Trailero\nPulsa {"#PRIMARY_COLOR"}'H'{ffffff} para recibir un trabajo", -1, Trailer_StartJob_Pos[0], Trailer_StartJob_Pos[1], Trailer_StartJob_Pos[2], 15.0, .testlos = true);
}

hook OnPlayerStateChange(playerid, newstate, oldstate) 
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleWork(vehicleid) == WORK_TRAILER)
		{
			if(!IsRentedTrailer(vehicleid))
			{
				if(IsVehicleTrailer_Truck(vehicleid))
				{
					SendInfoMessage(playerid, "Trailero~n~~n~Para rentar este trailer usa ~b~/rentar~w~ pero recuerda que cada vez que hagas un viaje se ta descontara un poco de tu dinero.~n~~n~");
				}
			}
		}
    }
    if(oldstate == PLAYER_STATE_DRIVER) 
	{
		if(GetVehicleWork(pTemp(playerid)[pt_LAST_VEHICLE_ID]) == WORK_TRAILER)
		{
			if(!IsRentedTrailer(pTemp(playerid)[pt_LAST_VEHICLE_ID]))
			{
				if(IsVehicleTrailer_Truck(pTemp(playerid)[pt_LAST_VEHICLE_ID]))
				{
                    SetVehicleToRespawnEx(pTemp(playerid)[pt_LAST_VEHICLE_ID]);
				}
			}
		}
    }
}

CMD:rentar(playerid, params[])
{
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendMessage(playerid, "Debes estar dentro de un trailer, como conductor.");
    new vehicleid = GetPlayerVehicleID(playerid);

    if(!GetPlayerWork(playerid, WORK_TRAILER)) return SendMessage(playerid, "Necesitas ser Trailero para rentar un trailer.");
    if(!IsVehicleTrailer_Truck(vehicleid)) return SendMessage(playerid, "No estas en un trailer.");
    if(GetVehicleWork(vehicleid) != WORK_TRAILER) return SendMessage(playerid, "Este trailer no se puede rentar.");
    if(IsRentedTrailer(vehicleid)) return SendMessage(playerid, "Este trailer ya esta rentada.");

    if(pTemp(playerid)[pt_RENT_VEHICLE] != INVALID_VEHICLE_ID)
    {
        if(IsRentedTrailer(pTemp(playerid)[pt_RENT_VEHICLE])) return SendMessage(playerid, "Ya tienes un trailer rentada.");
    }

    new modelid = GetVehicleModel(vehicleid);

    new vehicle_id = CreateVehicle(
            modelid, 
            Trailer_Exit_Pos[0], 
            Trailer_Exit_Pos[1], 
            Trailer_Exit_Pos[2], 
            Trailer_Exit_Pos[3], 
            1, 0, 
            -1, false
        );
    
    gVehicle(vehicle_id)[gb_vehicle_VALID] = true;
    gVehicle(vehicle_id)[gb_vehicle_TYPE] = VEHICLE_TYPE_WORK;
    gVehicle(vehicle_id)[gb_vehicle_MODELID] = modelid;
    format(gVehicle(vehicle_id)[gb_vehicle_NUMBER_PLATE], 32, "%c%c%c-%04d", getRandomLetter(), getRandomLetter(), getRandomLetter(), random(9999));
    gVehicle(vehicle_id)[gb_vehicle_SPAWN_X] = Trailer_Exit_Pos[0];
    gVehicle(vehicle_id)[gb_vehicle_SPAWN_Y] = Trailer_Exit_Pos[1];
    gVehicle(vehicle_id)[gb_vehicle_SPAWN_Z] = Trailer_Exit_Pos[2];
    gVehicle(vehicle_id)[gb_vehicle_SPAWN_ANGLE] = Trailer_Exit_Pos[3];
    
    gVehicle(vehicle_id)[gb_vehicle_POS][0] = gVehicle(vehicle_id)[gb_vehicle_SPAWN_X];
    gVehicle(vehicle_id)[gb_vehicle_POS][1] = gVehicle(vehicle_id)[gb_vehicle_SPAWN_Y];
    gVehicle(vehicle_id)[gb_vehicle_POS][2] = gVehicle(vehicle_id)[gb_vehicle_SPAWN_Z];
    
    gVehicle(vehicle_id)[gb_vehicle_HEALTH] = 1000.0;
    gVehicle(vehicle_id)[gb_vehicle_DAMAGE_PANELS] = 0;
    gVehicle(vehicle_id)[gb_vehicle_DAMAGE_DOORS] = 0;
    gVehicle(vehicle_id)[gb_vehicle_DAMAGE_LIGHTS] = 0;
    gVehicle(vehicle_id)[gb_vehicle_DAMAGE_TIRES] = 0;
    gVehicle(vehicle_id)[gb_vehicle_COLOR_1] = 1;
    gVehicle(vehicle_id)[gb_vehicle_COLOR_2] = 0;
    gVehicle(vehicle_id)[gb_vehicle_PAINTJOB] = 3; // No paintjob
    gVehicle(vehicle_id)[gb_vehicle_MAX_GAS] = VEHICLE_INFO[modelid - 400][vehicle_info_MAX_GAS];
    gVehicle(vehicle_id)[gb_vehicle_GAS] = gVehicle(vehicle_id)[gb_vehicle_MAX_GAS];
    gVehicle(vehicle_id)[gb_vehicle_STATE] = VEHICLE_STATE_NORMAL;
    gVehicle(vehicle_id)[gb_vehicle_INTERIOR] = 0;
    gVehicle(vehicle_id)[gb_vehicle_WORLD] = 0;

	WORK_VEHICLES[vehicle_id][work_vehicle_VALID] = true;
	WORK_VEHICLES[vehicle_id][work_vehicle_WORK] = WORK_TRAILER;
	WORK_VEHICLES[vehicle_id][work_vehicle_EXP] = 0;
	WORK_VEHICLES[vehicle_id][work_vehicle_NEED_DUTY] = work_info[ WORK_VEHICLES[vehicle_id][work_vehicle_WORK] ][work_info_NEED_DUTY];

	if(IsValidDynamic3DTextLabel(GLOBAL_VEHICLES[vehicle_id][gb_vehicle_LABEL]))
	{
		DestroyDynamic3DTextLabel(GLOBAL_VEHICLES[vehicle_id][gb_vehicle_LABEL]);
		GLOBAL_VEHICLES[vehicle_id][gb_vehicle_LABEL] = Text3D:INVALID_STREAMER_ID;
	}

    TrailerVehicle(vehicle_id)[trailer_VALID] = true;
    TrailerVehicle(vehicle_id)[trailer_LOADED] = false; 
    TrailerVehicle(vehicle_id)[trailer_UNLOADING] = false; 
    TrailerVehicle(vehicle_id)[trailer_LOADING] = false; 
    TrailerVehicle(vehicle_id)[trailer_DELIVERED] = false; 
    TrailerVehicle(vehicle_id)[trailer_ROUTE] = -1;
    TrailerVehicle(vehicle_id)[trailer_DRIVER] = PI[playerid][pi_ID];
    TrailerVehicle(vehicle_id)[trailer_TRAILER] = -1;
    TrailerVehicle(vehicle_id)[trailer_RENT] = true;
    pTemp(playerid)[pt_RENT_VEHICLE] = vehicle_id;

    SetVehicleVirtualWorldEx(vehicle_id, 0);
    SetVehicleToRespawnEx(vehicle_id);

    PutPlayerInVehicle(playerid, vehicle_id, 0);

    SendInfoMessagef(playerid, "Trailero~n~~n~Has rentado un trailer, usa ~b~/desrentar~w~ si quieres dejar de usarla.~n~~n~");
    return 1;
}

CMD:desrentar(playerid, params[])
{
    if(pTemp(playerid)[pt_RENT_VEHICLE] == INVALID_VEHICLE_ID) return SendMessage(playerid, "No tienes ningun trailer rentado.");
    if(TrailerVehicle( pTemp(playerid)[pt_RENT_VEHICLE] )[trailer_DRIVER] != PI[playerid][pi_ID]) return SendMessage(playerid, "No tienes ningun trailer rentado.");

    TrailerVehicle(pTemp(playerid)[pt_RENT_VEHICLE])[trailer_RENT] = false;

	if(IsValidDynamicCP(pTemp(playerid)[pt_TRAILER_CHECKPOINT]))
	{
		DestroyDynamicCP(pTemp(playerid)[pt_TRAILER_CHECKPOINT]);
		pTemp(playerid)[pt_TRAILER_CHECKPOINT] = INVALID_STREAMER_ID;
	}
    
    if(TrailerVehicle( pTemp(playerid)[pt_RENT_VEHICLE] )[trailer_TRAILER] != -1)
    {
        ClearTrailerInfo(TrailerVehicle( pTemp(playerid)[pt_RENT_VEHICLE] )[trailer_TRAILER]);
        DestroyVehicleEx(TrailerVehicle( pTemp(playerid)[pt_RENT_VEHICLE] )[trailer_TRAILER]);
    }

    ClearTrailerInfo(pTemp(playerid)[pt_RENT_VEHICLE]);
    DestroyVehicleEx(pTemp(playerid)[pt_RENT_VEHICLE]);

    pTemp(playerid)[pt_RENT_VEHICLE] = INVALID_VEHICLE_ID;

    SendInfoMessagef(playerid, "Trailero~n~~n~Has desrentado el trailer.~n~~n~");
    return 1;
}