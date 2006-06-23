bss
align 1
LABELV $73
skip 64
export CG_PlaceString
code
proc CG_PlaceString 12 20
file "../cg_event.c"
line 23
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_event.c -- handle entity events at snapshot or playerstate transitions
;4:
;5:#include "cg_local.h"
;6:
;7:// for the voice chats
;8:#ifdef MISSIONPACK // bk001205
;9:#include "../../ui/menudef.h"
;10:#endif
;11://==========================================================================
;12:
;13:
;14:
;15:
;16:/*
;17:===================
;18:CG_PlaceString
;19:
;20:Also called by scoreboard drawing
;21:===================
;22:*/
;23:const char	*CG_PlaceString( int rank ) {
line 27
;24:	static char	str[64];
;25:	char	*s, *t;
;26:
;27:	if ( rank & RANK_TIED_FLAG ) {
ADDRFP4 0
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $74
line 28
;28:		rank &= ~RANK_TIED_FLAG;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 29
;29:		t = "Tied for ";
ADDRLP4 4
ADDRGP4 $76
ASGNP4
line 30
;30:	} else {
ADDRGP4 $75
JUMPV
LABELV $74
line 31
;31:		t = "";
ADDRLP4 4
ADDRGP4 $77
ASGNP4
line 32
;32:	}
LABELV $75
line 34
;33:
;34:	if ( rank == 1 ) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $78
line 35
;35:		s = S_COLOR_BLUE "1st" S_COLOR_WHITE;		// draw in blue
ADDRLP4 0
ADDRGP4 $80
ASGNP4
line 36
;36:	} else if ( rank == 2 ) {
ADDRGP4 $79
JUMPV
LABELV $78
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $81
line 37
;37:		s = S_COLOR_RED "2nd" S_COLOR_WHITE;		// draw in red
ADDRLP4 0
ADDRGP4 $83
ASGNP4
line 38
;38:	} else if ( rank == 3 ) {
ADDRGP4 $82
JUMPV
LABELV $81
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $84
line 39
;39:		s = S_COLOR_YELLOW "3rd" S_COLOR_WHITE;		// draw in yellow
ADDRLP4 0
ADDRGP4 $86
ASGNP4
line 40
;40:	} else if ( rank == 11 ) {
ADDRGP4 $85
JUMPV
LABELV $84
ADDRFP4 0
INDIRI4
CNSTI4 11
NEI4 $87
line 41
;41:		s = "11th";
ADDRLP4 0
ADDRGP4 $89
ASGNP4
line 42
;42:	} else if ( rank == 12 ) {
ADDRGP4 $88
JUMPV
LABELV $87
ADDRFP4 0
INDIRI4
CNSTI4 12
NEI4 $90
line 43
;43:		s = "12th";
ADDRLP4 0
ADDRGP4 $92
ASGNP4
line 44
;44:	} else if ( rank == 13 ) {
ADDRGP4 $91
JUMPV
LABELV $90
ADDRFP4 0
INDIRI4
CNSTI4 13
NEI4 $93
line 45
;45:		s = "13th";
ADDRLP4 0
ADDRGP4 $95
ASGNP4
line 46
;46:	} else if ( rank % 10 == 1 ) {
ADDRGP4 $94
JUMPV
LABELV $93
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $96
line 47
;47:		s = va("%ist", rank);
ADDRGP4 $98
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 48
;48:	} else if ( rank % 10 == 2 ) {
ADDRGP4 $97
JUMPV
LABELV $96
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
NEI4 $99
line 49
;49:		s = va("%ind", rank);
ADDRGP4 $101
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 50
;50:	} else if ( rank % 10 == 3 ) {
ADDRGP4 $100
JUMPV
LABELV $99
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 3
NEI4 $102
line 51
;51:		s = va("%ird", rank);
ADDRGP4 $104
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 52
;52:	} else {
ADDRGP4 $103
JUMPV
LABELV $102
line 53
;53:		s = va("%ith", rank);
ADDRGP4 $105
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 54
;54:	}
LABELV $103
LABELV $100
LABELV $97
LABELV $94
LABELV $91
LABELV $88
LABELV $85
LABELV $82
LABELV $79
line 56
;55:
;56:	Com_sprintf( str, sizeof( str ), "%s%s", t, s );
ADDRGP4 $73
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $106
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 57
;57:	return str;
ADDRGP4 $73
RETP4
LABELV $72
endproc CG_PlaceString 12 20
proc CG_Obituary 132 20
line 65
;58:}
;59:
;60:/*
;61:=============
;62:CG_Obituary
;63:=============
;64:*/
;65:static void CG_Obituary( entityState_t *ent ) {
line 77
;66:	int			mod;
;67:	int			target, attacker;
;68:	char		*message;
;69:	char		*message2;
;70:	const char	*targetInfo;
;71:	const char	*attackerInfo;
;72:	char		targetName[32];
;73:	char		attackerName[32];
;74:	gender_t	gender;
;75:	clientInfo_t	*ci;
;76:
;77:	target = ent->otherEntityNum;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 78
;78:	attacker = ent->otherEntityNum2;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 79
;79:	mod = ent->eventParm;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 81
;80:
;81:	if ( target < 0 || target >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $110
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $108
LABELV $110
line 82
;82:		CG_Error( "CG_Obituary: target out of range" );
ADDRGP4 $111
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 83
;83:	}
LABELV $108
line 84
;84:	ci = &cgs.clientinfo[target];
ADDRLP4 92
CNSTI4 1708
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 86
;85:
;86:	if ( attacker < 0 || attacker >= MAX_CLIENTS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $115
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $113
LABELV $115
line 87
;87:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 88
;88:		attackerInfo = NULL;
ADDRLP4 52
CNSTP4 0
ASGNP4
line 89
;89:	} else {
ADDRGP4 $114
JUMPV
LABELV $113
line 90
;90:		attackerInfo = CG_ConfigString( CS_PLAYERS + attacker );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 108
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 52
ADDRLP4 108
INDIRP4
ASGNP4
line 91
;91:	}
LABELV $114
line 93
;92:
;93:	targetInfo = CG_ConfigString( CS_PLAYERS + target );
ADDRLP4 4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 108
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 108
INDIRP4
ASGNP4
line 94
;94:	if ( !targetInfo ) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $116
line 95
;95:		return;
ADDRGP4 $107
JUMPV
LABELV $116
line 97
;96:	}
;97:	Q_strncpyz( targetName, Info_ValueForKey( targetInfo, "n" ), sizeof(targetName) - 2);
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 $118
ARGP4
ADDRLP4 112
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 98
;98:	strcat( targetName, S_COLOR_WHITE );
ADDRLP4 8
ARGP4
ADDRGP4 $119
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 100
;99:
;100:	message2 = "";
ADDRLP4 88
ADDRGP4 $77
ASGNP4
line 104
;101:
;102:	// check for single client messages
;103:
;104:	switch( mod ) {
ADDRLP4 40
INDIRI4
CNSTI4 14
LTI4 $120
ADDRLP4 40
INDIRI4
CNSTI4 22
GTI4 $120
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $138-56
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $138
address $128
address $130
address $132
address $126
address $120
address $124
address $122
address $134
address $136
code
LABELV $122
line 106
;105:	case MOD_SUICIDE:
;106:		message = "suicides";
ADDRLP4 44
ADDRGP4 $123
ASGNP4
line 107
;107:		break;
ADDRGP4 $121
JUMPV
LABELV $124
line 109
;108:	case MOD_FALLING:
;109:		message = "cratered";
ADDRLP4 44
ADDRGP4 $125
ASGNP4
line 110
;110:		break;
ADDRGP4 $121
JUMPV
LABELV $126
line 112
;111:	case MOD_CRUSH:
;112:		message = "was squished";
ADDRLP4 44
ADDRGP4 $127
ASGNP4
line 113
;113:		break;
ADDRGP4 $121
JUMPV
LABELV $128
line 115
;114:	case MOD_WATER:
;115:		message = "sank like a rock";
ADDRLP4 44
ADDRGP4 $129
ASGNP4
line 116
;116:		break;
ADDRGP4 $121
JUMPV
LABELV $130
line 118
;117:	case MOD_SLIME:
;118:		message = "melted";
ADDRLP4 44
ADDRGP4 $131
ASGNP4
line 119
;119:		break;
ADDRGP4 $121
JUMPV
LABELV $132
line 121
;120:	case MOD_LAVA:
;121:		message = "does a back flip into the lava";
ADDRLP4 44
ADDRGP4 $133
ASGNP4
line 122
;122:		break;
ADDRGP4 $121
JUMPV
LABELV $134
line 124
;123:	case MOD_TARGET_LASER:
;124:		message = "saw the light";
ADDRLP4 44
ADDRGP4 $135
ASGNP4
line 125
;125:		break;
ADDRGP4 $121
JUMPV
LABELV $136
line 127
;126:	case MOD_TRIGGER_HURT:
;127:		message = "was in the wrong place";
ADDRLP4 44
ADDRGP4 $137
ASGNP4
line 128
;128:		break;
ADDRGP4 $121
JUMPV
LABELV $120
line 130
;129:	default:
;130:		message = NULL;
ADDRLP4 44
CNSTP4 0
ASGNP4
line 131
;131:		break;
LABELV $121
line 134
;132:	}
;133:
;134:	if (attacker == target) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $140
line 135
;135:		gender = ci->gender;
ADDRLP4 96
ADDRLP4 92
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 136
;136:		switch (mod) {
ADDRLP4 124
CNSTI4 13
ASGNI4
ADDRLP4 40
INDIRI4
ADDRLP4 124
INDIRI4
EQI4 $168
ADDRLP4 40
INDIRI4
ADDRLP4 124
INDIRI4
GTI4 $186
LABELV $185
ADDRLP4 40
INDIRI4
CNSTI4 5
EQI4 $144
ADDRLP4 40
INDIRI4
CNSTI4 7
EQI4 $152
ADDRLP4 40
INDIRI4
CNSTI4 9
EQI4 $160
ADDRGP4 $142
JUMPV
LABELV $186
ADDRLP4 40
INDIRI4
CNSTI4 23
EQI4 $170
ADDRGP4 $142
JUMPV
LABELV $144
line 143
;137:#ifdef MISSIONPACK
;138:		case MOD_KAMIKAZE:
;139:			message = "goes out with a bang";
;140:			break;
;141:#endif
;142:		case MOD_GRENADE_SPLASH:
;143:			if ( gender == GENDER_FEMALE )
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $145
line 144
;144:				message = "tripped on her own grenade";
ADDRLP4 44
ADDRGP4 $147
ASGNP4
ADDRGP4 $143
JUMPV
LABELV $145
line 145
;145:			else if ( gender == GENDER_NEUTER )
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $148
line 146
;146:				message = "tripped on its own grenade";
ADDRLP4 44
ADDRGP4 $150
ASGNP4
ADDRGP4 $143
JUMPV
LABELV $148
line 148
;147:			else
;148:				message = "tripped on his own grenade";
ADDRLP4 44
ADDRGP4 $151
ASGNP4
line 149
;149:			break;
ADDRGP4 $143
JUMPV
LABELV $152
line 151
;150:		case MOD_ROCKET_SPLASH:
;151:			if ( gender == GENDER_FEMALE )
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $153
line 152
;152:				message = "blew herself up";
ADDRLP4 44
ADDRGP4 $155
ASGNP4
ADDRGP4 $143
JUMPV
LABELV $153
line 153
;153:			else if ( gender == GENDER_NEUTER )
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $156
line 154
;154:				message = "blew itself up";
ADDRLP4 44
ADDRGP4 $158
ASGNP4
ADDRGP4 $143
JUMPV
LABELV $156
line 156
;155:			else
;156:				message = "blew himself up";
ADDRLP4 44
ADDRGP4 $159
ASGNP4
line 157
;157:			break;
ADDRGP4 $143
JUMPV
LABELV $160
line 159
;158:		case MOD_PLASMA_SPLASH:
;159:			if ( gender == GENDER_FEMALE )
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $161
line 160
;160:				message = "melted herself";
ADDRLP4 44
ADDRGP4 $163
ASGNP4
ADDRGP4 $143
JUMPV
LABELV $161
line 161
;161:			else if ( gender == GENDER_NEUTER )
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $164
line 162
;162:				message = "melted itself";
ADDRLP4 44
ADDRGP4 $166
ASGNP4
ADDRGP4 $143
JUMPV
LABELV $164
line 164
;163:			else
;164:				message = "melted himself";
ADDRLP4 44
ADDRGP4 $167
ASGNP4
line 165
;165:			break;
ADDRGP4 $143
JUMPV
LABELV $168
line 167
;166:		case MOD_BFG_SPLASH:
;167:			message = "should have used a smaller gun";
ADDRLP4 44
ADDRGP4 $169
ASGNP4
line 168
;168:			break;
ADDRGP4 $143
JUMPV
LABELV $170
line 170
;169:		case MOD_HEADSHOT:									// Shafe - Headshots
;170:			gender = ci->gender;
ADDRLP4 96
ADDRLP4 92
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 171
;171:			if(gender==GENDER_FEMALE)
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $171
line 172
;172:			{
line 173
;173:				message = "got her head blown off by";
ADDRLP4 44
ADDRGP4 $173
ASGNP4
line 174
;174:			}
ADDRGP4 $143
JUMPV
LABELV $171
line 176
;175:			else
;176:			{
line 177
;177:				if(gender==GENDER_NEUTER)
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $174
line 178
;178:					message = "got its head blown off by";
ADDRLP4 44
ADDRGP4 $176
ASGNP4
ADDRGP4 $143
JUMPV
LABELV $174
line 180
;179:				else
;180:					message = "got his head blown off by";
ADDRLP4 44
ADDRGP4 $177
ASGNP4
line 181
;181:			}
line 182
;182:			break;											
ADDRGP4 $143
JUMPV
LABELV $142
line 195
;183:#ifdef MISSIONPACK
;184:		case MOD_PROXIMITY_MINE:
;185:			if( gender == GENDER_FEMALE ) {
;186:				message = "found her prox mine";
;187:			} else if ( gender == GENDER_NEUTER ) {
;188:				message = "found it's prox mine";
;189:			} else {
;190:				message = "found his prox mine";
;191:			}
;192:			break;
;193:#endif
;194:		default:
;195:			if ( gender == GENDER_FEMALE )
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $178
line 196
;196:				message = "killed herself";
ADDRLP4 44
ADDRGP4 $180
ASGNP4
ADDRGP4 $143
JUMPV
LABELV $178
line 197
;197:			else if ( gender == GENDER_NEUTER )
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $181
line 198
;198:				message = "killed itself";
ADDRLP4 44
ADDRGP4 $183
ASGNP4
ADDRGP4 $143
JUMPV
LABELV $181
line 200
;199:			else
;200:				message = "killed himself";
ADDRLP4 44
ADDRGP4 $184
ASGNP4
line 201
;201:			break;
LABELV $143
line 203
;202:		}
;203:	}
LABELV $140
line 205
;204:
;205:	if (message) {
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $187
line 206
;206:		CG_Printf( "%s %s.\n", targetName, message);
ADDRGP4 $189
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 207
;207:		return;
ADDRGP4 $107
JUMPV
LABELV $187
line 211
;208:	}
;209:
;210:	// check for kill messages from the current clientNum
;211:	if ( attacker == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $190
line 214
;212:		char	*s;
;213:
;214:		if(mod != MOD_HEADSHOT) // Shafe - Trep - only for headshots
ADDRLP4 40
INDIRI4
CNSTI4 23
EQI4 $193
line 215
;215:		{						
line 216
;216:			if ( cgs.gametype < GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $195
line 217
;217:					s = va("You fragged %s\n%s place with %i", targetName, 
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 124
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $198
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 128
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 120
ADDRLP4 128
INDIRP4
ASGNP4
line 220
;218:					CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ),
;219:					cg.snap->ps.persistant[PERS_SCORE] );
;220:			} else {
ADDRGP4 $194
JUMPV
LABELV $195
line 221
;221:				s = va("You fragged %s", targetName );
ADDRGP4 $201
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 124
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 120
ADDRLP4 124
INDIRP4
ASGNP4
line 222
;222:			}
line 223
;223:		}
ADDRGP4 $194
JUMPV
LABELV $193
line 225
;224:		else										// Shafe - Trep Else for headshot
;225:		{
line 227
;226:
;227:			if ( cgs.gametype < GT_TEAM ) 
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $202
line 228
;228:			{
line 229
;229:				s = va("Headshot!\n\nYou fragged %s\n%s place with %i", targetName, 
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 124
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $205
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 128
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 120
ADDRLP4 128
INDIRP4
ASGNP4
line 232
;230:				CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ),
;231:				cg.snap->ps.persistant[PERS_SCORE] );
;232:			} else {
ADDRGP4 $203
JUMPV
LABELV $202
line 233
;233:				s = va("Headshot!\n\nYou fragged %s", targetName );
ADDRGP4 $208
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 124
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 120
ADDRLP4 124
INDIRP4
ASGNP4
line 234
;234:			}	
LABELV $203
line 237
;235:			
;236:	
;237:		}
LABELV $194
line 243
;238:#ifdef MISSIONPACK
;239:		if (!(cg_singlePlayerActive.integer && cg_cameraOrbit.integer)) {
;240:			CG_CenterPrint( s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
;241:		} 
;242:#else
;243:		CG_CenterPrint( s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRLP4 120
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 247
;244:#endif
;245:
;246:		// print the text message as well
;247:	}
LABELV $190
line 250
;248:
;249:	// check for double client messages
;250:	if ( !attackerInfo ) {
ADDRLP4 52
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $209
line 251
;251:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 252
;252:		strcpy( attackerName, "noname" );
ADDRLP4 56
ARGP4
ADDRGP4 $211
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 253
;253:	} else {
ADDRGP4 $210
JUMPV
LABELV $209
line 254
;254:		Q_strncpyz( attackerName, Info_ValueForKey( attackerInfo, "n" ), sizeof(attackerName) - 2);
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 $118
ARGP4
ADDRLP4 120
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
ARGP4
ADDRLP4 120
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 255
;255:		strcat( attackerName, S_COLOR_WHITE );
ADDRLP4 56
ARGP4
ADDRGP4 $119
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 257
;256:		// check for kill messages about the current clientNum
;257:		if ( target == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $212
line 258
;258:			Q_strncpyz( cg.killerName, attackerName, sizeof( cg.killerName ) );
ADDRGP4 cg+114344
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 259
;259:		}
LABELV $212
line 260
;260:	}
LABELV $210
line 262
;261:
;262:	if ( attacker != ENTITYNUM_WORLD ) {
ADDRLP4 0
INDIRI4
CNSTI4 1022
EQI4 $217
line 263
;263:		switch (mod) {
ADDRLP4 40
INDIRI4
CNSTI4 1
LTI4 $219
ADDRLP4 40
INDIRI4
CNSTI4 25
GTI4 $219
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $258-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $258
address $227
address $223
address $225
address $229
address $232
address $235
address $238
address $240
address $243
address $244
address $246
address $248
address $248
address $219
address $219
address $219
address $219
address $251
address $219
address $219
address $219
address $219
address $219
address $221
address $254
code
LABELV $221
line 265
;264:		case MOD_GRAPPLE:
;265:			message = "was caught by";
ADDRLP4 44
ADDRGP4 $222
ASGNP4
line 266
;266:			break;
ADDRGP4 $220
JUMPV
LABELV $223
line 268
;267:		case MOD_GAUNTLET:
;268:			message = "was pummeled by";
ADDRLP4 44
ADDRGP4 $224
ASGNP4
line 269
;269:			break;
ADDRGP4 $220
JUMPV
LABELV $225
line 271
;270:		case MOD_MACHINEGUN:
;271:			message = "was machinegunned by";
ADDRLP4 44
ADDRGP4 $226
ASGNP4
line 272
;272:			break;
ADDRGP4 $220
JUMPV
LABELV $227
line 274
;273:		case MOD_SHOTGUN:
;274:			message = "was gunned down by";
ADDRLP4 44
ADDRGP4 $228
ASGNP4
line 275
;275:			break;
ADDRGP4 $220
JUMPV
LABELV $229
line 277
;276:		case MOD_GRENADE:
;277:			message = "ate";
ADDRLP4 44
ADDRGP4 $230
ASGNP4
line 278
;278:			message2 = "'s grenade";
ADDRLP4 88
ADDRGP4 $231
ASGNP4
line 279
;279:			break;
ADDRGP4 $220
JUMPV
LABELV $232
line 281
;280:		case MOD_GRENADE_SPLASH:
;281:			message = "was shredded by";
ADDRLP4 44
ADDRGP4 $233
ASGNP4
line 282
;282:			message2 = "'s shrapnel";
ADDRLP4 88
ADDRGP4 $234
ASGNP4
line 283
;283:			break;
ADDRGP4 $220
JUMPV
LABELV $235
line 285
;284:		case MOD_ROCKET:
;285:			message = "was crushed by";
ADDRLP4 44
ADDRGP4 $236
ASGNP4
line 286
;286:			message2 = "'s singularity";
ADDRLP4 88
ADDRGP4 $237
ASGNP4
line 287
;287:			break;
ADDRGP4 $220
JUMPV
LABELV $238
line 289
;288:		case MOD_ROCKET_SPLASH:
;289:			message = "almost dodged";
ADDRLP4 44
ADDRGP4 $239
ASGNP4
line 290
;290:			message2 = "'s singularity";
ADDRLP4 88
ADDRGP4 $237
ASGNP4
line 291
;291:			break;
ADDRGP4 $220
JUMPV
LABELV $240
line 293
;292:		case MOD_PLASMA:
;293:			message = "was melted by";
ADDRLP4 44
ADDRGP4 $241
ASGNP4
line 294
;294:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $242
ASGNP4
line 295
;295:			break;
ADDRGP4 $220
JUMPV
LABELV $243
line 297
;296:		case MOD_PLASMA_SPLASH:
;297:			message = "was melted by";
ADDRLP4 44
ADDRGP4 $241
ASGNP4
line 298
;298:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $242
ASGNP4
line 299
;299:			break;
ADDRGP4 $220
JUMPV
LABELV $244
line 301
;300:		case MOD_RAILGUN:
;301:			message = "was degaussed by"; // Shafe - Trep - Reworded
ADDRLP4 44
ADDRGP4 $245
ASGNP4
line 302
;302:			break;
ADDRGP4 $220
JUMPV
LABELV $246
line 304
;303:		case MOD_LIGHTNING:
;304:			message = "was burnt by";
ADDRLP4 44
ADDRGP4 $247
ASGNP4
line 305
;305:			break;
ADDRGP4 $220
JUMPV
LABELV $248
line 308
;306:		case MOD_BFG:
;307:		case MOD_BFG_SPLASH:
;308:			message = "was blasted by";
ADDRLP4 44
ADDRGP4 $249
ASGNP4
line 309
;309:			message2 = "'s BFG";
ADDRLP4 88
ADDRGP4 $250
ASGNP4
line 310
;310:			break;
ADDRGP4 $220
JUMPV
LABELV $251
line 332
;311:#ifdef MISSIONPACK
;312:		case MOD_NAIL:
;313:			message = "was nailed by";
;314:			break;
;315:		case MOD_CHAINGUN:
;316:			message = "got lead poisoning from";
;317:			message2 = "'s Chaingun";
;318:			break;
;319:		case MOD_PROXIMITY_MINE:
;320:			message = "was too close to";
;321:			message2 = "'s Prox Mine";
;322:			break;
;323:		case MOD_KAMIKAZE:
;324:			message = "falls to";
;325:			message2 = "'s Kamikaze blast";
;326:			break;
;327:		case MOD_JUICED:
;328:			message = "was juiced by";
;329:			break;
;330:#endif
;331:		case MOD_TELEFRAG:
;332:			message = "tried to invade";
ADDRLP4 44
ADDRGP4 $252
ASGNP4
line 333
;333:			message2 = "'s personal space";
ADDRLP4 88
ADDRGP4 $253
ASGNP4
line 334
;334:			break;
ADDRGP4 $220
JUMPV
LABELV $254
line 336
;335:		case MOD_ALTFLAMER:		// Shafe - Trep - Flame Thrower Alt
;336:			message = "was toasted by";
ADDRLP4 44
ADDRGP4 $255
ASGNP4
line 337
;337:			message2 = "'s flame thrower";
ADDRLP4 88
ADDRGP4 $256
ASGNP4
line 338
;338:			break;
ADDRGP4 $220
JUMPV
LABELV $219
line 340
;339:		default:
;340:			message = "was killed by";
ADDRLP4 44
ADDRGP4 $257
ASGNP4
line 341
;341:			break;
LABELV $220
line 344
;342:		}
;343:
;344:		if (message) {
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $260
line 345
;345:			CG_Printf( "%s %s %s%s\n", 
ADDRGP4 $262
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 347
;346:				targetName, message, attackerName, message2);
;347:			return;
ADDRGP4 $107
JUMPV
LABELV $260
line 349
;348:		}
;349:	}
LABELV $217
line 352
;350:
;351:	// we don't know what it was
;352:	CG_Printf( "%s died.\n", targetName );
ADDRGP4 $263
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 353
;353:}
LABELV $107
endproc CG_Obituary 132 20
proc CG_UseItem 32 16
line 362
;354:
;355://==========================================================================
;356:
;357:/*
;358:===============
;359:CG_UseItem
;360:===============
;361:*/
;362:static void CG_UseItem( centity_t *cent ) {
line 368
;363:	clientInfo_t *ci;
;364:	int			itemNum, clientNum;
;365:	gitem_t		*item;
;366:	entityState_t *es;
;367:
;368:	es = &cent->currentState;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 370
;369:	
;370:	itemNum = (es->event & ~EV_EVENT_BITS) - EV_USE_ITEM0;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 25
SUBI4
ASGNI4
line 371
;371:	if ( itemNum < 0 || itemNum > HI_NUM_HOLDABLE ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $267
ADDRLP4 0
INDIRI4
CNSTI4 6
LEI4 $265
LABELV $267
line 372
;372:		itemNum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 373
;373:	}
LABELV $265
line 376
;374:
;375:	// print a message if the local player
;376:	if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $268
line 377
;377:		if ( !itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $271
line 378
;378:			CG_CenterPrint( "No item to use", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRGP4 $273
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 379
;379:		} else {
ADDRGP4 $272
JUMPV
LABELV $271
line 380
;380:			item = BG_FindItemForHoldable( itemNum );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 BG_FindItemForHoldable
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 381
;381:			CG_CenterPrint( va("Use %s", item->pickup_name), SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRGP4 $274
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 382
;382:		}
LABELV $272
line 383
;383:	}
LABELV $268
line 385
;384:
;385:	switch ( itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $277
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $276
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $281
ADDRGP4 $275
JUMPV
LABELV $275
LABELV $277
line 388
;386:	default:
;387:	case HI_NONE:
;388:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.useNothingSound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+152340+556
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 389
;389:		break;
ADDRGP4 $276
JUMPV
line 392
;390:
;391:	case HI_TELEPORTER:
;392:		break;
LABELV $281
line 395
;393:
;394:	case HI_MEDKIT:
;395:		clientNum = cent->currentState.clientNum;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 396
;396:		if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
ADDRLP4 28
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $282
ADDRLP4 28
INDIRI4
CNSTI4 64
GEI4 $282
line 397
;397:			ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 16
CNSTI4 1708
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 398
;398:			ci->medkitUsageTime = cg.time;
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 399
;399:		}
LABELV $282
line 400
;400:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.medkitSound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+152340+876
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 401
;401:		break;
LABELV $276
line 415
;402:
;403:#ifdef MISSIONPACK
;404:	case HI_KAMIKAZE:
;405:		break;
;406:
;407:	case HI_PORTAL:
;408:		break;
;409:	case HI_INVULNERABILITY:
;410:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.useInvulnerabilitySound );
;411:		break;
;412:#endif
;413:	}
;414:
;415:}
LABELV $264
endproc CG_UseItem 32 16
proc CG_ItemPickup 0 0
line 424
;416:
;417:/*
;418:================
;419:CG_ItemPickup
;420:
;421:A new item was picked up this frame
;422:================
;423:*/
;424:static void CG_ItemPickup( int itemNum ) {
line 425
;425:	cg.itemPickup = itemNum;
ADDRGP4 cg+124676
ADDRFP4 0
INDIRI4
ASGNI4
line 426
;426:	cg.itemPickupTime = cg.time;
ADDRGP4 cg+124680
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 427
;427:	cg.itemPickupBlendTime = cg.time;
ADDRGP4 cg+124684
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 429
;428:	// see if it should be the grabbed weapon
;429:	if ( bg_itemlist[itemNum].giType == IT_WEAPON ) {
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $294
line 431
;430:		// select it immediately
;431:		if ( cg_autoswitch.integer && bg_itemlist[itemNum].giTag != WP_MACHINEGUN ) {
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 0
EQI4 $297
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
EQI4 $297
line 432
;432:			cg.weaponSelectTime = cg.time;
ADDRGP4 cg+124688
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 433
;433:			cg.weaponSelect = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+108948
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 434
;434:		}
LABELV $297
line 435
;435:	}
LABELV $294
line 437
;436:
;437:}
LABELV $288
endproc CG_ItemPickup 0 0
export CG_PainEvent
proc CG_PainEvent 12 16
line 447
;438:
;439:
;440:/*
;441:================
;442:CG_PainEvent
;443:
;444:Also called by playerstate transition
;445:================
;446:*/
;447:void CG_PainEvent( centity_t *cent, int health ) {
line 451
;448:	char	*snd;
;449:
;450:	// don't do more than two pain sounds a second
;451:	if ( cg.time - cent->pe.painTime < 500 ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
SUBI4
CNSTI4 500
GEI4 $306
line 452
;452:		return;
ADDRGP4 $305
JUMPV
LABELV $306
line 455
;453:	}
;454:
;455:	if ( health < 25 ) {
ADDRFP4 4
INDIRI4
CNSTI4 25
GEI4 $309
line 456
;456:		snd = "*pain25_1.wav";
ADDRLP4 0
ADDRGP4 $311
ASGNP4
line 457
;457:	} else if ( health < 50 ) {
ADDRGP4 $310
JUMPV
LABELV $309
ADDRFP4 4
INDIRI4
CNSTI4 50
GEI4 $312
line 458
;458:		snd = "*pain50_1.wav";
ADDRLP4 0
ADDRGP4 $314
ASGNP4
line 459
;459:	} else if ( health < 75 ) {
ADDRGP4 $313
JUMPV
LABELV $312
ADDRFP4 4
INDIRI4
CNSTI4 75
GEI4 $315
line 460
;460:		snd = "*pain75_1.wav";
ADDRLP4 0
ADDRGP4 $317
ASGNP4
line 461
;461:	} else {
ADDRGP4 $316
JUMPV
LABELV $315
line 462
;462:		snd = "*pain100_1.wav";
ADDRLP4 0
ADDRGP4 $318
ASGNP4
line 463
;463:	}
LABELV $316
LABELV $313
LABELV $310
line 464
;464:	trap_S_StartSound( NULL, cent->currentState.number, CHAN_VOICE, 
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 468
;465:		CG_CustomSound( cent->currentState.number, snd ) );
;466:
;467:	// save pain time for programitic twitch animation
;468:	cent->pe.painTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 469
;469:	cent->pe.painDirection ^= 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 470
;470:}
LABELV $305
endproc CG_PainEvent 12 16
lit
align 4
LABELV $466
byte 4 0
byte 4 0
byte 4 1065353216
export CG_EntityEvent
code
proc CG_EntityEvent 112 48
line 483
;471:
;472:
;473:
;474:/*
;475:==============
;476:CG_EntityEvent
;477:
;478:An entity has an event value
;479:also called by CG_CheckPlayerstateEvents
;480:==============
;481:*/
;482:#define	DEBUGNAME(x) if(cg_debugEvents.integer){CG_Printf(x"\n");}
;483:void CG_EntityEvent( centity_t *cent, vec3_t position ) {
line 491
;484:	entityState_t	*es;
;485:	int				event;
;486:	vec3_t			dir;
;487:	const char		*s;
;488:	int				clientNum;
;489:	clientInfo_t	*ci;
;490:
;491:	es = &cent->currentState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 492
;492:	event = es->event & ~EV_EVENT_BITS;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 494
;493:
;494:	if ( cg_debugEvents.integer ) {
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $321
line 495
;495:		CG_Printf( "ent:%3i  event:%3i ", es->number, event );
ADDRGP4 $324
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 496
;496:	}
LABELV $321
line 498
;497:
;498:	if ( !event ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $325
line 499
;499:		DEBUGNAME("ZEROEVENT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $320
ADDRGP4 $330
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 500
;500:		return;
ADDRGP4 $320
JUMPV
LABELV $325
line 503
;501:	}
;502:
;503:	clientNum = es->clientNum;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 504
;504:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $333
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $331
LABELV $333
line 505
;505:		clientNum = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 506
;506:	}
LABELV $331
line 507
;507:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 12
CNSTI4 1708
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 509
;508:
;509:	switch ( event ) {
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $335
ADDRLP4 8
INDIRI4
CNSTI4 71
GTI4 $335
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $995-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $995
address $337
address $347
address $358
address $369
address $380
address $431
address $431
address $431
address $431
address $391
address $405
address $417
address $461
address $473
address $484
address $491
address $498
address $505
address $511
address $529
address $543
address $551
address $558
address $563
address $568
address $573
address $578
address $583
address $588
address $593
address $598
address $603
address $608
address $613
address $618
address $623
address $628
address $633
address $638
address $335
address $664
address $657
address $643
address $650
address $672
address $757
address $766
address $777
address $731
address $718
address $688
address $693
address $698
address $703
address $744
address $335
address $901
address $909
address $909
address $909
address $915
address $920
address $933
address $946
address $959
address $968
address $975
address $683
address $985
address $980
address $478
code
LABELV $337
line 514
;510:	//
;511:	// movement generated events
;512:	//
;513:	case EV_FOOTSTEP:
;514:		DEBUGNAME("EV_FOOTSTEP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $338
ADDRGP4 $341
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $338
line 515
;515:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $336
line 516
;516:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 cgs+152340+564
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 518
;517:				cgs.media.footsteps[ ci->footsteps ][rand()&3] );
;518:		}
line 519
;519:		break;
ADDRGP4 $336
JUMPV
LABELV $347
line 521
;520:	case EV_FOOTSTEP_METAL:
;521:		DEBUGNAME("EV_FOOTSTEP_METAL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $348
ADDRGP4 $351
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $348
line 522
;522:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $336
line 523
;523:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+564+80
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 525
;524:				cgs.media.footsteps[ FOOTSTEP_METAL ][rand()&3] );
;525:		}
line 526
;526:		break;
ADDRGP4 $336
JUMPV
LABELV $358
line 528
;527:	case EV_FOOTSPLASH:
;528:		DEBUGNAME("EV_FOOTSPLASH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $359
ADDRGP4 $362
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $359
line 529
;529:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $336
line 530
;530:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+564+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 532
;531:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;532:		}
line 533
;533:		break;
ADDRGP4 $336
JUMPV
LABELV $369
line 535
;534:	case EV_FOOTWADE:
;535:		DEBUGNAME("EV_FOOTWADE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $370
ADDRGP4 $373
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $370
line 536
;536:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $336
line 537
;537:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+564+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 539
;538:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;539:		}
line 540
;540:		break;
ADDRGP4 $336
JUMPV
LABELV $380
line 542
;541:	case EV_SWIM:
;542:		DEBUGNAME("EV_SWIM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $381
ADDRGP4 $384
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $381
line 543
;543:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $336
line 544
;544:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+564+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 546
;545:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;546:		}
line 547
;547:		break;
ADDRGP4 $336
JUMPV
LABELV $391
line 551
;548:
;549:
;550:	case EV_FALL_SHORT:
;551:		DEBUGNAME("EV_FALL_SHORT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $392
ADDRGP4 $395
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $392
line 552
;552:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.landSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+748
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 553
;553:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $336
line 555
;554:			// smooth landing z changes
;555:			cg.landChange = -8;
ADDRGP4 cg+108940
CNSTF4 3238002688
ASGNF4
line 556
;556:			cg.landTime = cg.time;
ADDRGP4 cg+108944
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 557
;557:		}
line 558
;558:		break;
ADDRGP4 $336
JUMPV
LABELV $405
line 560
;559:	case EV_FALL_MEDIUM:
;560:		DEBUGNAME("EV_FALL_MEDIUM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $406
ADDRGP4 $409
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $406
line 562
;561:		// use normal pain sound
;562:		trap_S_StartSound( NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*pain100_1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $318
ARGP4
ADDRLP4 40
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 563
;563:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $336
line 565
;564:			// smooth landing z changes
;565:			cg.landChange = -16;
ADDRGP4 cg+108940
CNSTF4 3246391296
ASGNF4
line 566
;566:			cg.landTime = cg.time;
ADDRGP4 cg+108944
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 567
;567:		}
line 568
;568:		break;
ADDRGP4 $336
JUMPV
LABELV $417
line 570
;569:	case EV_FALL_FAR:
;570:		DEBUGNAME("EV_FALL_FAR");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $418
ADDRGP4 $421
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $418
line 571
;571:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, CG_CustomSound( es->number, "*fall1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $422
ARGP4
ADDRLP4 44
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 572
;572:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 573
;573:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $336
line 575
;574:			// smooth landing z changes
;575:			cg.landChange = -24;
ADDRGP4 cg+108940
CNSTF4 3250585600
ASGNF4
line 576
;576:			cg.landTime = cg.time;
ADDRGP4 cg+108944
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 577
;577:		}
line 578
;578:		break;
ADDRGP4 $336
JUMPV
LABELV $431
line 584
;579:
;580:	case EV_STEP_4:
;581:	case EV_STEP_8:
;582:	case EV_STEP_12:
;583:	case EV_STEP_16:		// smooth out step up transitions
;584:		DEBUGNAME("EV_STEP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $432
ADDRGP4 $435
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $432
line 585
;585:	{
line 590
;586:		float	oldStep;
;587:		int		delta;
;588:		int		step;
;589:
;590:		if ( clientNum != cg.predictedPlayerState.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
EQI4 $436
line 591
;591:			break;
ADDRGP4 $336
JUMPV
LABELV $436
line 594
;592:		}
;593:		// if we are interpolating, we don't need to smooth steps
;594:		if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ||
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRGP4 cg+8
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $448
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 60
INDIRI4
NEI4 $448
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $448
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $440
LABELV $448
line 595
;595:			cg_nopredict.integer || cg_synchronousClients.integer ) {
line 596
;596:			break;
ADDRGP4 $336
JUMPV
LABELV $440
line 599
;597:		}
;598:		// check for stepping up before a previous step is completed
;599:		delta = cg.time - cg.stepTime;
ADDRLP4 48
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108928
INDIRI4
SUBI4
ASGNI4
line 600
;600:		if (delta < STEP_TIME) {
ADDRLP4 48
INDIRI4
CNSTI4 200
GEI4 $451
line 601
;601:			oldStep = cg.stepChange * (STEP_TIME - delta) / STEP_TIME;
ADDRLP4 52
ADDRGP4 cg+108924
INDIRF4
CNSTI4 200
ADDRLP4 48
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 602
;602:		} else {
ADDRGP4 $452
JUMPV
LABELV $451
line 603
;603:			oldStep = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 604
;604:		}
LABELV $452
line 607
;605:
;606:		// add this amount
;607:		step = 4 * (event - EV_STEP_4 + 1 );
ADDRLP4 56
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 24
SUBI4
CNSTI4 4
ADDI4
ASGNI4
line 608
;608:		cg.stepChange = oldStep + step;
ADDRGP4 cg+108924
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 609
;609:		if ( cg.stepChange > MAX_STEP_CHANGE ) {
ADDRGP4 cg+108924
INDIRF4
CNSTF4 1107296256
LEF4 $455
line 610
;610:			cg.stepChange = MAX_STEP_CHANGE;
ADDRGP4 cg+108924
CNSTF4 1107296256
ASGNF4
line 611
;611:		}
LABELV $455
line 612
;612:		cg.stepTime = cg.time;
ADDRGP4 cg+108928
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 613
;613:		break;
ADDRGP4 $336
JUMPV
LABELV $461
line 617
;614:	}
;615:
;616:	case EV_JUMP_PAD:
;617:		DEBUGNAME("EV_JUMP_PAD");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $462
ADDRGP4 $465
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $462
line 619
;618://		CG_Printf( "EV_JUMP_PAD w/effect #%i\n", es->eventParm );
;619:		{
line 621
;620:			localEntity_t	*smoke;
;621:			vec3_t			up = {0, 0, 1};
ADDRLP4 48
ADDRGP4 $466
INDIRB
ASGNB 12
line 624
;622:
;623:
;624:			smoke = CG_SmokePuff( cent->lerpOrigin, up, 
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ARGP4
ADDRLP4 48
ARGP4
CNSTF4 1107296256
ARGF4
ADDRLP4 64
CNSTF4 1065353216
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
CNSTF4 1051260355
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+152340+276
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 68
INDIRP4
ASGNP4
line 631
;625:						  32, 
;626:						  1, 1, 1, 0.33f,
;627:						  1000, 
;628:						  cg.time, 0,
;629:						  LEF_PUFF_DONT_SCALE, 
;630:						  cgs.media.smokePuffShader );
;631:		}
line 634
;632:
;633:		// boing sound at origin, jump sound on player
;634:		trap_S_StartSound ( cent->lerpOrigin, -1, CHAN_VOICE, cgs.media.jumpPadSound );
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+152340+756
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 635
;635:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $472
ARGP4
ADDRLP4 48
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 636
;636:		break;
ADDRGP4 $336
JUMPV
LABELV $473
line 639
;637:
;638:	case EV_JUMP:
;639:		DEBUGNAME("EV_JUMP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $474
ADDRGP4 $477
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $474
line 640
;640:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $472
ARGP4
ADDRLP4 52
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 641
;641:		break;
ADDRGP4 $336
JUMPV
LABELV $478
line 643
;642:	case EV_TAUNT:
;643:		DEBUGNAME("EV_TAUNT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $479
ADDRGP4 $482
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $479
line 644
;644:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*taunt.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $483
ARGP4
ADDRLP4 56
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 645
;645:		break;
ADDRGP4 $336
JUMPV
LABELV $484
line 673
;646:#ifdef MISSIONPACK
;647:	case EV_TAUNT_YES:
;648:		DEBUGNAME("EV_TAUNT_YES");
;649:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_YES);
;650:		break;
;651:	case EV_TAUNT_NO:
;652:		DEBUGNAME("EV_TAUNT_NO");
;653:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_NO);
;654:		break;
;655:	case EV_TAUNT_FOLLOWME:
;656:		DEBUGNAME("EV_TAUNT_FOLLOWME");
;657:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_FOLLOWME);
;658:		break;
;659:	case EV_TAUNT_GETFLAG:
;660:		DEBUGNAME("EV_TAUNT_GETFLAG");
;661:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONGETFLAG);
;662:		break;
;663:	case EV_TAUNT_GUARDBASE:
;664:		DEBUGNAME("EV_TAUNT_GUARDBASE");
;665:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONDEFENSE);
;666:		break;
;667:	case EV_TAUNT_PATROL:
;668:		DEBUGNAME("EV_TAUNT_PATROL");
;669:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONPATROL);
;670:		break;
;671:#endif
;672:	case EV_WATER_TOUCH:
;673:		DEBUGNAME("EV_WATER_TOUCH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $485
ADDRGP4 $488
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $485
line 674
;674:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+860
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 675
;675:		break;
ADDRGP4 $336
JUMPV
LABELV $491
line 677
;676:	case EV_WATER_LEAVE:
;677:		DEBUGNAME("EV_WATER_LEAVE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $492
ADDRGP4 $495
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $492
line 678
;678:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+864
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 679
;679:		break;
ADDRGP4 $336
JUMPV
LABELV $498
line 681
;680:	case EV_WATER_UNDER:
;681:		DEBUGNAME("EV_WATER_UNDER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $499
ADDRGP4 $502
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $499
line 682
;682:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrUnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+868
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 683
;683:		break;
ADDRGP4 $336
JUMPV
LABELV $505
line 685
;684:	case EV_WATER_CLEAR:
;685:		DEBUGNAME("EV_WATER_CLEAR");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $506
ADDRGP4 $509
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $506
line 686
;686:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, CG_CustomSound( es->number, "*gasp.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $510
ARGP4
ADDRLP4 60
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 687
;687:		break;
ADDRGP4 $336
JUMPV
LABELV $511
line 690
;688:
;689:	case EV_ITEM_PICKUP:
;690:		DEBUGNAME("EV_ITEM_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $512
ADDRGP4 $515
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $512
line 691
;691:		{
line 695
;692:			gitem_t	*item;
;693:			int		index;
;694:
;695:			index = es->eventParm;		// player predicted
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 697
;696:
;697:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 72
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 1
LTI4 $518
ADDRLP4 72
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $516
LABELV $518
line 698
;698:				break;
ADDRGP4 $336
JUMPV
LABELV $516
line 700
;699:			}
;700:			item = &bg_itemlist[ index ];
ADDRLP4 68
CNSTI4 52
ADDRLP4 64
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 704
;701:
;702:			// powerups and team items will have a separate global sound, this one
;703:			// will be played at prediction time
;704:			if ( item->giType == IT_POWERUP || item->giType == IT_TEAM) {
ADDRLP4 76
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 5
EQI4 $521
ADDRLP4 76
INDIRI4
CNSTI4 8
NEI4 $519
LABELV $521
line 705
;705:				trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.n_healthSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+1012
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 706
;706:			} else if (item->giType == IT_PERSISTANT_POWERUP) {
ADDRGP4 $520
JUMPV
LABELV $519
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $524
line 723
;707:#ifdef MISSIONPACK
;708:				switch (item->giTag ) {
;709:					case PW_SCOUT:
;710:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.scoutSound );
;711:					break;
;712:					case PW_GUARD:
;713:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.guardSound );
;714:					break;
;715:					case PW_DOUBLER:
;716:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.doublerSound );
;717:					break;
;718:					case PW_AMMOREGEN:
;719:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.ammoregenSound );
;720:					break;
;721:				}
;722:#endif
;723:			} else {
ADDRGP4 $525
JUMPV
LABELV $524
line 724
;724:				trap_S_StartSound (NULL, es->number, CHAN_AUTO,	trap_S_RegisterSound( item->pickup_sound, qfalse ) );
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 80
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 725
;725:			}
LABELV $525
LABELV $520
line 728
;726:
;727:			// show icon and name on status bar
;728:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $336
line 729
;729:				CG_ItemPickup( index );
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 730
;730:			}
line 731
;731:		}
line 732
;732:		break;
ADDRGP4 $336
JUMPV
LABELV $529
line 735
;733:
;734:	case EV_GLOBAL_ITEM_PICKUP:
;735:		DEBUGNAME("EV_GLOBAL_ITEM_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $530
ADDRGP4 $533
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $530
line 736
;736:		{
line 740
;737:			gitem_t	*item;
;738:			int		index;
;739:
;740:			index = es->eventParm;		// player predicted
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 742
;741:
;742:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 72
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 1
LTI4 $536
ADDRLP4 72
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $534
LABELV $536
line 743
;743:				break;
ADDRGP4 $336
JUMPV
LABELV $534
line 745
;744:			}
;745:			item = &bg_itemlist[ index ];
ADDRLP4 68
CNSTI4 52
ADDRLP4 64
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 747
;746:			// powerup pickups are global
;747:			if( item->pickup_sound ) {
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $537
line 748
;748:				trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, trap_S_RegisterSound( item->pickup_sound, qfalse ) );
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 76
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 749
;749:			}
LABELV $537
line 752
;750:
;751:			// show icon and name on status bar
;752:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $336
line 753
;753:				CG_ItemPickup( index );
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 754
;754:			}
line 755
;755:		}
line 756
;756:		break;
ADDRGP4 $336
JUMPV
LABELV $543
line 762
;757:
;758:	//
;759:	// weapon events
;760:	//
;761:	case EV_NOAMMO:
;762:		DEBUGNAME("EV_NOAMMO");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $544
ADDRGP4 $547
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $544
line 764
;763://		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.noAmmoSound );
;764:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $336
line 765
;765:			CG_OutOfAmmoChange();
ADDRGP4 CG_OutOfAmmoChange
CALLV
pop
line 766
;766:		}
line 767
;767:		break;
ADDRGP4 $336
JUMPV
LABELV $551
line 769
;768:	case EV_CHANGE_WEAPON:
;769:		DEBUGNAME("EV_CHANGE_WEAPON");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $552
ADDRGP4 $555
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $552
line 770
;770:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.selectSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+552
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 771
;771:		break;
ADDRGP4 $336
JUMPV
LABELV $558
line 773
;772:	case EV_FIRE_WEAPON:
;773:		DEBUGNAME("EV_FIRE_WEAPON");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $559
ADDRGP4 $562
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $559
line 774
;774:		CG_FireWeapon( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FireWeapon
CALLV
pop
line 775
;775:		break;
ADDRGP4 $336
JUMPV
LABELV $563
line 778
;776:
;777:	case EV_FIRE_WEAPON2: 
;778:		 DEBUGNAME("EV_FIRE_WEAPON2"); // Shafe - Trep Alt Fire
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $564
ADDRGP4 $567
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $564
line 779
;779:		 CG_FireWeapon2( cent ); 
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FireWeapon2
CALLV
pop
line 780
;780:		 break;
ADDRGP4 $336
JUMPV
LABELV $568
line 783
;781:
;782:	case EV_USE_ITEM0:
;783:		DEBUGNAME("EV_USE_ITEM0");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $569
ADDRGP4 $572
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $569
line 784
;784:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 785
;785:		break;
ADDRGP4 $336
JUMPV
LABELV $573
line 787
;786:	case EV_USE_ITEM1:
;787:		DEBUGNAME("EV_USE_ITEM1");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $574
ADDRGP4 $577
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $574
line 788
;788:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 789
;789:		break;
ADDRGP4 $336
JUMPV
LABELV $578
line 791
;790:	case EV_USE_ITEM2:
;791:		DEBUGNAME("EV_USE_ITEM2");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $579
ADDRGP4 $582
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $579
line 792
;792:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 793
;793:		break;
ADDRGP4 $336
JUMPV
LABELV $583
line 795
;794:	case EV_USE_ITEM3:
;795:		DEBUGNAME("EV_USE_ITEM3");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $584
ADDRGP4 $587
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $584
line 796
;796:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 797
;797:		break;
ADDRGP4 $336
JUMPV
LABELV $588
line 799
;798:	case EV_USE_ITEM4:
;799:		DEBUGNAME("EV_USE_ITEM4");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $589
ADDRGP4 $592
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $589
line 800
;800:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 801
;801:		break;
ADDRGP4 $336
JUMPV
LABELV $593
line 803
;802:	case EV_USE_ITEM5:
;803:		DEBUGNAME("EV_USE_ITEM5");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $594
ADDRGP4 $597
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $594
line 804
;804:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 805
;805:		break;
ADDRGP4 $336
JUMPV
LABELV $598
line 807
;806:	case EV_USE_ITEM6:
;807:		DEBUGNAME("EV_USE_ITEM6");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $599
ADDRGP4 $602
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $599
line 808
;808:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 809
;809:		break;
ADDRGP4 $336
JUMPV
LABELV $603
line 811
;810:	case EV_USE_ITEM7:
;811:		DEBUGNAME("EV_USE_ITEM7");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $604
ADDRGP4 $607
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $604
line 812
;812:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 813
;813:		break;
ADDRGP4 $336
JUMPV
LABELV $608
line 815
;814:	case EV_USE_ITEM8:
;815:		DEBUGNAME("EV_USE_ITEM8");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $609
ADDRGP4 $612
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $609
line 816
;816:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 817
;817:		break;
ADDRGP4 $336
JUMPV
LABELV $613
line 819
;818:	case EV_USE_ITEM9:
;819:		DEBUGNAME("EV_USE_ITEM9");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $614
ADDRGP4 $617
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $614
line 820
;820:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 821
;821:		break;
ADDRGP4 $336
JUMPV
LABELV $618
line 823
;822:	case EV_USE_ITEM10:
;823:		DEBUGNAME("EV_USE_ITEM10");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $619
ADDRGP4 $622
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $619
line 824
;824:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 825
;825:		break;
ADDRGP4 $336
JUMPV
LABELV $623
line 827
;826:	case EV_USE_ITEM11:
;827:		DEBUGNAME("EV_USE_ITEM11");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $624
ADDRGP4 $627
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $624
line 828
;828:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 829
;829:		break;
ADDRGP4 $336
JUMPV
LABELV $628
line 831
;830:	case EV_USE_ITEM12:
;831:		DEBUGNAME("EV_USE_ITEM12");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $629
ADDRGP4 $632
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $629
line 832
;832:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 833
;833:		break;
ADDRGP4 $336
JUMPV
LABELV $633
line 835
;834:	case EV_USE_ITEM13:
;835:		DEBUGNAME("EV_USE_ITEM13");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $634
ADDRGP4 $637
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $634
line 836
;836:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 837
;837:		break;
ADDRGP4 $336
JUMPV
LABELV $638
line 839
;838:	case EV_USE_ITEM14:
;839:		DEBUGNAME("EV_USE_ITEM14");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $639
ADDRGP4 $642
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $639
line 840
;840:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 841
;841:		break;
ADDRGP4 $336
JUMPV
LABELV $643
line 849
;842:
;843:	//=================================================================
;844:
;845:	//
;846:	// other events
;847:	//
;848:	case EV_PLAYER_TELEPORT_IN:
;849:		DEBUGNAME("EV_PLAYER_TELEPORT_IN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $644
ADDRGP4 $647
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $644
line 850
;850:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+728
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 851
;851:		CG_SpawnEffect( position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 852
;852:		break;
ADDRGP4 $336
JUMPV
LABELV $650
line 855
;853:
;854:	case EV_PLAYER_TELEPORT_OUT:
;855:		DEBUGNAME("EV_PLAYER_TELEPORT_OUT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $651
ADDRGP4 $654
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $651
line 856
;856:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+732
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 857
;857:		CG_SpawnEffect(  position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 858
;858:		break;
ADDRGP4 $336
JUMPV
LABELV $657
line 861
;859:
;860:	case EV_ITEM_POP:
;861:		DEBUGNAME("EV_ITEM_POP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $658
ADDRGP4 $661
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $658
line 862
;862:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+740
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 863
;863:		break;
ADDRGP4 $336
JUMPV
LABELV $664
line 865
;864:	case EV_ITEM_RESPAWN:
;865:		DEBUGNAME("EV_ITEM_RESPAWN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $665
ADDRGP4 $668
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $665
line 866
;866:		cent->miscTime = cg.time;	// scale up from this
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 867
;867:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+740
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 868
;868:		break;
ADDRGP4 $336
JUMPV
LABELV $672
line 871
;869:
;870:	case EV_GRENADE_BOUNCE:
;871:		DEBUGNAME("EV_GRENADE_BOUNCE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $673
ADDRGP4 $676
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $673
line 872
;872:		if ( rand() & 1 ) {
ADDRLP4 64
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $677
line 873
;873:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.hgrenb1aSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+1016
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 874
;874:		} else {
ADDRGP4 $336
JUMPV
LABELV $677
line 875
;875:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.hgrenb2aSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+1020
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 876
;876:		}
line 877
;877:		break;
ADDRGP4 $336
JUMPV
LABELV $683
line 921
;878:
;879:#ifdef MISSIONPACK
;880:	case EV_PROXIMITY_MINE_STICK:
;881:		DEBUGNAME("EV_PROXIMITY_MINE_STICK");
;882:		if( es->eventParm & SURF_FLESH ) {
;883:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimplSound );
;884:		} else 	if( es->eventParm & SURF_METALSTEPS ) {
;885:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimpmSound );
;886:		} else {
;887:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimpdSound );
;888:		}
;889:		break;
;890:
;891:	case EV_PROXIMITY_MINE_TRIGGER:
;892:		DEBUGNAME("EV_PROXIMITY_MINE_TRIGGER");
;893:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbactvSound );
;894:		break;
;895:	case EV_KAMIKAZE:
;896:		DEBUGNAME("EV_KAMIKAZE");
;897:		CG_KamikazeEffect( cent->lerpOrigin );
;898:		break;
;899:	case EV_OBELISKEXPLODE:
;900:		DEBUGNAME("EV_OBELISKEXPLODE");
;901:		CG_ObeliskExplode( cent->lerpOrigin, es->eventParm );
;902:		break;
;903:	case EV_OBELISKPAIN:
;904:		DEBUGNAME("EV_OBELISKPAIN");
;905:		CG_ObeliskPain( cent->lerpOrigin );
;906:		break;
;907:	case EV_INVUL_IMPACT:
;908:		DEBUGNAME("EV_INVUL_IMPACT");
;909:		CG_InvulnerabilityImpact( cent->lerpOrigin, cent->currentState.angles );
;910:		break;
;911:	case EV_JUICED:
;912:		DEBUGNAME("EV_JUICED");
;913:		CG_InvulnerabilityJuiced( cent->lerpOrigin );
;914:		break;
;915:	case EV_LIGHTNINGBOLT:
;916:		DEBUGNAME("EV_LIGHTNINGBOLT");
;917:		CG_LightningBoltBeam(es->origin2, es->pos.trBase);
;918:		break;
;919:#endif
;920:	case EV_SCOREPLUM:
;921:		DEBUGNAME("EV_SCOREPLUM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $684
ADDRGP4 $687
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $684
line 922
;922:		CG_ScorePlum( cent->currentState.otherEntityNum, cent->lerpOrigin, cent->currentState.time );
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 708
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ScorePlum
CALLV
pop
line 923
;923:		break;
ADDRGP4 $336
JUMPV
LABELV $688
line 929
;924:
;925:	//
;926:	// missile impacts
;927:	//
;928:	case EV_MISSILE_HIT:
;929:		DEBUGNAME("EV_MISSILE_HIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $689
ADDRGP4 $692
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $689
line 930
;930:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 931
;931:		CG_MissileHitPlayer( es->weapon, position, dir, es->otherEntityNum );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitPlayer
CALLV
pop
line 932
;932:		break;
ADDRGP4 $336
JUMPV
LABELV $693
line 935
;933:
;934:	case EV_MISSILE_MISS:
;935:		DEBUGNAME("EV_MISSILE_MISS");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $694
ADDRGP4 $697
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $694
line 936
;936:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 937
;937:		CG_MissileHitWall( es->weapon, 0, position, dir, IMPACTSOUND_DEFAULT );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 938
;938:		break;
ADDRGP4 $336
JUMPV
LABELV $698
line 941
;939:
;940:	case EV_MISSILE_MISS_METAL:
;941:		DEBUGNAME("EV_MISSILE_MISS_METAL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $699
ADDRGP4 $702
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $699
line 942
;942:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 943
;943:		CG_MissileHitWall( es->weapon, 0, position, dir, IMPACTSOUND_METAL );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 944
;944:		break;
ADDRGP4 $336
JUMPV
LABELV $703
line 947
;945:
;946:	case EV_RAILTRAIL:
;947:		DEBUGNAME("EV_RAILTRAIL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $704
ADDRGP4 $707
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $704
line 948
;948:		cent->currentState.weapon = WP_RAILGUN;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 7
ASGNI4
line 951
;949://unlagged - attack prediction #2
;950:		// if the client is us, unlagged is on server-side, and we've got it client-side
;951:		if ( es->clientNum == cg.predictedPlayerState.clientNum && 
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $708
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRGP4 cgs+153396
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $708
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 80
INDIRI4
NEI4 $715
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 80
INDIRI4
EQI4 $708
LABELV $715
line 952
;952:				cgs.delagHitscan && (cg_delag.integer & 1 || cg_delag.integer & 16) ) {
line 955
;953:			// do nothing, because it was already predicted
;954:			//Com_Printf("Ignoring rail trail event\n");
;955:		}
ADDRGP4 $336
JUMPV
LABELV $708
line 956
;956:		else {
line 958
;957:			// draw a rail trail, because it wasn't predicted
;958:			CG_RailTrail( ci, es->origin2, es->pos.trBase );
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 CG_RailTrail
CALLV
pop
line 961
;959:
;960:			// if the end was on a nomark surface, don't make an explosion
;961:			if ( es->eventParm != 255 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 255
EQI4 $336
line 962
;962:				ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 963
;963:				CG_MissileHitWall( es->weapon, es->clientNum, position, dir, IMPACTSOUND_DEFAULT );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 964
;964:			}
line 966
;965:			//Com_Printf("Non-predicted rail trail\n");
;966:		}
line 968
;967://unlagged - attack prediction #2
;968:		break;
ADDRGP4 $336
JUMPV
LABELV $718
line 971
;969:
;970:	case EV_BULLET_HIT_WALL:
;971:		DEBUGNAME("EV_BULLET_HIT_WALL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $719
ADDRGP4 $722
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $719
line 974
;972://unlagged - attack prediction #2
;973:		// if the client is us, unlagged is on server-side, and we've got it client-side
;974:		if ( es->clientNum == cg.predictedPlayerState.clientNum && 
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $723
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRGP4 cgs+153396
INDIRI4
ADDRLP4 84
INDIRI4
EQI4 $723
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 84
INDIRI4
NEI4 $730
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 84
INDIRI4
EQI4 $723
LABELV $730
line 975
;975:				cgs.delagHitscan && (cg_delag.integer & 1 || cg_delag.integer & 2) ) {
line 978
;976:			// do nothing, because it was already predicted
;977:			//Com_Printf("Ignoring bullet event\n");
;978:		}
ADDRGP4 $336
JUMPV
LABELV $723
line 979
;979:		else {
line 981
;980:			// do the bullet, because it wasn't predicted
;981:			ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 982
;982:			CG_Bullet( es->pos.trBase, es->otherEntityNum, dir, qfalse, ENTITYNUM_WORLD );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1022
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 984
;983:			//Com_Printf("Non-predicted bullet\n");
;984:		}
line 986
;985://unlagged - attack prediction #2
;986:		break;
ADDRGP4 $336
JUMPV
LABELV $731
line 989
;987:
;988:	case EV_BULLET_HIT_FLESH:
;989:		DEBUGNAME("EV_BULLET_HIT_FLESH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $732
ADDRGP4 $735
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $732
line 992
;990://unlagged - attack prediction #2
;991:		// if the client is us, unlagged is on server-side, and we've got it client-side
;992:		if ( es->clientNum == cg.predictedPlayerState.clientNum && 
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $736
ADDRLP4 88
CNSTI4 0
ASGNI4
ADDRGP4 cgs+153396
INDIRI4
ADDRLP4 88
INDIRI4
EQI4 $736
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 88
INDIRI4
NEI4 $743
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 88
INDIRI4
EQI4 $736
LABELV $743
line 993
;993:				cgs.delagHitscan && (cg_delag.integer & 1 || cg_delag.integer & 2) ) {
line 996
;994:			// do nothing, because it was already predicted
;995:			//Com_Printf("Ignoring bullet event\n");
;996:		}
ADDRGP4 $336
JUMPV
LABELV $736
line 997
;997:		else {
line 999
;998:			// do the bullet, because it wasn't predicted
;999:			CG_Bullet( es->pos.trBase, es->otherEntityNum, dir, qtrue, es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 1001
;1000:			//Com_Printf("Non-predicted bullet\n");
;1001:		}
line 1003
;1002://unlagged - attack prediction #2
;1003:		break;
ADDRGP4 $336
JUMPV
LABELV $744
line 1006
;1004:
;1005:	case EV_SHOTGUN:
;1006:		DEBUGNAME("EV_SHOTGUN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $745
ADDRGP4 $748
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $745
line 1009
;1007://unlagged - attack prediction #2
;1008:		// if the client is us, unlagged is on server-side, and we've got it client-side
;1009:		if ( es->otherEntityNum == cg.predictedPlayerState.clientNum && 
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $749
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRGP4 cgs+153396
INDIRI4
ADDRLP4 92
INDIRI4
EQI4 $749
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 92
INDIRI4
NEI4 $756
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 92
INDIRI4
EQI4 $749
LABELV $756
line 1010
;1010:				cgs.delagHitscan && (cg_delag.integer & 1 || cg_delag.integer & 4) ) {
line 1013
;1011:			// do nothing, because it was already predicted
;1012:			//Com_Printf("Ignoring shotgun event\n");
;1013:		}
ADDRGP4 $336
JUMPV
LABELV $749
line 1014
;1014:		else {
line 1016
;1015:			// do the shotgun pattern, because it wasn't predicted
;1016:			CG_ShotgunFire( es );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ShotgunFire
CALLV
pop
line 1018
;1017:			//Com_Printf("Non-predicted shotgun pattern\n");
;1018:		}
line 1020
;1019://unlagged - attack prediction #2
;1020:		break;
ADDRGP4 $336
JUMPV
LABELV $757
line 1023
;1021:
;1022:	case EV_GENERAL_SOUND:
;1023:		DEBUGNAME("EV_GENERAL_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $758
ADDRGP4 $761
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $758
line 1024
;1024:		if ( cgs.gameSounds[ es->eventParm ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35848
ADDP4
INDIRI4
CNSTI4 0
EQI4 $762
line 1025
;1025:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35848
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1026
;1026:		} else {
ADDRGP4 $336
JUMPV
LABELV $762
line 1027
;1027:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 96
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 96
INDIRP4
ASGNP4
line 1028
;1028:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1029
;1029:		}
line 1030
;1030:		break;
ADDRGP4 $336
JUMPV
LABELV $766
line 1033
;1031:
;1032:	case EV_GLOBAL_SOUND:	// play from the player's head so it never diminishes
;1033:		DEBUGNAME("EV_GLOBAL_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $767
ADDRGP4 $770
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $767
line 1034
;1034:		if ( cgs.gameSounds[ es->eventParm ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35848
ADDP4
INDIRI4
CNSTI4 0
EQI4 $771
line 1035
;1035:			trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRLP4 96
CNSTI4 184
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35848
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1036
;1036:		} else {
ADDRGP4 $336
JUMPV
LABELV $771
line 1037
;1037:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 96
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 96
INDIRP4
ASGNP4
line 1038
;1038:			trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1039
;1039:		}
line 1040
;1040:		break;
ADDRGP4 $336
JUMPV
LABELV $777
line 1043
;1041:
;1042:	case EV_GLOBAL_TEAM_SOUND:	// play from the player's head so it never diminishes
;1043:		{
line 1044
;1044:			DEBUGNAME("EV_GLOBAL_TEAM_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $778
ADDRGP4 $781
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $778
line 1045
;1045:			switch( es->eventParm ) {
ADDRLP4 96
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
LTI4 $336
ADDRLP4 96
INDIRI4
CNSTI4 12
GTI4 $336
ADDRLP4 96
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $900
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $900
address $785
address $795
address $805
address $817
address $829
address $849
address $869
address $877
address $885
address $888
address $891
address $894
address $897
code
LABELV $785
line 1047
;1046:				case GTS_RED_CAPTURE: // CTF: red team captured the blue flag, 1FCTF: red team captured the neutral flag
;1047:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED )
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $786
line 1048
;1048:						CG_AddBufferedSound( cgs.media.captureYourTeamSound );
ADDRGP4 cgs+152340+908
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $336
JUMPV
LABELV $786
line 1050
;1049:					else
;1050:						CG_AddBufferedSound( cgs.media.captureOpponentSound );
ADDRGP4 cgs+152340+912
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1051
;1051:					break;
ADDRGP4 $336
JUMPV
LABELV $795
line 1053
;1052:				case GTS_BLUE_CAPTURE: // CTF: blue team captured the red flag, 1FCTF: blue team captured the neutral flag
;1053:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_BLUE )
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $796
line 1054
;1054:						CG_AddBufferedSound( cgs.media.captureYourTeamSound );
ADDRGP4 cgs+152340+908
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $336
JUMPV
LABELV $796
line 1056
;1055:					else
;1056:						CG_AddBufferedSound( cgs.media.captureOpponentSound );
ADDRGP4 cgs+152340+912
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1057
;1057:					break;
ADDRGP4 $336
JUMPV
LABELV $805
line 1059
;1058:				case GTS_RED_RETURN: // CTF: blue flag returned, 1FCTF: never used
;1059:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED )
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $806
line 1060
;1060:						CG_AddBufferedSound( cgs.media.returnYourTeamSound );
ADDRGP4 cgs+152340+916
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $807
JUMPV
LABELV $806
line 1062
;1061:					else
;1062:						CG_AddBufferedSound( cgs.media.returnOpponentSound );
ADDRGP4 cgs+152340+920
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $807
line 1064
;1063:					//
;1064:					CG_AddBufferedSound( cgs.media.blueFlagReturnedSound );
ADDRGP4 cgs+152340+936
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1065
;1065:					break;
ADDRGP4 $336
JUMPV
LABELV $817
line 1067
;1066:				case GTS_BLUE_RETURN: // CTF red flag returned, 1FCTF: neutral flag returned
;1067:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_BLUE )
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $818
line 1068
;1068:						CG_AddBufferedSound( cgs.media.returnYourTeamSound );
ADDRGP4 cgs+152340+916
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $819
JUMPV
LABELV $818
line 1070
;1069:					else
;1070:						CG_AddBufferedSound( cgs.media.returnOpponentSound );
ADDRGP4 cgs+152340+920
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $819
line 1072
;1071:					//
;1072:					CG_AddBufferedSound( cgs.media.redFlagReturnedSound );
ADDRGP4 cgs+152340+932
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1073
;1073:					break;
ADDRGP4 $336
JUMPV
LABELV $829
line 1077
;1074:
;1075:				case GTS_RED_TAKEN: // CTF: red team took blue flag, 1FCTF: blue team took the neutral flag
;1076:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1077:					if (cg.snap->ps.powerups[PW_BLUEFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRLP4 104
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
ADDRLP4 104
INDIRI4
NEI4 $834
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
ADDRLP4 104
INDIRI4
EQI4 $830
LABELV $834
line 1078
;1078:					}
ADDRGP4 $336
JUMPV
LABELV $830
line 1079
;1079:					else {
line 1080
;1080:					if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE) {
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $835
line 1086
;1081:#ifdef MISSIONPACK
;1082:							if (cgs.gametype == GT_1FCTF) 
;1083:								CG_AddBufferedSound( cgs.media.yourTeamTookTheFlagSound );
;1084:							else
;1085:#endif
;1086:						 	CG_AddBufferedSound( cgs.media.enemyTookYourFlagSound );
ADDRGP4 cgs+152340+944
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1087
;1087:						}
ADDRGP4 $336
JUMPV
LABELV $835
line 1088
;1088:						else if (cgs.clientinfo[cg.clientNum].team == TEAM_RED) {
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $336
line 1094
;1089:#ifdef MISSIONPACK
;1090:							if (cgs.gametype == GT_1FCTF)
;1091:								CG_AddBufferedSound( cgs.media.enemyTookTheFlagSound );
;1092:							else
;1093:#endif
;1094: 							CG_AddBufferedSound( cgs.media.yourTeamTookEnemyFlagSound );
ADDRGP4 cgs+152340+952
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1095
;1095:						}
line 1096
;1096:					}
line 1097
;1097:					break;
ADDRGP4 $336
JUMPV
LABELV $849
line 1100
;1098:				case GTS_BLUE_TAKEN: // CTF: blue team took the red flag, 1FCTF red team took the neutral flag
;1099:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1100:					if (cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
ADDRLP4 108
INDIRI4
NEI4 $854
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
ADDRLP4 108
INDIRI4
EQI4 $850
LABELV $854
line 1101
;1101:					}
ADDRGP4 $336
JUMPV
LABELV $850
line 1102
;1102:					else {
line 1103
;1103:						if (cgs.clientinfo[cg.clientNum].team == TEAM_RED) {
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $855
line 1109
;1104:#ifdef MISSIONPACK
;1105:							if (cgs.gametype == GT_1FCTF)
;1106:								CG_AddBufferedSound( cgs.media.yourTeamTookTheFlagSound );
;1107:							else
;1108:#endif
;1109:							CG_AddBufferedSound( cgs.media.enemyTookYourFlagSound );
ADDRGP4 cgs+152340+944
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1110
;1110:						}
ADDRGP4 $336
JUMPV
LABELV $855
line 1111
;1111:						else if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE) {
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $336
line 1117
;1112:#ifdef MISSIONPACK
;1113:							if (cgs.gametype == GT_1FCTF)
;1114:								CG_AddBufferedSound( cgs.media.enemyTookTheFlagSound );
;1115:							else
;1116:#endif
;1117:							CG_AddBufferedSound( cgs.media.yourTeamTookEnemyFlagSound );
ADDRGP4 cgs+152340+952
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1118
;1118:						}
line 1119
;1119:					}
line 1120
;1120:					break;
ADDRGP4 $336
JUMPV
LABELV $869
line 1122
;1121:				case GTS_REDOBELISK_ATTACKED: // Overload: red obelisk is being attacked
;1122:					if (cgs.clientinfo[cg.clientNum].team == TEAM_RED) {
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $336
line 1123
;1123:						CG_AddBufferedSound( cgs.media.yourBaseIsUnderAttackSound );
ADDRGP4 cgs+152340+964
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1124
;1124:					}
line 1125
;1125:					break;
ADDRGP4 $336
JUMPV
LABELV $877
line 1127
;1126:				case GTS_BLUEOBELISK_ATTACKED: // Overload: blue obelisk is being attacked
;1127:					if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE) {
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $336
line 1128
;1128:						CG_AddBufferedSound( cgs.media.yourBaseIsUnderAttackSound );
ADDRGP4 cgs+152340+964
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1129
;1129:					}
line 1130
;1130:					break;
ADDRGP4 $336
JUMPV
LABELV $885
line 1133
;1131:
;1132:				case GTS_REDTEAM_SCORED:
;1133:					CG_AddBufferedSound(cgs.media.redScoredSound);
ADDRGP4 cgs+152340+888
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1134
;1134:					break;
ADDRGP4 $336
JUMPV
LABELV $888
line 1136
;1135:				case GTS_BLUETEAM_SCORED:
;1136:					CG_AddBufferedSound(cgs.media.blueScoredSound);
ADDRGP4 cgs+152340+892
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1137
;1137:					break;
ADDRGP4 $336
JUMPV
LABELV $891
line 1139
;1138:				case GTS_REDTEAM_TOOK_LEAD:
;1139:					CG_AddBufferedSound(cgs.media.redLeadsSound);
ADDRGP4 cgs+152340+896
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1140
;1140:					break;
ADDRGP4 $336
JUMPV
LABELV $894
line 1142
;1141:				case GTS_BLUETEAM_TOOK_LEAD:
;1142:					CG_AddBufferedSound(cgs.media.blueLeadsSound);
ADDRGP4 cgs+152340+900
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1143
;1143:					break;
ADDRGP4 $336
JUMPV
LABELV $897
line 1145
;1144:				case GTS_TEAMS_ARE_TIED:
;1145:					CG_AddBufferedSound( cgs.media.teamsTiedSound );
ADDRGP4 cgs+152340+904
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1146
;1146:					break;
line 1153
;1147:#ifdef MISSIONPACK
;1148:				case GTS_KAMIKAZE:
;1149:					trap_S_StartLocalSound(cgs.media.kamikazeFarSound, CHAN_ANNOUNCER);
;1150:					break;
;1151:#endif
;1152:				default:
;1153:					break;
line 1155
;1154:			}
;1155:			break;
ADDRGP4 $336
JUMPV
LABELV $901
line 1161
;1156:		}
;1157:
;1158:	case EV_PAIN:
;1159:		// local player sounds are triggered in CG_CheckLocalSounds,
;1160:		// so ignore events on the player
;1161:		DEBUGNAME("EV_PAIN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $902
ADDRGP4 $905
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $902
line 1162
;1162:		if ( cent->currentState.number != cg.snap->ps.clientNum ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $336
line 1163
;1163:			CG_PainEvent( cent, es->eventParm );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 1164
;1164:		}
line 1165
;1165:		break;
ADDRGP4 $336
JUMPV
LABELV $909
line 1170
;1166:
;1167:	case EV_DEATH1:
;1168:	case EV_DEATH2:
;1169:	case EV_DEATH3:
;1170:		DEBUGNAME("EV_DEATHx");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $910
ADDRGP4 $913
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $910
line 1171
;1171:		trap_S_StartSound( NULL, es->number, CHAN_VOICE, 
ADDRGP4 $914
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 58
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 96
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1173
;1172:				CG_CustomSound( es->number, va("*death%i.wav", event - EV_DEATH1 + 1) ) );
;1173:		break;
ADDRGP4 $336
JUMPV
LABELV $915
line 1177
;1174:
;1175:
;1176:	case EV_OBITUARY:
;1177:		DEBUGNAME("EV_OBITUARY");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $916
ADDRGP4 $919
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $916
line 1178
;1178:		CG_Obituary( es );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Obituary
CALLV
pop
line 1179
;1179:		break;
ADDRGP4 $336
JUMPV
LABELV $920
line 1185
;1180:
;1181:	//
;1182:	// powerup events
;1183:	//
;1184:	case EV_POWERUP_QUAD:
;1185:		DEBUGNAME("EV_POWERUP_QUAD");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $921
ADDRGP4 $924
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $921
line 1186
;1186:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $925
line 1187
;1187:			cg.powerupActive = PW_QUAD;
ADDRGP4 cg+124420
CNSTI4 1
ASGNI4
line 1188
;1188:			cg.powerupTime = cg.time;
ADDRGP4 cg+124424
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1189
;1189:		}
LABELV $925
line 1190
;1190:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.quadSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+152340+544
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1191
;1191:		break;
ADDRGP4 $336
JUMPV
LABELV $933
line 1193
;1192:	case EV_POWERUP_BATTLESUIT:
;1193:		DEBUGNAME("EV_POWERUP_BATTLESUIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $934
ADDRGP4 $937
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $934
line 1194
;1194:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $938
line 1195
;1195:			cg.powerupActive = PW_BATTLESUIT;
ADDRGP4 cg+124420
CNSTI4 2
ASGNI4
line 1196
;1196:			cg.powerupTime = cg.time;
ADDRGP4 cg+124424
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1197
;1197:		}
LABELV $938
line 1198
;1198:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.protectSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+152340+1008
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1199
;1199:		break;
ADDRGP4 $336
JUMPV
LABELV $946
line 1201
;1200:	case EV_POWERUP_REGEN:
;1201:		DEBUGNAME("EV_POWERUP_REGEN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $947
ADDRGP4 $950
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $947
line 1202
;1202:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $951
line 1203
;1203:			cg.powerupActive = PW_REGEN;
ADDRGP4 cg+124420
CNSTI4 5
ASGNI4
line 1204
;1204:			cg.powerupTime = cg.time;
ADDRGP4 cg+124424
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1205
;1205:		}
LABELV $951
line 1206
;1206:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.regenSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+152340+1004
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1207
;1207:		break;
ADDRGP4 $336
JUMPV
LABELV $959
line 1210
;1208:
;1209:	case EV_GIB_PLAYER:
;1210:		DEBUGNAME("EV_GIB_PLAYER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $960
ADDRGP4 $963
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $960
line 1214
;1211:		// don't play gib sound when using the kamikaze because it interferes
;1212:		// with the kamikaze sound, downside is that the gib sound will also
;1213:		// not be played when someone is gibbed while just carrying the kamikaze
;1214:		if ( !(es->eFlags & EF_KAMIKAZE) ) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $964
line 1215
;1215:			trap_S_StartSound( NULL, es->number, CHAN_BODY, cgs.media.gibSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+152340+712
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1216
;1216:		}
LABELV $964
line 1217
;1217:		CG_GibPlayer( cent->lerpOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ARGP4
ADDRGP4 CG_GibPlayer
CALLV
pop
line 1218
;1218:		break;
ADDRGP4 $336
JUMPV
LABELV $968
line 1222
;1219:
;1220:	// Shafe - Trep - Headshot stuff
;1221:	case EV_GIB_PLAYER_HEADSHOT:
;1222:		DEBUGNAME("EV_GIB_PLAYER_HEADSHOT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $969
ADDRGP4 $972
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $969
line 1223
;1223:		trap_S_StartSound( NULL, es->number, CHAN_BODY, cgs.media.gibSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+152340+712
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1224
;1224:		cent->pe.noHead = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
CNSTI4 1
ASGNI4
line 1225
;1225:		CG_GibPlayerHeadshot( cent->lerpOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ARGP4
ADDRGP4 CG_GibPlayerHeadshot
CALLV
pop
line 1226
;1226:		break;
ADDRGP4 $336
JUMPV
LABELV $975
line 1229
;1227:
;1228:	case EV_BODY_NOHEAD:
;1229:		DEBUGNAME("EV_BODY_NOHEAD");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $976
ADDRGP4 $979
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $976
line 1230
;1230:		cent->pe.noHead = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
CNSTI4 1
ASGNI4
line 1231
;1231:		break;
ADDRGP4 $336
JUMPV
LABELV $980
line 1235
;1232:	// Shafe - Trep - End Headshot Stuff
;1233:
;1234:	case EV_STOPLOOPINGSOUND:
;1235:		DEBUGNAME("EV_STOPLOOPINGSOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $981
ADDRGP4 $984
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $981
line 1236
;1236:		trap_S_StopLoopingSound( es->number );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StopLoopingSound
CALLV
pop
line 1237
;1237:		es->loopSound = 0;
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 1238
;1238:		break;
ADDRGP4 $336
JUMPV
LABELV $985
line 1241
;1239:
;1240:	case EV_DEBUG_LINE:
;1241:		DEBUGNAME("EV_DEBUG_LINE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $986
ADDRGP4 $989
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $986
line 1242
;1242:		CG_Beam( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 1243
;1243:		break;
ADDRGP4 $336
JUMPV
LABELV $335
line 1246
;1244:
;1245:	default:
;1246:		DEBUGNAME("UNKNOWN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $990
ADDRGP4 $993
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $990
line 1247
;1247:		CG_Error( "Unknown event: %i", event );
ADDRGP4 $994
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1248
;1248:		break;
LABELV $336
line 1251
;1249:	}
;1250:
;1251:}
LABELV $320
endproc CG_EntityEvent 112 48
export CG_CheckEvents
proc CG_CheckEvents 8 12
line 1260
;1252:
;1253:
;1254:/*
;1255:==============
;1256:CG_CheckEvents
;1257:
;1258:==============
;1259:*/
;1260:void CG_CheckEvents( centity_t *cent ) {
line 1262
;1261:	// check for event-only entities
;1262:	if ( cent->currentState.eType > ET_EVENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $998
line 1263
;1263:		if ( cent->previousEvent ) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1000
line 1264
;1264:			return;	// already fired
ADDRGP4 $997
JUMPV
LABELV $1000
line 1267
;1265:		}
;1266:		// if this is a player event set the entity number of the client entity number
;1267:		if ( cent->currentState.eFlags & EF_PLAYER_EVENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1002
line 1268
;1268:			cent->currentState.number = cent->currentState.otherEntityNum;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 1269
;1269:		}
LABELV $1002
line 1271
;1270:
;1271:		cent->previousEvent = 1;
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
CNSTI4 1
ASGNI4
line 1273
;1272:
;1273:		cent->currentState.event = cent->currentState.eType - ET_EVENTS;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
SUBI4
ASGNI4
line 1274
;1274:	} else {
ADDRGP4 $999
JUMPV
LABELV $998
line 1276
;1275:		// check for events riding with another entity
;1276:		if ( cent->currentState.event == cent->previousEvent ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
NEI4 $1004
line 1277
;1277:			return;
ADDRGP4 $997
JUMPV
LABELV $1004
line 1279
;1278:		}
;1279:		cent->previousEvent = cent->currentState.event;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 1280
;1280:		if ( ( cent->currentState.event & ~EV_EVENT_BITS ) == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 0
NEI4 $1006
line 1281
;1281:			return;
ADDRGP4 $997
JUMPV
LABELV $1006
line 1283
;1282:		}
;1283:	}
LABELV $999
line 1286
;1284:
;1285:	// calculate the position at exactly the frame time
;1286:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.snap->serverTime, cent->lerpOrigin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1287
;1287:	CG_SetEntitySoundPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 1289
;1288:
;1289:	CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 708
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 1290
;1290:}
LABELV $997
endproc CG_CheckEvents 8 12
import CG_DrawScanner
import CG_ScannerOff_f
import CG_ScannerOn_f
import CG_NewParticleArea
import initparticles
import CG_ParticleExplosion
import CG_ParticleMisc
import CG_ParticleDust
import CG_ParticleSparks
import CG_ParticleBulletDebris
import CG_ParticleSnowFlurry
import CG_AddParticleShrapnel
import CG_ParticleSmoke
import CG_ParticleSnow
import CG_AddParticles
import CG_ClearParticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedBoxTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_AddCommand
import trap_SendConsoleCommand
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_ShaderStateChanged
import CG_LoadVoiceChats
import CG_SetConfigValues
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_InitConsoleCommands
import CG_ConsoleCommand
import CG_DrawOldTourneyScoreboard
import CG_DrawOldScoreboard
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
import CG_TransitionEntity
import CG_ProcessSnapshots
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_GibPlayerHeadshot
import CG_GibPlayer
import CG_ScorePlum
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon2
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_InitTeamChat
import CG_SetPrintString
import CG_ShowResponseHead
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
import CG_DrawTeamBackground
import CG_DrawFlagModel
import CG_DrawActive
import CG_DrawHead
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
import teamChat2
import teamChat1
import systemChat
import drawTeamOverlayModificationCount
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawSmallStringColor
import CG_DrawSmallString
import CG_DrawBigStringColor
import CG_DrawBigString
import CG_DrawStringExt
import CG_DrawString
import CG_DrawPic
import CG_FillRect
import CG_AdjustFrom640
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_BuildSpectatorString
import CG_GetSelectedScore
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import CG_Cvar_ClampInt
import CG_AddBoundingBox
import CG_PredictWeaponEffects
import cg_playerOrigins
import cg_plOut
import cg_latentCmds
import cg_latentSnaps
import cl_timeNudge
import cg_optimizePrediction
import cg_projectileNudge
import sv_fps
import cg_cmdTimeNudge
import cg_drawBBox
import cg_debugDelag
import cg_delag
import cg_trueLightning
import cg_oldPlasma
import cg_oldRocket
import cg_oldRail
import cg_noProjectileTrail
import cg_noTaunt
import cg_bigFont
import cg_smallFont
import cg_cameraMode
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import pmove_msec
import pmove_fixed
import cg_scorePlum
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_deferPlayers
import cg_predictItems
import cg_blood
import cg_paused
import cg_buildScript
import cg_forceModel
import cg_stats
import cg_teamChatHeight
import cg_teamChatTime
import cg_synchronousClients
import cg_drawAttacker
import cg_lagometer
import cg_stereoSeparation
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_zoomFov
import cg_fov
import cg_simpleItems
import cg_ignore
import cg_autoswitch
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_viewsize
import cg_drawGun
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_brassTime
import cg_addMarks
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_railTrailTime
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_draw2D
import cg_drawStatus
import cg_crosshairHealth
import cg_crosshairSize
import cg_crosshairY
import cg_crosshairX
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_drawRewards
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_gibs
import cg_shadows
import cg_swingSpeed
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_runroll
import cg_runpitch
import cg_centertime
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import Max_Ammo
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Com_Printf
import Com_Error
import Info_NextPair
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import SnapVectorTowards
import tonextint
import init_tonextint
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Com_Memcpy
import Com_Memset
import Hunk_Alloc
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $994
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $993
byte 1 85
byte 1 78
byte 1 75
byte 1 78
byte 1 79
byte 1 87
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $989
byte 1 69
byte 1 86
byte 1 95
byte 1 68
byte 1 69
byte 1 66
byte 1 85
byte 1 71
byte 1 95
byte 1 76
byte 1 73
byte 1 78
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $984
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 84
byte 1 79
byte 1 80
byte 1 76
byte 1 79
byte 1 79
byte 1 80
byte 1 73
byte 1 78
byte 1 71
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $979
byte 1 69
byte 1 86
byte 1 95
byte 1 66
byte 1 79
byte 1 68
byte 1 89
byte 1 95
byte 1 78
byte 1 79
byte 1 72
byte 1 69
byte 1 65
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $972
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 73
byte 1 66
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 95
byte 1 72
byte 1 69
byte 1 65
byte 1 68
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $963
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 73
byte 1 66
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $950
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 82
byte 1 69
byte 1 71
byte 1 69
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $937
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 66
byte 1 65
byte 1 84
byte 1 84
byte 1 76
byte 1 69
byte 1 83
byte 1 85
byte 1 73
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $924
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 81
byte 1 85
byte 1 65
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $919
byte 1 69
byte 1 86
byte 1 95
byte 1 79
byte 1 66
byte 1 73
byte 1 84
byte 1 85
byte 1 65
byte 1 82
byte 1 89
byte 1 10
byte 1 0
align 1
LABELV $914
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $913
byte 1 69
byte 1 86
byte 1 95
byte 1 68
byte 1 69
byte 1 65
byte 1 84
byte 1 72
byte 1 120
byte 1 10
byte 1 0
align 1
LABELV $905
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 65
byte 1 73
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $781
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $770
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $761
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 69
byte 1 82
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $748
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $735
byte 1 69
byte 1 86
byte 1 95
byte 1 66
byte 1 85
byte 1 76
byte 1 76
byte 1 69
byte 1 84
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 95
byte 1 70
byte 1 76
byte 1 69
byte 1 83
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $722
byte 1 69
byte 1 86
byte 1 95
byte 1 66
byte 1 85
byte 1 76
byte 1 76
byte 1 69
byte 1 84
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 95
byte 1 87
byte 1 65
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $707
byte 1 69
byte 1 86
byte 1 95
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 84
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $702
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 95
byte 1 77
byte 1 69
byte 1 84
byte 1 65
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $697
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 10
byte 1 0
align 1
LABELV $692
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $687
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 67
byte 1 79
byte 1 82
byte 1 69
byte 1 80
byte 1 76
byte 1 85
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $676
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 95
byte 1 66
byte 1 79
byte 1 85
byte 1 78
byte 1 67
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $668
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 82
byte 1 69
byte 1 83
byte 1 80
byte 1 65
byte 1 87
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $661
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 79
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $654
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 95
byte 1 79
byte 1 85
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $647
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 95
byte 1 73
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $642
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 52
byte 1 10
byte 1 0
align 1
LABELV $637
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $632
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $627
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $622
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $617
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 57
byte 1 10
byte 1 0
align 1
LABELV $612
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 56
byte 1 10
byte 1 0
align 1
LABELV $607
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 55
byte 1 10
byte 1 0
align 1
LABELV $602
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 54
byte 1 10
byte 1 0
align 1
LABELV $597
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 53
byte 1 10
byte 1 0
align 1
LABELV $592
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 52
byte 1 10
byte 1 0
align 1
LABELV $587
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $582
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $577
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $572
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $567
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 73
byte 1 82
byte 1 69
byte 1 95
byte 1 87
byte 1 69
byte 1 65
byte 1 80
byte 1 79
byte 1 78
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $562
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 73
byte 1 82
byte 1 69
byte 1 95
byte 1 87
byte 1 69
byte 1 65
byte 1 80
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $555
byte 1 69
byte 1 86
byte 1 95
byte 1 67
byte 1 72
byte 1 65
byte 1 78
byte 1 71
byte 1 69
byte 1 95
byte 1 87
byte 1 69
byte 1 65
byte 1 80
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $547
byte 1 69
byte 1 86
byte 1 95
byte 1 78
byte 1 79
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 10
byte 1 0
align 1
LABELV $533
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $515
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $510
byte 1 42
byte 1 103
byte 1 97
byte 1 115
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $509
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 67
byte 1 76
byte 1 69
byte 1 65
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $502
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 85
byte 1 78
byte 1 68
byte 1 69
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $495
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 76
byte 1 69
byte 1 65
byte 1 86
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $488
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 84
byte 1 79
byte 1 85
byte 1 67
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $483
byte 1 42
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $482
byte 1 69
byte 1 86
byte 1 95
byte 1 84
byte 1 65
byte 1 85
byte 1 78
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $477
byte 1 69
byte 1 86
byte 1 95
byte 1 74
byte 1 85
byte 1 77
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $472
byte 1 42
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $465
byte 1 69
byte 1 86
byte 1 95
byte 1 74
byte 1 85
byte 1 77
byte 1 80
byte 1 95
byte 1 80
byte 1 65
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $435
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $422
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $421
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 70
byte 1 65
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $409
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 77
byte 1 69
byte 1 68
byte 1 73
byte 1 85
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $395
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 82
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $384
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 87
byte 1 73
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $373
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 87
byte 1 65
byte 1 68
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $362
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $351
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 95
byte 1 77
byte 1 69
byte 1 84
byte 1 65
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $341
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $330
byte 1 90
byte 1 69
byte 1 82
byte 1 79
byte 1 69
byte 1 86
byte 1 69
byte 1 78
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $324
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $318
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 49
byte 1 48
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $317
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 55
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $314
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 53
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $311
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 50
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $274
byte 1 85
byte 1 115
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $273
byte 1 78
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $263
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $262
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $257
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $256
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $255
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $253
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $252
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $250
byte 1 39
byte 1 115
byte 1 32
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $249
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $247
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $245
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 103
byte 1 97
byte 1 117
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $242
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $241
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $239
byte 1 97
byte 1 108
byte 1 109
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 100
byte 1 103
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $237
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 117
byte 1 108
byte 1 97
byte 1 114
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $236
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 99
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $234
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $233
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 101
byte 1 100
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $231
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $230
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $228
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $226
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $224
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 117
byte 1 109
byte 1 109
byte 1 101
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $222
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $211
byte 1 110
byte 1 111
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $208
byte 1 72
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 33
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $205
byte 1 72
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 33
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $201
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $198
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $189
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $184
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $183
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $180
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $177
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 98
byte 1 108
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $176
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 98
byte 1 108
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $173
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 98
byte 1 108
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $169
byte 1 115
byte 1 104
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $167
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $166
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $163
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $159
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $158
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $155
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $151
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $150
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $147
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $137
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 114
byte 1 111
byte 1 110
byte 1 103
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $135
byte 1 115
byte 1 97
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $133
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 0
align 1
LABELV $131
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $129
byte 1 115
byte 1 97
byte 1 110
byte 1 107
byte 1 32
byte 1 108
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $127
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 113
byte 1 117
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $125
byte 1 99
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $123
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $119
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $118
byte 1 110
byte 1 0
align 1
LABELV $111
byte 1 67
byte 1 71
byte 1 95
byte 1 79
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 58
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $106
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $105
byte 1 37
byte 1 105
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $104
byte 1 37
byte 1 105
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $101
byte 1 37
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $98
byte 1 37
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $95
byte 1 49
byte 1 51
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $92
byte 1 49
byte 1 50
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $89
byte 1 49
byte 1 49
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $86
byte 1 94
byte 1 51
byte 1 51
byte 1 114
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $83
byte 1 94
byte 1 49
byte 1 50
byte 1 110
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $80
byte 1 94
byte 1 52
byte 1 49
byte 1 115
byte 1 116
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $77
byte 1 0
align 1
LABELV $76
byte 1 84
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 0
