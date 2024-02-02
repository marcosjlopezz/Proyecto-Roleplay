#include <YSI-Includes\YSI\y_hooks>

#define	VEHICLE_FORKLIFT			530

new
	MECHANIC_STOCK_PIECES = 0,
	MECHANIC_GARAGE_PIECES = 500
;

stock IsVehicleForkLift(vehicleid)
{
	if(GetVehicleModel(vehicleid) == VEHICLE_FORKLIFT) return 1;
	return 0;
}

stock UpdateMechanicPiecesText3D()
{
	new str_text[445]; format(str_text, 445, "{"#PRIMARY_COLOR"}Piezas de mecánico\n{ffffff}Escribe {"#BLUE_COLOR"}/piezas [cantidad] {FFFFFF}para comprar piezas\nPrecio de pieza: {"#GREEN_COLOR"}50$\n{ffffff}Cantidad de piezas almacenadas: {"#ORANGE_COLOR"}%d", MECHANIC_GARAGE_PIECES);
	for(new i; i != sizeof MechanicBuyPiecesCoords; i++)
	{
		UpdateDynamic3DTextLabelText(MechanicBuyPiecesLabel[i], -1, str_text);
	}
	return 1;
}

stock UpdateCrateMechanicPiecesText3D()
{
	new str_text[445]; format(str_text, 445, "{"#PRIMARY_COLOR"}Cajas de Piezas\n{ffffff}Pulsa {"#BLUE_COLOR"}'H' {FFFFFF}para tomar una caja\nPiezas en la caja: {"#ORANGE_COLOR"}%d", MECHANIC_STOCK_PIECES);
	for(new i; i != sizeof MechanicPiecesForklift; i++)
	{
		UpdateDynamic3DTextLabelText(MechanicPiecesForkliftLabel[i], -1, str_text);
	}
	return 1;
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