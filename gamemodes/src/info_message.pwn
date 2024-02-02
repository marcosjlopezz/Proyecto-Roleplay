#include <YSI-Includes\YSI\y_hooks>

#include <td-string-width>

#define TD_INFOMESSAGE_LETTER_X 0.195999
#define TD_INFOMESSAGE_LETTER_Y 1.002667

enum InformationTDN
{
    Use,
    Line,
    Text[1024],
    PlayerText:TextDraw,
    Float:MinPosY,
    Float:MaxPosY,
    Hide,
    Timer
}
new TextDrawsInfoMessage[MAX_PLAYERS][3][InformationTDN],
    counter_@[MAX_PLAYERS];

forward TimerHideInfoMessage(playerid);
public TimerHideInfoMessage(playerid)
{
    for(new cycle; cycle < 3; cycle++)
    {
        if(TextDrawsInfoMessage[playerid][cycle][Hide] == -1)
        {
            TextDrawsInfoMessage[playerid][cycle][Use] = 0;
            if(TextDrawsInfoMessage[playerid][cycle][TextDraw] != PlayerText:-1)
            {
                PlayerTextDrawDestroy(playerid, TextDrawsInfoMessage[playerid][cycle][TextDraw]);
                TextDrawsInfoMessage[playerid][cycle][Line] = 0;
                TextDrawsInfoMessage[playerid][cycle][Text][0] = EOS;
                TextDrawsInfoMessage[playerid][cycle][MinPosY] = 0;
                TextDrawsInfoMessage[playerid][cycle][MaxPosY] = 0;
                TextDrawsInfoMessage[playerid][cycle][TextDraw] = PlayerText:-1;
            }
            TextDrawsInfoMessage[playerid][cycle][Hide] = -1;
            UpdateInfoMessage(playerid);

            return 1;
        }
    }
    return 0;
}

forward SendInfoMessage(playerid, const reason[]); 
public SendInfoMessage(playerid, const reason[])
{
    for(new cycle; cycle < 3; cycle++)
    {
        if(!TextDrawsInfoMessage[playerid][cycle][Use])
        {
            TextDrawsInfoMessage[playerid][cycle][Text][0] = EOS;

            strcat(TextDrawsInfoMessage[playerid][cycle][Text], reason, 1024);
            FixTextDrawString(TextDrawsInfoMessage[playerid][cycle][Text]);

            TextDrawsInfoMessage[playerid][cycle][Use] = 1;
 
            LinesInfoMessage(playerid, cycle);

            MinPosYInfoMessage(playerid, cycle);
            MaxPosYInfoMessage(playerid, cycle);

            TextDrawsInfoMessage[playerid][cycle][Hide] = -1;

            CreateTDN(playerid, cycle);

            SetTimerEx("TimerHideInfoMessage", 10000, false, "i", playerid);
            return 1;
        }
    }
    return -1;
}

forward SendInfoMessage_Manual(playerid, const reason[]); 
public SendInfoMessage_Manual(playerid, const reason[])
{
    for(new cycle; cycle < 3; cycle++)
    {
        if(!TextDrawsInfoMessage[playerid][cycle][Use])
        {
            TextDrawsInfoMessage[playerid][cycle][Text][0] = EOS;

            strcat(TextDrawsInfoMessage[playerid][cycle][Text], reason, 1024);
            FixTextDrawString(TextDrawsInfoMessage[playerid][cycle][Text]);
 
            TextDrawsInfoMessage[playerid][cycle][Use] = 1;
 
            LinesInfoMessage(playerid, cycle);

            MinPosYInfoMessage(playerid, cycle);
            MaxPosYInfoMessage(playerid, cycle);

            CreateTDN(playerid, cycle);

            for(new i; i < 3; i++)
            {
                if(used(playerid, counter_@[playerid]))
                {
                    if(counter_@[playerid] == 3 - 1) counter_@[playerid] = 0;
                    else counter_@[playerid]++;
                }
                else break;
            }

            new TDN = counter_@[playerid];

            TextDrawsInfoMessage[playerid][cycle][Hide] = TDN;

            if(counter_@[playerid] == 3 - 1) counter_@[playerid] = 0;
            else counter_@[playerid]++;

            return TDN;
        }
    }
    return -1;
}

stock used(playerid, id)
{
    for(new cycle; cycle < 3; cycle++)
    {
        if(TextDrawsInfoMessage[playerid][cycle][Hide] == id) return 1;
    }
    return 0;
}

forward HideInfoMessage(playerid, TDN);
public HideInfoMessage(playerid, TDN)
{
    for(new cycle; cycle < 3; cycle++)
    {
        if(TextDrawsInfoMessage[playerid][cycle][Hide] == TDN)
        {
            TextDrawsInfoMessage[playerid][cycle][Use] = 0;
            if(TextDrawsInfoMessage[playerid][cycle][TextDraw] != PlayerText:-1)
            {
                PlayerTextDrawDestroy(playerid, TextDrawsInfoMessage[playerid][cycle][TextDraw]);
                TextDrawsInfoMessage[playerid][cycle][Line] = 0;
                TextDrawsInfoMessage[playerid][cycle][Text][0] = EOS;
                TextDrawsInfoMessage[playerid][cycle][MinPosY] = 0;
                TextDrawsInfoMessage[playerid][cycle][MaxPosY] = 0;
                TextDrawsInfoMessage[playerid][cycle][TextDraw] = PlayerText:-1;
                TextDrawsInfoMessage[playerid][cycle][Timer] = -1;
            }
            TextDrawsInfoMessage[playerid][cycle][Hide] = -1;
            UpdateInfoMessage(playerid);
            return 1;
        }
    }
    return 0;
}

stock UpdateInfoMessage(playerid)
{
    for(new cycle = 0; cycle < 3; cycle ++)
    {
        if(!TextDrawsInfoMessage[playerid][cycle][Use])
        {
            if(cycle != 3 - 1)
            {
                if(TextDrawsInfoMessage[playerid][cycle + 1][Use])
                {
                    TextDrawsInfoMessage[playerid][cycle][Use] = TextDrawsInfoMessage[playerid][cycle + 1][Use];
                    TextDrawsInfoMessage[playerid][cycle][Line] = TextDrawsInfoMessage[playerid][cycle + 1][Line];
                    strcat(TextDrawsInfoMessage[playerid][cycle][Text], TextDrawsInfoMessage[playerid][cycle + 1][Text], 1024);
                    TextDrawsInfoMessage[playerid][cycle][TextDraw] = TextDrawsInfoMessage[playerid][cycle + 1][TextDraw];
                    TextDrawsInfoMessage[playerid][cycle][Hide] = TextDrawsInfoMessage[playerid][cycle + 1][Hide];

                    TextDrawsInfoMessage[playerid][cycle + 1][Use] = 0;
                    TextDrawsInfoMessage[playerid][cycle + 1][Line] = 0;
                    TextDrawsInfoMessage[playerid][cycle + 1][Text][0] = EOS;
                    TextDrawsInfoMessage[playerid][cycle + 1][TextDraw] = PlayerText:-1;
                    TextDrawsInfoMessage[playerid][cycle + 1][MinPosY] = 0;
                    TextDrawsInfoMessage[playerid][cycle + 1][MaxPosY] = 0;
                    TextDrawsInfoMessage[playerid][cycle + 1][Hide] = -1;

                    MinPosYInfoMessage(playerid, cycle);
                    MaxPosYInfoMessage(playerid, cycle);
                }
            }
        }
        else if(TextDrawsInfoMessage[playerid][cycle][Use])
        {
            if(cycle != 0)
            {
                if(!TextDrawsInfoMessage[playerid][cycle - 1][Use])
                {
                    TextDrawsInfoMessage[playerid][cycle - 1][Use] = TextDrawsInfoMessage[playerid][cycle][Use];
                    TextDrawsInfoMessage[playerid][cycle - 1][Line] = TextDrawsInfoMessage[playerid][cycle][Line];
                    strcat(TextDrawsInfoMessage[playerid][cycle - 1][Text], TextDrawsInfoMessage[playerid][cycle][Text], 1024);
                    TextDrawsInfoMessage[playerid][cycle - 1][TextDraw] = TextDrawsInfoMessage[playerid][cycle][TextDraw];
                    TextDrawsInfoMessage[playerid][cycle - 1][Hide] = TextDrawsInfoMessage[playerid][cycle][Hide];

                    TextDrawsInfoMessage[playerid][cycle][Use] = 0;
                    TextDrawsInfoMessage[playerid][cycle][Line] = 0;
                    TextDrawsInfoMessage[playerid][cycle][Text][0] = EOS;
                    TextDrawsInfoMessage[playerid][cycle][TextDraw] = PlayerText:-1;
                    TextDrawsInfoMessage[playerid][cycle][MinPosY] = 0;
                    TextDrawsInfoMessage[playerid][cycle][MaxPosY] = 0;
                    TextDrawsInfoMessage[playerid][cycle][Hide] = -1;

                    MinPosYInfoMessage(playerid, cycle - 1);
                    MaxPosYInfoMessage(playerid, cycle - 1);
                }
            }
        }
        CreateTDN(playerid, cycle);
    }
    return 1;
}

stock MinPosYInfoMessage(playerid, TDN)
{
    if(TDN == 0)
    {
        TextDrawsInfoMessage[playerid][TDN][MinPosY] = PI[playerid][pi_WANTED_LEVEL] == 0 ? 130.000000 : 153.0;
    }
    else
    {
        TextDrawsInfoMessage[playerid][TDN][MinPosY] = TextDrawsInfoMessage[playerid][TDN - 1][MaxPosY] + 10;
    }
    return 1;
}

stock MaxPosYInfoMessage(playerid, TDN)
{
    TextDrawsInfoMessage[playerid][TDN][MaxPosY] = TextDrawsInfoMessage[playerid][TDN][MinPosY] + (TD_INFOMESSAGE_LETTER_Y * 2) + 2 + (TD_INFOMESSAGE_LETTER_Y * 5.75 * TextDrawsInfoMessage[playerid][TDN][Line]) + ((TextDrawsInfoMessage[playerid][TDN][Line] - 1) * ((TD_INFOMESSAGE_LETTER_Y * 2) + 2 + TD_INFOMESSAGE_LETTER_Y)) + TD_INFOMESSAGE_LETTER_Y + 3;
    return 1;
}

stock LinesInfoMessage(playerid, TDN)
{
    new lines = 1, Float:width, lastspace = -1, supr, len = strlen(TextDrawsInfoMessage[playerid][TDN][Text]);
 
    for(new i = 0; i < len; i ++)
    {
        if(TextDrawsInfoMessage[playerid][TDN][Text][i] == '~')
        {
            if(supr == 0)
            {
                supr = 1;
                if(TextDrawsInfoMessage[playerid][TDN][Text][i+2] != '~') return 1;
            }
            else if(supr == 1) supr = 0;
        }
        else
        {
            if(supr == 1)
            {
                if(TextDrawsInfoMessage[playerid][TDN][Text][i] == 'n')
                {
                    lines ++;
                    lastspace = -1;
                    width = 0;
                }
            }
            else
            {
                if(TextDrawsInfoMessage[playerid][TDN][Text][i] == ' ') lastspace = i;
 
                width += TD_INFOMESSAGE_LETTER_X * GetTextDrawCharacterWidth(TextDrawsInfoMessage[playerid][TDN][Text][i], 1, bool:1);

                if(width > 112.100000 - 3)
                {
                    if(lastspace != i && lastspace != -1)
                    {
                        lines ++;
                        i = lastspace;
                        lastspace = -1;
                        width = 0;
                    }
                    else
                    {
                        lines ++;
                        lastspace = -1;
                        width = 0;
                    }
                }
            }
        }
    }
    
    TextDrawsInfoMessage[playerid][TDN][Line] = lines;
 
    return 1;
}

stock CreateTDN(playerid, TDN)
{
    if(TextDrawsInfoMessage[playerid][TDN][Use] == 1)
    {
        if(TextDrawsInfoMessage[playerid][TDN][TextDraw] != PlayerText:-1)
        {
            PlayerTextDrawDestroy(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw]);
        }
    
        TextDrawsInfoMessage[playerid][TDN][TextDraw] = CreatePlayerTextDraw(playerid, 499.000000, TextDrawsInfoMessage[playerid][TDN][MinPosY], TextDrawsInfoMessage[playerid][TDN][Text]);
        PlayerTextDrawFont(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw], 1);
        PlayerTextDrawLetterSize(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw], TD_INFOMESSAGE_LETTER_X, TD_INFOMESSAGE_LETTER_Y);
        PlayerTextDrawTextSize(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw], floatadd(499.000000, 107.0), 1.000000);
        PlayerTextDrawSetOutline(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw], 1);
        PlayerTextDrawSetShadow(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw], 0);
        PlayerTextDrawAlignment(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw], 1);
        PlayerTextDrawColor(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw], 0xFFFFFFFF);
        PlayerTextDrawBackgroundColor(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw], 255);
        PlayerTextDrawBoxColor(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw], 55);
        PlayerTextDrawUseBox(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw], 1);
        PlayerTextDrawSetProportional(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw], 1);
        PlayerTextDrawSetSelectable(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw], 0);
        PlayerTextDrawShow(playerid, TextDrawsInfoMessage[playerid][TDN][TextDraw]);
    }
    return 1;
}

hook OnGameModeInit()
{
    for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
    {
        for(new TDN = 0; TDN < 3; TDN++)
        {
            TextDrawsInfoMessage[playerid][TDN][TextDraw] = PlayerText:-1;
            TextDrawsInfoMessage[playerid][TDN][Hide] = -1;
            TextDrawsInfoMessage[playerid][TDN][Timer] = -1;
        }
    }
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    HideInfoMessages(playerid);
    return 1;
}

HideInfoMessages(playerid) {
    for(new cycle; cycle < 3; cycle++)
    {
        if(TextDrawsInfoMessage[playerid][cycle][TextDraw] != PlayerText:-1) {
            PlayerTextDrawDestroy(playerid, TextDrawsInfoMessage[playerid][cycle][TextDraw]);
        }
        if(TextDrawsInfoMessage[playerid][cycle][Timer] != -1) {
            KillTimer(TextDrawsInfoMessage[playerid][cycle][Timer]);
        }
        TextDrawsInfoMessage[playerid][cycle][Use] = 0;
        TextDrawsInfoMessage[playerid][cycle][Line] = 0;
        TextDrawsInfoMessage[playerid][cycle][Text][0] = EOS;
        TextDrawsInfoMessage[playerid][cycle][MinPosY] = 0;
        TextDrawsInfoMessage[playerid][cycle][MaxPosY] = 0;
        TextDrawsInfoMessage[playerid][cycle][Hide] = -1;
        TextDrawsInfoMessage[playerid][cycle][TextDraw] = PlayerText:-1;
        TextDrawsInfoMessage[playerid][cycle][Timer] = -1;
    }
}

stock SendInfoMessagef(playerid, const text[], {Float, _}:...)
{
	static
	    args,
	    str[192];

	if ((args = numargs()) <= 2)
	{
	    SendInfoMessage(playerid, text);
	}
	else
	{
		while (--args >= 2)
		{
			#emit LCTRL 5
			#emit LOAD.alt args
			#emit SHL.C.alt 2
			#emit ADD.C 12
			#emit ADD
			#emit LOAD.I
			#emit PUSH.pri
		}
		#emit PUSH.S text
		#emit PUSH.C 192
		#emit PUSH.C str
		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit ADD
		#emit PUSH.pri
		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		SendInfoMessage(playerid, str);

		#emit RETN
	}
	return 1;
}
