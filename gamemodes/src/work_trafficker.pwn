#include <YSI-Includes\YSI\y_hooks>

//CHECKPOINT_TYPE_TRAFFICKER

#define	TRAFFICKER_MAX_ROUTES 101

enum Trafficker_Content_Info
{
	bool:trafficker_content_VALID,
	trafficker_content_MONEY,
    trafficker_content_STEP,
	Float:trafficker_content_X,
	Float:trafficker_content_Y,
	Float:trafficker_content_Z
}
new Trafficker_Contents[TRAFFICKER_MAX_ROUTES][Trafficker_Content_Info];

enum
{
    TRAFFICKER_STEP_NONE,
    TRAFFICKER_STEP_SEARCH,
    TRAFFICKER_STEP_DELIVERY,
    TRAFFICKER_STEP_FINISH
}

enum trffckr_VEHICLE_Info
{
	bool:trffckr_vehicle_LOADED,
	bool:trffckr_vehicle_LOADING,
	bool:trffckr_vehicle_UNLOADING,
	trffckr_vehicle_DRIVER_USER_ID,
	trffckr_vehicle_POINT
}
new TRAFFICKER_VEHICLE[MAX_VEHICLES][trffckr_VEHICLE_Info];

new Float:Trafficker_Load_Points[][] =
{
    {1627.0009, 1035.8177, 10.8203}
};

stock LoadTraffickerInfo()
{
    for(new i; i != sizeof(Trafficker_Load_Points); i ++)
    {
        CreateDynamic3DTextLabel("{"#GREEN_COLOR"}Cargar Vehiculo\n{ffffff}Pulsa {"#PRIMARY_COLOR"}[ H ]{ffffff} para cargar tu vehiculo", -1, Trafficker_Load_Points[i][0], Trafficker_Load_Points[i][1], Trafficker_Load_Points[i][2], 5.0, .testlos = true);
        CreateDynamicPickup(19132, 1, Trafficker_Load_Points[i][0], Trafficker_Load_Points[i][1], Trafficker_Load_Points[i][2]);
    }

    CreateTraffickerCheckpoint(1, 0, TRAFFICKER_STEP_SEARCH, -1054.6196, -596.1787, 31.5781); // traficante 1 
    CreateTraffickerCheckpoint(2, 0, TRAFFICKER_STEP_SEARCH, 2746.3049, -2443.6436, 13.2141); // traficante 2
    CreateTraffickerCheckpoint(3, 0, TRAFFICKER_STEP_SEARCH, 2467.1924, -2548.5383, 13.2126); // traficante 3
    CreateTraffickerCheckpoint(4, 0, TRAFFICKER_STEP_SEARCH, 2417.1292, -2219.0166, 13.1102); // traficante 4
    CreateTraffickerCheckpoint(5, 0, TRAFFICKER_STEP_SEARCH, 2632.5806, -2242.3816, 13.1012); // traficante 5
    CreateTraffickerCheckpoint(6, 0, TRAFFICKER_STEP_SEARCH, 2279.6248, 63.6557, 26.0527); // traficante 6
    CreateTraffickerCheckpoint(7, 0, TRAFFICKER_STEP_SEARCH, 2439.7515, 114.7913, 26.0306); // traficante 7
    CreateTraffickerCheckpoint(8, 0, TRAFFICKER_STEP_SEARCH, 1583.9530, 38.8817, 24.3608); // traficante 8
    CreateTraffickerCheckpoint(9, 0, TRAFFICKER_STEP_SEARCH, 1387.5306, 265.8192, 19.1330); // traficante 9
    CreateTraffickerCheckpoint(10, 0, TRAFFICKER_STEP_SEARCH, 1407.9425, 458.5937, 19.7841); // traficante 10
    CreateTraffickerCheckpoint(11, 0, TRAFFICKER_STEP_SEARCH, 1362.8693, 481.4456, 19.7561); // traficante 11
    CreateTraffickerCheckpoint(12, 0, TRAFFICKER_STEP_SEARCH, 219.3176, 32.9477, 2.1429); // traficante 12
    CreateTraffickerCheckpoint(13, 0, TRAFFICKER_STEP_SEARCH, 168.7279, -15.1551, 1.1493); // traficante 13
    CreateTraffickerCheckpoint(14, 0, TRAFFICKER_STEP_SEARCH, 109.0504, -164.8963, 1.3779); // traficante 14
    CreateTraffickerCheckpoint(15, 0, TRAFFICKER_STEP_SEARCH, -24.1087, 109.6252, 2.6836); // traficante 15
    CreateTraffickerCheckpoint(16, 0, TRAFFICKER_STEP_SEARCH, -84.2985, 1159.0797, 19.3082); // traficante 16
    CreateTraffickerCheckpoint(17, 0, TRAFFICKER_STEP_SEARCH, 250.2443, 1420.8013, 10.1505); // traficante 17
    CreateTraffickerCheckpoint(18, 0, TRAFFICKER_STEP_SEARCH, 648.4564, 1690.3639, 6.5661); // traficante 18
    CreateTraffickerCheckpoint(19, 0, TRAFFICKER_STEP_SEARCH, 687.6994, 1717.4076, 6.5582); // traficante 19
    CreateTraffickerCheckpoint(20, 0, TRAFFICKER_STEP_SEARCH, 1024.7125, 2109.2419, 10.3845); // traficante 20
    CreateTraffickerCheckpoint(21, 0, TRAFFICKER_STEP_SEARCH, 1053.0925, 2192.8774, 10.3864); // traficante 21
    CreateTraffickerCheckpoint(22, 0, TRAFFICKER_STEP_SEARCH, 1101.4080, 2132.3206, 10.3749); // traficante 22
    CreateTraffickerCheckpoint(23, 0, TRAFFICKER_STEP_SEARCH, 1107.4478, 2337.8682, 10.3851); // traficante 23
    CreateTraffickerCheckpoint(24, 0, TRAFFICKER_STEP_SEARCH, -275.6705, 2674.3677, 62.1858); // traficante 24
    CreateTraffickerCheckpoint(25, 0, TRAFFICKER_STEP_SEARCH, -318.2948, 2664.8755, 62.5249); // traficante 25
    CreateTraffickerCheckpoint(26, 0, TRAFFICKER_STEP_SEARCH, -731.6951, 2744.4417, 46.7929); // traficante 26
    CreateTraffickerCheckpoint(27, 0, TRAFFICKER_STEP_SEARCH, -1278.2625, 2721.7808, 49.6256); // traficante 27
    CreateTraffickerCheckpoint(28, 0, TRAFFICKER_STEP_SEARCH, -1328.7443, 2697.1638, 49.6286); // traficante 28
    CreateTraffickerCheckpoint(29, 0, TRAFFICKER_STEP_SEARCH, -1522.1049, 2584.6006, 55.4054); // traficante 29
    CreateTraffickerCheckpoint(30, 0, TRAFFICKER_STEP_SEARCH, -2244.8970, 2372.9019, 4.5648); // traficante 30
    CreateTraffickerCheckpoint(31, 0, TRAFFICKER_STEP_SEARCH, -2545.8774, 1217.2208, 36.9878); // traficante 31
    CreateTraffickerCheckpoint(32, 0, TRAFFICKER_STEP_SEARCH, -2280.6763, 1100.2761, 79.7055); // traficante 32
    CreateTraffickerCheckpoint(33, 0, TRAFFICKER_STEP_SEARCH, -2486.3450, 789.9917, 34.7420); // traficante 33
    CreateTraffickerCheckpoint(34, 0, TRAFFICKER_STEP_SEARCH, -2405.8708, 735.0450, 34.5861); // traficante 34
    CreateTraffickerCheckpoint(35, 0, TRAFFICKER_STEP_SEARCH, -1715.4126, 393.8911, 6.7446); // traficante 35
    CreateTraffickerCheckpoint(36, 0, TRAFFICKER_STEP_SEARCH, -1665.8876, 446.4712, 6.7521); // traficante 36
    CreateTraffickerCheckpoint(37, 0, TRAFFICKER_STEP_SEARCH, -1640.0603, 1282.8387, 6.6056); // traficante 37
    CreateTraffickerCheckpoint(38, 0, TRAFFICKER_STEP_SEARCH, -1790.2880, 1424.3297, 6.7570); // traficante 38
    CreateTraffickerCheckpoint(39, 0, TRAFFICKER_STEP_SEARCH, -1853.6162, 118.5278, 14.6833); // traficante 39
    CreateTraffickerCheckpoint(40, 0, TRAFFICKER_STEP_SEARCH, -1839.2950, -14.3454, 14.6832); // traficante 40
    CreateTraffickerCheckpoint(41, 0, TRAFFICKER_STEP_SEARCH, -1698.2308, -90.6935, 3.1225); // traficante 41
    CreateTraffickerCheckpoint(42, 0, TRAFFICKER_STEP_SEARCH, -1546.8440, 124.6599, 3.1243); // traficante 42
    CreateTraffickerCheckpoint(43, 0, TRAFFICKER_STEP_SEARCH, -610.5728, -498.7329, 25.1102); // traficante 43
    CreateTraffickerCheckpoint(44, 0, TRAFFICKER_STEP_SEARCH, -19.6714, -274.9840, 4.9979); // traficante 44
    CreateTraffickerCheckpoint(45, 0, TRAFFICKER_STEP_SEARCH, 356.8361, -80.2742, 0.9129); // traficante 45
    CreateTraffickerCheckpoint(46, 0, TRAFFICKER_STEP_SEARCH, 318.1404, -249.8626, 1.1401); // traficante 46
    CreateTraffickerCheckpoint(47, 0, TRAFFICKER_STEP_SEARCH, -2191.9675, -2323.5134, 30.1960); // traficante 47
    CreateTraffickerCheckpoint(48, 0, TRAFFICKER_STEP_SEARCH, -2118.5300, -2489.3074, 30.1917); // traficante 48
    CreateTraffickerCheckpoint(49, 0, TRAFFICKER_STEP_SEARCH, -2241.5657, -2554.4700, 31.4921); // traficante 49
    CreateTraffickerCheckpoint(50, 0, TRAFFICKER_STEP_SEARCH, -1546.6370, -2738.6682, 48.1036); // traficante 50

    CreateTraffickerCheckpoint(51, 4200, TRAFFICKER_STEP_DELIVERY, -259.6676, -2219.7163, 28.2244); // traficante 51
    CreateTraffickerCheckpoint(52, 4200, TRAFFICKER_STEP_DELIVERY, 441.2480, -1297.2614, 14.7502); // traficante 52
    CreateTraffickerCheckpoint(53, 4200, TRAFFICKER_STEP_DELIVERY, 360.3151, -1320.1871, 14.1407); // traficante 53
    CreateTraffickerCheckpoint(54, 4200, TRAFFICKER_STEP_DELIVERY, 445.2579, -1803.3337, 5.1170); // traficante 54
    CreateTraffickerCheckpoint(55, 4200, TRAFFICKER_STEP_DELIVERY, 1097.0187, -1880.4844, 13.1171); // traficante 55
    CreateTraffickerCheckpoint(56, 4200, TRAFFICKER_STEP_DELIVERY, 1571.2336, -2328.3762, -3.1216); // traficante 56
    CreateTraffickerCheckpoint(57, 4200, TRAFFICKER_STEP_DELIVERY, 1800.9304, -2291.2864, -3.1191); // traficante 57
    CreateTraffickerCheckpoint(58, 4200, TRAFFICKER_STEP_DELIVERY, 2102.4680, -2044.0658, 13.1129); // traficante 58
    CreateTraffickerCheckpoint(59, 4200, TRAFFICKER_STEP_DELIVERY, 2000.4470, -2062.5193, 13.112); // traficante 59
    CreateTraffickerCheckpoint(60, 4200, TRAFFICKER_STEP_DELIVERY, 1923.7571, -2139.5596, 13.127); // traficante 60
    CreateTraffickerCheckpoint(61, 4200, TRAFFICKER_STEP_DELIVERY, 1944.7896, -1979.4117, 13.1033); // traficante 61
    CreateTraffickerCheckpoint(62, 4200, TRAFFICKER_STEP_DELIVERY, 2053.2529, -1810.0323, 12.9470); // traficante 62
    CreateTraffickerCheckpoint(63, 4200, TRAFFICKER_STEP_DELIVERY, 2121.8701, -1783.2411, 12.9571); // traficante 63
    CreateTraffickerCheckpoint(64, 4200, TRAFFICKER_STEP_DELIVERY, 2245.4697, -1939.0035, 13.1120); // traficante 64
    CreateTraffickerCheckpoint(65, 4200, TRAFFICKER_STEP_DELIVERY, 2262.5879, -1938.8926, 13.1080); // traficante 65
    CreateTraffickerCheckpoint(66, 4200, TRAFFICKER_STEP_DELIVERY, 2279.0603, -1938.7921, 13.1094); // traficante 66
    CreateTraffickerCheckpoint(67, 4200, TRAFFICKER_STEP_DELIVERY, 2373.0098, -1935.6671, 13.1187); // traficante 67
    CreateTraffickerCheckpoint(68, 4200, TRAFFICKER_STEP_DELIVERY, 2388.0168, -2015.0623, 13.1184); // traficante 68
    CreateTraffickerCheckpoint(69, 4200, TRAFFICKER_STEP_DELIVERY, 2382.7163, -2073.7986, 13.0618); // traficante 69
    CreateTraffickerCheckpoint(70, 4200, TRAFFICKER_STEP_DELIVERY, 2333.3240, -2079.8447, 13.1232); // traficante 70
    CreateTraffickerCheckpoint(71, 4200, TRAFFICKER_STEP_DELIVERY, 2489.2683, -1953.2891, 12.9926); // traficante 71
    CreateTraffickerCheckpoint(72, 4200, TRAFFICKER_STEP_DELIVERY, 2481.5867, -1749.3890, 13.1119); // traficante 72
    CreateTraffickerCheckpoint(73, 4200, TRAFFICKER_STEP_DELIVERY, 2772.2117, -1610.6364, 10.4884); // traficante 73
    CreateTraffickerCheckpoint(74, 4200, TRAFFICKER_STEP_DELIVERY, 2274.8379, -1034.7544, 50.6111); // traficante 74
    CreateTraffickerCheckpoint(75, 4200, TRAFFICKER_STEP_DELIVERY, 1687.9236, -1482.3376, 12.9463); // traficante 75
    CreateTraffickerCheckpoint(76, 4200, TRAFFICKER_STEP_DELIVERY, 2631.9580, 1072.2944, 10.3932); // traficante 76
    CreateTraffickerCheckpoint(77, 4200, TRAFFICKER_STEP_DELIVERY, 2413.7463, 1485.8363, 10.3936); // traficante 77
    CreateTraffickerCheckpoint(78, 4200, TRAFFICKER_STEP_DELIVERY, 2276.6768, 2041.2411, 10.3898); // traficante 78
    CreateTraffickerCheckpoint(79, 4200, TRAFFICKER_STEP_DELIVERY, 2359.9768, 1894.3685, 10.2917); // traficante 79
    CreateTraffickerCheckpoint(80, 4200, TRAFFICKER_STEP_DELIVERY, 2246.7458, 2233.0422, 10.3157); // traficante 80
    CreateTraffickerCheckpoint(81, 4200, TRAFFICKER_STEP_DELIVERY, 2554.4221, 2319.6501, 10.3863); // traficante 81
    CreateTraffickerCheckpoint(82, 4200, TRAFFICKER_STEP_DELIVERY, 1988.2937, 2073.2708, 10.3877); // traficante 82
    CreateTraffickerCheckpoint(83, 4200, TRAFFICKER_STEP_DELIVERY, 1844.7791, 2086.6372, 10.396); // traficante 83
    CreateTraffickerCheckpoint(84, 4200, TRAFFICKER_STEP_DELIVERY, 1494.4594, 2367.6289, 10.3800); // traficante 84
    CreateTraffickerCheckpoint(85, 4200, TRAFFICKER_STEP_DELIVERY, 1827.3765, 2616.6760, 10.3899); // traficante 85
    CreateTraffickerCheckpoint(86, 4200, TRAFFICKER_STEP_DELIVERY, 1360.4467, 1158.9868, 10.3898); // traficante 86
    CreateTraffickerCheckpoint(87, 4200, TRAFFICKER_STEP_DELIVERY, 1532.5996, 1035.4827, 10.3863); // traficante 87
    CreateTraffickerCheckpoint(88, 4200, TRAFFICKER_STEP_DELIVERY, -755.7060, 1588.2426, 26.5272); // traficante 88
    CreateTraffickerCheckpoint(89, 4200, TRAFFICKER_STEP_DELIVERY, -1489.4685, 1871.1178, 32.199); // traficante 89
    CreateTraffickerCheckpoint(90, 4200, TRAFFICKER_STEP_DELIVERY, 643.8715, -502.0673, 15.8992); // traficante 90
    CreateTraffickerCheckpoint(91, 4200, TRAFFICKER_STEP_DELIVERY, 698.0093, -441.2802, 15.8967); // traficante 91
    CreateTraffickerCheckpoint(92, 4200, TRAFFICKER_STEP_DELIVERY, 1338.1689, -864.0070, 38.8755); // traficante 92
    CreateTraffickerCheckpoint(93, 4200, TRAFFICKER_STEP_DELIVERY, 1620.1962, -1889.5791, 13.1165); // traficante 93
    CreateTraffickerCheckpoint(94, 4200, TRAFFICKER_STEP_DELIVERY, 369.7258, -2041.6675, 7.2386); // traficante 94
    CreateTraffickerCheckpoint(95, 4200, TRAFFICKER_STEP_DELIVERY, -68.2107, -1159.7506, 1.3195); // traficante 95
    CreateTraffickerCheckpoint(96, 4200, TRAFFICKER_STEP_DELIVERY, -216.6386, 1214.4691, 19.308); // traficante 96
    CreateTraffickerCheckpoint(97, 4200, TRAFFICKER_STEP_DELIVERY, -176.5196, 1017.2153, 19.2953); // traficante 97
    CreateTraffickerCheckpoint(98, 4200, TRAFFICKER_STEP_DELIVERY, 2092.4761, -1558.1576, 12.682); // traficante 98
    CreateTraffickerCheckpoint(99, 4200, TRAFFICKER_STEP_DELIVERY, 2388.5242, -1541.8246, 23.5662); // traficante 99
    CreateTraffickerCheckpoint(100, 4200, TRAFFICKER_STEP_DELIVERY, 2519.1714, -1466.4921, 23.5513); // traficante 100
}

stock GetTraffickerInfoLoaded(vehicleid)
{
    return TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_LOADED];
}

stock GetTraffickerInfoLoading(vehicleid)
{
    return TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_LOADING];
}

stock GetTraffickerInfoUnLoading(vehicleid)
{
    return TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_UNLOADING];
}

stock SetTraffickerInfoLoaded(vehicleid, bool:set)
{
    return TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_LOADED] = set;
}

stock SetTraffickerInfoLoading(vehicleid, bool:set)
{
    return TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_LOADING] = set;
}

stock SetTraffickerInfoUnLoading(vehicleid, bool:set)
{
    return TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_UNLOADING] = set;
}

stock GetTraffickerDriver(vehicleid)
{
    return TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_DRIVER_USER_ID];
}

SetGPSTraffickerLoad(playerid)
{
    SetPlayer_GPS_Checkpoint(
        playerid, 
        Trafficker_Load_Points[random(sizeof(Trafficker_Load_Points))][0], 
        Trafficker_Load_Points[random(sizeof(Trafficker_Load_Points))][1], 
        Trafficker_Load_Points[random(sizeof(Trafficker_Load_Points))][2], 
        0, 0
    );
}

ResetTraffickerInfo(vehicleid)
{
	static const tmp_TRAFFCKR_VEHICLE[trffckr_VEHICLE_Info]; TRAFFICKER_VEHICLE[vehicleid] = tmp_TRAFFCKR_VEHICLE;
	return 1;
}

CreateTraffickerCheckpoint(index, payment, step, Float:x, Float:y, Float:z)
{
	if(index >= TRUCK_MAX_ROUTES) return print("---> Límite superado en array 'Trafficker_Contents, index' en la función 'CreateTraffickerCheckpoint'.");

	Trafficker_Contents[index][trafficker_content_VALID] = true;
	Trafficker_Contents[index][trafficker_content_MONEY] = payment;

	Trafficker_Contents[index][trafficker_content_X] = x;
	Trafficker_Contents[index][trafficker_content_Y] = y;
	Trafficker_Contents[index][trafficker_content_Z] = z;

    Trafficker_Contents[index][trafficker_content_STEP] = step;
	return 1;
}

SetPlayerTraffickerCheckpoint(playerid, vehicleid)
{
	if(IsValidDynamicCP(PlayerTemp[playerid][pt_TRUCK_CHECKPOINT]))
	{
		DestroyDynamicCP(PlayerTemp[playerid][pt_TRUCK_CHECKPOINT]);
		PlayerTemp[playerid][pt_TRUCK_CHECKPOINT] = INVALID_STREAMER_ID;
	}

	if(Trafficker_Contents[ TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] ][trafficker_content_STEP] == TRAFFICKER_STEP_FINISH)
	{
		PlayerTemp[playerid][pt_TRUCK_CHECKPOINT] = CreateDynamicCP(Trafficker_Load_Points[0][0], Trafficker_Load_Points[0][1], Trafficker_Load_Points[0][2], 5.0, 0, 0, playerid, 9999999999.0);
		
		new info[1];
		info[0] = CHECKPOINT_TYPE_END_TRAFFICKER;
		Streamer_SetArrayData(STREAMER_TYPE_CP, PlayerTemp[playerid][pt_TRUCK_CHECKPOINT], E_STREAMER_EXTRA_ID, info);

        SendInfoMessagef(playerid, "Traficante~n~~n~Ve a ~r~traficante~w~ para confirmar la entrega y recibir el pago.~n~~n~Ganancias: ~g~%d$~w~.~n~~n~", number_format_thousand(Trafficker_Contents[ TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] ][trafficker_content_MONEY]));
	}
	else
	{
		PlayerTemp[playerid][pt_TRUCK_CHECKPOINT] = CreateDynamicCP(Trafficker_Contents[ TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] ][trafficker_content_X], Trafficker_Contents[ TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] ][trafficker_content_Y], Trafficker_Contents[ TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] ][trafficker_content_Z], 5.0, 0, 0, playerid, 9999999999.0);
		
		new info[1];
		info[0] = CHECKPOINT_TYPE_TRAFFICKER;
		Streamer_SetArrayData(STREAMER_TYPE_CP, PlayerTemp[playerid][pt_TRUCK_CHECKPOINT], E_STREAMER_EXTRA_ID, info);

        if(Trafficker_Contents[ TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] ][trafficker_content_STEP] == TRAFFICKER_STEP_SEARCH)
        {
            SendInfoMessage(playerid, "Traficante~n~~n~Ve al ~r~punto de busqueda~w~ para buscar el cargamento.~n~~n~");
        }
        else if(Trafficker_Contents[ TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] ][trafficker_content_STEP] == TRAFFICKER_STEP_DELIVERY)
        {
            SendInfoMessage(playerid, "Traficante~n~~n~Ve al ~r~punto de entrega~w~ para entregar el cargamento.~n~~n~");
        }
	}

	Streamer_Update(playerid, STREAMER_TYPE_CP);
	return 1;
}

stock SetTraffickeUnLoadData(playerid, vehicleid)
{
    DestroyDynamicCP(PlayerTemp[playerid][pt_TRUCK_CHECKPOINT]);
    PlayerTemp[playerid][pt_TRUCK_CHECKPOINT] = INVALID_STREAMER_ID;
                
    SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
                    
    GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE] = 0;
    UpdateVehicleParams(vehicleid);
                
    TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_UNLOADING] = true;
    PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][0], "");
    PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][0]);
    PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][1]);
    PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][2]);
    PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][3]);
                    
    PlayerTemp[playerid][pt_TRUCK_LOADING_VALUE] = 40.0;
    UpdatePlayerLoadingTruckSize(playerid);
    KillTimer(PlayerTemp[playerid][pt_TIMERS][7]);
    KillTimer(PlayerTemp[playerid][pt_TIMERS][9]);
    PlayerTemp[playerid][pt_TIMERS][9] = SetTimerEx("VehicleUnLoadUp", 1000, false, "ii", playerid, vehicleid);
    return 1;
}

forward VehicleLoadUp(playerid, vehicleid);
public VehicleLoadUp(playerid, vehicleid)
{
	if(PlayerTemp[playerid][pt_TRUCK_LOADING_VALUE] < 100.0)
	{
		PlayerTemp[playerid][pt_TRUCK_LOADING_VALUE] += 10.0;
		if(PlayerTemp[playerid][pt_TRUCK_LOADING_VALUE] > 100.0) PlayerTemp[playerid][pt_TRUCK_LOADING_VALUE] = 100.0;
		
		UpdatePlayerLoadingTruckSize(playerid);
		KillTimer(PlayerTemp[playerid][pt_TIMERS][9]);
		PlayerTemp[playerid][pt_TIMERS][9] = SetTimerEx("VehicleLoadUp", 1000, false, "ii", playerid, vehicleid);
		return 1;
	}
	
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][0]);
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][1]);
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][2]);
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][3]);
	
	GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE] = 1;
	UpdateVehicleParams(vehicleid);
	
	TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_LOADED] = true;
	TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_LOADING] = false;
	
	SetPlayerTraffickerCheckpoint(playerid, vehicleid);
	return 1;
}

forward VehicleUnLoadUp(playerid, vehicleid);
public VehicleUnLoadUp(playerid, vehicleid)
{
	if(PlayerTemp[playerid][pt_TRUCK_LOADING_VALUE] < 100.0)
	{
		PlayerTemp[playerid][pt_TRUCK_LOADING_VALUE] += 10.0;
		if(PlayerTemp[playerid][pt_TRUCK_LOADING_VALUE] > 100.0) PlayerTemp[playerid][pt_TRUCK_LOADING_VALUE] = 100.0;
		
		UpdatePlayerLoadingTruckSize(playerid);
		KillTimer(PlayerTemp[playerid][pt_TIMERS][9]);
		PlayerTemp[playerid][pt_TIMERS][9] = SetTimerEx("VehicleUnLoadUp", 1000, false, "ii", playerid, vehicleid);
		return 1;
	}
	
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][0]);
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][1]);
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][2]);
	PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][3]);
	
	GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE] = 1;
	UpdateVehicleParams(vehicleid);
	
	TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_UNLOADING] = false;
	
	SetPlayerTraffickerCheckpoint(playerid, vehicleid);
	return 1;
}

hook OnScriptInit()
{
    LoadTraffickerInfo();
}

hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	new info[1];
	Streamer_GetArrayData(STREAMER_TYPE_CP, checkpointid, E_STREAMER_EXTRA_ID, info);

	switch(info[0])
    {
        case CHECKPOINT_TYPE_TRAFFICKER:
        {
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
			if(!PLAYER_WORKS[playerid][WORK_TRAFFICKER][pwork_SET]) return 1;
			if(PlayerTemp[playerid][pt_WORKING_IN] != WORK_TRAFFICKER) return 1;
	
			new vehicleid = GetPlayerVehicleID(playerid);
			if(GLOBAL_VEHICLES[vehicleid][gb_vehicle_TYPE] != VEHICLE_TYPE_WORK) return 1;
			if(WORK_VEHICLES[vehicleid][work_vehicle_WORK] != WORK_TRAFFICKER) return 1;
			if(GetTraffickerDriver(vehicleid) != PI[playerid][pi_ID]) return 1;
            
            if(Trafficker_Contents[ TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] ][trafficker_content_STEP] == TRAFFICKER_STEP_SEARCH)
            {
                new index;
                while(/*!Trafficker_Contents[index][trafficker_content_VALID] && */Trafficker_Contents[index][trafficker_content_STEP] != TRAFFICKER_STEP_DELIVERY)
                {
                    index = random(TRAFFICKER_MAX_ROUTES);
                }

                TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] = index;

                SetTraffickeUnLoadData(playerid, vehicleid);
                return Y_HOOKS_BREAK_RETURN_1;
            }

            if(Trafficker_Contents[ TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] ][trafficker_content_STEP] == TRAFFICKER_STEP_DELIVERY) //TRAFFICKER_STEP_DELIVERY
            {
                Trafficker_Contents[ TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] ][trafficker_content_STEP] = TRAFFICKER_STEP_FINISH;

                SetTraffickeUnLoadData(playerid, vehicleid);
                return Y_HOOKS_BREAK_RETURN_1;
            }

            return Y_HOOKS_BREAK_RETURN_1;
        }
        case CHECKPOINT_TYPE_END_TRAFFICKER:
        {
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
			if(!PLAYER_WORKS[playerid][WORK_TRAFFICKER][pwork_SET]) return 1;
			if(PlayerTemp[playerid][pt_WORKING_IN] != WORK_TRAFFICKER) return 1;
	
			new vehicleid = GetPlayerVehicleID(playerid);
			if(GLOBAL_VEHICLES[vehicleid][gb_vehicle_TYPE] != VEHICLE_TYPE_WORK) return 1;
			if(WORK_VEHICLES[vehicleid][work_vehicle_WORK] != WORK_TRAFFICKER) return 1;
			if(GetTraffickerDriver(vehicleid) != PI[playerid][pi_ID]) return 1;

            if(Trafficker_Contents[ TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] ][trafficker_content_STEP] == TRAFFICKER_STEP_FINISH)
            {
                DestroyDynamicCP(PlayerTemp[playerid][pt_TRUCK_CHECKPOINT]);
                PlayerTemp[playerid][pt_TRUCK_CHECKPOINT] = INVALID_STREAMER_ID;
                
                SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
                
                new work_extra_payment;
                if(work_info[WORK_TRAFFICKER][work_info_EXTRA_PAY] > 0 && work_info[WORK_TRAFFICKER][work_info_EXTRA_PAY_EXP] > 0)
                {
                    work_extra_payment = (work_info[WORK_TRAFFICKER][work_info_EXTRA_PAY] * floatround(floatdiv(PLAYER_WORKS[playerid][WORK_TRAFFICKER][pwork_LEVEL], work_info[WORK_TRAFFICKER][work_info_EXTRA_PAY_EXP])));
                    if(work_info[WORK_TRAFFICKER][work_info_EXTRA_PAY_LIMIT] != 0) if(work_extra_payment > work_info[WORK_TRAFFICKER][work_info_EXTRA_PAY_LIMIT]) work_extra_payment = work_info[WORK_TRAFFICKER][work_info_EXTRA_PAY_LIMIT];
                
                    if(PI[playerid][pi_VIP]) work_extra_payment += VIP_WORK_EXTRA_PAY;
                }
                
                if(GivePlayerCash(playerid, Trafficker_Contents[ TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] ][trafficker_content_MONEY] + work_extra_payment, true, false)) 
                {
                    PLAYER_WORKS[playerid][WORK_TRAFFICKER][pwork_LEVEL] ++;
                    PI[playerid][pi_TRUCK_BONUS] ++;

                    if(PI[playerid][pi_TRUCK_BONUS] >= 50)
                    {
                        SendMessagef(playerid, "~y~!Felicidades¡ ~w~Has recibido un bono de ~g~%s$~w~ por tu gran trabajo.", number_format_thousand(TRUCK_BONUS_PRICE));
                        GivePlayerCash(playerid, TRUCK_BONUS_PRICE, true, false);

                        PI[playerid][pi_TRUCK_BONUS] = 0;
                        mysql_update_int(handle_db, "player", "truck_bonus", "id", PI[playerid][pi_ID], PI[playerid][pi_TRUCK_BONUS]);
                    }
                    else SendMessagef(playerid, "Te faltan ~r~%d~w~ Recorridos para obtener la bonificacion.", 50 - PI[playerid][pi_TRUCK_BONUS]);
                    
                    new string[64];
                    format(string, sizeof string, "+%s$", number_format_thousand(Trafficker_Contents[ TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] ][trafficker_content_MONEY] + work_extra_payment));
                    GameTextForPlayer(playerid, string, 5000, 1);
                    //ResetTraffickerInfo(vehicleid);
                    SetVehicleToRespawnEx(vehicleid);
                }
                
                return Y_HOOKS_BREAK_RETURN_1;
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys &  KEY_CROUCH)
	{
		if(PlayerTemp[playerid][pt_GAME_STATE] == GAME_STATE_NORMAL)
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
                if(PLAYER_WORKS[playerid][WORK_TRAFFICKER][pwork_SET] && PlayerTemp[playerid][pt_WORKING_IN] == WORK_TRAFFICKER) 
                {
                    new vehicleid = GetPlayerVehicleID(playerid);
                    if(!WORK_VEHICLES[vehicleid][work_vehicle_VALID]) return SendMessage(playerid, "~r~No estás conduciendo un vehiculo de trabajo.");
                    if(WORK_VEHICLES[vehicleid][work_vehicle_WORK] != WORK_TRAFFICKER) return SendMessage(playerid, "~r~No estás conduciendo un vehiculo de trabajo.");

                    for(new i = 0; i != sizeof Trafficker_Load_Points; i ++)
                    {
                        if(IsPlayerInRangeOfPoint(playerid, 3.0, Trafficker_Load_Points[i][0], Trafficker_Load_Points[i][1], Trafficker_Load_Points[i][2]))
                        {
                            if(TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_LOADED]) return 1;
                            if(TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_LOADING]) return 1;
                    
                            TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_LOADING] = true;
                            TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_DRIVER_USER_ID] = PI[playerid][pi_ID];
                                
                            SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
                                
                            GLOBAL_VEHICLES[vehicleid][gb_vehicle_PARAMS_ENGINE] = 0;
                            UpdateVehicleParams(vehicleid);
                            
                            new index;
                            while(/*!Trafficker_Contents[index][trafficker_content_VALID] && */Trafficker_Contents[index][trafficker_content_STEP] != TRAFFICKER_STEP_SEARCH)
                            {
                                index = random(TRAFFICKER_MAX_ROUTES);
                            }

                            TRAFFICKER_VEHICLE[vehicleid][trffckr_vehicle_POINT] = index;
                            
                            PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][0], "");
                            PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][0]);
                            PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][1]);
                            PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][2]);
                            PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][ptextdraw_TRUCK_LOAD][3]);
                            
                            PlayerTemp[playerid][pt_TRUCK_LOADING_VALUE] = 35.0;
                            UpdatePlayerLoadingTruckSize(playerid);
                            KillTimer(PlayerTemp[playerid][pt_TIMERS][7]);
                            KillTimer(PlayerTemp[playerid][pt_TIMERS][9]);
                            PlayerTemp[playerid][pt_TIMERS][9] = SetTimerEx("VehicleLoadUp", 1000, false, "ii", playerid, vehicleid);
                            
                            SendMessage(playerid, "~g~El vehiculo se está preparando, si sales de él se cancelará el viaje.");

                            return Y_HOOKS_BREAK_RETURN_1;
                        }
                    }
                }
            }
		}
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}