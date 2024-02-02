/* 

	MODULO
		GUARDADO DE DATOS DE LOS JUGADORES.

	by MarcosJLopezz/Negan/Wayne2200/GamerPlayer22_0
*/

stock mysql_update_float(MySQL:handle = MYSQL_DEFAULT_HANDLE, const table[], const data[], const where[], id, Float:value)
{
    new query[6144];
    mysql_format(handle, query, sizeof query, "UPDATE %s SET %s = %f WHERE %s = %d", table, data, value, where, id);
    mysql_tquery(handle, query);

	for(new i = 0; i < sizeof(query); i++) query[i] = 0; //Limpieza
}

stock mysql_update_int(MySQL:handle = MYSQL_DEFAULT_HANDLE, const table[], const data[], const where[], id, value)
{
    new query[6144];
    mysql_format(handle, query, sizeof query, "UPDATE %s SET %s = %d WHERE %s = %d", table, data, value, where, id);
    mysql_tquery(handle, query);

	for(new i = 0; i < sizeof(query); i++) query[i] = 0; //Limpieza
}

stock mysql_update_string(MySQL:handle = MYSQL_DEFAULT_HANDLE, const table[], const data[], const where[], id, const value[])
{
    new query[6144];
    mysql_format(handle, query, sizeof query, "UPDATE %s SET %s = '%e' WHERE %s = %d", table, data, value, where, id);
    mysql_tquery(handle, query);
	
	for(new i = 0; i < sizeof(query); i++) query[i] = 0; //Limpieza
}

function:LoadPlayerGameData(playerid)
{
    inline OnPlayerDataLoad()
    {
        new rows;
        if(cache_get_row_count(rows))
        {
            if(rows)
            {
				new bool:isnull_crew;
				reg_name(0, "reg_date", PI[playerid][pi_REG_DATE], 24);
				reg_name(0, "last_connection", PI[playerid][pi_LAST_CONNECTION], 24);
				reg_int(0, "last_connection_timestamp", PI[playerid][pi_LAST_CONNECTION_TIMESTAMP]);
				reg_int(0, "time_playing", PI[playerid][pi_TIME_PLAYING]);
				reg_int(0, "level", PI[playerid][pi_LEVEL]);
				reg_int(0, "rep", PI[playerid][pi_REP]);
				reg_int(0, "doubt_channel", PI[playerid][pi_DOUBT_CHANNEL]);
				reg_int(0, "time_for_rep", PI[playerid][pi_TIME_FOR_REP]);
				reg_int(0, "admin_level", PI[playerid][pi_ADMIN_LEVEL]);
				reg_int(0, "payday_rep", PI[playerid][pi_PAYDAY_REP]);
				reg_int(0, "vip", PI[playerid][pi_VIP]);
				reg_name(0, "vip_expire_date", PI[playerid][pi_VIP_EXPIRE_DATE], 24);
				reg_int(0, "coins", PI[playerid][pi_COINS]);
				reg_int(0, "skin", PI[playerid][pi_SKIN]);
				reg_int(0, "cash", PI[playerid][pi_CASH]);
				reg_float(0, "pos_x", PI[playerid][pi_POS_X]);
				reg_float(0, "pos_y", PI[playerid][pi_POS_Y]);
				reg_float(0, "pos_z", PI[playerid][pi_POS_Z]);
				reg_float(0, "angle", PI[playerid][pi_ANGLE]);
				reg_int(0, "state", PI[playerid][pi_STATE]);
				reg_int(0, "interior", PI[playerid][pi_INTERIOR]);
				reg_int(0, "local_interior", PI[playerid][pi_LOCAL_INTERIOR]);
				reg_int(0, "fight_style", PI[playerid][pi_FIGHT_STYLE]);
				reg_float(0, "health", PI[playerid][pi_HEALTH]);
				reg_float(0, "armour", PI[playerid][pi_ARMOUR]);
				reg_int(0, "gender", PI[playerid][pi_GENDER]);
				reg_float(0, "hungry", PI[playerid][pi_HUNGRY]);
				reg_float(0, "thirst", PI[playerid][pi_THIRST]);
				reg_int(0, "wanted_level", PI[playerid][pi_WANTED_LEVEL]);
				reg_int(0, "police_jail_time", PI[playerid][pi_POLICE_JAIL_TIME]);
				reg_int(0, "police_duty", PI[playerid][pi_POLICE_DUTY]);
				reg_int(0, "police_jail_id", PI[playerid][pi_POLICE_JAIL_ID]);
				reg_int(0, "bank_account", PI[playerid][pi_BANK_ACCOUNT]);
				reg_int(0, "bank_money", PI[playerid][pi_BANK_MONEY]);
				reg_int(0, "phone_number", PI[playerid][pi_PHONE_NUMBER]);
				reg_int(0, "phone_state", PI[playerid][pi_PHONE_STATE]);
				reg_int(0, "phone_visible_number", PI[playerid][pi_PHONE_VISIBLE_NUMBER]);
				reg_int(0, "gps", PI[playerid][pi_GPS]);
				reg_int(0, "mp3", PI[playerid][pi_MP3]);
				reg_int(0, "phone_resolver", PI[playerid][pi_PHONE_RESOLVER]);
				reg_int(0, "speakers", PI[playerid][pi_SPEAKERS]);
				reg_int(0, "mechanic_pieces", PI[playerid][pi_MECHANIC_PIECES]);
				reg_int(0, "fuel_drum", PI[playerid][pi_FUEL_DRUM]);
				reg_int(0, "seed_medicine", PI[playerid][pi_SEED_MEDICINE]);
				reg_int(0, "seed_cannabis", PI[playerid][pi_SEED_CANNABIS]);
				reg_int(0, "seed_crack", PI[playerid][pi_SEED_CRACK]);
				reg_int(0, "medicine", PI[playerid][pi_MEDICINE]);
				reg_int(0, "cannabis", PI[playerid][pi_CANNABIS]);
				reg_int(0, "crack", PI[playerid][pi_CRACK]);
				reg_int(0, "config_sounds", PI[playerid][pi_CONFIG_SOUNDS]);
				reg_int(0, "config_audio", PI[playerid][pi_CONFIG_AUDIO]);
				reg_int(0, "config_time", PI[playerid][pi_CONFIG_TIME]);
				reg_int(0, "config_hud", PI[playerid][pi_CONFIG_HUD]);
				reg_int(0, "config_admin", PI[playerid][pi_CONFIG_ADMIN]);
				reg_int(0, "mute", PI[playerid][pi_MUTE]);
				reg_int(0, "placa_pd", PI[playerid][pi_PLACA_PD]);
				cache_is_value_name_null(0, "crew", isnull_crew);
				if(!isnull_crew) reg_int(0, "crew", PI[playerid][pi_CREW]);
				reg_int(0, "crew_rank", PI[playerid][pi_CREW_RANK]);
				reg_int(0, "mechanic_kits", PI[playerid][pi_MECHANIC_KITS]);
				reg_int(0, "medical_kits", PI[playerid][pi_MEDICAL_KITS]);
				reg_int(0, "truck_bonus", PI[playerid][pi_TRUCK_BONUS]);
				CallLocalFunction("OnPlayerLogin", "i", playerid);
            }
            else Kick(playerid);
        }
        else Kick(playerid);
    }
    mysql_format(handle_db, QUERY_BUFFER, sizeof QUERY_BUFFER, "SELECT * FROM player WHERE id = %d;", PI[playerid][pi_ID]);
    mysql_tquery_inline(handle_db, QUERY_BUFFER, using inline OnPlayerDataLoad);
}

ResetPlayerVariables(playerid)
{
	static const tmp_PI[enum_PI]; PI[playerid] = tmp_PI;

	static const temp_PlayerTemp[enum_PT]; PlayerTemp[playerid] = temp_PlayerTemp;
	
	static const temp_PLAYER_TOYS[Player_Toys_Info];
	for(new i = 0; i != MAX_SU_TOYS; i ++) PLAYER_TOYS[playerid][i] = temp_PLAYER_TOYS;
	
	static const temp_PLAYER_POCKET[Player_Pocket_Enum];
	for(new i = 0; i != MAX_PLAYER_POCKET_OBJECTS; i ++) PLAYER_POCKET[playerid][i] = temp_PLAYER_POCKET;
	
	
	static const temp_PLAYER_PHONE_BOOK[Phone_Book_Enum]; 
	for(new i = 0; i != MAX_PHONE_CONTACTS; i ++) PLAYER_PHONE_BOOK[playerid][i] = temp_PLAYER_PHONE_BOOK;
	
	static const temp_PLAYER_GPS[Player_GPS_Enum]; 
	for(new i = 0; i != MAX_PLAYER_GPS_SAVES; i ++) PLAYER_GPS[playerid][i] = temp_PLAYER_GPS;
	
	static const tmp_PLAYER_WORKS[enum_PLAYER_WORKS];
	for(new i = 0; i != sizeof(PLAYER_WORKS[]); i ++) PLAYER_WORKS[playerid][i] = tmp_PLAYER_WORKS;
	
	static const temp_PLAYER_PROPERTY_CONSTRUCTO[PLAYER_PROPERTY_CONSTRUCTOR_ENU]; PLAYER_PROPERTY_CONSTRUCTOR[playerid] = temp_PLAYER_PROPERTY_CONSTRUCTO;
	
	pTemp(playerid)[pt_NOTARY_TO_PLAYER] = INVALID_PLAYER_ID;
	pTemp(playerid)[pt_ADMIN_SERVICE] = false;

	static const tmp_PLAYER_WEAPONS[enum_PLAYER_WEAPONS];
	for(new i = 0; i != sizeof PLAYER_WEAPONS[]; i ++) PLAYER_WEAPONS[playerid][i] = tmp_PLAYER_WEAPONS;
	
	static const tmp_PLAYER_AC_INFO[e_PLAYER_AC_INFO];
	for(new i = 0; i != sizeof(ac_Info); i ++) PLAYER_AC_INFO[playerid][i] = tmp_PLAYER_AC_INFO;
}

ResetPlayerTemp(playerid)
{
	pTemp(playerid)[pt_GAME_STATE] = 0;
	pTemp(playerid)[pt_NAME] = 0;
	pTemp(playerid)[pt_IP] = 0;
	pTemp(playerid)[pt_USER_EXIST] = false; // Esta registrado?
	pTemp(playerid)[pt_USER_LOGGED] = false; // 1 = ha cargado todos los datos del user
	pTemp(playerid)[pt_ANTIFLOOD_COMMANDS] = 0;
	pTemp(playerid)[pt_ANTIFLOOD_TALK] = 0;
	pTemp(playerid)[pt_TIMERS] = 0;
	pTemp(playerid)[pt_USER_VALID_NAME] = false;
	pTemp(playerid)[pt_BAD_LOGIN_ATTEMP] = 0;
	pTemp(playerid)[pt_DOUBT_CHANNEL_TIME] = 0;
	pTemp(playerid)[pt_LAST_PICKUP_ID] = 0;
	pTemp(playerid)[pt_LAST_AREA_ID] = 0;
	pTemp(playerid)[pt_HOSPITAL] = 0;
	pTemp(playerid)[pt_HOSPITAL_LIFE] = 0;
	pTemp(playerid)[pt_TIME_PASSED_LAST_REP] = 0;
	pTemp(playerid)[pt_INTERIOR_INDEX] = 0;
	pTemp(playerid)[pt_CLOTHING_SHOP] = 0;
	pTemp(playerid)[pt_CLOTHING_SHOP_SELECTED_SKIN] = 0;
	pTemp(playerid)[pt_SELECT_TEXTDRAW] = false;
	pTemp(playerid)[pt_HUD_TEXTDRAWS] = false;
	pTemp(playerid)[pt_THIRST_MESSAGE] = false;
	pTemp(playerid)[pt_HUNGRY_MESSAGE] = false;
	pTemp(playerid)[pt_TOYS_SHOP] = false;
	pTemp(playerid)[pt_TOYS_SHOP_TOY_SELECTED] = 0;
	pTemp(playerid)[pt_SELECTED_TOY_SLOT] = 0;
	pTemp(playerid)[pt_SELECT_BANK_TRANSFER_ACCOUNT] = 0;
	pTemp(playerid)[pt_SELECT_BANK_TRANSFER_ID] = 0;
	pTemp(playerid)[pt_PLAYER_IN_ATM] = false;
	pTemp(playerid)[pt_POCKET_SLOT_SELECTED] = 0;
	pTemp(playerid)[pt_PHONE_COMMANDS_MESSAGE] = false;
	pTemp(playerid)[pt_PLAYER_IN_CALL] = false;
	pTemp(playerid)[pt_PLAYER_PHONE_CALL_STATE] = 0;
	pTemp(playerid)[pt_PLAYER_PHONE_CALL_PLAYERID] = 0;
	pTemp(playerid)[pt_PLAYER_LISTITEM] = 0;
	pTemp(playerid)[pt_PLAYER_PHONE_BOOK_ADD_NUMBER] = 0;
	pTemp(playerid)[pt_PLAYER_PHONE_BOOK_SELECTED] = 0;
	pTemp(playerid)[pt_PLAYER_PHONE_NUMBER_SELECTED] = 0;
	pTemp(playerid)[pt_BUY_HOUSE_INDEX] = 0;
	pTemp(playerid)[pt_PLAYER_FINISH_HOSPITAL] = false;
	pTemp(playerid)[pt_ANTIFLOOD_KNOCK_PROPERTY] = 0;
	pTemp(playerid)[pt_KNOCK_PLAYER_ID] = 0;
	pTemp(playerid)[pt_GPS_CHECKPOINT] = INVALID_STREAMER_ID;
	pTemp(playerid)[pt_GPS_PLAYER_SELECTED] = 0;
	pTemp(playerid)[pt_PLAYER_GPS_SELECTED_PROPERTY] = 0;
	pTemp(playerid)[pt_PLAYER_PROPERTY_SELECTED] = 0;
	pTemp(playerid)[pt_PLAYER_WAITING_MP3_HTTP] = false;
	pTemp(playerid)[pt_MUSIC_FOR_PROPERTY] = false;
	pTemp(playerid)[pt_MUSIC_FOR_VEHICLE] = false;
	pTemp(playerid)[pt_SELECTED_BUY_VEHICLE_ID] = false;
	pTemp(playerid)[pt_LAST_VEHICLE_ID] = 0;
	pTemp(playerid)[pt_NOTARY_OPTION] = 0; //0 al banco] = 0; 1 a persona
	pTemp(playerid)[pt_NOTARY_PRICE] = 0;
	pTemp(playerid)[pt_NOTARY_TO_PLAYER] = 0;
	pTemp(playerid)[pt_PLAYER_VEHICLE_SELECTED] = 0;
	pTemp(playerid)[pt_TAXI_METER_ENABLED] = false;
	pTemp(playerid)[pt_WANT_TAXI] = false;
	pTemp(playerid)[pt_TRUCK_LOADING_VALUE] = 0;
	pTemp(playerid)[pt_TRUCK_CHECKPOINT] = INVALID_STREAMER_ID;
	pTemp(playerid)[pt_TUNING_SELECTED_PART] = 0;
	pTemp(playerid)[pt_TUNING_SELECTED_COMPONENT] = 0;
	pTemp(playerid)[pt_TUNING_SELECTED_COMPONENT_ID] = 0;
	pTemp(playerid)[pt_TUNING_SELECTED_PIECES] = 0;
	pTemp(playerid)[pt_PAINTJOB_SELECTED_ID] = 0;
	pTemp(playerid)[pt_WORKING_IN] = 0;
	pTemp(playerid)[pt_SELECTED_MECHANIC_VEHICLE_ID] = 0;
	pTemp(playerid)[pt_MECHANIC_COLOR_SLOT] = 0;
	pTemp(playerid)[pt_HARVERT_CHECKPOINT] = INVALID_STREAMER_ID;
	pTemp(playerid)[pt_HARVERT_PROCCESS] = 0;
	pTemp(playerid)[pt_PIZZA_CHECKPOINT] = INVALID_STREAMER_ID;
	pTemp(playerid)[pt_TRASH_DRIVER] = false;
	pTemp(playerid)[pt_TRASH_PASSENGER] = false;
	pTemp(playerid)[pt_TRASH_VEHICLE_ID] = 0;
	pTemp(playerid)[pt_TRASH_CHECKPOINT] = INVALID_STREAMER_ID;
	pTemp(playerid)[pt_RECYCLE_BIN_VALUE] = 0;
	pTemp(playerid)[pt_BUS_CHECKPOINT] = INVALID_STREAMER_ID;
	pTemp(playerid)[pt_PLAYER_CARRYING_TREE] = false;
	pTemp(playerid)[pt_PLAYER_LUMBERJACK_TREE] = 0;
	pTemp(playerid)[pt_LUMBERJACK_CHECKPOINT] = INVALID_STREAMER_ID;
	pTemp(playerid)[pt_LAST_GOT_WORK_TIME] = 0;
	pTemp(playerid)[pt_LAST_GIVE_MONEY_TIME] = 0;
	pTemp(playerid)[pt_SELECTED_BUY_SEED_ID] = 0;
	pTemp(playerid)[pt_PLANTING] = false;
	pTemp(playerid)[pt_PLANTING_PLANT_SELECTED] = 0;
	pTemp(playerid)[pt_GPS_MAP] = false;
	pTemp(playerid)[pt_PROPERTY_INDEX] = 0;
	pTemp(playerid)[pt_KICKED] = false;
	pTemp(playerid)[pt_SELECTED_DIALOG_WEAPON_SLOT] = 0;
	pTemp(playerid)[pt_TRICK_SELLER_PID] = 0;
	pTemp(playerid)[pt_TRICK_SELLER_AID] = 0;
	pTemp(playerid)[pt_TRICK_SELLER_EXTRA] = 0;
	pTemp(playerid)[pt_TRICK_PRICE] = 0;
	pTemp(playerid)[pt_TRICK_TIME] = 0;
	pTemp(playerid)[pt_DIALOG_BOT_VEHICLE] = 0;
	pTemp(playerid)[pt_DIALOG_BOT_VEHICLE_BOOT_SLOT] = 0;
	pTemp(playerid)[pt_POLICE_RADIO] = 0;
	pTemp(playerid)[pt_CUFFING] = false;
	pTemp(playerid)[pt_CUFFED] = false;
	pTemp(playerid)[pt_ENTER_JAIL_TIME] = 0;
	pTemp(playerid)[pt_DIALOG_DB_LIMIT] = 0;
	pTemp(playerid)[pt_DIALOG_DB_PAGE] = 0;
	pTemp(playerid)[pt_SELECTED_DB_AC_ID] = 0;
	pTemp(playerid)[pt_POLICE_CALL_NAME] = false;
	pTemp(playerid)[pt_POLICE_CALL_DESCRIPTION] = false;
	pTemp(playerid)[pt_POLICE_CALL_NAME_STR] = 0;
	pTemp(playerid)[pt_SAVE_ACCOUNT_TIME] = 0;
	pTemp(playerid)[pt_ANTIFLOOD_REPORT] = 0;
	pTemp(playerid)[pt_SEE_ACMD_LOG] = false;
	pTemp(playerid)[pt_SEE_ADM_LOG] = false;
	pTemp(playerid)[pt_SEE_ADM_CHAT] = false;
	pTemp(playerid)[pt_LAST_CHEAT_DETECTED_TIME] = 0;
	pTemp(playerid)[pt_SEE_AC_LOG] = false;
	pTemp(playerid)[pt_ANTIFLOOD_DEATH] = 0;
	pTemp(playerid)[pt_ANTIFLOOD_STATE] = 0;
	pTemp(playerid)[pt_ANTIFLOOD_ENTER_VEHICLE] = 0;
	pTemp(playerid)[pt_SELECTED_AC_LISTITEM] = 0;
	pTemp(playerid)[pt_ADMIN_PM_PID] = 0;
	pTemp(playerid)[pt_ADMIN_PM_AID] = 0;
	pTemp(playerid)[pt_ADMIN_PM_TIME] = 0;
	pTemp(playerid)[pt_MECHANIC_PID] = 0;
	pTemp(playerid)[pt_MECHANIC_AID] = 0;
	pTemp(playerid)[pt_MECHANIC_PRICE] = 0;
	pTemp(playerid)[pt_MECHANIC_TEXT] = 0;
	pTemp(playerid)[pt_MECHANIC_TYPE] = 0;
	pTemp(playerid)[pt_MECHANIC_EXTRA] = 0;
	pTemp(playerid)[pt_MECHANIC_VEHICLE_ID] = 0;
	pTemp(playerid)[pt_MECHANIC_PIECES] = 0;
	pTemp(playerid)[pt_MECHANIC_TIME] = 0;
	pTemp(playerid)[pt_MECHANIC_SELECTED_COLOR] = 0;
	pTemp(playerid)[pt_MECHANIC_SELECTED_COMPONENT] = 0;
	pTemp(playerid)[pt_SHOP] = false;
	pTemp(playerid)[pt_SHOP_STATE] = 0;
	pTemp(playerid)[pt_SHOP_ARTICLE_ID] = 0;
	pTemp(playerid)[pt_SHOP_SELECTED_ARTICLE_ID] = 0;
	pTemp(playerid)[pt_SHOP_COME_FROM_MY_ADS] = false;
	pTemp(playerid)[pt_ANTIFLOOD_SHOP] = 0;	
	pTemp(playerid)[pt_SHOP_ADD_TYPE] = 0;
	pTemp(playerid)[pt_SHOP_ADD_TEXT] = 0;
	pTemp(playerid)[pt_SHOP_ADD_MODELID] = 0;
	pTemp(playerid)[pt_SHOP_ADD_VCOL1] = 0;
	pTemp(playerid)[pt_SHOP_ADD_VCOL2] = 0;
	pTemp(playerid)[pt_VIRTUAL_WORLD] = 0;
	pTemp(playerid)[pt_PLAYER_SPECTATE] = false;
	pTemp(playerid)[pt_PIZZA_PROCCESS] = 0;
	pTemp(playerid)[pt_DELIVERED_PIZZAS] = 0;
	pTemp(playerid)[pt_PIZZA_ACTOR] = 0;
	pTemp(playerid)[pt_LAST_PLANT_TIME] = 0;
	pTemp(playerid)[pt_LAST_SET_WANTED_LEVEL] = 0;
	pTemp(playerid)[pt_CREATE_CREW_NAME] = 0;
	pTemp(playerid)[pt_CREATE_CREW_COLOR] = 0;
	pTemp(playerid)[pt_CREW_INVITE_PID] = 0;
	pTemp(playerid)[pt_CREW_INVITE_AID] = 0;
	pTemp(playerid)[pt_CREW_INVITE_INFO] = 0;
	pTemp(playerid)[pt_CREW_SELECTED_RANK] = 0;
	pTemp(playerid)[pt_CREW_SELECTED_NEW_RANK] = 0;
	pTemp(playerid)[pt_LAST_TERRITORY] = 0;
	pTemp(playerid)[pt_PLAYER_TERRITORY_PRO] = 0;
	pTemp(playerid)[pt_PLAYER_COLOR] = 0;
	pTemp(playerid)[pt_LAST_GOT_CREW] = 0;
	pTemp(playerid)[pt_POLICE_PEN_PID] = 0;
	pTemp(playerid)[pt_POLICE_PEN_AID] = 0;
	pTemp(playerid)[pt_POLICE_PEN_IM] = 0;
	pTemp(playerid)[pt_POLICE_PEN_TIME] = 0;
	pTemp(playerid)[pt_LAST_SU_CHECK] = 0;
	pTemp(playerid)[pt_PIVOT_OBJECT] = 0;
	pTemp(playerid)[pt_LAST_SHOT_ROBBERY] = 0;
	pTemp(playerid)[pt_PASSWD] = 0;
	pTemp(playerid)[pt_CONTROL] = false;
	pTemp(playerid)[pt_SELECTING_STYLE] = 0;
	pTemp(playerid)[pt_SELECTED_STYLE] = 0;
	pTemp(playerid)[pt_PROPERTY_CINFO] = 0;
	pTemp(playerid)[pt_CJ_WARNINGS] = 0;
	pTemp(playerid)[pt_FIRST_NAME] = 0;
	pTemp(playerid)[pt_SUB_NAME] = 0;
	pTemp(playerid)[pt_POLICE_LABEL] = Text3D:INVALID_STREAMER_ID;
	pTemp(playerid)[pt_ADMIN_SERVICE] = false;
	pTemp(playerid)[pt_ADMIN_LABEL] = Text3D:INVALID_STREAMER_ID;
	pTemp(playerid)[pt_LAST_SAFE_ZONE_WARNING] = 0;
	pTemp(playerid)[pt_SELECTED_POLICE_OBJECT_INDEX] = 0;
	pTemp(playerid)[pt_SELECTED_BYC_ID] = 0;
	pTemp(playerid)[pt_SELECTED_BYC_USER_ID] = 0;
	pTemp(playerid)[pt_DIALOG_RESPONDED] = false;
	pTemp(playerid)[pt_DIALOG_ID] = 0;
	pTemp(playerid)[pt_SPEAKERS_TIME] = 0;
	pTemp(playerid)[pt_MUSIC_FOR_SPEAKERS] = false;
	pTemp(playerid)[pt_FUMIGATOR_CHECKPOINT] = INVALID_STREAMER_ID;
	pTemp(playerid)[pt_FUMIGATOR_PROCCESS] = 0;
	pTemp(playerid)[pt_COOLDOWN_MEDICINE] = 0;
	pTemp(playerid)[pt_COOLDOWN_CRACK] = 0;
	pTemp(playerid)[pt_COOLDOWN_WEED] = 0;
	pTemp(playerid)[pt_SELECTED_OBJECT] = 0;
	pTemp(playerid)[pt_DIALOG_CLOSET_PROPERTY] = 0;
	pTemp(playerid)[pt_DIALOG_CLOSET_PROPERTY_SLOT] = 0;
	pTemp(playerid)[pt_CLASSED] = false;
	pTemp(playerid)[pt_CREW_INDEX] = 0;
	pTemp(playerid)[pt_DEATH_TIME] = 0;
	pTemp(playerid)[pt_CREW_HELP] = false;
	pTemp(playerid)[pt_COMBAT] = false;
	pTemp(playerid)[pt_COMBAT_TIMER] = 0;
	pTemp(playerid)[pt_LAST_VEHICLE_DESTROY] = 0;
	pTemp(playerid)[pt_LOGIN_KICK_TIMER] = 0;
	pTemp(playerid)[pt_COOLDOWN_MEDICAL_KIT] = 0;
	pTemp(playerid)[pt_SELECTED_GRAFFITI] = 0;
	pTemp(playerid)[pt_PAYDAY_NOTIFICATION] = false;
	pTemp(playerid)[pt_INJURED_POS] = 0;
	pTemp(playerid)[pt_DROP_ITEM_TIMER] = 0;
	pTemp(playerid)[pt_LAST_PLAYER_POS] = 0;
	pTemp(playerid)[pt_LAST_PLAYER_WORLD] = 0;
	pTemp(playerid)[pt_LAST_PLAYER_INTERIOR] = 0;
	pTemp(playerid)[pt_PLAYER_PASS] = false;
	pTemp(playerid)[pt_LOGGINING] = false;
	pTemp(playerid)[pt_DEATH_HOTDOG_BYPASS] = false;
	pTemp(playerid)[pt_MECHANIC_LABEL] = Text3D:INVALID_STREAMER_ID;
	pTemp(playerid)[pt_OWN_VEHICLE_TAXI] = false;
	pTemp(playerid)[pt_GLOBAL_CHANNEL_TIMER] = 0;
	pTemp(playerid)[pt_ATM_MAKER] = false;
	pTemp(playerid)[pt_GPS_TELEPORT] = false;
	pTemp(playerid)[pt_PLAYER_INVISIBLE] = false;
	pTemp(playerid)[pt_DISPENSARY] = 0;
	pTemp(playerid)[pt_PLAYER_KEYS] = 0;
	pTemp(playerid)[pt_PLAYER_KEYS_OWNER] = 0;
	pTemp(playerid)[pt_SELECTED_PLAYER] = 0;
	pTemp(playerid)[pt_GARAGE_INDEX] = 0;
	pTemp(playerid)[pt_EDITING_EXT_GPOS] = false;
	pTemp(playerid)[pt_SV_MODELID] = 0;
	pTemp(playerid)[pt_SV_COLOUR_0] = 0;
	pTemp(playerid)[pt_SV_COLOUR_1] = 0;
	pTemp(playerid)[pt_SV_VIP] = false;
	pTemp(playerid)[pt_SV_LEVEL] = 0;
	pTemp(playerid)[pt_SV_PRICE] = 0;
	pTemp(playerid)[pt_SV_SELECTED_PRICE] = 0;
	pTemp(playerid)[pt_SV_EXTRA] = 0;
	pTemp(playerid)[pt_SV_SHOP] = 0;
}

ResetPlayerInfo(playerid)
{
    PI[playerid][pi_ID] = 0;
	PI[playerid][pi_NAME] = 0;
	PI[playerid][pi_IP] = 0;
	PI[playerid][pi_EMAIL] = 0;
	PI[playerid][pi_SALT] = 0;
	PI[playerid][pi_PASS] = 0;
	PI[playerid][pi_REG_DATE] = 0;
	PI[playerid][pi_LAST_CONNECTION] = 0;
	PI[playerid][pi_LAST_CONNECTION_TIMESTAMP] = 0;
	PI[playerid][pi_TIME_PLAYING] = 0;
	PI[playerid][pi_LEVEL] = 0;
	PI[playerid][pi_REP] = 0;
	PI[playerid][pi_CONNECTED] = 0;
	PI[playerid][pi_PLAYERID] = 0;
	PI[playerid][pi_DOUBT_CHANNEL] = 0;
	PI[playerid][pi_TIME_FOR_REP] = 0;
	PI[playerid][pi_ADMIN_LEVEL] = 0;
	PI[playerid][pi_PAYDAY_REP] = 0;
	PI[playerid][pi_VIP] = 0;
	PI[playerid][pi_VIP_EXPIRE_DATE] = 0;
	PI[playerid][pi_COINS] = 0;
	PI[playerid][pi_SKIN] = 0;
	PI[playerid][pi_CASH] = 0;
	PI[playerid][pi_POS_X] = 0;
	PI[playerid][pi_POS_Y] = 0;
	PI[playerid][pi_POS_Z] = 0;
	PI[playerid][pi_ANGLE] = 0;
	PI[playerid][pi_STATE] = 0;
	PI[playerid][pi_INTERIOR] = 0;
	PI[playerid][pi_LOCAL_INTERIOR] = 0;
	PI[playerid][pi_FIGHT_STYLE] = 0;
	PI[playerid][pi_HEALTH] = 0;
	PI[playerid][pi_ARMOUR] = 0;
	PI[playerid][pi_GENDER] = 0;
	PI[playerid][pi_HUNGRY] = 0;
	PI[playerid][pi_THIRST] = 0;
	PI[playerid][pi_WANTED_LEVEL] = 0;
	PI[playerid][pi_POLICE_JAIL_TIME] = 0;
	PI[playerid][pi_POLICE_DUTY] = 0;
	PI[playerid][pi_POLICE_JAIL_ID] = 0;
	PI[playerid][pi_BANK_ACCOUNT] = 0;
	PI[playerid][pi_BANK_MONEY] = 0;
	PI[playerid][pi_PHONE_NUMBER] = 0;
	PI[playerid][pi_PHONE_STATE] = 0;
	PI[playerid][pi_PHONE_VISIBLE_NUMBER] = 0;
	PI[playerid][pi_GPS] = 0;
	PI[playerid][pi_MP3] = 0;
	PI[playerid][pi_PHONE_RESOLVER] = 0;
	PI[playerid][pi_SPEAKERS] = 0;
	PI[playerid][pi_MECHANIC_PIECES] = 0;
	PI[playerid][pi_FUEL_DRUM] = 0;
	PI[playerid][pi_SEED_MEDICINE] = 0;
	PI[playerid][pi_SEED_CANNABIS] = 0;
	PI[playerid][pi_SEED_CRACK] = 0;
	PI[playerid][pi_MEDICINE] = 0;
	PI[playerid][pi_CANNABIS] = 0;
	PI[playerid][pi_CRACK] = 0;
	PI[playerid][pi_CONFIG_SOUNDS] = 0;
	PI[playerid][pi_CONFIG_AUDIO] = 0;
	PI[playerid][pi_CONFIG_TIME] = 0;
	PI[playerid][pi_CONFIG_HUD] = 0;
	PI[playerid][pi_CONFIG_ADMIN] = 0;
	PI[playerid][pi_MUTE] = 0;
	PI[playerid][pi_PLACA_PD] = 0;
	PI[playerid][pi_CREW] = 0;
	PI[playerid][pi_CREW_RANK] = 0;
	PI[playerid][pi_MECHANIC_KITS] = 0;
	PI[playerid][pi_MEDICAL_KITS] = 0;
	PI[playerid][pi_TRUCK_BONUS] = 0;
}