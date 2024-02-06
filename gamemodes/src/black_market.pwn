#include <YSI-Includes\YSI\y_hooks>

/* 
	DIALOG_BLACK_MARKET
    DIALOG_BLACK_MARKET_ARTICLES
	DIALOG_BLACK_MARKET_WEAPON
	DIALOG_BLACK_MARKET_AMMO

    pt_BM_SELECTED_WEAPON
*/

#define BmArticles  BLACK_MARKET_ARTICLES
#define AMMO_PRICE  1

new Float:BlackMarketShopPos[] = {292.0055, -106.7242, 1001.5156};
new Float:BlackMarketActorPos[] = {291.8348, -104.1821, 1001.5229, 180.0};

hook OnScriptInit()
{
    CreateDynamic3DTextLabel("Mercado Negro\nPulsa {"#ORANGE_COLOR"}'H'{ffffff} para ver las opciones", -1, BlackMarketShopPos[0], BlackMarketShopPos[1], BlackMarketShopPos[2], 15.0, .testlos = true, .interiorid = 6, .worldid = -1);
    CreateDynamicActor(24, BlackMarketActorPos[0], BlackMarketActorPos[1], BlackMarketActorPos[2], BlackMarketActorPos[3], 1, 100.0, -1, 6);
}

stock ShowBlackMarketDialog(playerid, dialogid)
{
    switch(dialogid)
    {
        case DIALOG_BLACK_MARKET:
        {
            ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_TABLIST, "Mercado Negro", "{d1d1d1}Comprar Articulos\n{d1d1d1}Comprar Municion", "Continuar", "Cerrar");
        }
        case DIALOG_BLACK_MARKET_ARTICLES:
        {
            new dialog[(145 * sizeof(BLACK_MARKET_ARTICLES) + 2)], line_str[(145 + 2)], listitem; //145 caracteres cada linea incluyendo el \n.

            for(new i = 0; i != MAX_LISTITEMS; i++ ) pTemp(playerid)[pt_PLAYER_LISTITEM][i] = -1;
            LoopEx(i, sizeof(BLACK_MARKET_ARTICLES), 0)
            {
                switch(BmArticles[i][bm_ARTICLE])
                {
                    case BM_ARTICLE_WEAPON:
                    {
                        if(BLACK_MARKET_ARTICLES[i][bm_ARTICLE_PRICE]) format(line_str, sizeof(line_str), "{d1d1d1}%s\t{d1d1d1}%s$\n", WEAPON_INFO[ BLACK_MARKET_ARTICLES[i][bm_ARTICLE_ID] ][weapon_info_NAME], number_format_thousand(BLACK_MARKET_ARTICLES[i][bm_ARTICLE_PRICE]));
                        else format(line_str, sizeof(line_str), "{d1d1d1}%s\t{d1d1d1}%s "SERVER_COIN"\n", WEAPON_INFO[ BLACK_MARKET_ARTICLES[i][bm_ARTICLE_ID] ][weapon_info_NAME], number_format_thousand(BLACK_MARKET_ARTICLES[i][bm_ARTICLE_EXTRA]));
                        strcat(dialog, line_str);
                    }
                }

                pTemp(playerid)[pt_PLAYER_LISTITEM][listitem] = i;
                listitem ++;
            }

            ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_TABLIST, "Mercado Negro - Articulos", dialog, "Comprar", "Cerrar");
        }
        case DIALOG_BLACK_MARKET_WEAPON:
        {
			for(new i = 0; i != MAX_LISTITEMS; i ++) pTemp(playerid)[pt_PLAYER_LISTITEM][i] = -1;
			
			new dialog[95 * 15], line_str[95], listitem;
			format(dialog, sizeof dialog, "{"#SILVER_COLOR"}Arma\t{"#BLUE_COLOR"}Munición\t{"#SILVER_COLOR"}Slot\n");
			
			for(new i = 0; i < sizeof PLAYER_WEAPONS[]; i ++)
			{
				if(!PLAYER_WEAPONS[playerid][i][player_weapon_VALID]) continue;
				
				format(line_str, sizeof line_str, "{"#SILVER_COLOR"}%s\t{"#BLUE_COLOR"}%s\t{"#SILVER_COLOR"}%d\n", WEAPON_INFO[ PLAYER_WEAPONS[playerid][i][player_weapon_ID] ][weapon_info_NAME], number_format_thousand(PLAYER_WEAPONS[playerid][i][player_weapon_AMMO]), i);
				strcat(dialog, line_str);
				
				pTemp(playerid)[pt_PLAYER_LISTITEM][listitem] = i; 
				listitem ++;
			}
			
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_TABLIST_HEADERS, "Seleccionar Arma", dialog, "Continuar", "Cerrar");
        }
        case DIALOG_BLACK_MARKET_AMMO:
        {
            new dialog[(445 + WEAPON_INFO[ PLAYER_WEAPONS[playerid][ pTemp(playerid)[pt_BM_SELECTED_WEAPON] ][player_weapon_ID] ][weapon_info_NAME])];

            format
            (
                dialog, sizeof(dialog),
                "\
                    {d1d1d1}Escribe la cantidad de balas que quieres comprar para tu %s.\n\
                    {d1d1d1}Precio de cada bala: "AMMO_PRICE"$.\n\
                    \n\
                    {d1d1d1}No puedes tener mas de 5000 balas en cada arma.\n\
                    \n\
                ",
                    WEAPON_INFO[ PLAYER_WEAPONS[playerid][ pTemp(playerid)[pt_BM_SELECTED_WEAPON] ][player_weapon_ID] ][weapon_info_NAME]
            );

            ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, "Comprar Balas", dialog, "Continuar", "Cerrar");
        }
    }
    return 1;
}

enum
{
    BM_ARTICLE_WEAPON
}

enum e_bm_article_info
{
    bm_ARTICLE,
    bm_ARTICLE_NAME[32],
    bm_ARTICLE_PRICE,
    bm_ARTICLE_EXTRA,
    bm_ARTICLE_ID
};
new BLACK_MARKET_ARTICLES[][e_bm_article_info] =
{
    {BM_ARTICLE_WEAPON, "", 2500, 0, 4},
    {BM_ARTICLE_WEAPON, "", 5500, 0, 22},
    {BM_ARTICLE_WEAPON, "", 5500, 0, 23},
    {BM_ARTICLE_WEAPON, "", 15345, 0, 24},
    {BM_ARTICLE_WEAPON, "", 17250, 0, 25},
    {BM_ARTICLE_WEAPON, "", 42310, 0, 27},
    {BM_ARTICLE_WEAPON, "", 34715, 0, 29},
    {BM_ARTICLE_WEAPON, "", 62520, 0, 30},
    {BM_ARTICLE_WEAPON, "", 174325, 0, 34}
};