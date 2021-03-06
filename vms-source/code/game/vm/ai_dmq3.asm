export BotSetUserInfo
code
proc BotSetUserInfo 1024 12
file "../ai_dmq3.c"
line 100
;1:// 2016 Trepidation Licensed under the GPL2
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_dmq3.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_dmq3.c $
;10: * $Author: Zaphod $ 
;11: * $Revision: 85 $
;12: * $Modtime: 5/16/01 2:53p $
;13: * $Date: 5/16/01 2:53p $
;14: *
;15: *****************************************************************************/
;16:
;17:
;18:#include "g_local.h"
;19:#include "botlib.h"
;20:#include "be_aas.h"
;21:#include "be_ea.h"
;22:#include "be_ai_char.h"
;23:#include "be_ai_chat.h"
;24:#include "be_ai_gen.h"
;25:#include "be_ai_goal.h"
;26:#include "be_ai_move.h"
;27:#include "be_ai_weap.h"
;28://
;29:#include "ai_main.h"
;30:#include "ai_dmq3.h"
;31:#include "ai_chat.h"
;32:#include "ai_cmd.h"
;33:#include "ai_dmnet.h"
;34:#include "ai_team.h"
;35://
;36:#include "chars.h"				//characteristics
;37:#include "inv.h"				//indexes into the inventory
;38:#include "syn.h"				//synonyms
;39:#include "match.h"				//string matching types and vars
;40:
;41:// for the voice chats
;42:#include "../../ui/menudef.h" // sos001205 - for q3_ui also
;43:
;44:// from aasfile.h
;45:#define AREACONTENTS_MOVER				1024
;46:#define AREACONTENTS_MODELNUMSHIFT		24
;47:#define AREACONTENTS_MAXMODELNUM		0xFF
;48:#define AREACONTENTS_MODELNUM			(AREACONTENTS_MAXMODELNUM << AREACONTENTS_MODELNUMSHIFT)
;49:
;50:#define IDEAL_ATTACKDIST			140
;51:
;52:#define MAX_WAYPOINTS		128
;53://
;54:bot_waypoint_t botai_waypoints[MAX_WAYPOINTS];
;55:bot_waypoint_t *botai_freewaypoints;
;56:
;57://NOTE: not using a cvars which can be updated because the game should be reloaded anyway
;58:int gametype;		//game type
;59:int maxclients;		//maximum number of clients
;60:
;61:vmCvar_t bot_grapple;
;62:vmCvar_t bot_rocketjump;
;63:vmCvar_t bot_fastchat;
;64:vmCvar_t bot_nochat;
;65:vmCvar_t bot_testrchat;
;66:vmCvar_t bot_challenge;
;67:vmCvar_t bot_predictobstacles;
;68:vmCvar_t g_spSkill;
;69:
;70:extern vmCvar_t bot_developer;
;71:
;72:vec3_t lastteleport_origin;		//last teleport event origin
;73:float lastteleport_time;		//last teleport event time
;74:int max_bspmodelindex;			//maximum BSP model index
;75:
;76://CTF flag goals
;77:bot_goal_t ctf_redflag;
;78:bot_goal_t ctf_blueflag;
;79:#ifdef MISSIONPACK
;80:bot_goal_t ctf_neutralflag;
;81:bot_goal_t redobelisk;
;82:bot_goal_t blueobelisk;
;83:bot_goal_t neutralobelisk;
;84:#endif
;85:
;86:#define MAX_ALTROUTEGOALS		32
;87:
;88:int altroutegoals_setup;
;89:aas_altroutegoal_t red_altroutegoals[MAX_ALTROUTEGOALS];
;90:int red_numaltroutegoals;
;91:aas_altroutegoal_t blue_altroutegoals[MAX_ALTROUTEGOALS];
;92:int blue_numaltroutegoals;
;93:
;94:
;95:/*
;96:==================
;97:BotSetUserInfo
;98:==================
;99:*/
;100:void BotSetUserInfo(bot_state_t *bs, char *key, char *value) {
line 103
;101:	char userinfo[MAX_INFO_STRING];
;102:
;103:	trap_GetUserinfo(bs->client, userinfo, sizeof(userinfo));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 104
;104:	Info_SetValueForKey(userinfo, key, value);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 105
;105:	trap_SetUserinfo(bs->client, userinfo);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 106
;106:	ClientUserinfoChanged( bs->client );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 107
;107:}
LABELV $56
endproc BotSetUserInfo 1024 12
export BotFirstLadder
proc BotFirstLadder 8 4
line 117
;108:
;109:/*
;110:==================
;111:BotFirstLadder
;112:==================
;113:*/
;114:
;115:// Ladder support (part 2) -Vincent
;116:int BotFirstLadder( int *areas, int numareas )
;117:{
line 119
;118:	int i;
;119:	for (i=0; i<numareas; i++) 
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $61
JUMPV
LABELV $58
line 120
;120:	{
line 121
;121:		if (trap_AAS_AreaLadder( areas[i] )) 
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_AAS_AreaLadder
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $62
line 122
;122:		{
line 123
;123:		return areas[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI4
RETI4
ADDRGP4 $57
JUMPV
LABELV $62
line 125
;124:		}
;125:	}
LABELV $59
line 119
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $61
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $58
line 126
;126:	return 0;
CNSTI4 0
RETI4
LABELV $57
endproc BotFirstLadder 8 4
export BotCTFCarryingFlag
proc BotCTFCarryingFlag 0 0
line 134
;127:}
;128:
;129:/*
;130:==================
;131:BotCTFCarryingFlag
;132:==================
;133:*/
;134:int BotCTFCarryingFlag(bot_state_t *bs) {
line 135
;135:	if (gametype != GT_CTF) return CTF_FLAG_NONE;
ADDRGP4 gametype
INDIRI4
CNSTI4 4
EQI4 $65
CNSTI4 0
RETI4
ADDRGP4 $64
JUMPV
LABELV $65
line 137
;136:
;137:	if (bs->inventory[INVENTORY_REDFLAG] > 0) return CTF_FLAG_RED;
ADDRFP4 0
INDIRP4
CNSTI4 5132
ADDP4
INDIRI4
CNSTI4 0
LEI4 $67
CNSTI4 1
RETI4
ADDRGP4 $64
JUMPV
LABELV $67
line 138
;138:	else if (bs->inventory[INVENTORY_BLUEFLAG] > 0) return CTF_FLAG_BLUE;
ADDRFP4 0
INDIRP4
CNSTI4 5136
ADDP4
INDIRI4
CNSTI4 0
LEI4 $69
CNSTI4 2
RETI4
ADDRGP4 $64
JUMPV
LABELV $69
line 139
;139:	return CTF_FLAG_NONE;
CNSTI4 0
RETI4
LABELV $64
endproc BotCTFCarryingFlag 0 0
export BotTeam
proc BotTeam 1044 12
line 147
;140:}
;141:
;142:/*
;143:==================
;144:BotTeam
;145:==================
;146:*/
;147:int BotTeam(bot_state_t *bs) {
line 150
;148:	char info[1024];
;149:
;150:	if (bs->client < 0 || bs->client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
LTI4 $74
ADDRLP4 1024
INDIRI4
CNSTI4 64
LTI4 $72
LABELV $74
line 152
;151:		//BotAI_Print(PRT_ERROR, "BotCTFTeam: client out of range\n");
;152:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $71
JUMPV
LABELV $72
line 154
;153:	}
;154:	trap_GetConfigstring(CS_PLAYERS+bs->client, info, sizeof(info));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 156
;155:	//
;156:	if (atoi(Info_ValueForKey(info, "t")) == TEAM_RED) return TEAM_RED;
ADDRLP4 0
ARGP4
ADDRGP4 $77
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $75
CNSTI4 1
RETI4
ADDRGP4 $71
JUMPV
LABELV $75
line 157
;157:	else if (atoi(Info_ValueForKey(info, "t")) == TEAM_BLUE) return TEAM_BLUE;
ADDRLP4 0
ARGP4
ADDRGP4 $77
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 2
NEI4 $78
CNSTI4 2
RETI4
ADDRGP4 $71
JUMPV
LABELV $78
line 158
;158:	return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $71
endproc BotTeam 1044 12
export BotOppositeTeam
proc BotOppositeTeam 12 4
line 166
;159:}
;160:
;161:/*
;162:==================
;163:BotOppositeTeam
;164:==================
;165:*/
;166:int BotOppositeTeam(bot_state_t *bs) {
line 167
;167:	switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $84
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $85
ADDRGP4 $81
JUMPV
LABELV $84
line 168
;168:		case TEAM_RED: return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $80
JUMPV
LABELV $85
line 169
;169:		case TEAM_BLUE: return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $80
JUMPV
LABELV $81
line 170
;170:		default: return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $80
endproc BotOppositeTeam 12 4
export BotEnemyFlag
proc BotEnemyFlag 4 4
line 179
;171:	}
;172:}
;173:
;174:/*
;175:==================
;176:BotEnemyFlag
;177:==================
;178:*/
;179:bot_goal_t *BotEnemyFlag(bot_state_t *bs) {
line 180
;180:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $87
line 181
;181:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
ADDRGP4 $86
JUMPV
LABELV $87
line 183
;182:	}
;183:	else {
line 184
;184:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
LABELV $86
endproc BotEnemyFlag 4 4
export BotTeamFlag
proc BotTeamFlag 4 4
line 193
;185:	}
;186:}
;187:
;188:/*
;189:==================
;190:BotTeamFlag
;191:==================
;192:*/
;193:bot_goal_t *BotTeamFlag(bot_state_t *bs) {
line 194
;194:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $90
line 195
;195:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
ADDRGP4 $89
JUMPV
LABELV $90
line 197
;196:	}
;197:	else {
line 198
;198:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
LABELV $89
endproc BotTeamFlag 4 4
export EntityIsDead
proc EntityIsDead 472 8
line 208
;199:	}
;200:}
;201:
;202:
;203:/*
;204:==================
;205:EntityIsDead
;206:==================
;207:*/
;208:qboolean EntityIsDead(aas_entityinfo_t *entinfo) {
line 211
;209:	playerState_t ps;
;210:
;211:	if (entinfo->number >= 0 && entinfo->number < MAX_CLIENTS) {
ADDRLP4 468
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 468
INDIRI4
CNSTI4 0
LTI4 $93
ADDRLP4 468
INDIRI4
CNSTI4 64
GEI4 $93
line 213
;212:		//retrieve the current client state
;213:		BotAI_GetClientState( entinfo->number, &ps );
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 214
;214:		if (ps.pm_type != PM_NORMAL) return qtrue;
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $95
CNSTI4 1
RETI4
ADDRGP4 $92
JUMPV
LABELV $95
line 215
;215:	}
LABELV $93
line 216
;216:	return qfalse;
CNSTI4 0
RETI4
LABELV $92
endproc EntityIsDead 472 8
export EntityCarriesFlag
proc EntityCarriesFlag 0 0
line 224
;217:}
;218:
;219:/*
;220:==================
;221:EntityCarriesFlag
;222:==================
;223:*/
;224:qboolean EntityCarriesFlag(aas_entityinfo_t *entinfo) {
line 225
;225:	if ( entinfo->powerups & ( 1 << PW_REDFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $99
line 226
;226:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $98
JUMPV
LABELV $99
line 227
;227:	if ( entinfo->powerups & ( 1 << PW_BLUEFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $101
line 228
;228:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $98
JUMPV
LABELV $101
line 233
;229:#ifdef MISSIONPACK
;230:	if ( entinfo->powerups & ( 1 << PW_NEUTRALFLAG ) )
;231:		return qtrue;
;232:#endif
;233:	return qfalse;
CNSTI4 0
RETI4
LABELV $98
endproc EntityCarriesFlag 0 0
export EntityIsInvisible
proc EntityIsInvisible 4 4
line 241
;234:}
;235:
;236:/*
;237:==================
;238:EntityIsInvisible
;239:==================
;240:*/
;241:qboolean EntityIsInvisible(aas_entityinfo_t *entinfo) {
line 243
;242:	// the flag is always visible
;243:	if (EntityCarriesFlag(entinfo)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $104
line 244
;244:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $103
JUMPV
LABELV $104
line 246
;245:	}
;246:	if (entinfo->powerups & (1 << PW_INVIS)) {
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $106
line 247
;247:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $103
JUMPV
LABELV $106
line 249
;248:	}
;249:	return qfalse;
CNSTI4 0
RETI4
LABELV $103
endproc EntityIsInvisible 4 4
export EntityIsShooting
proc EntityIsShooting 0 0
line 257
;250:}
;251:
;252:/*
;253:==================
;254:EntityIsShooting
;255:==================
;256:*/
;257:qboolean EntityIsShooting(aas_entityinfo_t *entinfo) {
line 258
;258:	if (entinfo->flags & EF_FIRING) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $109
line 259
;259:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $108
JUMPV
LABELV $109
line 261
;260:	}
;261:	return qfalse;
CNSTI4 0
RETI4
LABELV $108
endproc EntityIsShooting 0 0
export EntityIsChatting
proc EntityIsChatting 0 0
line 269
;262:}
;263:
;264:/*
;265:==================
;266:EntityIsChatting
;267:==================
;268:*/
;269:qboolean EntityIsChatting(aas_entityinfo_t *entinfo) {
line 270
;270:	if (entinfo->flags & EF_TALK) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $112
line 271
;271:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $111
JUMPV
LABELV $112
line 273
;272:	}
;273:	return qfalse;
CNSTI4 0
RETI4
LABELV $111
endproc EntityIsChatting 0 0
export EntityHasQuad
proc EntityHasQuad 0 0
line 281
;274:}
;275:
;276:/*
;277:==================
;278:EntityHasQuad
;279:==================
;280:*/
;281:qboolean EntityHasQuad(aas_entityinfo_t *entinfo) {
line 282
;282:	if (entinfo->powerups & (1 << PW_QUAD)) {
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $115
line 283
;283:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $114
JUMPV
LABELV $115
line 285
;284:	}
;285:	return qfalse;
CNSTI4 0
RETI4
LABELV $114
endproc EntityHasQuad 0 0
export BotRememberLastOrderedTask
proc BotRememberLastOrderedTask 16 12
line 349
;286:}
;287:
;288:#ifdef MISSIONPACK
;289:/*
;290:==================
;291:EntityHasKamikze
;292:==================
;293:*/
;294:qboolean EntityHasKamikaze(aas_entityinfo_t *entinfo) {
;295:	if (entinfo->flags & EF_KAMIKAZE) {
;296:		return qtrue;
;297:	}
;298:	return qfalse;
;299:}
;300:
;301:/*
;302:==================
;303:EntityCarriesCubes
;304:==================
;305:*/
;306:qboolean EntityCarriesCubes(aas_entityinfo_t *entinfo) {
;307:	entityState_t state;
;308:
;309:	if (gametype != GT_HARVESTER)
;310:		return qfalse;
;311:	//FIXME: get this info from the aas_entityinfo_t ?
;312:	BotAI_GetEntityState(entinfo->number, &state);
;313:	if (state.generic1 > 0)
;314:		return qtrue;
;315:	return qfalse;
;316:}
;317:
;318:/*
;319:==================
;320:Bot1FCTFCarryingFlag
;321:==================
;322:*/
;323:int Bot1FCTFCarryingFlag(bot_state_t *bs) {
;324:	if (gametype != GT_1FCTF) return qfalse;
;325:
;326:	if (bs->inventory[INVENTORY_NEUTRALFLAG] > 0) return qtrue;
;327:	return qfalse;
;328:}
;329:
;330:/*
;331:==================
;332:BotHarvesterCarryingCubes
;333:==================
;334:*/
;335:int BotHarvesterCarryingCubes(bot_state_t *bs) {
;336:	if (gametype != GT_HARVESTER) return qfalse;
;337:
;338:	if (bs->inventory[INVENTORY_REDCUBE] > 0) return qtrue;
;339:	if (bs->inventory[INVENTORY_BLUECUBE] > 0) return qtrue;
;340:	return qfalse;
;341:}
;342:#endif
;343:
;344:/*
;345:==================
;346:BotRememberLastOrderedTask
;347:==================
;348:*/
;349:void BotRememberLastOrderedTask(bot_state_t *bs) {
line 350
;350:	if (!bs->ordered) {
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $118
line 351
;351:		return;
ADDRGP4 $117
JUMPV
LABELV $118
line 353
;352:	}
;353:	bs->lastgoal_decisionmaker = bs->decisionmaker;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6756
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
ASGNI4
line 354
;354:	bs->lastgoal_ltgtype = bs->ltgtype;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6760
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
line 355
;355:	memcpy(&bs->lastgoal_teamgoal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6768
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 356
;356:	bs->lastgoal_teammate = bs->teammate;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6764
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ASGNI4
line 357
;357:}
LABELV $117
endproc BotRememberLastOrderedTask 16 12
export BotSetTeamStatus
proc BotSetTeamStatus 0 0
line 364
;358:
;359:/*
;360:==================
;361:BotSetTeamStatus
;362:==================
;363:*/
;364:void BotSetTeamStatus(bot_state_t *bs) {
line 421
;365:#ifdef MISSIONPACK
;366:	int teamtask;
;367:	aas_entityinfo_t entinfo;
;368:
;369:	teamtask = TEAMTASK_PATROL;
;370:
;371:	switch(bs->ltgtype) {
;372:		case LTG_TEAMHELP:
;373:			break;
;374:		case LTG_TEAMACCOMPANY:
;375:			BotEntityInfo(bs->teammate, &entinfo);
;376:			if ( ( (gametype == GT_CTF || gametype == GT_1FCTF) && EntityCarriesFlag(&entinfo))
;377:				|| ( gametype == GT_HARVESTER && EntityCarriesCubes(&entinfo)) ) {
;378:				teamtask = TEAMTASK_ESCORT;
;379:			}
;380:			else {
;381:				teamtask = TEAMTASK_FOLLOW;
;382:			}
;383:			break;
;384:		case LTG_DEFENDKEYAREA:
;385:			teamtask = TEAMTASK_DEFENSE;
;386:			break;
;387:		case LTG_GETFLAG:
;388:			teamtask = TEAMTASK_OFFENSE;
;389:			break;
;390:		case LTG_RUSHBASE:
;391:			teamtask = TEAMTASK_DEFENSE;
;392:			break;
;393:		case LTG_RETURNFLAG:
;394:			teamtask = TEAMTASK_RETRIEVE;
;395:			break;
;396:		case LTG_CAMP:
;397:		case LTG_CAMPORDER:
;398:			teamtask = TEAMTASK_CAMP;
;399:			break;
;400:		case LTG_PATROL:
;401:			teamtask = TEAMTASK_PATROL;
;402:			break;
;403:		case LTG_GETITEM:
;404:			teamtask = TEAMTASK_PATROL;
;405:			break;
;406:		case LTG_KILL:
;407:			teamtask = TEAMTASK_PATROL;
;408:			break;
;409:		case LTG_HARVEST:
;410:			teamtask = TEAMTASK_OFFENSE;
;411:			break;
;412:		case LTG_ATTACKENEMYBASE:
;413:			teamtask = TEAMTASK_OFFENSE;
;414:			break;
;415:		default:
;416:			teamtask = TEAMTASK_PATROL;
;417:			break;
;418:	}
;419:	BotSetUserInfo(bs, "teamtask", va("%d", teamtask));
;420:#endif
;421:}
LABELV $120
endproc BotSetTeamStatus 0 0
export BotSetLastOrderedTask
proc BotSetLastOrderedTask 60 16
line 428
;422:
;423:/*
;424:==================
;425:BotSetLastOrderedTask
;426:==================
;427:*/
;428:int BotSetLastOrderedTask(bot_state_t *bs) {
line 430
;429:
;430:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $122
line 432
;431:		// don't go back to returning the flag if it's at the base
;432:		if ( bs->lastgoal_ltgtype == LTG_RETURNFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 6
NEI4 $124
line 433
;433:			if ( BotTeam(bs) == TEAM_RED ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $126
line 434
;434:				if ( bs->redflagstatus == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
CNSTI4 0
NEI4 $127
line 435
;435:					bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
CNSTI4 0
ASGNI4
line 436
;436:				}
line 437
;437:			}
ADDRGP4 $127
JUMPV
LABELV $126
line 438
;438:			else {
line 439
;439:				if ( bs->blueflagstatus == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 0
NEI4 $130
line 440
;440:					bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
CNSTI4 0
ASGNI4
line 441
;441:				}
LABELV $130
line 442
;442:			}
LABELV $127
line 443
;443:		}
LABELV $124
line 444
;444:	}
LABELV $122
line 446
;445:
;446:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $132
line 447
;447:		bs->decisionmaker = bs->lastgoal_decisionmaker;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 6756
ADDP4
INDIRI4
ASGNI4
line 448
;448:		bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 449
;449:		bs->ltgtype = bs->lastgoal_ltgtype;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6600
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
ASGNI4
line 450
;450:		memcpy(&bs->teamgoal, &bs->lastgoal_teamgoal, sizeof(bot_goal_t));
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 6768
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 451
;451:		bs->teammate = bs->lastgoal_teammate;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 6764
ADDP4
INDIRI4
ASGNI4
line 452
;452:		bs->teamgoal_time = FloatTime() + 300;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1133903872
ADDF4
ASGNF4
line 453
;453:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 455
;454:		//
;455:		if ( gametype == GT_CTF ) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $134
line 456
;456:			if ( bs->ltgtype == LTG_GETFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $136
line 460
;457:				bot_goal_t *tb, *eb;
;458:				int tt, et;
;459:
;460:				tb = BotTeamFlag(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 BotTeamFlag
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 461
;461:				eb = BotEnemyFlag(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotEnemyFlag
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 36
INDIRP4
ASGNP4
line 462
;462:				tt = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, tb->areanum, TFL_DEFAULT);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 44
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 44
INDIRI4
ASGNI4
line 463
;463:				et = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, eb->areanum, TFL_DEFAULT);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 52
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 52
INDIRI4
ASGNI4
line 465
;464:				// if the travel time towards the enemy base is larger than towards our base
;465:				if (et > tt) {
ADDRLP4 28
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $138
line 467
;466:					//get an alternative route goal towards the enemy base
;467:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 468
;468:				}
LABELV $138
line 469
;469:			}
LABELV $136
line 470
;470:		}
LABELV $134
line 471
;471:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $121
JUMPV
LABELV $132
line 473
;472:	}
;473:	return qfalse;
CNSTI4 0
RETI4
LABELV $121
endproc BotSetLastOrderedTask 60 16
export BotRefuseOrder
proc BotRefuseOrder 8 12
line 481
;474:}
;475:
;476:/*
;477:==================
;478:BotRefuseOrder
;479:==================
;480:*/
;481:void BotRefuseOrder(bot_state_t *bs) {
line 482
;482:	if (!bs->ordered)
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $141
line 483
;483:		return;
ADDRGP4 $140
JUMPV
LABELV $141
line 485
;484:	// if the bot was ordered to do something
;485:	if ( bs->order_time && bs->order_time > FloatTime() - 10 ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $143
ADDRLP4 0
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
SUBF4
LEF4 $143
line 486
;486:		trap_EA_Action(bs->client, ACTION_NEGATIVE);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 2097152
ARGI4
ADDRGP4 trap_EA_Action
CALLV
pop
line 487
;487:		BotVoiceChat(bs, bs->decisionmaker, VOICECHAT_NO);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 488
;488:		bs->order_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTF4 0
ASGNF4
line 489
;489:	}
LABELV $143
line 490
;490:}
LABELV $140
endproc BotRefuseOrder 8 12
export BotCTFSeekGoals
proc BotCTFSeekGoals 240 12
line 497
;491:
;492:/*
;493:==================
;494:BotCTFSeekGoals
;495:==================
;496:*/
;497:void BotCTFSeekGoals(bot_state_t *bs) {
line 504
;498:	float rnd, l1, l2;
;499:	int flagstatus, c;
;500:	vec3_t dir;
;501:	aas_entityinfo_t entinfo;
;502:
;503:	//when carrying a flag in ctf the bot should rush to the base
;504:	if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $147
line 506
;505:		//if not already rushing to the base
;506:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $149
line 507
;507:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 508
;508:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 509
;509:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 510
;510:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 511
;511:			bs->decisionmaker = bs->client;
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 176
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 512
;512:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 514
;513:			//
;514:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 180
ADDRLP4 184
INDIRI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
EQI4 $154
ADDRLP4 180
INDIRI4
CNSTI4 2
EQI4 $159
ADDRGP4 $151
JUMPV
LABELV $154
line 515
;515:				case TEAM_RED: VectorSubtract(bs->origin, ctf_blueflag.origin, dir); break;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
ADDRLP4 192
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 192
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag+8
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $152
JUMPV
LABELV $159
line 516
;516:				case TEAM_BLUE: VectorSubtract(bs->origin, ctf_redflag.origin, dir); break;
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
ADDRLP4 196
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRGP4 ctf_redflag
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 196
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRGP4 ctf_redflag+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRGP4 ctf_redflag+8
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $152
JUMPV
LABELV $151
line 517
;517:				default: VectorSet(dir, 999, 999, 999); break;
ADDRLP4 200
CNSTF4 1148829696
ASGNF4
ADDRLP4 160
ADDRLP4 200
INDIRF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 200
INDIRF4
ASGNF4
ADDRLP4 160+8
CNSTF4 1148829696
ASGNF4
LABELV $152
line 520
;518:			}
;519:			// if the bot picked up the flag very close to the enemy base
;520:			if ( VectorLength(dir) < 128 ) {
ADDRLP4 160
ARGP4
ADDRLP4 192
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 192
INDIRF4
CNSTF4 1124073472
GEF4 $166
line 522
;521:				// get an alternative route goal through the enemy base
;522:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 523
;523:			} else {
ADDRGP4 $167
JUMPV
LABELV $166
line 525
;524:				// don't use any alt route goal, just get the hell out of the base
;525:				bs->altroutegoal.areanum = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6692
ADDP4
CNSTI4 0
ASGNI4
line 526
;526:			}
LABELV $167
line 527
;527:			BotSetUserInfo(bs, "teamtask", va("%d", TEAMTASK_OFFENSE));
ADDRGP4 $169
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 196
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $168
ARGP4
ADDRLP4 196
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
line 528
;528:			BotVoiceChat(bs, -1, VOICECHAT_IHAVEFLAG);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $170
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 529
;529:		}
ADDRGP4 $146
JUMPV
LABELV $149
line 530
;530:		else if (bs->rushbaseaway_time > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $146
line 531
;531:			if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 1
NEI4 $173
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $174
JUMPV
LABELV $173
line 532
;532:			else flagstatus = bs->blueflagstatus;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
ASGNI4
LABELV $174
line 534
;533:			//if the flag is back
;534:			if (flagstatus == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $146
line 535
;535:				bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 536
;536:			}
line 537
;537:		}
line 538
;538:		return;
ADDRGP4 $146
JUMPV
LABELV $147
line 541
;539:	}
;540:	// if the bot decided to follow someone
;541:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $177
ADDRLP4 176
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $177
line 543
;542:		// if the team mate being accompanied no longer carries the flag
;543:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 544
;544:		if (!EntityCarriesFlag(&entinfo)) {
ADDRLP4 16
ARGP4
ADDRLP4 180
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $179
line 545
;545:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 546
;546:		}
LABELV $179
line 547
;547:	}
LABELV $177
line 549
;548:	//
;549:	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
NEI4 $181
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 184
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 184
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $182
JUMPV
LABELV $181
line 550
;550:	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 188
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 188
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
ADDI4
ASGNI4
LABELV $182
line 552
;551:	//if our team has the enemy flag and our flag is at the base
;552:	if (flagstatus == 1) {
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $183
line 554
;553:		//
;554:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $146
line 556
;555:			//if Not defending the base already
;556:			if (!(bs->ltgtype == LTG_DEFENDKEYAREA &&
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
NEI4 $191
ADDRLP4 196
ADDRLP4 192
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ASGNI4
ADDRLP4 196
INDIRI4
ADDRGP4 ctf_redflag+44
INDIRI4
EQI4 $146
ADDRLP4 196
INDIRI4
ADDRGP4 ctf_blueflag+44
INDIRI4
EQI4 $146
LABELV $191
line 558
;557:					(bs->teamgoal.number == ctf_redflag.number ||
;558:					bs->teamgoal.number == ctf_blueflag.number))) {
line 560
;559:				//if there is a visible team mate flag carrier
;560:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 200
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 200
INDIRI4
ASGNI4
line 561
;561:				if (c >= 0 &&
ADDRLP4 204
ADDRLP4 156
INDIRI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
LTI4 $146
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 208
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $194
ADDRLP4 208
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ADDRLP4 204
INDIRI4
EQI4 $146
LABELV $194
line 563
;562:						// and not already following the team mate flag carrier
;563:						(bs->ltgtype != LTG_TEAMACCOMPANY || bs->teammate != c)) {
line 565
;564:					//
;565:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 567
;566:					//follow the flag carrier
;567:					bs->decisionmaker = bs->client;
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 212
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 212
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 568
;568:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 570
;569:					//the team mate
;570:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 572
;571:					//last time the team mate was visible
;572:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 574
;573:					//no message
;574:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 576
;575:					//no arrive message
;576:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 578
;577:					//
;578:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
ADDRLP4 216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRLP4 216
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 580
;579:					//get the team goal time
;580:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 581
;581:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 582
;582:					bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7012
ADDP4
CNSTF4 1121976320
ASGNF4
line 583
;583:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 584
;584:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 585
;585:				}
line 586
;586:			}
line 587
;587:		}
line 588
;588:		return;
ADDRGP4 $146
JUMPV
LABELV $183
line 591
;589:	}
;590:	//if the enemy has our flag
;591:	else if (flagstatus == 2) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $196
line 593
;592:		//
;593:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $146
line 595
;594:			//if enemy flag carrier is visible
;595:			c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 192
INDIRI4
ASGNI4
line 596
;596:			if (c >= 0) {
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $200
line 598
;597:				//FIXME: fight enemy flag carrier
;598:			}
LABELV $200
line 600
;599:			//if not already doing something important
;600:			if (bs->ltgtype != LTG_GETFLAG &&
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 4
EQI4 $146
ADDRLP4 196
INDIRI4
CNSTI4 6
EQI4 $146
ADDRLP4 196
INDIRI4
CNSTI4 1
EQI4 $146
ADDRLP4 196
INDIRI4
CNSTI4 2
EQI4 $146
ADDRLP4 196
INDIRI4
CNSTI4 8
EQI4 $146
ADDRLP4 196
INDIRI4
CNSTI4 9
EQI4 $146
ADDRLP4 196
INDIRI4
CNSTI4 10
EQI4 $146
line 606
;601:				bs->ltgtype != LTG_RETURNFLAG &&
;602:				bs->ltgtype != LTG_TEAMHELP &&
;603:				bs->ltgtype != LTG_TEAMACCOMPANY &&
;604:				bs->ltgtype != LTG_CAMPORDER &&
;605:				bs->ltgtype != LTG_PATROL &&
;606:				bs->ltgtype != LTG_GETITEM) {
line 608
;607:
;608:				BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 609
;609:				bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 610
;610:				bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 612
;611:				//
;612:				if (random() < 0.5) {
ADDRLP4 204
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
GEF4 $204
line 614
;613:					//go for the enemy flag
;614:					bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 4
ASGNI4
line 615
;615:				}
ADDRGP4 $205
JUMPV
LABELV $204
line 616
;616:				else {
line 617
;617:					bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 6
ASGNI4
line 618
;618:				}
LABELV $205
line 620
;619:				//no team message
;620:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 622
;621:				//set the time the bot will stop getting the flag
;622:				bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 624
;623:				//get an alternative route goal towards the enemy base
;624:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 626
;625:				//
;626:				BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 627
;627:				bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 628
;628:			}
line 629
;629:		}
line 630
;630:		return;
ADDRGP4 $146
JUMPV
LABELV $196
line 633
;631:	}
;632:	//if both flags Not at their bases
;633:	else if (flagstatus == 3) {
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $206
line 635
;634:		//
;635:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $146
line 637
;636:			// if not trying to return the flag and not following the team flag carrier
;637:			if ( bs->ltgtype != LTG_RETURNFLAG && bs->ltgtype != LTG_TEAMACCOMPANY ) {
ADDRLP4 192
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 6
EQI4 $146
ADDRLP4 192
INDIRI4
CNSTI4 2
EQI4 $146
line 639
;638:				//
;639:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 196
INDIRI4
ASGNI4
line 641
;640:				// if there is a visible team mate flag carrier
;641:				if (c >= 0) {
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $212
line 642
;642:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 644
;643:					//follow the flag carrier
;644:					bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 645
;645:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 647
;646:					//the team mate
;647:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 649
;648:					//last time the team mate was visible
;649:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 651
;650:					//no message
;651:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 653
;652:					//no arrive message
;653:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 655
;654:					//
;655:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 204
INDIRP4
ARGP4
ADDRLP4 204
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 657
;656:					//get the team goal time
;657:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 658
;658:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 659
;659:					bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7012
ADDP4
CNSTF4 1121976320
ASGNF4
line 661
;660:					//
;661:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 662
;662:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 663
;663:				}
ADDRGP4 $146
JUMPV
LABELV $212
line 664
;664:				else {
line 665
;665:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 666
;666:					bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 667
;667:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 669
;668:					//get the enemy flag
;669:					bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 204
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 204
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 671
;670:					//get the flag
;671:					bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 6
ASGNI4
line 673
;672:					//set the time the bot will stop getting the flag
;673:					bs->teamgoal_time = FloatTime() + CTF_RETURNFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 675
;674:					//get an alternative route goal towards the enemy base
;675:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 677
;676:					//
;677:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 678
;678:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 679
;679:				}
line 680
;680:			}
line 681
;681:		}
line 682
;682:		return;
ADDRGP4 $146
JUMPV
LABELV $206
line 685
;683:	}
;684:	// don't just do something wait for the bot team leader to give orders
;685:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $214
line 686
;686:		return;
ADDRGP4 $146
JUMPV
LABELV $214
line 689
;687:	}
;688:	// if the bot is ordered to do something
;689:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $216
line 690
;690:		bs->teamgoal_time += 60;
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 691
;691:	}
LABELV $216
line 693
;692:	// if the bot decided to do something on it's own and has a last ordered goal
;693:	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
CNSTI4 0
ASGNI4
ADDRLP4 196
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
ADDRLP4 200
INDIRI4
NEI4 $218
ADDRLP4 196
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
ADDRLP4 200
INDIRI4
EQI4 $218
line 694
;694:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 695
;695:	}
LABELV $218
line 697
;696:	//if already a CTF or team goal
;697:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 204
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 1
EQI4 $231
ADDRLP4 204
INDIRI4
CNSTI4 2
EQI4 $231
ADDRLP4 204
INDIRI4
CNSTI4 3
EQI4 $231
ADDRLP4 204
INDIRI4
CNSTI4 4
EQI4 $231
ADDRLP4 204
INDIRI4
CNSTI4 5
EQI4 $231
ADDRLP4 204
INDIRI4
CNSTI4 6
EQI4 $231
ADDRLP4 204
INDIRI4
CNSTI4 8
EQI4 $231
ADDRLP4 204
INDIRI4
CNSTI4 9
EQI4 $231
ADDRLP4 204
INDIRI4
CNSTI4 10
EQI4 $231
ADDRLP4 204
INDIRI4
CNSTI4 14
EQI4 $231
ADDRLP4 204
INDIRI4
CNSTI4 15
NEI4 $220
LABELV $231
line 707
;698:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;699:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;700:			bs->ltgtype == LTG_GETFLAG ||
;701:			bs->ltgtype == LTG_RUSHBASE ||
;702:			bs->ltgtype == LTG_RETURNFLAG ||
;703:			bs->ltgtype == LTG_CAMPORDER ||
;704:			bs->ltgtype == LTG_PATROL ||
;705:			bs->ltgtype == LTG_GETITEM ||
;706:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;707:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 708
;708:		return;
ADDRGP4 $146
JUMPV
LABELV $220
line 711
;709:	}
;710:	//
;711:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
EQI4 $232
line 712
;712:		return;
ADDRGP4 $146
JUMPV
LABELV $232
line 714
;713:	//
;714:	if (bs->owndecision_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
LEF4 $234
line 715
;715:		return;;
ADDRGP4 $146
JUMPV
LABELV $234
line 717
;716:	//if the bot is roaming
;717:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $236
line 718
;718:		return;
ADDRGP4 $146
JUMPV
LABELV $236
line 720
;719:	//if the bot has anough aggression to decide what to do
;720:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 212
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 212
INDIRF4
CNSTF4 1112014848
GEF4 $238
line 721
;721:		return;
ADDRGP4 $146
JUMPV
LABELV $238
line 723
;722:	//set the time to send a message to the team mates
;723:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 216
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 216
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 725
;724:	//
;725:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $240
line 726
;726:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $242
line 727
;727:			l1 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 728
;728:		}
ADDRGP4 $243
JUMPV
LABELV $242
line 729
;729:		else {
line 730
;730:			l1 = 0.2f;
ADDRLP4 8
CNSTF4 1045220557
ASGNF4
line 731
;731:		}
LABELV $243
line 732
;732:		l2 = 0.9f;
ADDRLP4 12
CNSTF4 1063675494
ASGNF4
line 733
;733:	}
ADDRGP4 $241
JUMPV
LABELV $240
line 734
;734:	else {
line 735
;735:		l1 = 0.4f;
ADDRLP4 8
CNSTF4 1053609165
ASGNF4
line 736
;736:		l2 = 0.7f;
ADDRLP4 12
CNSTF4 1060320051
ASGNF4
line 737
;737:	}
LABELV $241
line 739
;738:	//get the flag or defend the base
;739:	rnd = random();
ADDRLP4 220
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 220
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ASGNF4
line 740
;740:	if (rnd < l1 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $244
ADDRLP4 224
CNSTI4 0
ASGNI4
ADDRGP4 ctf_redflag+12
INDIRI4
ADDRLP4 224
INDIRI4
EQI4 $244
ADDRGP4 ctf_blueflag+12
INDIRI4
ADDRLP4 224
INDIRI4
EQI4 $244
line 741
;741:		bs->decisionmaker = bs->client;
ADDRLP4 228
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 228
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 228
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 742
;742:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 743
;743:		bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 4
ASGNI4
line 745
;744:		//set the time the bot will stop getting the flag
;745:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 747
;746:		//get an alternative route goal towards the enemy base
;747:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 232
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 232
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 748
;748:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 749
;749:	}
ADDRGP4 $245
JUMPV
LABELV $244
line 750
;750:	else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $248
ADDRLP4 228
CNSTI4 0
ASGNI4
ADDRGP4 ctf_redflag+12
INDIRI4
ADDRLP4 228
INDIRI4
EQI4 $248
ADDRGP4 ctf_blueflag+12
INDIRI4
ADDRLP4 228
INDIRI4
EQI4 $248
line 751
;751:		bs->decisionmaker = bs->client;
ADDRLP4 232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 232
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 232
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 752
;752:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 754
;753:		//
;754:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 236
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 1
NEI4 $252
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $253
JUMPV
LABELV $252
line 755
;755:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $253
line 757
;756:		//set the ltg type
;757:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 759
;758:		//set the time the bot stops defending the base
;759:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 760
;760:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 761
;761:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 762
;762:	}
ADDRGP4 $249
JUMPV
LABELV $248
line 763
;763:	else {
line 764
;764:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 766
;765:		//set the time the bot will stop roaming
;766:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 767
;767:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 768
;768:	}
LABELV $249
LABELV $245
line 769
;769:	bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 773
;770:#ifdef DEBUG
;771:	BotPrintTeamGoal(bs);
;772:#endif //DEBUG
;773:}
LABELV $146
endproc BotCTFSeekGoals 240 12
export BotCTFRetreatGoals
proc BotCTFRetreatGoals 8 4
line 780
;774:
;775:/*
;776:==================
;777:BotCTFRetreatGoals
;778:==================
;779:*/
;780:void BotCTFRetreatGoals(bot_state_t *bs) {
line 782
;781:	//when carrying a flag in ctf the bot should rush to the base
;782:	if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $255
line 784
;783:		//if not already rushing to the base
;784:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $257
line 785
;785:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 786
;786:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 787
;787:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 788
;788:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 789
;789:			bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 790
;790:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 791
;791:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 792
;792:		}
LABELV $257
line 793
;793:	}
LABELV $255
line 794
;794:}
LABELV $254
endproc BotCTFRetreatGoals 8 4
export BotTeamGoals
proc BotTeamGoals 0 4
line 1330
;795:
;796:#ifdef MISSIONPACK
;797:/*
;798:==================
;799:Bot1FCTFSeekGoals
;800:==================
;801:*/
;802:void Bot1FCTFSeekGoals(bot_state_t *bs) {
;803:	aas_entityinfo_t entinfo;
;804:	float rnd, l1, l2;
;805:	int c;
;806:
;807:	//when carrying a flag in ctf the bot should rush to the base
;808:	if (Bot1FCTFCarryingFlag(bs)) {
;809:		//if not already rushing to the base
;810:		if (bs->ltgtype != LTG_RUSHBASE) {
;811:			BotRefuseOrder(bs);
;812:			bs->ltgtype = LTG_RUSHBASE;
;813:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;814:			bs->rushbaseaway_time = 0;
;815:			bs->decisionmaker = bs->client;
;816:			bs->ordered = qfalse;
;817:			//get an alternative route goal towards the enemy base
;818:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;819:			//
;820:			BotSetTeamStatus(bs);
;821:			BotVoiceChat(bs, -1, VOICECHAT_IHAVEFLAG);
;822:		}
;823:		return;
;824:	}
;825:	// if the bot decided to follow someone
;826:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
;827:		// if the team mate being accompanied no longer carries the flag
;828:		BotEntityInfo(bs->teammate, &entinfo);
;829:		if (!EntityCarriesFlag(&entinfo)) {
;830:			bs->ltgtype = 0;
;831:		}
;832:	}
;833:	//our team has the flag
;834:	if (bs->neutralflagstatus == 1) {
;835:		if (bs->owndecision_time < FloatTime()) {
;836:			// if not already following someone
;837:			if (bs->ltgtype != LTG_TEAMACCOMPANY) {
;838:				//if there is a visible team mate flag carrier
;839:				c = BotTeamFlagCarrierVisible(bs);
;840:				if (c >= 0) {
;841:					BotRefuseOrder(bs);
;842:					//follow the flag carrier
;843:					bs->decisionmaker = bs->client;
;844:					bs->ordered = qfalse;
;845:					//the team mate
;846:					bs->teammate = c;
;847:					//last time the team mate was visible
;848:					bs->teammatevisible_time = FloatTime();
;849:					//no message
;850:					bs->teammessage_time = 0;
;851:					//no arrive message
;852:					bs->arrive_time = 1;
;853:					//
;854:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
;855:					//get the team goal time
;856:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
;857:					bs->ltgtype = LTG_TEAMACCOMPANY;
;858:					bs->formation_dist = 3.5 * 32;		//3.5 meter
;859:					BotSetTeamStatus(bs);
;860:					bs->owndecision_time = FloatTime() + 5;
;861:					return;
;862:				}
;863:			}
;864:			//if already a CTF or team goal
;865:			if (bs->ltgtype == LTG_TEAMHELP ||
;866:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;867:					bs->ltgtype == LTG_DEFENDKEYAREA ||
;868:					bs->ltgtype == LTG_GETFLAG ||
;869:					bs->ltgtype == LTG_RUSHBASE ||
;870:					bs->ltgtype == LTG_CAMPORDER ||
;871:					bs->ltgtype == LTG_PATROL ||
;872:					bs->ltgtype == LTG_ATTACKENEMYBASE ||
;873:					bs->ltgtype == LTG_GETITEM ||
;874:					bs->ltgtype == LTG_MAKELOVE_UNDER ||
;875:					bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;876:				return;
;877:			}
;878:			//if not already attacking the enemy base
;879:			if (bs->ltgtype != LTG_ATTACKENEMYBASE) {
;880:				BotRefuseOrder(bs);
;881:				bs->decisionmaker = bs->client;
;882:				bs->ordered = qfalse;
;883:				//
;884:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
;885:				else memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
;886:				//set the ltg type
;887:				bs->ltgtype = LTG_ATTACKENEMYBASE;
;888:				//set the time the bot will stop getting the flag
;889:				bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
;890:				BotSetTeamStatus(bs);
;891:				bs->owndecision_time = FloatTime() + 5;
;892:			}
;893:		}
;894:		return;
;895:	}
;896:	//enemy team has the flag
;897:	else if (bs->neutralflagstatus == 2) {
;898:		if (bs->owndecision_time < FloatTime()) {
;899:			c = BotEnemyFlagCarrierVisible(bs);
;900:			if (c >= 0) {
;901:				//FIXME: attack enemy flag carrier
;902:			}
;903:			//if already a CTF or team goal
;904:			if (bs->ltgtype == LTG_TEAMHELP ||
;905:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;906:					bs->ltgtype == LTG_CAMPORDER ||
;907:					bs->ltgtype == LTG_PATROL ||
;908:					bs->ltgtype == LTG_GETITEM) {
;909:				return;
;910:			}
;911:			// if not already defending the base
;912:			if (bs->ltgtype != LTG_DEFENDKEYAREA) {
;913:				BotRefuseOrder(bs);
;914:				bs->decisionmaker = bs->client;
;915:				bs->ordered = qfalse;
;916:				//
;917:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
;918:				else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
;919:				//set the ltg type
;920:				bs->ltgtype = LTG_DEFENDKEYAREA;
;921:				//set the time the bot stops defending the base
;922:				bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;923:				bs->defendaway_time = 0;
;924:				BotSetTeamStatus(bs);
;925:				bs->owndecision_time = FloatTime() + 5;
;926:			}
;927:		}
;928:		return;
;929:	}
;930:	// don't just do something wait for the bot team leader to give orders
;931:	if (BotTeamLeader(bs)) {
;932:		return;
;933:	}
;934:	// if the bot is ordered to do something
;935:	if ( bs->lastgoal_ltgtype ) {
;936:		bs->teamgoal_time += 60;
;937:	}
;938:	// if the bot decided to do something on it's own and has a last ordered goal
;939:	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
;940:		bs->ltgtype = 0;
;941:	}
;942:	//if already a CTF or team goal
;943:	if (bs->ltgtype == LTG_TEAMHELP ||
;944:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;945:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;946:			bs->ltgtype == LTG_GETFLAG ||
;947:			bs->ltgtype == LTG_RUSHBASE ||
;948:			bs->ltgtype == LTG_RETURNFLAG ||
;949:			bs->ltgtype == LTG_CAMPORDER ||
;950:			bs->ltgtype == LTG_PATROL ||
;951:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;952:			bs->ltgtype == LTG_GETITEM ||
;953:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;954:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;955:		return;
;956:	}
;957:	//
;958:	if (BotSetLastOrderedTask(bs))
;959:		return;
;960:	//
;961:	if (bs->owndecision_time > FloatTime())
;962:		return;;
;963:	//if the bot is roaming
;964:	if (bs->ctfroam_time > FloatTime())
;965:		return;
;966:	//if the bot has anough aggression to decide what to do
;967:	if (BotAggression(bs) < 50)
;968:		return;
;969:	//set the time to send a message to the team mates
;970:	bs->teammessage_time = FloatTime() + 2 * random();
;971:	//
;972:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
;973:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
;974:			l1 = 0.7f;
;975:		}
;976:		else {
;977:			l1 = 0.2f;
;978:		}
;979:		l2 = 0.9f;
;980:	}
;981:	else {
;982:		l1 = 0.4f;
;983:		l2 = 0.7f;
;984:	}
;985:	//get the flag or defend the base
;986:	rnd = random();
;987:	if (rnd < l1 && ctf_neutralflag.areanum) {
;988:		bs->decisionmaker = bs->client;
;989:		bs->ordered = qfalse;
;990:		bs->ltgtype = LTG_GETFLAG;
;991:		//set the time the bot will stop getting the flag
;992:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
;993:		BotSetTeamStatus(bs);
;994:	}
;995:	else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
;996:		bs->decisionmaker = bs->client;
;997:		bs->ordered = qfalse;
;998:		//
;999:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
;1000:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
;1001:		//set the ltg type
;1002:		bs->ltgtype = LTG_DEFENDKEYAREA;
;1003:		//set the time the bot stops defending the base
;1004:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;1005:		bs->defendaway_time = 0;
;1006:		BotSetTeamStatus(bs);
;1007:	}
;1008:	else {
;1009:		bs->ltgtype = 0;
;1010:		//set the time the bot will stop roaming
;1011:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
;1012:		BotSetTeamStatus(bs);
;1013:	}
;1014:	bs->owndecision_time = FloatTime() + 5;
;1015:#ifdef DEBUG
;1016:	BotPrintTeamGoal(bs);
;1017:#endif //DEBUG
;1018:}
;1019:
;1020:/*
;1021:==================
;1022:Bot1FCTFRetreatGoals
;1023:==================
;1024:*/
;1025:void Bot1FCTFRetreatGoals(bot_state_t *bs) {
;1026:	//when carrying a flag in ctf the bot should rush to the enemy base
;1027:	if (Bot1FCTFCarryingFlag(bs)) {
;1028:		//if not already rushing to the base
;1029:		if (bs->ltgtype != LTG_RUSHBASE) {
;1030:			BotRefuseOrder(bs);
;1031:			bs->ltgtype = LTG_RUSHBASE;
;1032:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;1033:			bs->rushbaseaway_time = 0;
;1034:			bs->decisionmaker = bs->client;
;1035:			bs->ordered = qfalse;
;1036:			//get an alternative route goal towards the enemy base
;1037:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;1038:			BotSetTeamStatus(bs);
;1039:		}
;1040:	}
;1041:}
;1042:
;1043:/*
;1044:==================
;1045:BotObeliskSeekGoals
;1046:==================
;1047:*/
;1048:void BotObeliskSeekGoals(bot_state_t *bs) {
;1049:	float rnd, l1, l2;
;1050:
;1051:	// don't just do something wait for the bot team leader to give orders
;1052:	if (BotTeamLeader(bs)) {
;1053:		return;
;1054:	}
;1055:	// if the bot is ordered to do something
;1056:	if ( bs->lastgoal_ltgtype ) {
;1057:		bs->teamgoal_time += 60;
;1058:	}
;1059:	//if already a team goal
;1060:	if (bs->ltgtype == LTG_TEAMHELP ||
;1061:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1062:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1063:			bs->ltgtype == LTG_GETFLAG ||
;1064:			bs->ltgtype == LTG_RUSHBASE ||
;1065:			bs->ltgtype == LTG_RETURNFLAG ||
;1066:			bs->ltgtype == LTG_CAMPORDER ||
;1067:			bs->ltgtype == LTG_PATROL ||
;1068:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1069:			bs->ltgtype == LTG_GETITEM ||
;1070:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1071:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;1072:		return;
;1073:	}
;1074:	//
;1075:	if (BotSetLastOrderedTask(bs))
;1076:		return;
;1077:	//if the bot is roaming
;1078:	if (bs->ctfroam_time > FloatTime())
;1079:		return;
;1080:	//if the bot has anough aggression to decide what to do
;1081:	if (BotAggression(bs) < 50)
;1082:		return;
;1083:	//set the time to send a message to the team mates
;1084:	bs->teammessage_time = FloatTime() + 2 * random();
;1085:	//
;1086:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
;1087:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
;1088:			l1 = 0.7f;
;1089:		}
;1090:		else {
;1091:			l1 = 0.2f;
;1092:		}
;1093:		l2 = 0.9f;
;1094:	}
;1095:	else {
;1096:		l1 = 0.4f;
;1097:		l2 = 0.7f;
;1098:	}
;1099:	//get the flag or defend the base
;1100:	rnd = random();
;1101:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
;1102:		bs->decisionmaker = bs->client;
;1103:		bs->ordered = qfalse;
;1104:		//
;1105:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1106:		else memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1107:		//set the ltg type
;1108:		bs->ltgtype = LTG_ATTACKENEMYBASE;
;1109:		//set the time the bot will stop attacking the enemy base
;1110:		bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
;1111:		//get an alternate route goal towards the enemy base
;1112:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;1113:		BotSetTeamStatus(bs);
;1114:	}
;1115:	else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
;1116:		bs->decisionmaker = bs->client;
;1117:		bs->ordered = qfalse;
;1118:		//
;1119:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1120:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1121:		//set the ltg type
;1122:		bs->ltgtype = LTG_DEFENDKEYAREA;
;1123:		//set the time the bot stops defending the base
;1124:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;1125:		bs->defendaway_time = 0;
;1126:		BotSetTeamStatus(bs);
;1127:	}
;1128:	else {
;1129:		bs->ltgtype = 0;
;1130:		//set the time the bot will stop roaming
;1131:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
;1132:		BotSetTeamStatus(bs);
;1133:	}
;1134:}
;1135:
;1136:/*
;1137:==================
;1138:BotGoHarvest
;1139:==================
;1140:*/
;1141:void BotGoHarvest(bot_state_t *bs) {
;1142:	//
;1143:	if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1144:	else memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1145:	//set the ltg type
;1146:	bs->ltgtype = LTG_HARVEST;
;1147:	//set the time the bot will stop harvesting
;1148:	bs->teamgoal_time = FloatTime() + TEAM_HARVEST_TIME;
;1149:	bs->harvestaway_time = 0;
;1150:	BotSetTeamStatus(bs);
;1151:}
;1152:
;1153:/*
;1154:==================
;1155:BotObeliskRetreatGoals
;1156:==================
;1157:*/
;1158:void BotObeliskRetreatGoals(bot_state_t *bs) {
;1159:	//nothing special
;1160:}
;1161:
;1162:/*
;1163:==================
;1164:BotHarvesterSeekGoals
;1165:==================
;1166:*/
;1167:void BotHarvesterSeekGoals(bot_state_t *bs) {
;1168:	aas_entityinfo_t entinfo;
;1169:	float rnd, l1, l2;
;1170:	int c;
;1171:
;1172:	//when carrying cubes in harvester the bot should rush to the base
;1173:	if (BotHarvesterCarryingCubes(bs)) {
;1174:		//if not already rushing to the base
;1175:		if (bs->ltgtype != LTG_RUSHBASE) {
;1176:			BotRefuseOrder(bs);
;1177:			bs->ltgtype = LTG_RUSHBASE;
;1178:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;1179:			bs->rushbaseaway_time = 0;
;1180:			bs->decisionmaker = bs->client;
;1181:			bs->ordered = qfalse;
;1182:			//get an alternative route goal towards the enemy base
;1183:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;1184:			//
;1185:			BotSetTeamStatus(bs);
;1186:		}
;1187:		return;
;1188:	}
;1189:	// don't just do something wait for the bot team leader to give orders
;1190:	if (BotTeamLeader(bs)) {
;1191:		return;
;1192:	}
;1193:	// if the bot decided to follow someone
;1194:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
;1195:		// if the team mate being accompanied no longer carries the flag
;1196:		BotEntityInfo(bs->teammate, &entinfo);
;1197:		if (!EntityCarriesCubes(&entinfo)) {
;1198:			bs->ltgtype = 0;
;1199:		}
;1200:	}
;1201:	// if the bot is ordered to do something
;1202:	if ( bs->lastgoal_ltgtype ) {
;1203:		bs->teamgoal_time += 60;
;1204:	}
;1205:	//if not yet doing something
;1206:	if (bs->ltgtype == LTG_TEAMHELP ||
;1207:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1208:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1209:			bs->ltgtype == LTG_GETFLAG ||
;1210:			bs->ltgtype == LTG_CAMPORDER ||
;1211:			bs->ltgtype == LTG_PATROL ||
;1212:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1213:			bs->ltgtype == LTG_HARVEST ||
;1214:			bs->ltgtype == LTG_GETITEM ||
;1215:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1216:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;1217:		return;
;1218:	}
;1219:	//
;1220:	if (BotSetLastOrderedTask(bs))
;1221:		return;
;1222:	//if the bot is roaming
;1223:	if (bs->ctfroam_time > FloatTime())
;1224:		return;
;1225:	//if the bot has anough aggression to decide what to do
;1226:	if (BotAggression(bs) < 50)
;1227:		return;
;1228:	//set the time to send a message to the team mates
;1229:	bs->teammessage_time = FloatTime() + 2 * random();
;1230:	//
;1231:	c = BotEnemyCubeCarrierVisible(bs);
;1232:	if (c >= 0) {
;1233:		//FIXME: attack enemy cube carrier
;1234:	}
;1235:	if (bs->ltgtype != LTG_TEAMACCOMPANY) {
;1236:		//if there is a visible team mate carrying cubes
;1237:		c = BotTeamCubeCarrierVisible(bs);
;1238:		if (c >= 0) {
;1239:			//follow the team mate carrying cubes
;1240:			bs->decisionmaker = bs->client;
;1241:			bs->ordered = qfalse;
;1242:			//the team mate
;1243:			bs->teammate = c;
;1244:			//last time the team mate was visible
;1245:			bs->teammatevisible_time = FloatTime();
;1246:			//no message
;1247:			bs->teammessage_time = 0;
;1248:			//no arrive message
;1249:			bs->arrive_time = 1;
;1250:			//
;1251:			BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
;1252:			//get the team goal time
;1253:			bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
;1254:			bs->ltgtype = LTG_TEAMACCOMPANY;
;1255:			bs->formation_dist = 3.5 * 32;		//3.5 meter
;1256:			BotSetTeamStatus(bs);
;1257:			return;
;1258:		}
;1259:	}
;1260:	//
;1261:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
;1262:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
;1263:			l1 = 0.7f;
;1264:		}
;1265:		else {
;1266:			l1 = 0.2f;
;1267:		}
;1268:		l2 = 0.9f;
;1269:	}
;1270:	else {
;1271:		l1 = 0.4f;
;1272:		l2 = 0.7f;
;1273:	}
;1274:	//
;1275:	rnd = random();
;1276:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
;1277:		bs->decisionmaker = bs->client;
;1278:		bs->ordered = qfalse;
;1279:		BotGoHarvest(bs);
;1280:	}
;1281:	else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
;1282:		bs->decisionmaker = bs->client;
;1283:		bs->ordered = qfalse;
;1284:		//
;1285:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1286:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1287:		//set the ltg type
;1288:		bs->ltgtype = LTG_DEFENDKEYAREA;
;1289:		//set the time the bot stops defending the base
;1290:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;1291:		bs->defendaway_time = 0;
;1292:		BotSetTeamStatus(bs);
;1293:	}
;1294:	else {
;1295:		bs->ltgtype = 0;
;1296:		//set the time the bot will stop roaming
;1297:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
;1298:		BotSetTeamStatus(bs);
;1299:	}
;1300:}
;1301:
;1302:/*
;1303:==================
;1304:BotHarvesterRetreatGoals
;1305:==================
;1306:*/
;1307:void BotHarvesterRetreatGoals(bot_state_t *bs) {
;1308:	//when carrying cubes in harvester the bot should rush to the base
;1309:	if (BotHarvesterCarryingCubes(bs)) {
;1310:		//if not already rushing to the base
;1311:		if (bs->ltgtype != LTG_RUSHBASE) {
;1312:			BotRefuseOrder(bs);
;1313:			bs->ltgtype = LTG_RUSHBASE;
;1314:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;1315:			bs->rushbaseaway_time = 0;
;1316:			bs->decisionmaker = bs->client;
;1317:			bs->ordered = qfalse;
;1318:			BotSetTeamStatus(bs);
;1319:		}
;1320:		return;
;1321:	}
;1322:}
;1323:#endif
;1324:
;1325:/*
;1326:==================
;1327:BotTeamGoals
;1328:==================
;1329:*/
;1330:void BotTeamGoals(bot_state_t *bs, int retreat) {
line 1332
;1331:
;1332:	if ( retreat ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $260
line 1333
;1333:		if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $261
line 1334
;1334:			BotCTFRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFRetreatGoals
CALLV
pop
line 1335
;1335:		}
line 1347
;1336:#ifdef MISSIONPACK
;1337:		else if (gametype == GT_1FCTF) {
;1338:			Bot1FCTFRetreatGoals(bs);
;1339:		}
;1340:		else if (gametype == GT_OBELISK) {
;1341:			BotObeliskRetreatGoals(bs);
;1342:		}
;1343:		else if (gametype == GT_HARVESTER) {
;1344:			BotHarvesterRetreatGoals(bs);
;1345:		}
;1346:#endif
;1347:	}
ADDRGP4 $261
JUMPV
LABELV $260
line 1348
;1348:	else {
line 1349
;1349:		if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $264
line 1351
;1350:			//decide what to do in CTF mode
;1351:			BotCTFSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFSeekGoals
CALLV
pop
line 1352
;1352:		}
LABELV $264
line 1364
;1353:#ifdef MISSIONPACK
;1354:		else if (gametype == GT_1FCTF) {
;1355:			Bot1FCTFSeekGoals(bs);
;1356:		}
;1357:		else if (gametype == GT_OBELISK) {
;1358:			BotObeliskSeekGoals(bs);
;1359:		}
;1360:		else if (gametype == GT_HARVESTER) {
;1361:			BotHarvesterSeekGoals(bs);
;1362:		}
;1363:#endif
;1364:	}
LABELV $261
line 1367
;1365:	// reset the order time which is used to see if
;1366:	// we decided to refuse an order
;1367:	bs->order_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTF4 0
ASGNF4
line 1368
;1368:}
LABELV $259
endproc BotTeamGoals 0 4
export BotPointAreaNum
proc BotPointAreaNum 136 20
line 1376
;1369:
;1370:/*
;1371:==================
;1372:BotPointAreaNum
;1373:==================
;1374:*/
;1375:int BotPointAreaNum(vec3_t origin) 
;1376:{
line 1379
;1377:	int areanum, numareas, areas[10];
;1378:	vec3_t end, mins, maxs;
;1379:	gentity_t *ent=NULL;
ADDRLP4 16
CNSTP4 0
ASGNP4
line 1382
;1380:
;1381:	// Ladder support (part 1) -Vincent
;1382:	if (ent && ent->client && ent->client->ps.pm_flags & PMF_LADDER)
ADDRLP4 92
CNSTU4 0
ASGNU4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 92
INDIRU4
EQU4 $267
ADDRLP4 96
ADDRLP4 16
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CVPU4 4
ADDRLP4 92
INDIRU4
EQU4 $267
ADDRLP4 96
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $267
line 1383
;1383:	{
line 1384
;1384:		areanum = trap_AAS_PointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 trap_AAS_PointAreaNum
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 100
INDIRI4
ASGNI4
line 1385
;1385:		if (areanum && !trap_AAS_AreaLadder(areanum)) 
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $269
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 trap_AAS_AreaLadder
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $269
line 1386
;1386:		{
line 1387
;1387:		areanum = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1388
;1388:		}
LABELV $269
line 1389
;1389:		if (areanum)
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $271
line 1390
;1390:		{
line 1391
;1391:		return areanum;
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $266
JUMPV
LABELV $271
line 1394
;1392:		}
;1393:
;1394:		maxs[0] = 8;
ADDRLP4 0
CNSTF4 1090519040
ASGNF4
line 1395
;1395:		maxs[1] = 8;
ADDRLP4 0+4
CNSTF4 1090519040
ASGNF4
line 1396
;1396:		maxs[2] = 4;
ADDRLP4 0+8
CNSTF4 1082130432
ASGNF4
line 1397
;1397:		VectorSubtract( origin, maxs, mins );
ADDRLP4 112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 112
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 112
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 1398
;1398:		VectorAdd( origin, maxs, maxs );
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 116
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 116
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 1399
;1399:		numareas = trap_AAS_BBoxAreas(mins, maxs, areas, 50);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 120
ADDRGP4 trap_AAS_BBoxAreas
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 120
INDIRI4
ASGNI4
line 1400
;1400:		if (numareas > 0) 
ADDRLP4 20
INDIRI4
CNSTI4 0
LEI4 $283
line 1401
;1401:		{
line 1402
;1402:		BotFirstLadder(areas, numareas);
ADDRLP4 36
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 BotFirstLadder
CALLI4
pop
line 1403
;1403:		}
LABELV $283
line 1405
;1404:
;1405:		areanum = trap_AAS_PointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 trap_AAS_PointAreaNum
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 124
INDIRI4
ASGNI4
line 1406
;1406:		if (areanum && !trap_AAS_AreaReachability(areanum)) 
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $285
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
NEI4 $285
line 1407
;1407:		{
line 1408
;1408:		areanum = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1409
;1409:		}
LABELV $285
line 1410
;1410:		if (areanum) 
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $287
line 1411
;1411:		{
line 1412
;1412:		return areanum;
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $266
JUMPV
LABELV $287
line 1414
;1413:		}
;1414:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $266
JUMPV
LABELV $267
line 1417
;1415:	}
;1416:	else
;1417:	{
line 1418
;1418:		areanum = trap_AAS_PointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 trap_AAS_PointAreaNum
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 100
INDIRI4
ASGNI4
line 1420
;1419:	
;1420:		if (areanum)
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $289
line 1421
;1421:		{
line 1422
;1422:		return areanum;
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $266
JUMPV
LABELV $289
line 1425
;1423:		}
;1424:	
;1425:		VectorCopy(origin, end);
ADDRLP4 76
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1426
;1426:		end[2] += 10;
ADDRLP4 76+8
ADDRLP4 76+8
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 1427
;1427:		numareas = trap_AAS_TraceAreas(origin, end, areas, NULL, 10);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 36
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 104
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 104
INDIRI4
ASGNI4
line 1429
;1428:
;1429:		if (numareas > 0)
ADDRLP4 20
INDIRI4
CNSTI4 0
LEI4 $292
line 1430
;1430:		{
line 1431
;1431:		return areas[0];
ADDRLP4 36
INDIRI4
RETI4
ADDRGP4 $266
JUMPV
LABELV $292
line 1433
;1432:		}
;1433:		return 0;
CNSTI4 0
RETI4
LABELV $266
endproc BotPointAreaNum 136 20
export ClientName
proc ClientName 1032 12
line 1442
;1434:	}
;1435:}
;1436:
;1437:/*
;1438:==================
;1439:ClientName
;1440:==================
;1441:*/
;1442:char *ClientName(int client, char *name, int size) {
line 1445
;1443:	char buf[MAX_INFO_STRING];
;1444:
;1445:	if (client < 0 || client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
LTI4 $297
ADDRLP4 1024
INDIRI4
CNSTI4 64
LTI4 $295
LABELV $297
line 1446
;1446:		BotAI_Print(PRT_ERROR, "ClientName: client out of range\n");
CNSTI4 3
ARGI4
ADDRGP4 $298
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1447
;1447:		return "[client out of range]";
ADDRGP4 $299
RETP4
ADDRGP4 $294
JUMPV
LABELV $295
line 1449
;1448:	}
;1449:	trap_GetConfigstring(CS_PLAYERS+client, buf, sizeof(buf));
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1450
;1450:	strncpy(name, Info_ValueForKey(buf, "n"), size-1);
ADDRLP4 0
ARGP4
ADDRGP4 $300
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1451
;1451:	name[size-1] = '\0';
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1452
;1452:	Q_CleanStr( name );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1453
;1453:	return name;
ADDRFP4 4
INDIRP4
RETP4
LABELV $294
endproc ClientName 1032 12
export ClientSkin
proc ClientSkin 1032 12
line 1461
;1454:}
;1455:
;1456:/*
;1457:==================
;1458:ClientSkin
;1459:==================
;1460:*/
;1461:char *ClientSkin(int client, char *skin, int size) {
line 1464
;1462:	char buf[MAX_INFO_STRING];
;1463:
;1464:	if (client < 0 || client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
LTI4 $304
ADDRLP4 1024
INDIRI4
CNSTI4 64
LTI4 $302
LABELV $304
line 1465
;1465:		BotAI_Print(PRT_ERROR, "ClientSkin: client out of range\n");
CNSTI4 3
ARGI4
ADDRGP4 $305
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1466
;1466:		return "[client out of range]";
ADDRGP4 $299
RETP4
ADDRGP4 $301
JUMPV
LABELV $302
line 1468
;1467:	}
;1468:	trap_GetConfigstring(CS_PLAYERS+client, buf, sizeof(buf));
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1469
;1469:	strncpy(skin, Info_ValueForKey(buf, "model"), size-1);
ADDRLP4 0
ARGP4
ADDRGP4 $306
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1470
;1470:	skin[size-1] = '\0';
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1471
;1471:	return skin;
ADDRFP4 4
INDIRP4
RETP4
LABELV $301
endproc ClientSkin 1032 12
bss
align 4
LABELV $308
skip 4
export ClientFromName
code
proc ClientFromName 1040 12
line 1479
;1472:}
;1473:
;1474:/*
;1475:==================
;1476:ClientFromName
;1477:==================
;1478:*/
;1479:int ClientFromName(char *name) {
line 1484
;1480:	int i;
;1481:	char buf[MAX_INFO_STRING];
;1482:	static int maxclients;
;1483:
;1484:	if (!maxclients)
ADDRGP4 $308
INDIRI4
CNSTI4 0
NEI4 $309
line 1485
;1485:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $311
ARGP4
ADDRLP4 1028
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $308
ADDRLP4 1028
INDIRI4
ASGNI4
LABELV $309
line 1486
;1486:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $315
JUMPV
LABELV $312
line 1487
;1487:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1488
;1488:		Q_CleanStr( buf );
ADDRLP4 4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1489
;1489:		if (!Q_stricmp(Info_ValueForKey(buf, "n"), name)) return i;
ADDRLP4 4
ARGP4
ADDRGP4 $300
ARGP4
ADDRLP4 1032
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $316
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $307
JUMPV
LABELV $316
line 1490
;1490:	}
LABELV $313
line 1486
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $315
ADDRLP4 0
INDIRI4
ADDRGP4 $308
INDIRI4
GEI4 $318
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $312
LABELV $318
line 1491
;1491:	return -1;
CNSTI4 -1
RETI4
LABELV $307
endproc ClientFromName 1040 12
bss
align 4
LABELV $320
skip 4
export ClientOnSameTeamFromName
code
proc ClientOnSameTeamFromName 1044 12
line 1499
;1492:}
;1493:
;1494:/*
;1495:==================
;1496:ClientOnSameTeamFromName
;1497:==================
;1498:*/
;1499:int ClientOnSameTeamFromName(bot_state_t *bs, char *name) {
line 1504
;1500:	int i;
;1501:	char buf[MAX_INFO_STRING];
;1502:	static int maxclients;
;1503:
;1504:	if (!maxclients)
ADDRGP4 $320
INDIRI4
CNSTI4 0
NEI4 $321
line 1505
;1505:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $311
ARGP4
ADDRLP4 1028
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $320
ADDRLP4 1028
INDIRI4
ASGNI4
LABELV $321
line 1506
;1506:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $326
JUMPV
LABELV $323
line 1507
;1507:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1032
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $327
line 1508
;1508:			continue;
ADDRGP4 $324
JUMPV
LABELV $327
line 1509
;1509:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1510
;1510:		Q_CleanStr( buf );
ADDRLP4 4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1511
;1511:		if (!Q_stricmp(Info_ValueForKey(buf, "n"), name)) return i;
ADDRLP4 4
ARGP4
ADDRGP4 $300
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $329
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $319
JUMPV
LABELV $329
line 1512
;1512:	}
LABELV $324
line 1506
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $326
ADDRLP4 0
INDIRI4
ADDRGP4 $320
INDIRI4
GEI4 $331
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $323
LABELV $331
line 1513
;1513:	return -1;
CNSTI4 -1
RETI4
LABELV $319
endproc ClientOnSameTeamFromName 1044 12
export stristr
proc stristr 12 4
line 1521
;1514:}
;1515:
;1516:/*
;1517:==================
;1518:stristr
;1519:==================
;1520:*/
;1521:char *stristr(char *str, char *charset) {
ADDRGP4 $334
JUMPV
LABELV $333
line 1524
;1522:	int i;
;1523:
;1524:	while(*str) {
line 1525
;1525:		for (i = 0; charset[i] && str[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $339
JUMPV
LABELV $336
line 1526
;1526:			if (toupper(charset[i]) != toupper(str[i])) break;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $340
ADDRGP4 $338
JUMPV
LABELV $340
line 1527
;1527:		}
LABELV $337
line 1525
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $339
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 8
INDIRI4
EQI4 $342
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 8
INDIRI4
NEI4 $336
LABELV $342
LABELV $338
line 1528
;1528:		if (!charset[i]) return str;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $343
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $332
JUMPV
LABELV $343
line 1529
;1529:		str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1530
;1530:	}
LABELV $334
line 1524
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $333
line 1531
;1531:	return NULL;
CNSTP4 0
RETP4
LABELV $332
endproc stristr 12 4
export EasyClientName
proc EasyClientName 208 12
line 1539
;1532:}
;1533:
;1534:/*
;1535:==================
;1536:EasyClientName
;1537:==================
;1538:*/
;1539:char *EasyClientName(int client, char *buf, int size) {
line 1544
;1540:	int i;
;1541:	char *str1, *str2, *ptr, c;
;1542:	char name[128];
;1543:
;1544:	strcpy(name, ClientName(client, name, sizeof(name)));
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 5
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 148
ADDRGP4 ClientName
CALLP4
ASGNP4
ADDRLP4 5
ARGP4
ADDRLP4 148
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1545
;1545:	for (i = 0; name[i]; i++) name[i] &= 127;
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRGP4 $349
JUMPV
LABELV $346
ADDRLP4 152
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVII1 4
ASGNI1
LABELV $347
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $349
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $346
line 1547
;1546:	//remove all spaces
;1547:	for (ptr = strstr(name, " "); ptr; ptr = strstr(name, " ")) 
ADDRLP4 5
ARGP4
ADDRGP4 $354
ARGP4
ADDRLP4 156
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
ADDRGP4 $353
JUMPV
LABELV $350
line 1548
;1548:	{
line 1549
;1549:		memmove(ptr, ptr+1, strlen(ptr+1)+1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 160
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 168
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
ARGP4
ADDRLP4 160
INDIRI4
ADDRLP4 168
INDIRI4
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1550
;1550:	}
LABELV $351
line 1547
ADDRLP4 5
ARGP4
ADDRGP4 $354
ARGP4
ADDRLP4 160
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 160
INDIRP4
ASGNP4
LABELV $353
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $350
line 1553
;1551:	
;1552:	//check for [x] and ]x[ clan names
;1553:	str1 = strstr(name, "[");
ADDRLP4 5
ARGP4
ADDRGP4 $355
ARGP4
ADDRLP4 164
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 140
ADDRLP4 164
INDIRP4
ASGNP4
line 1554
;1554:	str2 = strstr(name, "]");
ADDRLP4 5
ARGP4
ADDRGP4 $356
ARGP4
ADDRLP4 168
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 144
ADDRLP4 168
INDIRP4
ASGNP4
line 1555
;1555:	if (str1 && str2) {
ADDRLP4 172
CNSTU4 0
ASGNU4
ADDRLP4 140
INDIRP4
CVPU4 4
ADDRLP4 172
INDIRU4
EQU4 $357
ADDRLP4 144
INDIRP4
CVPU4 4
ADDRLP4 172
INDIRU4
EQU4 $357
line 1556
;1556:		if (str2 > str1) memmove(str1, str2+1, strlen(str2+1)+1);
ADDRLP4 144
INDIRP4
CVPU4 4
ADDRLP4 140
INDIRP4
CVPU4 4
LEU4 $359
ADDRLP4 144
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 176
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 180
CNSTI4 1
ASGNI4
ADDRLP4 144
INDIRP4
ADDRLP4 180
INDIRI4
ADDP4
ARGP4
ADDRLP4 176
INDIRI4
ADDRLP4 180
INDIRI4
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
ADDRGP4 $360
JUMPV
LABELV $359
line 1557
;1557:		else memmove(str2, str1+1, strlen(str1+1)+1);
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 184
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 188
CNSTI4 1
ASGNI4
ADDRLP4 140
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
ARGP4
ADDRLP4 184
INDIRI4
ADDRLP4 188
INDIRI4
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
LABELV $360
line 1558
;1558:	}
LABELV $357
line 1561
;1559:
;1560:	//remove Mr or Ms (not really frequently used but important too...) prefix -Vincent
;1561:	if ((name[0] == 'm' || name[0] == 'M') &&
ADDRLP4 176
ADDRLP4 5
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 109
EQI4 $367
ADDRLP4 176
INDIRI4
CNSTI4 77
NEI4 $361
LABELV $367
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 114
EQI4 $370
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 82
EQI4 $370
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 115
EQI4 $370
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 83
NEI4 $361
LABELV $370
line 1563
;1562:			(name[1] == 'r' || name[1] == 'R' || name[1] == 's' || name[1] == 'S')) 
;1563:	{
line 1564
;1564:		memmove(name, name+2, strlen(name+2)+1);
ADDRLP4 5+2
ARGP4
ADDRLP4 180
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 5
ARGP4
ADDRLP4 5+2
ARGP4
ADDRLP4 180
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1565
;1565:	}
LABELV $361
line 1568
;1566:
;1567:
;1568:	ptr = name;
ADDRLP4 0
ADDRLP4 5
ASGNP4
line 1570
;1569:	
;1570:	if (*ptr >= 'A' && *ptr <= 'Z')
ADDRLP4 180
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 65
LTI4 $376
ADDRLP4 180
INDIRI4
CNSTI4 90
GTI4 $376
line 1571
;1571:	{ //Leave first capital in name untouched, now done correctly -Vincent
line 1572
;1572:	ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1573
;1573:	}
ADDRGP4 $376
JUMPV
LABELV $375
line 1576
;1574:
;1575:	while(*ptr) 
;1576:	{
line 1577
;1577:		c = *ptr;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 1578
;1578:		if ((c >= 'a' && c <= 'z') ||
ADDRLP4 184
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 97
LTI4 $381
ADDRLP4 184
INDIRI4
CNSTI4 122
LEI4 $382
LABELV $381
ADDRLP4 188
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 48
LTI4 $383
ADDRLP4 188
INDIRI4
CNSTI4 57
LEI4 $382
LABELV $383
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 95
NEI4 $378
LABELV $382
line 1580
;1579:				(c >= '0' && c <= '9') || c == '_') 
;1580:		{
line 1581
;1581:		ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1582
;1582:		}
ADDRGP4 $379
JUMPV
LABELV $378
line 1583
;1583:		else if (c >= 'A' && c <= 'Z') 
ADDRLP4 192
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 65
LTI4 $384
ADDRLP4 192
INDIRI4
CNSTI4 90
GTI4 $384
line 1584
;1584:		{
line 1585
;1585:		*ptr += 'a' - 'A';
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
ADDI4
CVII1 4
ASGNI1
line 1586
;1586:		ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1587
;1587:		}
ADDRGP4 $385
JUMPV
LABELV $384
line 1589
;1588:		else 
;1589:		{
line 1590
;1590:		memmove(ptr, ptr+1, strlen(ptr + 1)+1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 196
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 204
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
ARGP4
ADDRLP4 196
INDIRI4
ADDRLP4 204
INDIRI4
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1591
;1591:		}
LABELV $385
LABELV $379
line 1592
;1592:	}
LABELV $376
line 1575
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $375
line 1593
;1593:	strncpy(buf, name, size-1);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 5
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1594
;1594:	buf[size-1] = '\0';
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1595
;1595:	return buf;
ADDRFP4 4
INDIRP4
RETP4
LABELV $345
endproc EasyClientName 208 12
export BotSynonymContext
proc BotSynonymContext 8 4
line 1603
;1596:}
;1597:
;1598:/*
;1599:==================
;1600:BotSynonymContext
;1601:==================
;1602:*/
;1603:int BotSynonymContext(bot_state_t *bs) {
line 1606
;1604:	int context;
;1605:
;1606:	context = CONTEXT_NORMAL|CONTEXT_NEARBYITEM|CONTEXT_NAMES;
ADDRLP4 0
CNSTI4 1027
ASGNI4
line 1608
;1607:	//
;1608:	if (gametype == GT_CTF
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $387
line 1612
;1609:#ifdef MISSIONPACK
;1610:		|| gametype == GT_1FCTF
;1611:#endif
;1612:		) {
line 1613
;1613:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_CTFREDTEAM;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $389
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 4
BORI4
ASGNI4
ADDRGP4 $390
JUMPV
LABELV $389
line 1614
;1614:		else context |= CONTEXT_CTFBLUETEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 8
BORI4
ASGNI4
LABELV $390
line 1615
;1615:	}
LABELV $387
line 1626
;1616:#ifdef MISSIONPACK
;1617:	else if (gametype == GT_OBELISK) {
;1618:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_OBELISKREDTEAM;
;1619:		else context |= CONTEXT_OBELISKBLUETEAM;
;1620:	}
;1621:	else if (gametype == GT_HARVESTER) {
;1622:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_HARVESTERREDTEAM;
;1623:		else context |= CONTEXT_HARVESTERBLUETEAM;
;1624:	}
;1625:#endif
;1626:	return context;
ADDRLP4 0
INDIRI4
RETI4
LABELV $386
endproc BotSynonymContext 8 4
export BotChooseWeapon
proc BotChooseWeapon 20 8
line 1634
;1627:}
;1628:
;1629:/*
;1630:==================
;1631:BotChooseWeapon
;1632:==================
;1633:*/
;1634:void BotChooseWeapon(bot_state_t *bs) {
line 1638
;1635:	int newweaponnum;
;1636:
;1637:	
;1638:		if (bs->cur_ps.weaponstate == WEAPON_RAISING ||
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $394
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $392
LABELV $394
line 1639
;1639:				bs->cur_ps.weaponstate == WEAPON_DROPPING) {
line 1640
;1640:			trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1641
;1641:		}
ADDRGP4 $393
JUMPV
LABELV $392
line 1642
;1642:		else {
line 1643
;1643:			newweaponnum = trap_BotChooseBestFightWeapon(bs->ws, bs->inventory);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 4952
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_BotChooseBestFightWeapon
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1647
;1644:			
;1645:			// Bad hack? Shafe
;1646:			//if ((newweaponnum == 1) && (bs->inventory[INVENTORY_BULLETS] > 50)) { newweaponnum = 2; }
;1647:			if (newweaponnum == 1)  { newweaponnum = 2; }
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $395
ADDRLP4 0
CNSTI4 2
ASGNI4
LABELV $395
line 1650
;1648:			///////////////////////////
;1649:
;1650:			if (bs->weaponnum != newweaponnum) bs->weaponchange_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $397
ADDRFP4 0
INDIRP4
CNSTI4 6192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $397
line 1651
;1651:			bs->weaponnum = newweaponnum;
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1654
;1652:
;1653:			//BotAI_Print(PRT_MESSAGE, "bs->weaponnum = %d\n", bs->weaponnum);
;1654:			trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1655
;1655:		}
LABELV $393
line 1657
;1656:
;1657:}
LABELV $391
endproc BotChooseWeapon 20 8
export BotSetupForMovement
proc BotSetupForMovement 88 12
line 1664
;1658:
;1659:/*
;1660:==================
;1661:BotSetupForMovement
;1662:==================
;1663:*/
;1664:void BotSetupForMovement(bot_state_t *bs) {
line 1667
;1665:	bot_initmove_t initmove;
;1666:
;1667:	memset(&initmove, 0, sizeof(bot_initmove_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 68
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1668
;1668:	VectorCopy(bs->cur_ps.origin, initmove.origin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1669
;1669:	VectorCopy(bs->cur_ps.velocity, initmove.velocity);
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRB
ASGNB 12
line 1670
;1670:	VectorClear(initmove.viewoffset);
ADDRLP4 68
CNSTF4 0
ASGNF4
ADDRLP4 0+24+8
ADDRLP4 68
INDIRF4
ASGNF4
ADDRLP4 0+24+4
ADDRLP4 68
INDIRF4
ASGNF4
ADDRLP4 0+24
ADDRLP4 68
INDIRF4
ASGNF4
line 1671
;1671:	initmove.viewoffset[2] += bs->cur_ps.viewheight;
ADDRLP4 0+24+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1672
;1672:	initmove.entitynum = bs->entitynum;
ADDRLP4 0+36
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1673
;1673:	initmove.client = bs->client;
ADDRLP4 0+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1674
;1674:	initmove.thinktime = bs->thinktime;
ADDRLP4 0+44
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
INDIRF4
ASGNF4
line 1676
;1675:	//set the onground flag
;1676:	if (bs->cur_ps.groundEntityNum != ENTITYNUM_NONE) initmove.or_moveflags |= MFL_ONGROUND;
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $411
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 2
BORI4
ASGNI4
LABELV $411
line 1678
;1677:	//set the teleported flag
;1678:	if ((bs->cur_ps.pm_flags & PMF_TIME_KNOCKBACK) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 76
INDIRI4
EQI4 $414
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 76
INDIRI4
LEI4 $414
line 1679
;1679:		initmove.or_moveflags |= MFL_TELEPORTED;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1680
;1680:	}
LABELV $414
line 1682
;1681:	//set the waterjump flag
;1682:	if ((bs->cur_ps.pm_flags & PMF_TIME_WATERJUMP) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 256
BANDI4
ADDRLP4 84
INDIRI4
EQI4 $417
ADDRLP4 80
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
LEI4 $417
line 1683
;1683:		initmove.or_moveflags |= MFL_WATERJUMP;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 1684
;1684:	}
LABELV $417
line 1686
;1685:	//set presence type
;1686:	if (bs->cur_ps.pm_flags & PMF_DUCKED) initmove.presencetype = PRESENCE_CROUCH;
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $420
ADDRLP4 0+48
CNSTI4 4
ASGNI4
ADDRGP4 $421
JUMPV
LABELV $420
line 1687
;1687:	else initmove.presencetype = PRESENCE_NORMAL;
ADDRLP4 0+48
CNSTI4 2
ASGNI4
LABELV $421
line 1689
;1688:	//
;1689:	if (bs->walker > 0.5) initmove.or_moveflags |= MFL_WALK;
ADDRFP4 0
INDIRP4
CNSTI4 6056
ADDP4
INDIRF4
CNSTF4 1056964608
LEF4 $424
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 512
BORI4
ASGNI4
LABELV $424
line 1691
;1690:	//
;1691:	VectorCopy(bs->viewangles, initmove.viewangles);
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
INDIRB
ASGNB 12
line 1693
;1692:	//
;1693:	trap_BotInitMoveState(bs->ms, &initmove);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotInitMoveState
CALLV
pop
line 1694
;1694:}
LABELV $399
endproc BotSetupForMovement 88 12
export BotCheckItemPickup
proc BotCheckItemPickup 0 0
line 1701
;1695:
;1696:/*
;1697:==================
;1698:BotCheckItemPickup
;1699:==================
;1700:*/
;1701:void BotCheckItemPickup(bot_state_t *bs, int *oldinventory) {
line 1788
;1702:#ifdef MISSIONPACK
;1703:	int offence, leader;
;1704:
;1705:	if (gametype <= GT_TEAM)
;1706:		return;
;1707:
;1708:	offence = -1;
;1709:	// go into offence if picked up the kamikaze or invulnerability
;1710:	if (!oldinventory[INVENTORY_KAMIKAZE] && bs->inventory[INVENTORY_KAMIKAZE] >= 1) {
;1711:		offence = qtrue;
;1712:	}
;1713:	if (!oldinventory[INVENTORY_INVULNERABILITY] && bs->inventory[INVENTORY_INVULNERABILITY] >= 1) {
;1714:		offence = qtrue;
;1715:	}
;1716:	// if not already wearing the kamikaze or invulnerability
;1717:	if (!bs->inventory[INVENTORY_KAMIKAZE] && !bs->inventory[INVENTORY_INVULNERABILITY]) {
;1718:		if (!oldinventory[INVENTORY_SCOUT] && bs->inventory[INVENTORY_SCOUT] >= 1) {
;1719:			offence = qtrue;
;1720:		}
;1721:		if (!oldinventory[INVENTORY_GUARD] && bs->inventory[INVENTORY_GUARD] >= 1) {
;1722:			offence = qtrue;
;1723:		}
;1724:		if (!oldinventory[INVENTORY_DOUBLER] && bs->inventory[INVENTORY_DOUBLER] >= 1) {
;1725:			offence = qfalse;
;1726:		}
;1727:		if (!oldinventory[INVENTORY_AMMOREGEN] && bs->inventory[INVENTORY_AMMOREGEN] >= 1) {
;1728:			offence = qfalse;
;1729:		}
;1730:	}
;1731:
;1732:	if (offence >= 0) {
;1733:		leader = ClientFromName(bs->teamleader);
;1734:		if (offence) {
;1735:			if (!(bs->teamtaskpreference & TEAMTP_ATTACKER)) {
;1736:				// if we have a bot team leader
;1737:				if (BotTeamLeader(bs)) {
;1738:					// tell the leader we want to be on offence
;1739:					BotVoiceChat(bs, leader, VOICECHAT_WANTONOFFENSE);
;1740:					//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;1741:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1742:				}
;1743:				else if (g_spSkill.integer <= 3) {
;1744:					if ( bs->ltgtype != LTG_GETFLAG &&
;1745:						 bs->ltgtype != LTG_ATTACKENEMYBASE &&
;1746:						 bs->ltgtype != LTG_HARVEST ) {
;1747:						//
;1748:						if ((gametype != GT_CTF || (bs->redflagstatus == 0 && bs->blueflagstatus == 0)) &&
;1749:							(gametype != GT_1FCTF || bs->neutralflagstatus == 0) ) {
;1750:							// tell the leader we want to be on offence
;1751:							BotVoiceChat(bs, leader, VOICECHAT_WANTONOFFENSE);
;1752:							//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;1753:							//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1754:						}
;1755:					}
;1756:					bs->teamtaskpreference |= TEAMTP_ATTACKER;
;1757:				}
;1758:			}
;1759:			bs->teamtaskpreference &= ~TEAMTP_DEFENDER;
;1760:		}
;1761:		else {
;1762:			if (!(bs->teamtaskpreference & TEAMTP_DEFENDER)) {
;1763:				// if we have a bot team leader
;1764:				if (BotTeamLeader(bs)) {
;1765:					// tell the leader we want to be on defense
;1766:					BotVoiceChat(bs, -1, VOICECHAT_WANTONDEFENSE);
;1767:					//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;1768:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1769:				}
;1770:				else if (g_spSkill.integer <= 3) {
;1771:					if ( bs->ltgtype != LTG_DEFENDKEYAREA ) {
;1772:						//
;1773:						if ((gametype != GT_CTF || (bs->redflagstatus == 0 && bs->blueflagstatus == 0)) &&
;1774:							(gametype != GT_1FCTF || bs->neutralflagstatus == 0) ) {
;1775:							// tell the leader we want to be on defense
;1776:							BotVoiceChat(bs, -1, VOICECHAT_WANTONDEFENSE);
;1777:							//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;1778:							//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1779:						}
;1780:					}
;1781:				}
;1782:				bs->teamtaskpreference |= TEAMTP_DEFENDER;
;1783:			}
;1784:			bs->teamtaskpreference &= ~TEAMTP_ATTACKER;
;1785:		}
;1786:	}
;1787:#endif
;1788:}
LABELV $428
endproc BotCheckItemPickup 0 0
export BotUpdateInventory
proc BotUpdateInventory 1224 12
line 1795
;1789:
;1790:/*
;1791:==================
;1792:BotUpdateInventory
;1793:==================
;1794:*/
;1795:void BotUpdateInventory(bot_state_t *bs) {
line 1798
;1796:	int oldinventory[MAX_ITEMS];
;1797:
;1798:	memcpy(oldinventory, bs->inventory, sizeof(oldinventory));
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4952
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1800
;1799:	//armor
;1800:	bs->inventory[INVENTORY_ARMOR] = bs->cur_ps.stats[STAT_ARMOR];
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 4956
ADDP4
ADDRLP4 1024
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 1802
;1801:	//weapons
;1802:	bs->inventory[INVENTORY_GAUNTLET] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GAUNTLET)) != 0;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $431
ADDRLP4 1028
CNSTI4 1
ASGNI4
ADDRGP4 $432
JUMPV
LABELV $431
ADDRLP4 1028
CNSTI4 0
ASGNI4
LABELV $432
ADDRLP4 1032
INDIRP4
CNSTI4 4968
ADDP4
ADDRLP4 1028
INDIRI4
ASGNI4
line 1803
;1803:	bs->inventory[INVENTORY_SHOTGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_SHOTGUN)) != 0;
ADDRLP4 1040
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $434
ADDRLP4 1036
CNSTI4 1
ASGNI4
ADDRGP4 $435
JUMPV
LABELV $434
ADDRLP4 1036
CNSTI4 0
ASGNI4
LABELV $435
ADDRLP4 1040
INDIRP4
CNSTI4 4972
ADDP4
ADDRLP4 1036
INDIRI4
ASGNI4
line 1804
;1804:	bs->inventory[INVENTORY_MACHINEGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_MACHINEGUN)) != 0;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $437
ADDRLP4 1044
CNSTI4 1
ASGNI4
ADDRGP4 $438
JUMPV
LABELV $437
ADDRLP4 1044
CNSTI4 0
ASGNI4
LABELV $438
ADDRLP4 1048
INDIRP4
CNSTI4 4976
ADDP4
ADDRLP4 1044
INDIRI4
ASGNI4
line 1805
;1805:	bs->inventory[INVENTORY_GRENADELAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRENADE_LAUNCHER)) != 0;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $440
ADDRLP4 1052
CNSTI4 1
ASGNI4
ADDRGP4 $441
JUMPV
LABELV $440
ADDRLP4 1052
CNSTI4 0
ASGNI4
LABELV $441
ADDRLP4 1056
INDIRP4
CNSTI4 4980
ADDP4
ADDRLP4 1052
INDIRI4
ASGNI4
line 1806
;1806:	bs->inventory[INVENTORY_ROCKETLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_ROCKET_LAUNCHER)) != 0;
ADDRLP4 1064
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1064
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $443
ADDRLP4 1060
CNSTI4 1
ASGNI4
ADDRGP4 $444
JUMPV
LABELV $443
ADDRLP4 1060
CNSTI4 0
ASGNI4
LABELV $444
ADDRLP4 1064
INDIRP4
CNSTI4 4984
ADDP4
ADDRLP4 1060
INDIRI4
ASGNI4
line 1807
;1807:	bs->inventory[INVENTORY_LIGHTNING] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_LIGHTNING)) != 0;
ADDRLP4 1072
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $446
ADDRLP4 1068
CNSTI4 1
ASGNI4
ADDRGP4 $447
JUMPV
LABELV $446
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $447
ADDRLP4 1072
INDIRP4
CNSTI4 4988
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 1808
;1808:	bs->inventory[INVENTORY_RAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_RAILGUN)) != 0;
ADDRLP4 1080
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1080
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $449
ADDRLP4 1076
CNSTI4 1
ASGNI4
ADDRGP4 $450
JUMPV
LABELV $449
ADDRLP4 1076
CNSTI4 0
ASGNI4
LABELV $450
ADDRLP4 1080
INDIRP4
CNSTI4 4992
ADDP4
ADDRLP4 1076
INDIRI4
ASGNI4
line 1809
;1809:	bs->inventory[INVENTORY_PLASMAGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PLASMAGUN)) != 0;
ADDRLP4 1088
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1088
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $452
ADDRLP4 1084
CNSTI4 1
ASGNI4
ADDRGP4 $453
JUMPV
LABELV $452
ADDRLP4 1084
CNSTI4 0
ASGNI4
LABELV $453
ADDRLP4 1088
INDIRP4
CNSTI4 4996
ADDP4
ADDRLP4 1084
INDIRI4
ASGNI4
line 1810
;1810:	bs->inventory[INVENTORY_BFG10K] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_BFG)) != 0;
ADDRLP4 1096
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1096
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $455
ADDRLP4 1092
CNSTI4 1
ASGNI4
ADDRGP4 $456
JUMPV
LABELV $455
ADDRLP4 1092
CNSTI4 0
ASGNI4
LABELV $456
ADDRLP4 1096
INDIRP4
CNSTI4 5004
ADDP4
ADDRLP4 1092
INDIRI4
ASGNI4
line 1811
;1811:	bs->inventory[INVENTORY_GRAPPLINGHOOK] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRAPPLING_HOOK)) != 0;
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $458
ADDRLP4 1100
CNSTI4 1
ASGNI4
ADDRGP4 $459
JUMPV
LABELV $458
ADDRLP4 1100
CNSTI4 0
ASGNI4
LABELV $459
ADDRLP4 1104
INDIRP4
CNSTI4 5008
ADDP4
ADDRLP4 1100
INDIRI4
ASGNI4
line 1818
;1812:#ifdef MISSIONPACK
;1813:	bs->inventory[INVENTORY_NAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_NAILGUN)) != 0;;
;1814:	bs->inventory[INVENTORY_PROXLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PROX_LAUNCHER)) != 0;;
;1815:	bs->inventory[INVENTORY_CHAINGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_CHAINGUN)) != 0;;
;1816:#endif
;1817:	//ammo
;1818:	bs->inventory[INVENTORY_SHELLS] = bs->cur_ps.ammo[WP_SHOTGUN];
ADDRLP4 1108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1108
INDIRP4
CNSTI4 5024
ADDP4
ADDRLP4 1108
INDIRP4
CNSTI4 404
ADDP4
INDIRI4
ASGNI4
line 1819
;1819:	bs->inventory[INVENTORY_BULLETS] = bs->cur_ps.ammo[WP_MACHINEGUN];
ADDRLP4 1112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1112
INDIRP4
CNSTI4 5028
ADDP4
ADDRLP4 1112
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ASGNI4
line 1820
;1820:	bs->inventory[INVENTORY_GRENADES] = bs->cur_ps.ammo[WP_GRENADE_LAUNCHER];
ADDRLP4 1116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1116
INDIRP4
CNSTI4 5032
ADDP4
ADDRLP4 1116
INDIRP4
CNSTI4 408
ADDP4
INDIRI4
ASGNI4
line 1821
;1821:	bs->inventory[INVENTORY_CELLS] = bs->cur_ps.ammo[WP_PLASMAGUN];
ADDRLP4 1120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1120
INDIRP4
CNSTI4 5036
ADDP4
ADDRLP4 1120
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 1822
;1822:	bs->inventory[INVENTORY_LIGHTNINGAMMO] = bs->cur_ps.ammo[WP_LIGHTNING];
ADDRLP4 1124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1124
INDIRP4
CNSTI4 5040
ADDP4
ADDRLP4 1124
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 1823
;1823:	bs->inventory[INVENTORY_ROCKETS] = bs->cur_ps.ammo[WP_ROCKET_LAUNCHER];
ADDRLP4 1128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1128
INDIRP4
CNSTI4 5044
ADDP4
ADDRLP4 1128
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ASGNI4
line 1824
;1824:	bs->inventory[INVENTORY_SLUGS] = bs->cur_ps.ammo[WP_RAILGUN];
ADDRLP4 1132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1132
INDIRP4
CNSTI4 5048
ADDP4
ADDRLP4 1132
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ASGNI4
line 1825
;1825:	bs->inventory[INVENTORY_BFGAMMO] = bs->cur_ps.ammo[WP_BFG];
ADDRLP4 1136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1136
INDIRP4
CNSTI4 5052
ADDP4
ADDRLP4 1136
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ASGNI4
line 1832
;1826:#ifdef MISSIONPACK
;1827:	bs->inventory[INVENTORY_NAILS] = bs->cur_ps.ammo[WP_NAILGUN];
;1828:	bs->inventory[INVENTORY_MINES] = bs->cur_ps.ammo[WP_PROX_LAUNCHER];
;1829:	bs->inventory[INVENTORY_BELT] = bs->cur_ps.ammo[WP_CHAINGUN];
;1830:#endif
;1831:	//powerups
;1832:	bs->inventory[INVENTORY_HEALTH] = bs->cur_ps.stats[STAT_HEALTH];
ADDRLP4 1140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140
INDIRP4
CNSTI4 5068
ADDP4
ADDRLP4 1140
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 1833
;1833:	bs->inventory[INVENTORY_TELEPORTER] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_TELEPORTER;
ADDRLP4 1148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1148
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 26
NEI4 $461
ADDRLP4 1144
CNSTI4 1
ASGNI4
ADDRGP4 $462
JUMPV
LABELV $461
ADDRLP4 1144
CNSTI4 0
ASGNI4
LABELV $462
ADDRLP4 1148
INDIRP4
CNSTI4 5072
ADDP4
ADDRLP4 1144
INDIRI4
ASGNI4
line 1834
;1834:	bs->inventory[INVENTORY_MEDKIT] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_MEDKIT;
ADDRLP4 1156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1156
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 27
NEI4 $464
ADDRLP4 1152
CNSTI4 1
ASGNI4
ADDRGP4 $465
JUMPV
LABELV $464
ADDRLP4 1152
CNSTI4 0
ASGNI4
LABELV $465
ADDRLP4 1156
INDIRP4
CNSTI4 5076
ADDP4
ADDRLP4 1152
INDIRI4
ASGNI4
line 1840
;1835:#ifdef MISSIONPACK
;1836:	bs->inventory[INVENTORY_KAMIKAZE] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_KAMIKAZE;
;1837:	bs->inventory[INVENTORY_PORTAL] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_PORTAL;
;1838:	bs->inventory[INVENTORY_INVULNERABILITY] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_INVULNERABILITY;
;1839:#endif
;1840:	bs->inventory[INVENTORY_QUAD] = bs->cur_ps.powerups[PW_QUAD] != 0;
ADDRLP4 1164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1164
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $467
ADDRLP4 1160
CNSTI4 1
ASGNI4
ADDRGP4 $468
JUMPV
LABELV $467
ADDRLP4 1160
CNSTI4 0
ASGNI4
LABELV $468
ADDRLP4 1164
INDIRP4
CNSTI4 5092
ADDP4
ADDRLP4 1160
INDIRI4
ASGNI4
line 1841
;1841:	bs->inventory[INVENTORY_ENVIRONMENTSUIT] = bs->cur_ps.powerups[PW_BATTLESUIT] != 0;
ADDRLP4 1172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1172
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $470
ADDRLP4 1168
CNSTI4 1
ASGNI4
ADDRGP4 $471
JUMPV
LABELV $470
ADDRLP4 1168
CNSTI4 0
ASGNI4
LABELV $471
ADDRLP4 1172
INDIRP4
CNSTI4 5096
ADDP4
ADDRLP4 1168
INDIRI4
ASGNI4
line 1842
;1842:	bs->inventory[INVENTORY_HASTE] = bs->cur_ps.powerups[PW_HASTE] != 0;
ADDRLP4 1180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1180
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $473
ADDRLP4 1176
CNSTI4 1
ASGNI4
ADDRGP4 $474
JUMPV
LABELV $473
ADDRLP4 1176
CNSTI4 0
ASGNI4
LABELV $474
ADDRLP4 1180
INDIRP4
CNSTI4 5100
ADDP4
ADDRLP4 1176
INDIRI4
ASGNI4
line 1843
;1843:	bs->inventory[INVENTORY_INVISIBILITY] = bs->cur_ps.powerups[PW_INVIS] != 0;
ADDRLP4 1188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1188
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $476
ADDRLP4 1184
CNSTI4 1
ASGNI4
ADDRGP4 $477
JUMPV
LABELV $476
ADDRLP4 1184
CNSTI4 0
ASGNI4
LABELV $477
ADDRLP4 1188
INDIRP4
CNSTI4 5104
ADDP4
ADDRLP4 1184
INDIRI4
ASGNI4
line 1844
;1844:	bs->inventory[INVENTORY_REGEN] = bs->cur_ps.powerups[PW_REGEN] != 0;
ADDRLP4 1196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1196
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $479
ADDRLP4 1192
CNSTI4 1
ASGNI4
ADDRGP4 $480
JUMPV
LABELV $479
ADDRLP4 1192
CNSTI4 0
ASGNI4
LABELV $480
ADDRLP4 1196
INDIRP4
CNSTI4 5108
ADDP4
ADDRLP4 1192
INDIRI4
ASGNI4
line 1845
;1845:	bs->inventory[INVENTORY_FLIGHT] = bs->cur_ps.powerups[PW_FLIGHT] != 0;
ADDRLP4 1204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1204
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $482
ADDRLP4 1200
CNSTI4 1
ASGNI4
ADDRGP4 $483
JUMPV
LABELV $482
ADDRLP4 1200
CNSTI4 0
ASGNI4
LABELV $483
ADDRLP4 1204
INDIRP4
CNSTI4 5112
ADDP4
ADDRLP4 1200
INDIRI4
ASGNI4
line 1852
;1846:#ifdef MISSIONPACK
;1847:	bs->inventory[INVENTORY_SCOUT] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_SCOUT;
;1848:	bs->inventory[INVENTORY_GUARD] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_GUARD;
;1849:	bs->inventory[INVENTORY_DOUBLER] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_DOUBLER;
;1850:	bs->inventory[INVENTORY_AMMOREGEN] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_AMMOREGEN;
;1851:#endif
;1852:	bs->inventory[INVENTORY_REDFLAG] = bs->cur_ps.powerups[PW_REDFLAG] != 0;
ADDRLP4 1212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1212
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $485
ADDRLP4 1208
CNSTI4 1
ASGNI4
ADDRGP4 $486
JUMPV
LABELV $485
ADDRLP4 1208
CNSTI4 0
ASGNI4
LABELV $486
ADDRLP4 1212
INDIRP4
CNSTI4 5132
ADDP4
ADDRLP4 1208
INDIRI4
ASGNI4
line 1853
;1853:	bs->inventory[INVENTORY_BLUEFLAG] = bs->cur_ps.powerups[PW_BLUEFLAG] != 0;
ADDRLP4 1220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1220
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
EQI4 $488
ADDRLP4 1216
CNSTI4 1
ASGNI4
ADDRGP4 $489
JUMPV
LABELV $488
ADDRLP4 1216
CNSTI4 0
ASGNI4
LABELV $489
ADDRLP4 1220
INDIRP4
CNSTI4 5136
ADDP4
ADDRLP4 1216
INDIRI4
ASGNI4
line 1865
;1854:#ifdef MISSIONPACK
;1855:	bs->inventory[INVENTORY_NEUTRALFLAG] = bs->cur_ps.powerups[PW_NEUTRALFLAG] != 0;
;1856:	if (BotTeam(bs) == TEAM_RED) {
;1857:		bs->inventory[INVENTORY_REDCUBE] = bs->cur_ps.generic1;
;1858:		bs->inventory[INVENTORY_BLUECUBE] = 0;
;1859:	}
;1860:	else {
;1861:		bs->inventory[INVENTORY_REDCUBE] = 0;
;1862:		bs->inventory[INVENTORY_BLUECUBE] = bs->cur_ps.generic1;
;1863:	}
;1864:#endif
;1865:	BotCheckItemPickup(bs, oldinventory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckItemPickup
CALLV
pop
line 1866
;1866:}
LABELV $429
endproc BotUpdateInventory 1224 12
export BotUpdateBattleInventory
proc BotUpdateBattleInventory 160 8
line 1873
;1867:
;1868:/*
;1869:==================
;1870:BotUpdateBattleInventory
;1871:==================
;1872:*/
;1873:void BotUpdateBattleInventory(bot_state_t *bs, int enemy) {
line 1877
;1874:	vec3_t dir;
;1875:	aas_entityinfo_t entinfo;
;1876:
;1877:	BotEntityInfo(enemy, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1878
;1878:	VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12+24
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+24+4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1879
;1879:	bs->inventory[ENEMY_HEIGHT] = (int) dir[2];
ADDRFP4 0
INDIRP4
CNSTI4 5756
ADDP4
ADDRLP4 0+8
INDIRF4
CVFI4 4
ASGNI4
line 1880
;1880:	dir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1881
;1881:	bs->inventory[ENEMY_HORIZONTAL_DIST] = (int) VectorLength(dir);
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 5752
ADDP4
ADDRLP4 156
INDIRF4
CVFI4 4
ASGNI4
line 1883
;1882:	//FIXME: add num visible enemies and num visible team mates to the inventory
;1883:}
LABELV $490
endproc BotUpdateBattleInventory 160 8
export BotBattleUseItems
proc BotBattleUseItems 4 4
line 2110
;1884:
;1885:#ifdef MISSIONPACK
;1886:/*
;1887:==================
;1888:BotUseKamikaze
;1889:==================
;1890:*/
;1891:#define KAMIKAZE_DIST		1024
;1892:
;1893:void BotUseKamikaze(bot_state_t *bs) {
;1894:	int c, teammates, enemies;
;1895:	aas_entityinfo_t entinfo;
;1896:	vec3_t dir, target;
;1897:	bot_goal_t *goal;
;1898:	bsp_trace_t trace;
;1899:
;1900:	//if the bot has no kamikaze
;1901:	if (bs->inventory[INVENTORY_KAMIKAZE] <= 0)
;1902:		return;
;1903:	if (bs->kamikaze_time > FloatTime())
;1904:		return;
;1905:	bs->kamikaze_time = FloatTime() + 0.2;
;1906:	if (gametype == GT_CTF) {
;1907:		//never use kamikaze if the team flag carrier is visible
;1908:		if (BotCTFCarryingFlag(bs))
;1909:			return;
;1910:		c = BotTeamFlagCarrierVisible(bs);
;1911:		if (c >= 0) {
;1912:			BotEntityInfo(c, &entinfo);
;1913:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1914:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
;1915:				return;
;1916:		}
;1917:		c = BotEnemyFlagCarrierVisible(bs);
;1918:		if (c >= 0) {
;1919:			BotEntityInfo(c, &entinfo);
;1920:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1921:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
;1922:				trap_EA_Use(bs->client);
;1923:				return;
;1924:			}
;1925:		}
;1926:	}
;1927:	else if (gametype == GT_1FCTF) {
;1928:		//never use kamikaze if the team flag carrier is visible
;1929:		if (Bot1FCTFCarryingFlag(bs))
;1930:			return;
;1931:		c = BotTeamFlagCarrierVisible(bs);
;1932:		if (c >= 0) {
;1933:			BotEntityInfo(c, &entinfo);
;1934:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1935:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
;1936:				return;
;1937:		}
;1938:		c = BotEnemyFlagCarrierVisible(bs);
;1939:		if (c >= 0) {
;1940:			BotEntityInfo(c, &entinfo);
;1941:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1942:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
;1943:				trap_EA_Use(bs->client);
;1944:				return;
;1945:			}
;1946:		}
;1947:	}
;1948:	else if (gametype == GT_OBELISK) {
;1949:		switch(BotTeam(bs)) {
;1950:			case TEAM_RED: goal = &blueobelisk; break;
;1951:			default: goal = &redobelisk; break;
;1952:		}
;1953:		//if the obelisk is visible
;1954:		VectorCopy(goal->origin, target);
;1955:		target[2] += 1;
;1956:		VectorSubtract(bs->origin, target, dir);
;1957:		if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST * 0.9)) {
;1958:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;1959:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;1960:				trap_EA_Use(bs->client);
;1961:				return;
;1962:			}
;1963:		}
;1964:	}
;1965:	else if (gametype == GT_HARVESTER) {
;1966:		//
;1967:		if (BotHarvesterCarryingCubes(bs))
;1968:			return;
;1969:		//never use kamikaze if a team mate carrying cubes is visible
;1970:		c = BotTeamCubeCarrierVisible(bs);
;1971:		if (c >= 0) {
;1972:			BotEntityInfo(c, &entinfo);
;1973:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1974:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
;1975:				return;
;1976:		}
;1977:		c = BotEnemyCubeCarrierVisible(bs);
;1978:		if (c >= 0) {
;1979:			BotEntityInfo(c, &entinfo);
;1980:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1981:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
;1982:				trap_EA_Use(bs->client);
;1983:				return;
;1984:			}
;1985:		}
;1986:	}
;1987:	//
;1988:	BotVisibleTeamMatesAndEnemies(bs, &teammates, &enemies, KAMIKAZE_DIST);
;1989:	//
;1990:	if (enemies > 2 && enemies > teammates+1) {
;1991:		trap_EA_Use(bs->client);
;1992:		return;
;1993:	}
;1994:}
;1995:
;1996:/*
;1997:==================
;1998:BotUseInvulnerability
;1999:==================
;2000:*/
;2001:void BotUseInvulnerability(bot_state_t *bs) {
;2002:	int c;
;2003:	vec3_t dir, target;
;2004:	bot_goal_t *goal;
;2005:	bsp_trace_t trace;
;2006:
;2007:	//if the bot has no invulnerability
;2008:	if (bs->inventory[INVENTORY_INVULNERABILITY] <= 0)
;2009:		return;
;2010:	if (bs->invulnerability_time > FloatTime())
;2011:		return;
;2012:	bs->invulnerability_time = FloatTime() + 0.2;
;2013:	if (gametype == GT_CTF) {
;2014:		//never use kamikaze if the team flag carrier is visible
;2015:		if (BotCTFCarryingFlag(bs))
;2016:			return;
;2017:		c = BotEnemyFlagCarrierVisible(bs);
;2018:		if (c >= 0)
;2019:			return;
;2020:		//if near enemy flag and the flag is visible
;2021:		switch(BotTeam(bs)) {
;2022:			case TEAM_RED: goal = &ctf_blueflag; break;
;2023:			default: goal = &ctf_redflag; break;
;2024:		}
;2025:		//if the obelisk is visible
;2026:		VectorCopy(goal->origin, target);
;2027:		target[2] += 1;
;2028:		VectorSubtract(bs->origin, target, dir);
;2029:		if (VectorLengthSquared(dir) < Square(200)) {
;2030:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;2031:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;2032:				trap_EA_Use(bs->client);
;2033:				return;
;2034:			}
;2035:		}
;2036:	}
;2037:	else if (gametype == GT_1FCTF) {
;2038:		//never use kamikaze if the team flag carrier is visible
;2039:		if (Bot1FCTFCarryingFlag(bs))
;2040:			return;
;2041:		c = BotEnemyFlagCarrierVisible(bs);
;2042:		if (c >= 0)
;2043:			return;
;2044:		//if near enemy flag and the flag is visible
;2045:		switch(BotTeam(bs)) {
;2046:			case TEAM_RED: goal = &ctf_blueflag; break;
;2047:			default: goal = &ctf_redflag; break;
;2048:		}
;2049:		//if the obelisk is visible
;2050:		VectorCopy(goal->origin, target);
;2051:		target[2] += 1;
;2052:		VectorSubtract(bs->origin, target, dir);
;2053:		if (VectorLengthSquared(dir) < Square(200)) {
;2054:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;2055:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;2056:				trap_EA_Use(bs->client);
;2057:				return;
;2058:			}
;2059:		}
;2060:	}
;2061:	else if (gametype == GT_OBELISK) {
;2062:		switch(BotTeam(bs)) {
;2063:			case TEAM_RED: goal = &blueobelisk; break;
;2064:			default: goal = &redobelisk; break;
;2065:		}
;2066:		//if the obelisk is visible
;2067:		VectorCopy(goal->origin, target);
;2068:		target[2] += 1;
;2069:		VectorSubtract(bs->origin, target, dir);
;2070:		if (VectorLengthSquared(dir) < Square(300)) {
;2071:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;2072:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;2073:				trap_EA_Use(bs->client);
;2074:				return;
;2075:			}
;2076:		}
;2077:	}
;2078:	else if (gametype == GT_HARVESTER) {
;2079:		//
;2080:		if (BotHarvesterCarryingCubes(bs))
;2081:			return;
;2082:		c = BotEnemyCubeCarrierVisible(bs);
;2083:		if (c >= 0)
;2084:			return;
;2085:		//if near enemy base and enemy base is visible
;2086:		switch(BotTeam(bs)) {
;2087:			case TEAM_RED: goal = &blueobelisk; break;
;2088:			default: goal = &redobelisk; break;
;2089:		}
;2090:		//if the obelisk is visible
;2091:		VectorCopy(goal->origin, target);
;2092:		target[2] += 1;
;2093:		VectorSubtract(bs->origin, target, dir);
;2094:		if (VectorLengthSquared(dir) < Square(200)) {
;2095:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;2096:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;2097:				trap_EA_Use(bs->client);
;2098:				return;
;2099:			}
;2100:		}
;2101:	}
;2102:}
;2103:#endif
;2104:
;2105:/*
;2106:==================
;2107:BotBattleUseItems
;2108:==================
;2109:*/
;2110:void BotBattleUseItems(bot_state_t *bs) {
line 2111
;2111:	if (bs->inventory[INVENTORY_HEALTH] < 40) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 40
GEI4 $501
line 2112
;2112:		if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5072
ADDP4
INDIRI4
CNSTI4 0
LEI4 $503
line 2113
;2113:			if (!BotCTFCarryingFlag(bs)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $505
line 2118
;2114:#ifdef MISSIONPACK
;2115:				&& !Bot1FCTFCarryingFlag(bs)
;2116:				&& !BotHarvesterCarryingCubes(bs)
;2117:#endif
;2118:				) {
line 2119
;2119:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2120
;2120:			}
LABELV $505
line 2121
;2121:		}
LABELV $503
line 2122
;2122:	}
LABELV $501
line 2123
;2123:	if (bs->inventory[INVENTORY_MEDKIT] > 0)
ADDRFP4 0
INDIRP4
CNSTI4 5076
ADDP4
INDIRI4
CNSTI4 0
LEI4 $507
line 2124
;2124:	{ //-Vincent
line 2125
;2125:		if (bs->inventory[INVENTORY_HEALTH] < 30)
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 30
GEI4 $500
line 2126
;2126:		{
line 2127
;2127:			trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2128
;2128:		}
line 2129
;2129:		return;
LABELV $507
line 2135
;2130:	}
;2131:#ifdef MISSIONPACK
;2132:	BotUseKamikaze(bs);
;2133:	BotUseInvulnerability(bs);
;2134:#endif
;2135:}
LABELV $500
endproc BotBattleUseItems 4 4
export BotSetTeleportTime
proc BotSetTeleportTime 8 0
line 2142
;2136:
;2137:/*
;2138:==================
;2139:BotSetTeleportTime
;2140:==================
;2141:*/
;2142:void BotSetTeleportTime(bot_state_t *bs) {
line 2143
;2143:	if ((bs->cur_ps.eFlags ^ bs->last_eFlags) & EF_TELEPORT_BIT) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $512
line 2144
;2144:		bs->teleport_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2145
;2145:	}
LABELV $512
line 2146
;2146:	bs->last_eFlags = bs->cur_ps.eFlags;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 484
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ASGNI4
line 2147
;2147:}
LABELV $511
endproc BotSetTeleportTime 8 0
export BotIsDead
proc BotIsDead 4 0
line 2154
;2148:
;2149:/*
;2150:==================
;2151:BotIsDead
;2152:==================
;2153:*/
;2154:qboolean BotIsDead(bot_state_t *bs) {
line 2155
;2155:	return (bs->cur_ps.pm_type == PM_DEAD);
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 3
NEI4 $516
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $517
JUMPV
LABELV $516
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $517
ADDRLP4 0
INDIRI4
RETI4
LABELV $514
endproc BotIsDead 4 0
export BotIsObserver
proc BotIsObserver 1032 12
line 2163
;2156:}
;2157:
;2158:/*
;2159:==================
;2160:BotIsObserver
;2161:==================
;2162:*/
;2163:qboolean BotIsObserver(bot_state_t *bs) {
line 2165
;2164:	char buf[MAX_INFO_STRING];
;2165:	if (bs->cur_ps.pm_type == PM_SPECTATOR) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
NEI4 $519
CNSTI4 1
RETI4
ADDRGP4 $518
JUMPV
LABELV $519
line 2166
;2166:	trap_GetConfigstring(CS_PLAYERS+bs->client, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 2167
;2167:	if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) return qtrue;
ADDRLP4 0
ARGP4
ADDRGP4 $77
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 3
NEI4 $521
CNSTI4 1
RETI4
ADDRGP4 $518
JUMPV
LABELV $521
line 2168
;2168:	return qfalse;
CNSTI4 0
RETI4
LABELV $518
endproc BotIsObserver 1032 12
export BotIntermission
proc BotIntermission 8 0
line 2176
;2169:}
;2170:
;2171:/*
;2172:==================
;2173:BotIntermission
;2174:==================
;2175:*/
;2176:qboolean BotIntermission(bot_state_t *bs) {
line 2178
;2177:	//NOTE: we shouldn't be looking at the game code...
;2178:	if (level.intermissiontime) return qtrue;
ADDRGP4 level+9140
INDIRI4
CNSTI4 0
EQI4 $524
CNSTI4 1
RETI4
ADDRGP4 $523
JUMPV
LABELV $524
line 2179
;2179:	return (bs->cur_ps.pm_type == PM_FREEZE || bs->cur_ps.pm_type == PM_INTERMISSION);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
EQI4 $530
ADDRLP4 4
INDIRI4
CNSTI4 5
NEI4 $528
LABELV $530
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $529
JUMPV
LABELV $528
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $529
ADDRLP4 0
INDIRI4
RETI4
LABELV $523
endproc BotIntermission 8 0
export BotInLavaOrSlime
proc BotInLavaOrSlime 16 4
line 2188
;2180:	
;2181:}
;2182:
;2183:/*
;2184:==================
;2185:BotInLavaOrSlime
;2186:==================
;2187:*/
;2188:qboolean BotInLavaOrSlime(bot_state_t *bs) {
line 2191
;2189:	vec3_t feet;
;2190:
;2191:	VectorCopy(bs->origin, feet);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 2192
;2192:	feet[2] -= 23;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1102577664
SUBF4
ASGNF4
line 2193
;2193:	return (trap_AAS_PointContents(feet) & (CONTENTS_LAVA|CONTENTS_SLIME));
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 24
BANDI4
RETI4
LABELV $531
endproc BotInLavaOrSlime 16 4
lit
align 4
LABELV $534
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $535
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCreateWayPoint
code
proc BotCreateWayPoint 32 12
line 2201
;2194:}
;2195:
;2196:/*
;2197:==================
;2198:BotCreateWayPoint
;2199:==================
;2200:*/
;2201:bot_waypoint_t *BotCreateWayPoint(char *name, vec3_t origin, int areanum) {
line 2203
;2202:	bot_waypoint_t *wp;
;2203:	vec3_t waypointmins = {-8, -8, -8}, waypointmaxs = {8, 8, 8};
ADDRLP4 4
ADDRGP4 $534
INDIRB
ASGNB 12
ADDRLP4 16
ADDRGP4 $535
INDIRB
ASGNB 12
line 2205
;2204:
;2205:	wp = botai_freewaypoints;
ADDRLP4 0
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2206
;2206:	if ( !wp ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $536
line 2207
;2207:		BotAI_Print( PRT_WARNING, "BotCreateWayPoint: Out of waypoints\n" );
CNSTI4 2
ARGI4
ADDRGP4 $538
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 2208
;2208:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $533
JUMPV
LABELV $536
line 2210
;2209:	}
;2210:	botai_freewaypoints = botai_freewaypoints->next;
ADDRLP4 28
ADDRGP4 botai_freewaypoints
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 2212
;2211:
;2212:	Q_strncpyz( wp->name, name, sizeof(wp->name) );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2213
;2213:	VectorCopy(origin, wp->goal.origin);
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2214
;2214:	VectorCopy(waypointmins, wp->goal.mins);
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 2215
;2215:	VectorCopy(waypointmaxs, wp->goal.maxs);
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 2216
;2216:	wp->goal.areanum = areanum;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 2217
;2217:	wp->next = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
CNSTP4 0
ASGNP4
line 2218
;2218:	wp->prev = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
CNSTP4 0
ASGNP4
line 2219
;2219:	return wp;
ADDRLP4 0
INDIRP4
RETP4
LABELV $533
endproc BotCreateWayPoint 32 12
export BotFindWayPoint
proc BotFindWayPoint 8 8
line 2227
;2220:}
;2221:
;2222:/*
;2223:==================
;2224:BotFindWayPoint
;2225:==================
;2226:*/
;2227:bot_waypoint_t *BotFindWayPoint(bot_waypoint_t *waypoints, char *name) {
line 2230
;2228:	bot_waypoint_t *wp;
;2229:
;2230:	for (wp = waypoints; wp; wp = wp->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $543
JUMPV
LABELV $540
line 2231
;2231:		if (!Q_stricmp(wp->name, name)) return wp;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $544
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $539
JUMPV
LABELV $544
line 2232
;2232:	}
LABELV $541
line 2230
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $543
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $540
line 2233
;2233:	return NULL;
CNSTP4 0
RETP4
LABELV $539
endproc BotFindWayPoint 8 8
export BotFreeWaypoints
proc BotFreeWaypoints 4 0
line 2241
;2234:}
;2235:
;2236:/*
;2237:==================
;2238:BotFreeWaypoints
;2239:==================
;2240:*/
;2241:void BotFreeWaypoints(bot_waypoint_t *wp) {
line 2244
;2242:	bot_waypoint_t *nextwp;
;2243:
;2244:	for (; wp; wp = nextwp) {
ADDRGP4 $550
JUMPV
LABELV $547
line 2245
;2245:		nextwp = wp->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 2246
;2246:		wp->next = botai_freewaypoints;
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2247
;2247:		botai_freewaypoints = wp;
ADDRGP4 botai_freewaypoints
ADDRFP4 0
INDIRP4
ASGNP4
line 2248
;2248:	}
LABELV $548
line 2244
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $550
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $547
line 2249
;2249:}
LABELV $546
endproc BotFreeWaypoints 4 0
export BotInitWaypoints
proc BotInitWaypoints 4 0
line 2256
;2250:
;2251:/*
;2252:==================
;2253:BotInitWaypoints
;2254:==================
;2255:*/
;2256:void BotInitWaypoints(void) {
line 2259
;2257:	int i;
;2258:
;2259:	botai_freewaypoints = NULL;
ADDRGP4 botai_freewaypoints
CNSTP4 0
ASGNP4
line 2260
;2260:	for (i = 0; i < MAX_WAYPOINTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $552
line 2261
;2261:		botai_waypoints[i].next = botai_freewaypoints;
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 botai_waypoints+92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2262
;2262:		botai_freewaypoints = &botai_waypoints[i];
ADDRGP4 botai_freewaypoints
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 botai_waypoints
ADDP4
ASGNP4
line 2263
;2263:	}
LABELV $553
line 2260
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 128
LTI4 $552
line 2264
;2264:}
LABELV $551
endproc BotInitWaypoints 4 0
export TeamPlayIsOn
proc TeamPlayIsOn 4 0
line 2271
;2265:
;2266:/*
;2267:==================
;2268:TeamPlayIsOn
;2269:==================
;2270:*/
;2271:int TeamPlayIsOn(void) {
line 2272
;2272:	return ( gametype >= GT_TEAM );
ADDRGP4 gametype
INDIRI4
CNSTI4 3
LTI4 $559
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $560
JUMPV
LABELV $559
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $560
ADDRLP4 0
INDIRI4
RETI4
LABELV $557
endproc TeamPlayIsOn 4 0
export BotAggression
proc BotAggression 28 0
line 2280
;2273:}
;2274:
;2275:/*
;2276:==================
;2277:BotAggression
;2278:==================
;2279:*/
;2280:float BotAggression(bot_state_t *bs) {
line 2282
;2281:	//if the bot has quad
;2282:	if (bs->inventory[INVENTORY_QUAD]) {
ADDRFP4 0
INDIRP4
CNSTI4 5092
ADDP4
INDIRI4
CNSTI4 0
EQI4 $562
line 2284
;2283:		//if the bot is not holding the gauntlet or the enemy is really nearby
;2284:		if (bs->weaponnum != WP_GAUNTLET ||
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $566
ADDRLP4 0
INDIRP4
CNSTI4 5752
ADDP4
INDIRI4
CNSTI4 80
GEI4 $564
LABELV $566
line 2285
;2285:			bs->inventory[ENEMY_HORIZONTAL_DIST] < 80) {
line 2286
;2286:			return 70;
CNSTF4 1116471296
RETF4
ADDRGP4 $561
JUMPV
LABELV $564
line 2288
;2287:		}
;2288:	}
LABELV $562
line 2290
;2289:	//if the enemy is located way higher than the bot
;2290:	if (bs->inventory[ENEMY_HEIGHT] > 200) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 5756
ADDP4
INDIRI4
CNSTI4 200
LEI4 $567
CNSTF4 0
RETF4
ADDRGP4 $561
JUMPV
LABELV $567
line 2292
;2291:	//if the bot is very low on health
;2292:	if (bs->inventory[INVENTORY_HEALTH] < 60) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $569
CNSTF4 0
RETF4
ADDRGP4 $561
JUMPV
LABELV $569
line 2294
;2293:	//if the bot is low on health
;2294:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 80
GEI4 $571
line 2296
;2295:		//if the bot has insufficient armor
;2296:		if (bs->inventory[INVENTORY_ARMOR] < 40) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $573
CNSTF4 0
RETF4
ADDRGP4 $561
JUMPV
LABELV $573
line 2297
;2297:	}
LABELV $571
line 2299
;2298:	//if the bot can use the bfg
;2299:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $575
ADDRLP4 0
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 7
LEI4 $575
line 2300
;2300:			bs->inventory[INVENTORY_BFGAMMO] > 7) return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $561
JUMPV
LABELV $575
line 2302
;2301:	//if the bot can use the railgun
;2302:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $577
ADDRLP4 4
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 5
LEI4 $577
line 2303
;2303:			bs->inventory[INVENTORY_SLUGS] > 5) return 95;
CNSTF4 1119748096
RETF4
ADDRGP4 $561
JUMPV
LABELV $577
line 2305
;2304:	//if the bot can use the lightning gun
;2305:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4988
ADDP4
INDIRI4
CNSTI4 0
LEI4 $579
ADDRLP4 8
INDIRP4
CNSTI4 5040
ADDP4
INDIRI4
CNSTI4 50
LEI4 $579
line 2306
;2306:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $561
JUMPV
LABELV $579
line 2308
;2307:	//if the bot can use the rocketlauncher
;2308:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $581
ADDRLP4 12
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 5
LEI4 $581
line 2309
;2309:			bs->inventory[INVENTORY_ROCKETS] > 5) return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $561
JUMPV
LABELV $581
line 2311
;2310:	//if the bot can use the plasmagun
;2311:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $583
ADDRLP4 16
INDIRP4
CNSTI4 5036
ADDP4
INDIRI4
CNSTI4 40
LEI4 $583
line 2312
;2312:			bs->inventory[INVENTORY_CELLS] > 40) return 85;
CNSTF4 1118437376
RETF4
ADDRGP4 $561
JUMPV
LABELV $583
line 2314
;2313:	//if the bot can use the grenade launcher
;2314:	if (bs->inventory[INVENTORY_GRENADELAUNCHER] > 0 &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4980
ADDP4
INDIRI4
CNSTI4 0
LEI4 $585
ADDRLP4 20
INDIRP4
CNSTI4 5032
ADDP4
INDIRI4
CNSTI4 10
LEI4 $585
line 2315
;2315:			bs->inventory[INVENTORY_GRENADES] > 10) return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $561
JUMPV
LABELV $585
line 2317
;2316:	//if the bot can use the shotgun
;2317:	if (bs->inventory[INVENTORY_SHOTGUN] > 0 &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 4972
ADDP4
INDIRI4
CNSTI4 0
LEI4 $587
ADDRLP4 24
INDIRP4
CNSTI4 5024
ADDP4
INDIRI4
CNSTI4 10
LEI4 $587
line 2318
;2318:			bs->inventory[INVENTORY_SHELLS] > 10) return 50;
CNSTF4 1112014848
RETF4
ADDRGP4 $561
JUMPV
LABELV $587
line 2320
;2319:	//otherwise the bot is not feeling too good
;2320:	return 0;
CNSTF4 0
RETF4
LABELV $561
endproc BotAggression 28 0
export BotFeelingBad
proc BotFeelingBad 0 0
line 2328
;2321:}
;2322:
;2323:/*
;2324:==================
;2325:BotFeelingBad
;2326:==================
;2327:*/
;2328:float BotFeelingBad(bot_state_t *bs) {
line 2330
;2329:
;2330:	if (g_instagib.integer == 0) {  // Shafe - Grrr... Instagib
ADDRGP4 g_instagib+12
INDIRI4
CNSTI4 0
NEI4 $590
line 2332
;2331:	
;2332:		if (bs->weaponnum == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $593
line 2333
;2333:			return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $589
JUMPV
LABELV $593
line 2335
;2334:		}
;2335:		if (bs->inventory[INVENTORY_HEALTH] < 40) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 40
GEI4 $595
line 2336
;2336:			return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $589
JUMPV
LABELV $595
line 2338
;2337:		}
;2338:		if (bs->weaponnum == WP_MACHINEGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 2
NEI4 $597
line 2339
;2339:			return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $589
JUMPV
LABELV $597
line 2341
;2340:		}
;2341:		if (bs->inventory[INVENTORY_HEALTH] < 60) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $599
line 2342
;2342:			return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $589
JUMPV
LABELV $599
line 2344
;2343:		}
;2344:	} // End Shafe
LABELV $590
line 2345
;2345:	return 0;
CNSTF4 0
RETF4
LABELV $589
endproc BotFeelingBad 0 0
export BotWantsToRetreat
proc BotWantsToRetreat 144 8
line 2353
;2346:}
;2347:
;2348:/*
;2349:==================
;2350:BotWantsToRetreat
;2351:==================
;2352:*/
;2353:int BotWantsToRetreat(bot_state_t *bs) {
line 2356
;2354:	aas_entityinfo_t entinfo;
;2355:
;2356:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $602
line 2358
;2357:		//always retreat when carrying a CTF flag
;2358:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $604
line 2359
;2359:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $601
JUMPV
LABELV $604
line 2360
;2360:	}
LABELV $602
line 2386
;2361:#ifdef MISSIONPACK
;2362:	else if (gametype == GT_1FCTF) {
;2363:		//if carrying the flag then always retreat
;2364:		if (Bot1FCTFCarryingFlag(bs))
;2365:			return qtrue;
;2366:	}
;2367:	else if (gametype == GT_OBELISK) {
;2368:		//the bots should be dedicated to attacking the enemy obelisk
;2369:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
;2370:			if (bs->enemy != redobelisk.entitynum ||
;2371:						bs->enemy != blueobelisk.entitynum) {
;2372:				return qtrue;
;2373:			}
;2374:		}
;2375:		if (BotFeelingBad(bs) > 50) {
;2376:			return qtrue;
;2377:		}
;2378:		return qfalse;
;2379:	}
;2380:	else if (gametype == GT_HARVESTER) {
;2381:		//if carrying cubes then always retreat
;2382:		if (BotHarvesterCarryingCubes(bs)) return qtrue;
;2383:	}
;2384:#endif
;2385:	//
;2386:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
LTI4 $606
line 2388
;2387:		//if the enemy is carrying a flag
;2388:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2389
;2389:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $608
line 2390
;2390:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $601
JUMPV
LABELV $608
line 2391
;2391:	}
LABELV $606
line 2393
;2392:	//if the bot is getting the flag
;2393:	if (bs->ltgtype == LTG_GETFLAG)
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $610
line 2394
;2394:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $601
JUMPV
LABELV $610
line 2396
;2395:	//
;2396:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
GEF4 $612
line 2397
;2397:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $601
JUMPV
LABELV $612
line 2398
;2398:	return qfalse;
CNSTI4 0
RETI4
LABELV $601
endproc BotWantsToRetreat 144 8
export BotWantsToChase
proc BotWantsToChase 148 8
line 2406
;2399:}
;2400:
;2401:/*
;2402:==================
;2403:BotWantsToChase
;2404:==================
;2405:*/
;2406:int BotWantsToChase(bot_state_t *bs) {
line 2409
;2407:	aas_entityinfo_t entinfo;
;2408:
;2409:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $615
line 2411
;2410:		//never chase when carrying a CTF flag
;2411:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $617
line 2412
;2412:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $614
JUMPV
LABELV $617
line 2414
;2413:		//always chase if the enemy is carrying a flag
;2414:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2415
;2415:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $619
line 2416
;2416:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $614
JUMPV
LABELV $619
line 2417
;2417:	}
LABELV $615
line 2444
;2418:#ifdef MISSIONPACK
;2419:	else if (gametype == GT_1FCTF) {
;2420:		//never chase if carrying the flag
;2421:		if (Bot1FCTFCarryingFlag(bs))
;2422:			return qfalse;
;2423:		//always chase if the enemy is carrying a flag
;2424:		BotEntityInfo(bs->enemy, &entinfo);
;2425:		if (EntityCarriesFlag(&entinfo))
;2426:			return qtrue;
;2427:	}
;2428:	else if (gametype == GT_OBELISK) {
;2429:		//the bots should be dedicated to attacking the enemy obelisk
;2430:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
;2431:			if (bs->enemy != redobelisk.entitynum ||
;2432:						bs->enemy != blueobelisk.entitynum) {
;2433:				return qfalse;
;2434:			}
;2435:		}
;2436:	}
;2437:	else if (gametype == GT_HARVESTER) {
;2438:		//never chase if carrying cubes
;2439:		if (BotHarvesterCarryingCubes(bs))
;2440:			return qfalse;
;2441:	}
;2442:#endif
;2443:	//if the bot is getting the flag
;2444:	if (bs->ltgtype == LTG_GETFLAG)
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $621
line 2445
;2445:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $614
JUMPV
LABELV $621
line 2447
;2446:	//
;2447:	if (BotAggression(bs) > 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
LEF4 $623
line 2448
;2448:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $614
JUMPV
LABELV $623
line 2449
;2449:	return qfalse;
CNSTI4 0
RETI4
LABELV $614
endproc BotWantsToChase 148 8
export BotWantsToHelp
proc BotWantsToHelp 0 0
line 2457
;2450:}
;2451:
;2452:/*
;2453:==================
;2454:BotWantsToHelp
;2455:==================
;2456:*/
;2457:int BotWantsToHelp(bot_state_t *bs) {
line 2458
;2458:	return qtrue;
CNSTI4 1
RETI4
LABELV $625
endproc BotWantsToHelp 0 0
export BotCanAndWantsToRocketJump
proc BotCanAndWantsToRocketJump 8 16
line 2466
;2459:}
;2460:
;2461:/*
;2462:==================
;2463:BotCanAndWantsToRocketJump
;2464:==================
;2465:*/
;2466:int BotCanAndWantsToRocketJump(bot_state_t *bs) {
line 2470
;2467:	float rocketjumper;
;2468:
;2469:	//if rocket jumping is disabled
;2470:	if (!bot_rocketjump.integer) return qfalse;
ADDRGP4 bot_rocketjump+12
INDIRI4
CNSTI4 0
NEI4 $627
CNSTI4 0
RETI4
ADDRGP4 $626
JUMPV
LABELV $627
line 2473
;2471:	
;2472:	//if no rocket launcher
;2473:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0) 
ADDRFP4 0
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
GTI4 $630
line 2474
;2474:	{
line 2476
;2475:		// Try Grenade here
;2476:		if (bs->inventory[INVENTORY_GRENADELAUNCHER] <= 0) 
ADDRFP4 0
INDIRP4
CNSTI4 4980
ADDP4
INDIRI4
CNSTI4 0
GTI4 $631
line 2477
;2477:		{
line 2478
;2478:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $626
JUMPV
line 2480
;2479:		}
;2480:	} 
LABELV $630
line 2482
;2481:	else 
;2482:	{
line 2484
;2483:		//if low on rockets
;2484:		if (bs->inventory[INVENTORY_ROCKETS] < 2) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 2
GEI4 $634
CNSTI4 0
RETI4
ADDRGP4 $626
JUMPV
LABELV $634
line 2485
;2485:	}
LABELV $631
line 2489
;2486:	
;2487:	
;2488:	//never rocket jump with the Quad
;2489:	if (bs->inventory[INVENTORY_QUAD]) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5092
ADDP4
INDIRI4
CNSTI4 0
EQI4 $636
CNSTI4 0
RETI4
ADDRGP4 $626
JUMPV
LABELV $636
line 2491
;2490:	//if low on health
;2491:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $638
CNSTI4 0
RETI4
ADDRGP4 $626
JUMPV
LABELV $638
line 2493
;2492:	//if not full health
;2493:	if (bs->inventory[INVENTORY_HEALTH] < 70) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 70
GEI4 $640
line 2495
;2494:		//if the bot has insufficient armor
;2495:		if (bs->inventory[INVENTORY_ARMOR] < 10) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 10
GEI4 $642
CNSTI4 0
RETI4
ADDRGP4 $626
JUMPV
LABELV $642
line 2496
;2496:	}
LABELV $640
line 2497
;2497:	rocketjumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_WEAPONJUMPING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 38
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 4
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 2498
;2498:	if (rocketjumper < 0.5) return qfalse;
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
GEF4 $644
CNSTI4 0
RETI4
ADDRGP4 $626
JUMPV
LABELV $644
line 2499
;2499:	return qtrue;
CNSTI4 1
RETI4
LABELV $626
endproc BotCanAndWantsToRocketJump 8 16
export BotHasPersistantPowerupAndWeapon
proc BotHasPersistantPowerupAndWeapon 32 0
line 2507
;2500:}
;2501:
;2502:/*
;2503:==================
;2504:BotHasPersistantPowerupAndWeapon
;2505:==================
;2506:*/
;2507:int BotHasPersistantPowerupAndWeapon(bot_state_t *bs) {
line 2518
;2508:#ifdef MISSIONPACK
;2509:	// if the bot does not have a persistant powerup
;2510:	if (!bs->inventory[INVENTORY_SCOUT] &&
;2511:		!bs->inventory[INVENTORY_GUARD] &&
;2512:		!bs->inventory[INVENTORY_DOUBLER] &&
;2513:		!bs->inventory[INVENTORY_AMMOREGEN] ) {
;2514:		return qfalse;
;2515:	}
;2516:#endif
;2517:	//if the bot is very low on health
;2518:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $647
CNSTI4 0
RETI4
ADDRGP4 $646
JUMPV
LABELV $647
line 2520
;2519:	//if the bot is low on health
;2520:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 80
GEI4 $649
line 2522
;2521:		//if the bot has insufficient armor
;2522:		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $651
CNSTI4 0
RETI4
ADDRGP4 $646
JUMPV
LABELV $651
line 2523
;2523:	}
LABELV $649
line 2525
;2524:	//if the bot can use the bfg
;2525:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $653
ADDRLP4 0
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 7
LEI4 $653
line 2526
;2526:			bs->inventory[INVENTORY_BFGAMMO] > 7) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $646
JUMPV
LABELV $653
line 2528
;2527:	//if the bot can use the railgun
;2528:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $655
ADDRLP4 4
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 5
LEI4 $655
line 2529
;2529:			bs->inventory[INVENTORY_SLUGS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $646
JUMPV
LABELV $655
line 2531
;2530:	//if the bot can use the lightning gun
;2531:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4988
ADDP4
INDIRI4
CNSTI4 0
LEI4 $657
ADDRLP4 8
INDIRP4
CNSTI4 5040
ADDP4
INDIRI4
CNSTI4 50
LEI4 $657
line 2532
;2532:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $646
JUMPV
LABELV $657
line 2534
;2533:	//if the bot can use the rocketlauncher
;2534:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $659
ADDRLP4 12
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 5
LEI4 $659
line 2535
;2535:			bs->inventory[INVENTORY_ROCKETS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $646
JUMPV
LABELV $659
line 2537
;2536:	//
;2537:	if (bs->inventory[INVENTORY_NAILGUN] > 0 &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 5012
ADDP4
INDIRI4
CNSTI4 0
LEI4 $661
ADDRLP4 16
INDIRP4
CNSTI4 5056
ADDP4
INDIRI4
CNSTI4 5
LEI4 $661
line 2538
;2538:			bs->inventory[INVENTORY_NAILS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $646
JUMPV
LABELV $661
line 2540
;2539:	//
;2540:	if (bs->inventory[INVENTORY_PROXLAUNCHER] > 0 &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 5016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $663
ADDRLP4 20
INDIRP4
CNSTI4 5060
ADDP4
INDIRI4
CNSTI4 5
LEI4 $663
line 2541
;2541:			bs->inventory[INVENTORY_MINES] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $646
JUMPV
LABELV $663
line 2543
;2542:	//
;2543:	if (bs->inventory[INVENTORY_CHAINGUN] > 0 &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 5020
ADDP4
INDIRI4
CNSTI4 0
LEI4 $665
ADDRLP4 24
INDIRP4
CNSTI4 5064
ADDP4
INDIRI4
CNSTI4 40
LEI4 $665
line 2544
;2544:			bs->inventory[INVENTORY_BELT] > 40) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $646
JUMPV
LABELV $665
line 2546
;2545:	//if the bot can use the plasmagun
;2546:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $667
ADDRLP4 28
INDIRP4
CNSTI4 5036
ADDP4
INDIRI4
CNSTI4 20
LEI4 $667
line 2547
;2547:			bs->inventory[INVENTORY_CELLS] > 20) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $646
JUMPV
LABELV $667
line 2548
;2548:	return qfalse;
CNSTI4 0
RETI4
LABELV $646
endproc BotHasPersistantPowerupAndWeapon 32 0
export BotGoCamp
proc BotGoCamp 16 16
line 2556
;2549:}
;2550:
;2551:/*
;2552:==================
;2553:BotGoCamp
;2554:==================
;2555:*/
;2556:void BotGoCamp(bot_state_t *bs, bot_goal_t *goal) {
line 2559
;2557:	float camper;
;2558:
;2559:	bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 2561
;2560:	//set message time to zero so bot will NOT show any message
;2561:	bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 2563
;2562:	//set the ltg type
;2563:	bs->ltgtype = LTG_CAMP;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 7
ASGNI4
line 2565
;2564:	//set the team goal
;2565:	memcpy(&bs->teamgoal, goal, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2567
;2566:	//get the team goal time
;2567:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 44
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 8
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 2568
;2568:	if (camper > 0.99) bs->teamgoal_time = FloatTime() + 99999;
ADDRLP4 0
INDIRF4
CNSTF4 1065185444
LEF4 $670
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1203982208
ADDF4
ASGNF4
ADDRGP4 $671
JUMPV
LABELV $670
line 2569
;2569:	else bs->teamgoal_time = FloatTime() + 120 + 180 * camper + random() * 15;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
CNSTF4 1127481344
ADDRLP4 0
INDIRF4
MULF4
ADDF4
CNSTF4 1097859072
ADDRLP4 12
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
LABELV $671
line 2571
;2570:	//set the last time the bot started camping
;2571:	bs->camp_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2573
;2572:	//the teammate that requested the camping
;2573:	bs->teammate = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
CNSTI4 0
ASGNI4
line 2575
;2574:	//do NOT type arrive message
;2575:	bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 2576
;2576:}
LABELV $669
endproc BotGoCamp 16 16
export BotWantsToCamp
proc BotWantsToCamp 176 16
line 2583
;2577:
;2578:/*
;2579:==================
;2580:BotWantsToCamp
;2581:==================
;2582:*/
;2583:int BotWantsToCamp(bot_state_t *bs) {
line 2588
;2584:	float camper;
;2585:	int cs, traveltime, besttraveltime;
;2586:	bot_goal_t goal, bestgoal;
;2587:
;2588:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 44
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 128
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 124
ADDRLP4 128
INDIRF4
ASGNF4
line 2589
;2589:	if (camper < 0.1) return qfalse;
ADDRLP4 124
INDIRF4
CNSTF4 1036831949
GEF4 $673
CNSTI4 0
RETI4
ADDRGP4 $672
JUMPV
LABELV $673
line 2591
;2590:	//if the bot has a team goal
;2591:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 132
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 1
EQI4 $683
ADDRLP4 132
INDIRI4
CNSTI4 2
EQI4 $683
ADDRLP4 132
INDIRI4
CNSTI4 3
EQI4 $683
ADDRLP4 132
INDIRI4
CNSTI4 4
EQI4 $683
ADDRLP4 132
INDIRI4
CNSTI4 5
EQI4 $683
ADDRLP4 132
INDIRI4
CNSTI4 7
EQI4 $683
ADDRLP4 132
INDIRI4
CNSTI4 8
EQI4 $683
ADDRLP4 132
INDIRI4
CNSTI4 9
NEI4 $675
LABELV $683
line 2598
;2592:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;2593:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;2594:			bs->ltgtype == LTG_GETFLAG ||
;2595:			bs->ltgtype == LTG_RUSHBASE ||
;2596:			bs->ltgtype == LTG_CAMP ||
;2597:			bs->ltgtype == LTG_CAMPORDER ||
;2598:			bs->ltgtype == LTG_PATROL) {
line 2599
;2599:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $672
JUMPV
LABELV $675
line 2602
;2600:	}
;2601:	//if camped recently
;2602:	if (bs->camp_time > FloatTime() - 60 + 300 * (1-camper)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
SUBF4
CNSTF4 1133903872
CNSTF4 1065353216
ADDRLP4 124
INDIRF4
SUBF4
MULF4
ADDF4
LEF4 $684
CNSTI4 0
RETI4
ADDRGP4 $672
JUMPV
LABELV $684
line 2604
;2603:	//
;2604:	if (random() > camper) {
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 124
INDIRF4
LEF4 $686
line 2605
;2605:		bs->camp_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2606
;2606:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $672
JUMPV
LABELV $686
line 2609
;2607:	}
;2608:	//if the bot isn't healthy anough
;2609:	if (BotAggression(bs) < 50) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
GEF4 $688
CNSTI4 0
RETI4
ADDRGP4 $672
JUMPV
LABELV $688
line 2611
;2610:	//the bot should have at least have the rocket launcher, the railgun or the bfg10k with some ammo
;2611:	if ((bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0 || bs->inventory[INVENTORY_ROCKETS < 10]) &&
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
CNSTI4 0
ASGNI4
ADDRLP4 144
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
ADDRLP4 148
INDIRI4
LEI4 $692
ADDRLP4 144
INDIRP4
CNSTI4 4952
ADDP4
INDIRI4
ADDRLP4 148
INDIRI4
EQI4 $690
LABELV $692
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $693
ADDRLP4 152
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 10
GEI4 $690
LABELV $693
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $694
ADDRLP4 156
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 10
GEI4 $690
LABELV $694
line 2613
;2612:		(bs->inventory[INVENTORY_RAILGUN] <= 0 || bs->inventory[INVENTORY_SLUGS] < 10) &&
;2613:		(bs->inventory[INVENTORY_BFG10K] <= 0 || bs->inventory[INVENTORY_BFGAMMO] < 10)) {
line 2614
;2614:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $672
JUMPV
LABELV $690
line 2617
;2615:	}
;2616:	//find the closest camp spot
;2617:	besttraveltime = 99999;
ADDRLP4 64
CNSTI4 99999
ASGNI4
line 2618
;2618:	for (cs = trap_BotGetNextCampSpotGoal(0, &goal); cs; cs = trap_BotGetNextCampSpotGoal(cs, &goal)) {
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 160
ADDRGP4 trap_BotGetNextCampSpotGoal
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 160
INDIRI4
ASGNI4
ADDRGP4 $698
JUMPV
LABELV $695
line 2619
;2619:		traveltime = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, goal.areanum, TFL_DEFAULT);
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 8+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 168
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 168
INDIRI4
ASGNI4
line 2620
;2620:		if (traveltime && traveltime < besttraveltime) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $700
ADDRLP4 0
INDIRI4
ADDRLP4 64
INDIRI4
GEI4 $700
line 2621
;2621:			besttraveltime = traveltime;
ADDRLP4 64
ADDRLP4 0
INDIRI4
ASGNI4
line 2622
;2622:			memcpy(&bestgoal, &goal, sizeof(bot_goal_t));
ADDRLP4 68
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2623
;2623:		}
LABELV $700
line 2624
;2624:	}
LABELV $696
line 2618
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 164
ADDRGP4 trap_BotGetNextCampSpotGoal
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 164
INDIRI4
ASGNI4
LABELV $698
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $695
line 2625
;2625:	if (besttraveltime > 150) return qfalse;
ADDRLP4 64
INDIRI4
CNSTI4 150
LEI4 $702
CNSTI4 0
RETI4
ADDRGP4 $672
JUMPV
LABELV $702
line 2627
;2626:	//ok found a camp spot, go camp there
;2627:	BotGoCamp(bs, &bestgoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 BotGoCamp
CALLV
pop
line 2628
;2628:	bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 2630
;2629:	//
;2630:	return qtrue;
CNSTI4 1
RETI4
LABELV $672
endproc BotWantsToCamp 176 16
export BotDontAvoid
proc BotDontAvoid 68 12
line 2638
;2631:}
;2632:
;2633:/*
;2634:==================
;2635:BotDontAvoid
;2636:==================
;2637:*/
;2638:void BotDontAvoid(bot_state_t *bs, char *itemname) {
line 2642
;2639:	bot_goal_t goal;
;2640:	int num;
;2641:
;2642:	num = trap_BotGetLevelItemGoal(-1, itemname, &goal);
CNSTI4 -1
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 60
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
ADDRGP4 $706
JUMPV
LABELV $705
line 2643
;2643:	while(num >= 0) {
line 2644
;2644:		trap_BotRemoveFromAvoidGoals(bs->gs, goal.number);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 4+44
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveFromAvoidGoals
CALLV
pop
line 2645
;2645:		num = trap_BotGetLevelItemGoal(num, itemname, &goal);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 64
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 64
INDIRI4
ASGNI4
line 2646
;2646:	}
LABELV $706
line 2643
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $705
line 2647
;2647:}
LABELV $704
endproc BotDontAvoid 68 12
export BotGoForPowerups
proc BotGoForPowerups 0 8
line 2654
;2648:
;2649:/*
;2650:==================
;2651:BotGoForPowerups
;2652:==================
;2653:*/
;2654:void BotGoForPowerups(bot_state_t *bs) {
line 2657
;2655:
;2656:	//don't avoid any of the powerups anymore
;2657:	BotDontAvoid(bs, "Quad Damage");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $710
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2658
;2658:	BotDontAvoid(bs, "Regeneration");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $711
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2659
;2659:	BotDontAvoid(bs, "Battle Suit");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $712
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2660
;2660:	BotDontAvoid(bs, "Speed");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $713
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2661
;2661:	BotDontAvoid(bs, "Invisibility");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $714
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2662
;2662:	BotDontAvoid(bs, "Flight"); // Not sure about this one
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $715
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2665
;2663:	//reset the long term goal time so the bot will go for the powerup
;2664:	//NOTE: the long term goal type doesn't change
;2665:	bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6068
ADDP4
CNSTF4 0
ASGNF4
line 2666
;2666:}
LABELV $709
endproc BotGoForPowerups 0 8
export BotRoamGoal
proc BotRoamGoal 180 28
line 2673
;2667:
;2668:/*
;2669:==================
;2670:BotRoamGoal
;2671:==================
;2672:*/
;2673:void BotRoamGoal(bot_state_t *bs, vec3_t goal) {
line 2679
;2674:	int pc, i;
;2675:	float len, rnd;
;2676:	vec3_t dir, bestorg, belowbestorg;
;2677:	bsp_trace_t trace;
;2678:
;2679:	for (i = 0; i < 10; i++) {
ADDRLP4 116
CNSTI4 0
ASGNI4
LABELV $717
line 2681
;2680:		//start at the bot origin
;2681:		VectorCopy(bs->origin, bestorg);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 2682
;2682:		rnd = random();
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 112
ADDRLP4 136
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ASGNF4
line 2683
;2683:		if (rnd > 0.25) {
ADDRLP4 112
INDIRF4
CNSTF4 1048576000
LEF4 $721
line 2685
;2684:			//add a random value to the x-coordinate
;2685:			if (random() < 0.5) bestorg[0] -= 800 * random() + 100;
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
GEF4 $723
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1145569280
ADDRLP4 144
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $724
JUMPV
LABELV $723
line 2686
;2686:			else bestorg[0] += 800 * random() + 100;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1145569280
ADDRLP4 148
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $724
line 2687
;2687:		}
LABELV $721
line 2688
;2688:		if (rnd < 0.75) {
ADDRLP4 112
INDIRF4
CNSTF4 1061158912
GEF4 $725
line 2690
;2689:			//add a random value to the y-coordinate
;2690:			if (random() < 0.5) bestorg[1] -= 800 * random() + 100;
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
GEF4 $727
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1145569280
ADDRLP4 144
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $728
JUMPV
LABELV $727
line 2691
;2691:			else bestorg[1] += 800 * random() + 100;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1145569280
ADDRLP4 148
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $728
line 2692
;2692:		}
LABELV $725
line 2694
;2693:		//add a random value to the z-coordinate (NOTE: 48 = maxjump?)
;2694:		bestorg[2] += 2 * 48 * crandom();
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1119879168
CNSTF4 1073741824
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ADDF4
ASGNF4
line 2696
;2695:		//trace a line from the origin to the roam target
;2696:		BotAI_Trace(&trace, bs->origin, NULL, NULL, bestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 148
CNSTP4 0
ASGNP4
ADDRLP4 148
INDIRP4
ARGP4
ADDRLP4 148
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2698
;2697:		//direction and length towards the roam target
;2698:		VectorSubtract(trace.endpos, bs->origin, dir);
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24+12
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24+12+4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24+12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2699
;2699:		len = VectorNormalize(dir);
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 108
ADDRLP4 156
INDIRF4
ASGNF4
line 2701
;2700:		//if the roam target is far away anough
;2701:		if (len > 200) {
ADDRLP4 108
INDIRF4
CNSTF4 1128792064
LEF4 $739
line 2703
;2702:			//the roam target is in the given direction before walls
;2703:			VectorScale(dir, len * trace.fraction - 40, dir);
ADDRLP4 164
CNSTF4 1109393408
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDRLP4 164
INDIRF4
SUBF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDRLP4 164
INDIRF4
SUBF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
line 2704
;2704:			VectorAdd(bs->origin, dir, bestorg);
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 168
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 168
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 2706
;2705:			//get the coordinates of the floor below the roam target
;2706:			belowbestorg[0] = bestorg[0];
ADDRLP4 120
ADDRLP4 12
INDIRF4
ASGNF4
line 2707
;2707:			belowbestorg[1] = bestorg[1];
ADDRLP4 120+4
ADDRLP4 12+4
INDIRF4
ASGNF4
line 2708
;2708:			belowbestorg[2] = bestorg[2] - 800;
ADDRLP4 120+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1145569280
SUBF4
ASGNF4
line 2709
;2709:			BotAI_Trace(&trace, bestorg, NULL, NULL, belowbestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 172
CNSTP4 0
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2711
;2710:			//
;2711:			if (!trace.startsolid) {
ADDRLP4 24+4
INDIRI4
CNSTI4 0
NEI4 $756
line 2712
;2712:				trace.endpos[2]++;
ADDRLP4 24+12+8
ADDRLP4 24+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2713
;2713:				pc = trap_PointContents(trace.endpos, bs->entitynum);
ADDRLP4 24+12
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 176
INDIRI4
ASGNI4
line 2714
;2714:				if (!(pc & (CONTENTS_LAVA | CONTENTS_SLIME))) {
ADDRLP4 132
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
NEI4 $762
line 2715
;2715:					VectorCopy(bestorg, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 2716
;2716:					return;
ADDRGP4 $716
JUMPV
LABELV $762
line 2718
;2717:				}
;2718:			}
LABELV $756
line 2719
;2719:		}
LABELV $739
line 2720
;2720:	}
LABELV $718
line 2679
ADDRLP4 116
ADDRLP4 116
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 10
LTI4 $717
line 2721
;2721:	VectorCopy(bestorg, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 2722
;2722:}
LABELV $716
endproc BotRoamGoal 180 28
lit
align 4
LABELV $766
byte 4 0
byte 4 0
byte 4 1065353216
export BotAttackMove
code
proc BotAttackMove 392 16
line 2729
;2723:
;2724:/*
;2725:==================
;2726:BotAttackMove
;2727:==================
;2728:*/
;2729:bot_moveresult_t BotAttackMove(bot_state_t *bs, int tfl) {
line 2733
;2730:	int movetype, i, attackentity;
;2731:	float attack_skill, jumper, croucher, dist, strafechange_time;
;2732:	float attack_dist, attack_range;
;2733:	vec3_t forward, backward, sideward, hordir, up = {0, 0, 1};
ADDRLP4 56
ADDRGP4 $766
INDIRB
ASGNB 12
line 2738
;2734:	aas_entityinfo_t entinfo;
;2735:	bot_moveresult_t moveresult;
;2736:	bot_goal_t goal;
;2737:
;2738:	attackentity = bs->enemy;
ADDRLP4 332
ADDRFP4 4
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ASGNI4
line 2740
;2739:	//
;2740:	if (bs->attackchase_time > FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 6124
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $767
line 2742
;2741:		//create the chase goal
;2742:		goal.entitynum = attackentity;
ADDRLP4 136+40
ADDRLP4 332
INDIRI4
ASGNI4
line 2743
;2743:		goal.areanum = bs->lastenemyareanum;
ADDRLP4 136+12
ADDRFP4 4
INDIRP4
CNSTI4 6544
ADDP4
INDIRI4
ASGNI4
line 2744
;2744:		VectorCopy(bs->lastenemyorigin, goal.origin);
ADDRLP4 136
ADDRFP4 4
INDIRP4
CNSTI4 6548
ADDP4
INDIRB
ASGNB 12
line 2745
;2745:		VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 136+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 136+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 136+16+8
CNSTF4 3238002688
ASGNF4
line 2746
;2746:		VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 136+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 136+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 136+28+8
CNSTF4 1090519040
ASGNF4
line 2748
;2747:		//initialize the movement state
;2748:		BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2750
;2749:		//move towards the goal
;2750:		trap_BotMoveToGoal(&moveresult, bs->ms, &goal, tfl);
ADDRLP4 80
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 2751
;2751:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $764
JUMPV
LABELV $767
line 2754
;2752:	}
;2753:	//
;2754:	memset(&moveresult, 0, sizeof(bot_moveresult_t));
ADDRLP4 80
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2756
;2755:	//
;2756:	attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 348
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 132
ADDRLP4 348
INDIRF4
ASGNF4
line 2757
;2757:	jumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_JUMPER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 37
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 352
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 340
ADDRLP4 352
INDIRF4
ASGNF4
line 2758
;2758:	croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 36
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 356
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 344
ADDRLP4 356
INDIRF4
ASGNF4
line 2760
;2759:	//if the bot is really stupid
;2760:	if (attack_skill < 0.2) return moveresult;
ADDRLP4 132
INDIRF4
CNSTF4 1045220557
GEF4 $781
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $764
JUMPV
LABELV $781
line 2762
;2761:	//initialize the movement state
;2762:	BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2764
;2763:	//get the enemy entity info
;2764:	BotEntityInfo(attackentity, &entinfo);
ADDRLP4 332
INDIRI4
ARGI4
ADDRLP4 192
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2766
;2765:	//direction towards the enemy
;2766:	VectorSubtract(entinfo.origin, bs->origin, forward);
ADDRLP4 360
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 192+24
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 192+24+4
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 192+24+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2768
;2767:	//the distance towards the enemy
;2768:	dist = VectorNormalize(forward);
ADDRLP4 24
ARGP4
ADDRLP4 364
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 364
INDIRF4
ASGNF4
line 2769
;2769:	VectorNegate(forward, backward);
ADDRLP4 36
ADDRLP4 24
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 24+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 24+8
INDIRF4
NEGF4
ASGNF4
line 2771
;2770:	//walk, crouch or jump
;2771:	movetype = MOVE_WALK;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 2773
;2772:	//
;2773:	if (bs->attackcrouch_time < FloatTime() - 1) {
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $794
line 2774
;2774:		if (random() < jumper) {
ADDRLP4 368
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 340
INDIRF4
GEF4 $796
line 2775
;2775:			movetype = MOVE_JUMP;
ADDRLP4 52
CNSTI4 4
ASGNI4
line 2776
;2776:		}
ADDRGP4 $797
JUMPV
LABELV $796
line 2778
;2777:		//wait at least one second before crouching again
;2778:		else if (bs->attackcrouch_time < FloatTime() - 1 && random() < croucher) {
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $798
ADDRLP4 372
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 372
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 344
INDIRF4
GEF4 $798
line 2779
;2779:			bs->attackcrouch_time = FloatTime() + croucher * 5;
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDRLP4 344
INDIRF4
MULF4
ADDF4
ASGNF4
line 2780
;2780:		}
LABELV $798
LABELV $797
line 2781
;2781:	}
LABELV $794
line 2782
;2782:	if (bs->attackcrouch_time > FloatTime()) movetype = MOVE_CROUCH;
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $800
ADDRLP4 52
CNSTI4 2
ASGNI4
LABELV $800
line 2784
;2783:	//if the bot should jump
;2784:	if (movetype == MOVE_JUMP) {
ADDRLP4 52
INDIRI4
CNSTI4 4
NEI4 $802
line 2786
;2785:		//if jumped last frame
;2786:		if (bs->attackjump_time > FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 6128
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $804
line 2787
;2787:			movetype = MOVE_WALK;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 2788
;2788:		}
ADDRGP4 $805
JUMPV
LABELV $804
line 2789
;2789:		else {
line 2790
;2790:			bs->attackjump_time = FloatTime() + 1;
ADDRFP4 4
INDIRP4
CNSTI4 6128
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2791
;2791:		}
LABELV $805
line 2792
;2792:	}
LABELV $802
line 2793
;2793:	if( bs->cur_ps.weapon == WP_GAUNTLET ) 
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
NEI4 $806
line 2794
;2794:	{
line 2795
;2795:		attack_dist = 0;
ADDRLP4 72
CNSTF4 0
ASGNF4
line 2796
;2796:		attack_range = 0;
ADDRLP4 76
CNSTF4 0
ASGNF4
line 2797
;2797:	}
ADDRGP4 $807
JUMPV
LABELV $806
line 2798
;2798:	else if( bs->cur_ps.weapon == WP_LIGHTNING )
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 6
NEI4 $808
line 2799
;2799:	{ // They need to fire the flamethrower much closer to the enemy -Vincent
line 2800
;2800:		attack_dist = 30; // Preferred value
ADDRLP4 72
CNSTF4 1106247680
ASGNF4
line 2801
;2801:		attack_range = 45; // Maximum value
ADDRLP4 76
CNSTF4 1110704128
ASGNF4
line 2802
;2802:	}
ADDRGP4 $809
JUMPV
LABELV $808
line 2804
;2803:	else
;2804:	{
line 2805
;2805:		attack_dist = IDEAL_ATTACKDIST;
ADDRLP4 72
CNSTF4 1124859904
ASGNF4
line 2806
;2806:		attack_range = 40;
ADDRLP4 76
CNSTF4 1109393408
ASGNF4
line 2807
;2807:	}
LABELV $809
LABELV $807
line 2809
;2808:	//if the bot is stupid
;2809:	if (attack_skill <= 0.4) {
ADDRLP4 132
INDIRF4
CNSTF4 1053609165
GTF4 $810
line 2811
;2810:		//just walk to or away from the enemy
;2811:		if (dist > attack_dist + attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
LEF4 $812
line 2812
;2812:			if (trap_BotMoveInDirection(bs->ms, forward, 400, movetype)) return moveresult;
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 368
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $814
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $764
JUMPV
LABELV $814
line 2813
;2813:		}
LABELV $812
line 2814
;2814:		if (dist < attack_dist - attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
GEF4 $816
line 2815
;2815:			if (trap_BotMoveInDirection(bs->ms, backward, 400, movetype)) return moveresult;
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 368
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $818
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $764
JUMPV
LABELV $818
line 2816
;2816:		}
LABELV $816
line 2817
;2817:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $764
JUMPV
LABELV $810
line 2820
;2818:	}
;2819:	//increase the strafe time
;2820:	bs->attackstrafe_time += bs->thinktime;
ADDRLP4 368
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 372
ADDRLP4 368
INDIRP4
CNSTI4 6116
ADDP4
ASGNP4
ADDRLP4 372
INDIRP4
ADDRLP4 372
INDIRP4
INDIRF4
ADDRLP4 368
INDIRP4
CNSTI4 4904
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2822
;2821:	//get the strafe change time
;2822:	strafechange_time = 0.4 + (1 - attack_skill) * 0.2;
ADDRLP4 336
CNSTF4 1045220557
CNSTF4 1065353216
ADDRLP4 132
INDIRF4
SUBF4
MULF4
CNSTF4 1053609165
ADDF4
ASGNF4
line 2823
;2823:	if (attack_skill > 0.7) strafechange_time += crandom() * 0.2;
ADDRLP4 132
INDIRF4
CNSTF4 1060320051
LEF4 $820
ADDRLP4 376
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 336
ADDRLP4 336
INDIRF4
CNSTF4 1045220557
CNSTF4 1073741824
ADDRLP4 376
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ADDF4
ASGNF4
LABELV $820
line 2825
;2824:	//if the strafe direction should be changed
;2825:	if (bs->attackstrafe_time > strafechange_time) {
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
INDIRF4
ADDRLP4 336
INDIRF4
LEF4 $822
line 2827
;2826:		//some magic number :)
;2827:		if (random() > 0.935) {
ADDRLP4 380
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1064262697
LEF4 $824
line 2829
;2828:			//flip the strafe direction
;2829:			bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 384
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 384
INDIRP4
ADDRLP4 384
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2830
;2830:			bs->attackstrafe_time = 0;
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
CNSTF4 0
ASGNF4
line 2831
;2831:		}
LABELV $824
line 2832
;2832:	}
LABELV $822
line 2834
;2833:	//
;2834:	for (i = 0; i < 2; i++) {
ADDRLP4 48
CNSTI4 0
ASGNI4
LABELV $826
line 2835
;2835:		hordir[0] = forward[0];
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
line 2836
;2836:		hordir[1] = forward[1];
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ASGNF4
line 2837
;2837:		hordir[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 2838
;2838:		VectorNormalize(hordir);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2840
;2839:		//get the sideward vector
;2840:		CrossProduct(hordir, up, sideward);
ADDRLP4 12
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2842
;2841:		//reverse the vector depending on the strafe direction
;2842:		if (bs->flags & BFL_STRAFERIGHT) VectorNegate(sideward, sideward);
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $833
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
NEGF4
ASGNF4
LABELV $833
line 2844
;2843:		//randomly go back a little
;2844:		if (random() > 0.9) {
ADDRLP4 380
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1063675494
LEF4 $839
line 2845
;2845:			VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2846
;2846:		}
ADDRGP4 $840
JUMPV
LABELV $839
line 2847
;2847:		else {
line 2849
;2848:			//walk forward or backward to get at the ideal attack distance
;2849:			if (dist > attack_dist + attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
LEF4 $847
line 2850
;2850:				VectorAdd(sideward, forward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 2851
;2851:			}
ADDRGP4 $848
JUMPV
LABELV $847
line 2852
;2852:			else if (dist < attack_dist - attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
GEF4 $855
line 2853
;2853:				VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2854
;2854:			}
LABELV $855
LABELV $848
line 2855
;2855:		}
LABELV $840
line 2857
;2856:		//perform the movement
;2857:		if (trap_BotMoveInDirection(bs->ms, sideward, 400, movetype))
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 384
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 384
INDIRI4
CNSTI4 0
EQI4 $863
line 2858
;2858:			return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $764
JUMPV
LABELV $863
line 2860
;2859:		//movement failed, flip the strafe direction
;2860:		bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 388
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 388
INDIRP4
ADDRLP4 388
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2861
;2861:		bs->attackstrafe_time = 0;
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
CNSTF4 0
ASGNF4
line 2862
;2862:	}
LABELV $827
line 2834
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 2
LTI4 $826
line 2865
;2863:	//bot couldn't do any usefull movement
;2864://	bs->attackchase_time = AAS_Time() + 6;
;2865:	return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
LABELV $764
endproc BotAttackMove 392 16
export BotSameTeam
proc BotSameTeam 2072 12
line 2873
;2866:}
;2867:
;2868:/*
;2869:==================
;2870:BotSameTeam
;2871:==================
;2872:*/
;2873:int BotSameTeam(bot_state_t *bs, int entnum) {
line 2876
;2874:	char info1[1024], info2[1024];
;2875:
;2876:	if (bs->client < 0 || bs->client >= MAX_CLIENTS) {
ADDRLP4 2048
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 2048
INDIRI4
CNSTI4 0
LTI4 $868
ADDRLP4 2048
INDIRI4
CNSTI4 64
LTI4 $866
LABELV $868
line 2878
;2877:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;2878:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $865
JUMPV
LABELV $866
line 2880
;2879:	}
;2880:	if (entnum < 0 || entnum >= MAX_CLIENTS) {
ADDRLP4 2052
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 2052
INDIRI4
CNSTI4 0
LTI4 $871
ADDRLP4 2052
INDIRI4
CNSTI4 64
LTI4 $869
LABELV $871
line 2882
;2881:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;2882:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $865
JUMPV
LABELV $869
line 2884
;2883:	}
;2884:	if ( gametype >= GT_TEAM ) {
ADDRGP4 gametype
INDIRI4
CNSTI4 3
LTI4 $872
line 2885
;2885:		trap_GetConfigstring(CS_PLAYERS+bs->client, info1, sizeof(info1));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 2886
;2886:		trap_GetConfigstring(CS_PLAYERS+entnum, info2, sizeof(info2));
ADDRFP4 4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 2888
;2887:		//
;2888:		if (atoi(Info_ValueForKey(info1, "t")) == atoi(Info_ValueForKey(info2, "t"))) return qtrue;
ADDRLP4 0
ARGP4
ADDRGP4 $77
ARGP4
ADDRLP4 2056
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2056
INDIRP4
ARGP4
ADDRLP4 2060
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
ARGP4
ADDRGP4 $77
ARGP4
ADDRLP4 2064
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2064
INDIRP4
ARGP4
ADDRLP4 2068
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
ADDRLP4 2068
INDIRI4
NEI4 $874
CNSTI4 1
RETI4
ADDRGP4 $865
JUMPV
LABELV $874
line 2889
;2889:	}
LABELV $872
line 2890
;2890:	return qfalse;
CNSTI4 0
RETI4
LABELV $865
endproc BotSameTeam 2072 12
export InFieldOfVision
proc InFieldOfVision 24 4
line 2899
;2891:}
;2892:
;2893:/*
;2894:==================
;2895:InFieldOfVision
;2896:==================
;2897:*/
;2898:qboolean InFieldOfVision(vec3_t viewangles, float fov, vec3_t angles)
;2899:{
line 2903
;2900:	int i;
;2901:	float diff, angle;
;2902:
;2903:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $877
line 2904
;2904:		angle = AngleMod(viewangles[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
ASGNF4
line 2905
;2905:		angles[i] = AngleMod(angles[i]);
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRF4
ASGNF4
line 2906
;2906:		diff = angles[i] - angle;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 2907
;2907:		if (angles[i] > angle) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $881
line 2908
;2908:			if (diff > 180.0) diff -= 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 1127481344
LEF4 $882
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 2909
;2909:		}
ADDRGP4 $882
JUMPV
LABELV $881
line 2910
;2910:		else {
line 2911
;2911:			if (diff < -180.0) diff += 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 3274964992
GEF4 $885
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $885
line 2912
;2912:		}
LABELV $882
line 2913
;2913:		if (diff > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $887
line 2914
;2914:			if (diff > fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
ADDRFP4 4
INDIRF4
MULF4
LEF4 $888
CNSTI4 0
RETI4
ADDRGP4 $876
JUMPV
line 2915
;2915:		}
LABELV $887
line 2916
;2916:		else {
line 2917
;2917:			if (diff < -fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
ADDRFP4 4
INDIRF4
NEGF4
MULF4
GEF4 $891
CNSTI4 0
RETI4
ADDRGP4 $876
JUMPV
LABELV $891
line 2918
;2918:		}
LABELV $888
line 2919
;2919:	}
LABELV $878
line 2903
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $877
line 2920
;2920:	return qtrue;
CNSTI4 1
RETI4
LABELV $876
endproc InFieldOfVision 24 4
export BotEntityVisible
proc BotEntityVisible 376 28
line 2930
;2921:}
;2922:
;2923:/*
;2924:==================
;2925:BotEntityVisible
;2926:
;2927:returns visibility in the range [0, 1] taking fog and water surfaces into account
;2928:==================
;2929:*/
;2930:float BotEntityVisible(int viewer, vec3_t eye, vec3_t viewangles, float fov, int ent) {
line 2938
;2931:	int i, contents_mask, passent, hitent, infog, inwater, otherinfog, pc;
;2932:	float squaredfogdist, waterfactor, vis, bestvis;
;2933:	bsp_trace_t trace;
;2934:	aas_entityinfo_t entinfo;
;2935:	vec3_t dir, entangles, start, end, middle;
;2936:
;2937:	//calculate middle of bounding box
;2938:	BotEntityInfo(ent, &entinfo);
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2939
;2939:	VectorAdd(entinfo.mins, entinfo.maxs, middle);
ADDRLP4 84
ADDRLP4 148+72
INDIRF4
ADDRLP4 148+84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+72+4
INDIRF4
ADDRLP4 148+84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+72+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDF4
ASGNF4
line 2940
;2940:	VectorScale(middle, 0.5, middle);
ADDRLP4 332
CNSTF4 1056964608
ASGNF4
ADDRLP4 84
ADDRLP4 332
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 332
INDIRF4
ADDRLP4 84+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 84+8
CNSTF4 1056964608
ADDRLP4 84+8
INDIRF4
MULF4
ASGNF4
line 2941
;2941:	VectorAdd(entinfo.origin, middle, middle);
ADDRLP4 84
ADDRLP4 148+24
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+24+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+24+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 2943
;2942:	//check if entity is within field of vision
;2943:	VectorSubtract(middle, eye, dir);
ADDRLP4 336
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 84
INDIRF4
ADDRLP4 336
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 336
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 84+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2944
;2944:	vectoangles(dir, entangles);
ADDRLP4 136
ARGP4
ADDRLP4 320
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2945
;2945:	if (!InFieldOfVision(viewangles, fov, entangles)) return 0;
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 320
ARGP4
ADDRLP4 340
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 340
INDIRI4
CNSTI4 0
NEI4 $923
CNSTF4 0
RETF4
ADDRGP4 $893
JUMPV
LABELV $923
line 2947
;2946:	//
;2947:	pc = trap_AAS_PointContents(eye);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 344
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 316
ADDRLP4 344
INDIRI4
ASGNI4
line 2948
;2948:	infog = (pc & CONTENTS_FOG);
ADDRLP4 312
ADDRLP4 316
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 2949
;2949:	inwater = (pc & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER));
ADDRLP4 308
ADDRLP4 316
INDIRI4
CNSTI4 56
BANDI4
ASGNI4
line 2951
;2950:	//
;2951:	bestvis = 0;
ADDRLP4 296
CNSTF4 0
ASGNF4
line 2952
;2952:	for (i = 0; i < 3; i++) {
ADDRLP4 100
CNSTI4 0
ASGNI4
LABELV $925
line 2956
;2953:		//if the point is not in potential visible sight
;2954:		//if (!AAS_inPVS(eye, middle)) continue;
;2955:		//
;2956:		contents_mask = CONTENTS_SOLID|CONTENTS_PLAYERCLIP;
ADDRLP4 96
CNSTI4 65537
ASGNI4
line 2957
;2957:		passent = viewer;
ADDRLP4 116
ADDRFP4 0
INDIRI4
ASGNI4
line 2958
;2958:		hitent = ent;
ADDRLP4 132
ADDRFP4 16
INDIRI4
ASGNI4
line 2959
;2959:		VectorCopy(eye, start);
ADDRLP4 120
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2960
;2960:		VectorCopy(middle, end);
ADDRLP4 104
ADDRLP4 84
INDIRB
ASGNB 12
line 2962
;2961:		//if the entity is in water, lava or slime
;2962:		if (trap_AAS_PointContents(middle) & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
ADDRLP4 84
ARGP4
ADDRLP4 348
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $929
line 2963
;2963:			contents_mask |= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BORI4
ASGNI4
line 2964
;2964:		}
LABELV $929
line 2966
;2965:		//if eye is in water, lava or slime
;2966:		if (inwater) {
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $931
line 2967
;2967:			if (!(contents_mask & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER))) {
ADDRLP4 96
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $933
line 2968
;2968:				passent = ent;
ADDRLP4 116
ADDRFP4 16
INDIRI4
ASGNI4
line 2969
;2969:				hitent = viewer;
ADDRLP4 132
ADDRFP4 0
INDIRI4
ASGNI4
line 2970
;2970:				VectorCopy(middle, start);
ADDRLP4 120
ADDRLP4 84
INDIRB
ASGNB 12
line 2971
;2971:				VectorCopy(eye, end);
ADDRLP4 104
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2972
;2972:			}
LABELV $933
line 2973
;2973:			contents_mask ^= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BXORI4
ASGNI4
line 2974
;2974:		}
LABELV $931
line 2976
;2975:		//trace from start to end
;2976:		BotAI_Trace(&trace, start, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 120
ARGP4
ADDRLP4 352
CNSTP4 0
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2978
;2977:		//if water was hit
;2978:		waterfactor = 1.0;
ADDRLP4 288
CNSTF4 1065353216
ASGNF4
line 2979
;2979:		if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
ADDRLP4 0+76
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $935
line 2981
;2980:			//if the water surface is translucent
;2981:			if (1) {
line 2983
;2982:				//trace through the water
;2983:				contents_mask &= ~(CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 -57
BANDI4
ASGNI4
line 2984
;2984:				BotAI_Trace(&trace, trace.endpos, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 356
CNSTP4 0
ASGNP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2985
;2985:				waterfactor = 0.5;
ADDRLP4 288
CNSTF4 1056964608
ASGNF4
line 2986
;2986:			}
LABELV $938
line 2987
;2987:		}
LABELV $935
line 2989
;2988:		//if a full trace or the hitent was hit
;2989:		if (trace.fraction >= 1 || trace.ent == hitent) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $945
ADDRLP4 0+80
INDIRI4
ADDRLP4 132
INDIRI4
NEI4 $941
LABELV $945
line 2992
;2990:			//check for fog, assuming there's only one fog brush where
;2991:			//either the viewer or the entity is in or both are in
;2992:			otherinfog = (trap_AAS_PointContents(middle) & CONTENTS_FOG);
ADDRLP4 84
ARGP4
ADDRLP4 356
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 304
ADDRLP4 356
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 2993
;2993:			if (infog && otherinfog) {
ADDRLP4 360
CNSTI4 0
ASGNI4
ADDRLP4 312
INDIRI4
ADDRLP4 360
INDIRI4
EQI4 $946
ADDRLP4 304
INDIRI4
ADDRLP4 360
INDIRI4
EQI4 $946
line 2994
;2994:				VectorSubtract(trace.endpos, eye, dir);
ADDRLP4 364
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 0+12
INDIRF4
ADDRLP4 364
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 0+12+4
INDIRF4
ADDRLP4 364
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 0+12+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2995
;2995:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 368
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 368
INDIRF4
ASGNF4
line 2996
;2996:			}
ADDRGP4 $947
JUMPV
LABELV $946
line 2997
;2997:			else if (infog) {
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $955
line 2998
;2998:				VectorCopy(trace.endpos, start);
ADDRLP4 120
ADDRLP4 0+12
INDIRB
ASGNB 12
line 2999
;2999:				BotAI_Trace(&trace, start, NULL, NULL, eye, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRLP4 120
ARGP4
ADDRLP4 364
CNSTP4 0
ASGNP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3000
;3000:				VectorSubtract(eye, trace.endpos, dir);
ADDRLP4 368
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 368
INDIRP4
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 368
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 3001
;3001:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 372
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 372
INDIRF4
ASGNF4
line 3002
;3002:			}
ADDRGP4 $956
JUMPV
LABELV $955
line 3003
;3003:			else if (otherinfog) {
ADDRLP4 304
INDIRI4
CNSTI4 0
EQI4 $965
line 3004
;3004:				VectorCopy(trace.endpos, end);
ADDRLP4 104
ADDRLP4 0+12
INDIRB
ASGNB 12
line 3005
;3005:				BotAI_Trace(&trace, eye, NULL, NULL, end, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 364
CNSTP4 0
ASGNP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3006
;3006:				VectorSubtract(end, trace.endpos, dir);
ADDRLP4 136
ADDRLP4 104
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 104+4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 104+8
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 3007
;3007:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 368
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 368
INDIRF4
ASGNF4
line 3008
;3008:			}
ADDRGP4 $966
JUMPV
LABELV $965
line 3009
;3009:			else {
line 3011
;3010:				//if the entity and the viewer are not in fog assume there's no fog in between
;3011:				squaredfogdist = 0;
ADDRLP4 300
CNSTF4 0
ASGNF4
line 3012
;3012:			}
LABELV $966
LABELV $956
LABELV $947
line 3014
;3013:			//decrease visibility with the view distance through fog
;3014:			vis = 1 / ((squaredfogdist * 0.001) < 1 ? 1 : (squaredfogdist * 0.001));
ADDRLP4 368
CNSTF4 1065353216
ASGNF4
CNSTF4 981668463
ADDRLP4 300
INDIRF4
MULF4
ADDRLP4 368
INDIRF4
GEF4 $978
ADDRLP4 364
CNSTF4 1065353216
ASGNF4
ADDRGP4 $979
JUMPV
LABELV $978
ADDRLP4 364
CNSTF4 981668463
ADDRLP4 300
INDIRF4
MULF4
ASGNF4
LABELV $979
ADDRLP4 292
ADDRLP4 368
INDIRF4
ADDRLP4 364
INDIRF4
DIVF4
ASGNF4
line 3016
;3015:			//if entering water visibility is reduced
;3016:			vis *= waterfactor;
ADDRLP4 292
ADDRLP4 292
INDIRF4
ADDRLP4 288
INDIRF4
MULF4
ASGNF4
line 3018
;3017:			//
;3018:			if (vis > bestvis) bestvis = vis;
ADDRLP4 292
INDIRF4
ADDRLP4 296
INDIRF4
LEF4 $980
ADDRLP4 296
ADDRLP4 292
INDIRF4
ASGNF4
LABELV $980
line 3020
;3019:			//if pretty much no fog
;3020:			if (bestvis >= 0.95) return bestvis;
ADDRLP4 296
INDIRF4
CNSTF4 1064514355
LTF4 $982
ADDRLP4 296
INDIRF4
RETF4
ADDRGP4 $893
JUMPV
LABELV $982
line 3021
;3021:		}
LABELV $941
line 3023
;3022:		//check bottom and top of bounding box as well
;3023:		if (i == 0) middle[2] += entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $984
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
ADDF4
ASGNF4
ADDRGP4 $985
JUMPV
LABELV $984
line 3024
;3024:		else if (i == 1) middle[2] += entinfo.maxs[2] - entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $989
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
SUBF4
ADDF4
ASGNF4
LABELV $989
LABELV $985
line 3025
;3025:	}
LABELV $926
line 2952
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 3
LTI4 $925
line 3026
;3026:	return bestvis;
ADDRLP4 296
INDIRF4
RETF4
LABELV $893
endproc BotEntityVisible 376 28
export BotFindEnemy
proc BotFindEnemy 452 20
line 3034
;3027:}
;3028:
;3029:/*
;3030:==================
;3031:BotFindEnemy
;3032:==================
;3033:*/
;3034:int BotFindEnemy(bot_state_t *bs, int curenemy) {
line 3048
;3035:	int i, healthdecrease;
;3036:	float f, alertness, easyfragger, vis;
;3037:	float squaredist, cursquaredist;
;3038:	aas_entityinfo_t entinfo, curenemyinfo;
;3039:	vec3_t dir, angles;
;3040:	// Trep
;3041:		gentity_t	*e;
;3042:		int		c, c2;
;3043:
;3044://	int ent;
;3045://	entityState_t state;
;3046:	
;3047:
;3048:	alertness = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ALERTNESS, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 46
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 348
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 164
ADDRLP4 348
INDIRF4
ASGNF4
line 3049
;3049:	easyfragger = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_EASY_FRAGGER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 45
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 352
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 180
ADDRLP4 352
INDIRF4
ASGNF4
line 3051
;3050:	//check if the health decreased
;3051:	healthdecrease = bs->lasthealth > bs->inventory[INVENTORY_HEALTH];
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 360
INDIRP4
CNSTI4 5988
ADDP4
INDIRI4
ADDRLP4 360
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
LEI4 $998
ADDRLP4 356
CNSTI4 1
ASGNI4
ADDRGP4 $999
JUMPV
LABELV $998
ADDRLP4 356
CNSTI4 0
ASGNI4
LABELV $999
ADDRLP4 160
ADDRLP4 356
INDIRI4
ASGNI4
line 3053
;3052:	//remember the current health value
;3053:	bs->lasthealth = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 364
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 364
INDIRP4
CNSTI4 5988
ADDP4
ADDRLP4 364
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
ASGNI4
line 3055
;3054:	//
;3055:	if (curenemy >= 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1000
line 3056
;3056:		BotEntityInfo(curenemy, &curenemyinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 208
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3057
;3057:		if (EntityCarriesFlag(&curenemyinfo)) return qfalse;
ADDRLP4 208
ARGP4
ADDRLP4 368
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $1002
CNSTI4 0
RETI4
ADDRGP4 $996
JUMPV
LABELV $1002
line 3058
;3058:		VectorSubtract(curenemyinfo.origin, bs->origin, dir);
ADDRLP4 372
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 208+24
INDIRF4
ADDRLP4 372
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 208+24+4
INDIRF4
ADDRLP4 372
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 208+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3059
;3059:		cursquaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 376
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 196
ADDRLP4 376
INDIRF4
ASGNF4
line 3060
;3060:	}
ADDRGP4 $1001
JUMPV
LABELV $1000
line 3061
;3061:	else {
line 3062
;3062:		cursquaredist = 0;
ADDRLP4 196
CNSTF4 0
ASGNF4
line 3063
;3063:	}
LABELV $1001
line 3097
;3064:
;3065:	
;3066:
;3067:
;3068:
;3069:#ifdef MISSIONPACK
;3070:	if (gametype == GT_OBELISK) {
;3071:		vec3_t target;
;3072:		bot_goal_t *goal;
;3073:		bsp_trace_t trace;
;3074:
;3075:		if (BotTeam(bs) == TEAM_RED)
;3076:			goal = &blueobelisk;
;3077:		else
;3078:			goal = &redobelisk;
;3079:		//if the obelisk is visible
;3080:		VectorCopy(goal->origin, target);
;3081:		target[2] += 1;
;3082:		BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;3083:		if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;3084:			if (goal->entitynum == bs->enemy) {
;3085:				return qfalse;
;3086:			}
;3087:			bs->enemy = goal->entitynum;
;3088:			bs->enemysight_time = FloatTime();
;3089:			bs->enemysuicide = qfalse;
;3090:			bs->enemydeath_time = 0;
;3091:			bs->enemyvisible_time = FloatTime();
;3092:			return qtrue;
;3093:		}
;3094:	}
;3095:#endif
;3096:	//
;3097:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $1014
JUMPV
LABELV $1011
line 3099
;3098:
;3099:		if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1015
ADDRGP4 $1012
JUMPV
LABELV $1015
line 3101
;3100:		//if it's the current enemy
;3101:		if (i == curenemy) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1017
ADDRGP4 $1012
JUMPV
LABELV $1017
line 3103
;3102:		//
;3103:		BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3105
;3104:		//
;3105:		if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1019
ADDRGP4 $1012
JUMPV
LABELV $1019
line 3107
;3106:		//if the enemy isn't dead and the enemy isn't the bot self
;3107:		if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 368
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
NEI4 $1024
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $1021
LABELV $1024
ADDRGP4 $1012
JUMPV
LABELV $1021
line 3109
;3108:		//if the enemy is invisible and not shooting
;3109:		if (EntityIsInvisible(&entinfo) && !EntityIsShooting(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 372
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 372
INDIRI4
CNSTI4 0
EQI4 $1025
ADDRLP4 0
ARGP4
ADDRLP4 376
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 376
INDIRI4
CNSTI4 0
NEI4 $1025
line 3110
;3110:			continue;
ADDRGP4 $1012
JUMPV
LABELV $1025
line 3114
;3111:		}
;3112://unlagged - misc
;3113:		// this has nothing to do with lag compensation, but it's great for testing
;3114:		if ( g_entities[i].flags & FL_NOTARGET ) continue;
CNSTI4 924
ADDRLP4 140
INDIRI4
MULI4
ADDRGP4 g_entities+544
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1027
ADDRGP4 $1012
JUMPV
LABELV $1027
line 3117
;3115://unlagged - misc
;3116:		//if not an easy fragger don't shoot at chatting players
;3117:		if (easyfragger < 0.5 && EntityIsChatting(&entinfo)) continue;
ADDRLP4 180
INDIRF4
CNSTF4 1056964608
GEF4 $1030
ADDRLP4 0
ARGP4
ADDRLP4 380
ADDRGP4 EntityIsChatting
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 0
EQI4 $1030
ADDRGP4 $1012
JUMPV
LABELV $1030
line 3119
;3118:		//
;3119:		if (lastteleport_time > FloatTime() - 3) {
ADDRGP4 lastteleport_time
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
LEF4 $1032
line 3120
;3120:			VectorSubtract(entinfo.origin, lastteleport_origin, dir);
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRGP4 lastteleport_origin
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRGP4 lastteleport_origin+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRGP4 lastteleport_origin+8
INDIRF4
SUBF4
ASGNF4
line 3121
;3121:			if (VectorLengthSquared(dir) < Square(70)) continue;
ADDRLP4 144
ARGP4
ADDRLP4 384
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 384
INDIRF4
CNSTF4 1167663104
GEF4 $1043
ADDRGP4 $1012
JUMPV
LABELV $1043
line 3122
;3122:		}
LABELV $1032
line 3124
;3123:		//calculate the distance towards the enemy
;3124:		VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 384
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRLP4 384
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 384
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3125
;3125:		squaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 388
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 388
INDIRF4
ASGNF4
line 3127
;3126:		//if this entity is not carrying a flag
;3127:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 392
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 392
INDIRI4
CNSTI4 0
NEI4 $1052
line 3128
;3128:		{
line 3130
;3129:			//if this enemy is further away than the current one
;3130:			if (curenemy >= 0 && squaredist > cursquaredist) continue;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1054
ADDRLP4 156
INDIRF4
ADDRLP4 196
INDIRF4
LEF4 $1054
ADDRGP4 $1012
JUMPV
LABELV $1054
line 3131
;3131:		} //end if
LABELV $1052
line 3133
;3132:		//if the bot has no
;3133:		if (squaredist > Square(900.0 + alertness * 4000.0)) continue;
ADDRLP4 396
CNSTF4 1165623296
ADDRLP4 164
INDIRF4
MULF4
CNSTF4 1147207680
ADDF4
ASGNF4
ADDRLP4 156
INDIRF4
ADDRLP4 396
INDIRF4
ADDRLP4 396
INDIRF4
MULF4
LEF4 $1056
ADDRGP4 $1012
JUMPV
LABELV $1056
line 3135
;3134:		//if on the same team
;3135:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 400
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 400
INDIRI4
CNSTI4 0
EQI4 $1058
ADDRGP4 $1012
JUMPV
LABELV $1058
line 3137
;3136:		//if the bot's health decreased or the enemy is shooting
;3137:		if (curenemy < 0 && (healthdecrease || EntityIsShooting(&entinfo)))
ADDRLP4 404
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 404
INDIRI4
GEI4 $1060
ADDRLP4 160
INDIRI4
ADDRLP4 404
INDIRI4
NEI4 $1062
ADDRLP4 0
ARGP4
ADDRLP4 408
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 408
INDIRI4
CNSTI4 0
EQI4 $1060
LABELV $1062
line 3138
;3138:			f = 360;
ADDRLP4 168
CNSTF4 1135869952
ASGNF4
ADDRGP4 $1061
JUMPV
LABELV $1060
line 3140
;3139:		else
;3140:			f = 90 + 90 - (90 - (squaredist > Square(810) ? Square(810) : squaredist) / (810 * 9));
ADDRLP4 156
INDIRF4
CNSTF4 1226845760
LEF4 $1064
ADDRLP4 412
CNSTF4 1226845760
ASGNF4
ADDRGP4 $1065
JUMPV
LABELV $1064
ADDRLP4 412
ADDRLP4 156
INDIRF4
ASGNF4
LABELV $1065
ADDRLP4 168
CNSTF4 1127481344
CNSTF4 1119092736
ADDRLP4 412
INDIRF4
CNSTF4 1172557824
DIVF4
SUBF4
SUBF4
ASGNF4
LABELV $1061
line 3142
;3141:		//check if the enemy is visible
;3142:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, f, i);
ADDRLP4 416
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 416
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 416
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 416
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 168
INDIRF4
ARGF4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 420
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 172
ADDRLP4 420
INDIRF4
ASGNF4
line 3143
;3143:		if (vis <= 0) continue;
ADDRLP4 172
INDIRF4
CNSTF4 0
GTF4 $1066
ADDRGP4 $1012
JUMPV
LABELV $1066
line 3145
;3144:		//if the enemy is quite far away, not shooting and the bot is not damaged
;3145:		if (curenemy < 0 && squaredist > Square(100) && !healthdecrease && !EntityIsShooting(&entinfo))
ADDRLP4 424
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 424
INDIRI4
GEI4 $1068
ADDRLP4 156
INDIRF4
CNSTF4 1176256512
LEF4 $1068
ADDRLP4 160
INDIRI4
ADDRLP4 424
INDIRI4
NEI4 $1068
ADDRLP4 0
ARGP4
ADDRLP4 428
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 428
INDIRI4
CNSTI4 0
NEI4 $1068
line 3146
;3146:		{
line 3148
;3147:			//check if we can avoid this enemy
;3148:			VectorSubtract(bs->origin, entinfo.origin, dir);
ADDRLP4 432
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 432
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 432
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+24+8
INDIRF4
SUBF4
ASGNF4
line 3149
;3149:			vectoangles(dir, angles);
ADDRLP4 144
ARGP4
ADDRLP4 184
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3151
;3150:			//if the bot isn't in the fov of the enemy
;3151:			if (!InFieldOfVision(entinfo.angles, 90, angles)) {
ADDRLP4 0+36
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 184
ARGP4
ADDRLP4 436
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 436
INDIRI4
CNSTI4 0
NEI4 $1077
line 3153
;3152:				//update some stuff for this enemy
;3153:				BotUpdateBattleInventory(bs, i);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 3155
;3154:				//if the bot doesn't really want to fight
;3155:				if (BotWantsToRetreat(bs)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 440
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 440
INDIRI4
CNSTI4 0
EQI4 $1080
ADDRGP4 $1012
JUMPV
LABELV $1080
line 3156
;3156:			}
LABELV $1077
line 3157
;3157:		}
LABELV $1068
line 3159
;3158:		//found an enemy
;3159:		bs->enemy = entinfo.number;
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
ADDRLP4 0+20
INDIRI4
ASGNI4
line 3160
;3160:		if (curenemy >= 0) bs->enemysight_time = FloatTime() - 2;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1083
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
ADDRGP4 $1084
JUMPV
LABELV $1083
line 3161
;3161:		else bs->enemysight_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $1084
line 3162
;3162:		bs->enemysuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTI4 0
ASGNI4
line 3163
;3163:		bs->enemydeath_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6136
ADDP4
CNSTF4 0
ASGNF4
line 3164
;3164:		bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3165
;3165:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $996
JUMPV
LABELV $1012
line 3097
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1014
ADDRLP4 140
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1085
ADDRLP4 140
INDIRI4
CNSTI4 64
LTI4 $1011
LABELV $1085
line 3169
;3166:	}
;3167:
;3168:	// Trepidation Gametype - An enemy is also a buildable
;3169:	if (g_GameMode.integer == 3 && curenemy == 0)
ADDRGP4 g_GameMode+12
INDIRI4
CNSTI4 3
NEI4 $1086
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $1086
line 3170
;3170:	{
line 3171
;3171:		c = 0;
ADDRLP4 200
CNSTI4 0
ASGNI4
line 3172
;3172:		c2 = 0;
ADDRLP4 204
CNSTI4 0
ASGNI4
line 3173
;3173:		for ( i=1, e=g_entities+i ; i < level.num_entities ; i++,e++ )
ADDRLP4 140
CNSTI4 1
ASGNI4
ADDRLP4 176
CNSTI4 924
ADDRLP4 140
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
ADDRGP4 $1092
JUMPV
LABELV $1089
line 3174
;3174:		{
line 3176
;3175:
;3176:			if (e->s.eType == ET_BUILDABLE && e->s.team != BotTeam(bs))
ADDRLP4 176
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
NEI4 $1094
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 376
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 176
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 376
INDIRI4
EQI4 $1094
line 3177
;3177:			{
line 3180
;3178:				
;3179:				
;3180:				if (i == curenemy) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1096
ADDRGP4 $1090
JUMPV
LABELV $1096
line 3182
;3181:				//
;3182:				BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3184
;3183:				//
;3184:				if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1098
ADDRGP4 $1090
JUMPV
LABELV $1098
line 3186
;3185:				//if the enemy isn't dead and the enemy isn't the bot self
;3186:				if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 380
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 0
NEI4 $1103
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $1100
LABELV $1103
ADDRGP4 $1090
JUMPV
LABELV $1100
line 3188
;3187:				//if the enemy is invisible and not shooting
;3188:				if (EntityIsInvisible(&entinfo) && !EntityIsShooting(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 384
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 384
INDIRI4
CNSTI4 0
EQI4 $1104
ADDRLP4 0
ARGP4
ADDRLP4 388
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 388
INDIRI4
CNSTI4 0
NEI4 $1104
line 3189
;3189:					continue;
ADDRGP4 $1090
JUMPV
LABELV $1104
line 3193
;3190:				}
;3191:		//unlagged - misc
;3192:				// this has nothing to do with lag compensation, but it's great for testing
;3193:				if ( g_entities[i].flags & FL_NOTARGET ) continue;
CNSTI4 924
ADDRLP4 140
INDIRI4
MULI4
ADDRGP4 g_entities+544
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1106
ADDRGP4 $1090
JUMPV
LABELV $1106
line 3196
;3194:		//unlagged - misc
;3195:				//if not an easy fragger don't shoot at chatting players
;3196:				if (easyfragger < 0.5 && EntityIsChatting(&entinfo)) continue;
ADDRLP4 180
INDIRF4
CNSTF4 1056964608
GEF4 $1109
ADDRLP4 0
ARGP4
ADDRLP4 392
ADDRGP4 EntityIsChatting
CALLI4
ASGNI4
ADDRLP4 392
INDIRI4
CNSTI4 0
EQI4 $1109
ADDRGP4 $1090
JUMPV
LABELV $1109
line 3198
;3197:				//
;3198:				if (lastteleport_time > FloatTime() - 3) {
ADDRGP4 lastteleport_time
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
LEF4 $1111
line 3199
;3199:					VectorSubtract(entinfo.origin, lastteleport_origin, dir);
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRGP4 lastteleport_origin
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRGP4 lastteleport_origin+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRGP4 lastteleport_origin+8
INDIRF4
SUBF4
ASGNF4
line 3200
;3200:					if (VectorLengthSquared(dir) < Square(70)) continue;
ADDRLP4 144
ARGP4
ADDRLP4 396
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 396
INDIRF4
CNSTF4 1167663104
GEF4 $1122
ADDRGP4 $1090
JUMPV
LABELV $1122
line 3201
;3201:				}
LABELV $1111
line 3203
;3202:				//calculate the distance towards the enemy
;3203:				VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 396
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRLP4 396
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 396
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3204
;3204:				squaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 400
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 400
INDIRF4
ASGNF4
line 3206
;3205:				//if this entity is not carrying a flag
;3206:				if (!EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 404
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 404
INDIRI4
CNSTI4 0
NEI4 $1131
line 3207
;3207:				{
line 3209
;3208:					//if this enemy is further away than the current one
;3209:					if (curenemy >= 0 && squaredist > cursquaredist) continue;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1133
ADDRLP4 156
INDIRF4
ADDRLP4 196
INDIRF4
LEF4 $1133
ADDRGP4 $1090
JUMPV
LABELV $1133
line 3210
;3210:				} //end if
LABELV $1131
line 3212
;3211:				//if the bot has no
;3212:				if (squaredist > Square(900.0 + alertness * 4000.0)) continue;
ADDRLP4 408
CNSTF4 1165623296
ADDRLP4 164
INDIRF4
MULF4
CNSTF4 1147207680
ADDF4
ASGNF4
ADDRLP4 156
INDIRF4
ADDRLP4 408
INDIRF4
ADDRLP4 408
INDIRF4
MULF4
LEF4 $1135
ADDRGP4 $1090
JUMPV
LABELV $1135
line 3216
;3213:				//if on the same team
;3214:				//if (BotSameTeam(bs, i)) continue;
;3215:				//if the bot's health decreased or the enemy is shooting
;3216:				if (curenemy < 0 && (healthdecrease || EntityIsShooting(&entinfo)))
ADDRLP4 412
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 412
INDIRI4
GEI4 $1137
ADDRLP4 160
INDIRI4
ADDRLP4 412
INDIRI4
NEI4 $1139
ADDRLP4 0
ARGP4
ADDRLP4 416
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 416
INDIRI4
CNSTI4 0
EQI4 $1137
LABELV $1139
line 3217
;3217:					f = 360;
ADDRLP4 168
CNSTF4 1135869952
ASGNF4
ADDRGP4 $1138
JUMPV
LABELV $1137
line 3219
;3218:				else
;3219:					f = 90 + 90 - (90 - (squaredist > Square(810) ? Square(810) : squaredist) / (810 * 9));
ADDRLP4 156
INDIRF4
CNSTF4 1226845760
LEF4 $1141
ADDRLP4 420
CNSTF4 1226845760
ASGNF4
ADDRGP4 $1142
JUMPV
LABELV $1141
ADDRLP4 420
ADDRLP4 156
INDIRF4
ASGNF4
LABELV $1142
ADDRLP4 168
CNSTF4 1127481344
CNSTF4 1119092736
ADDRLP4 420
INDIRF4
CNSTF4 1172557824
DIVF4
SUBF4
SUBF4
ASGNF4
LABELV $1138
line 3221
;3220:				//check if the enemy is visible
;3221:				vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, f, i);
ADDRLP4 424
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 424
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 424
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 424
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 168
INDIRF4
ARGF4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 428
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 172
ADDRLP4 428
INDIRF4
ASGNF4
line 3222
;3222:				if (vis <= 0) continue;
ADDRLP4 172
INDIRF4
CNSTF4 0
GTF4 $1143
ADDRGP4 $1090
JUMPV
LABELV $1143
line 3224
;3223:				//if the enemy is quite far away, not shooting and the bot is not damaged
;3224:				if (curenemy < 0 && squaredist > Square(100) && !healthdecrease && !EntityIsShooting(&entinfo))
ADDRLP4 432
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 432
INDIRI4
GEI4 $1145
ADDRLP4 156
INDIRF4
CNSTF4 1176256512
LEF4 $1145
ADDRLP4 160
INDIRI4
ADDRLP4 432
INDIRI4
NEI4 $1145
ADDRLP4 0
ARGP4
ADDRLP4 436
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 436
INDIRI4
CNSTI4 0
NEI4 $1145
line 3225
;3225:				{
line 3227
;3226:					//check if we can avoid this enemy
;3227:					VectorSubtract(bs->origin, entinfo.origin, dir);
ADDRLP4 440
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 440
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 440
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+24+8
INDIRF4
SUBF4
ASGNF4
line 3228
;3228:					vectoangles(dir, angles);
ADDRLP4 144
ARGP4
ADDRLP4 184
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3230
;3229:					//if the bot isn't in the fov of the enemy
;3230:					if (!InFieldOfVision(entinfo.angles, 90, angles)) {
ADDRLP4 0+36
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 184
ARGP4
ADDRLP4 444
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 444
INDIRI4
CNSTI4 0
NEI4 $1154
line 3232
;3231:						//update some stuff for this enemy
;3232:						BotUpdateBattleInventory(bs, i);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 3234
;3233:						//if the bot doesn't really want to fight
;3234:						if (BotWantsToRetreat(bs)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 448
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 448
INDIRI4
CNSTI4 0
EQI4 $1157
ADDRGP4 $1090
JUMPV
LABELV $1157
line 3235
;3235:					}
LABELV $1154
line 3236
;3236:				}
LABELV $1145
line 3238
;3237:				//found an enemy
;3238:				bs->enemy = entinfo.number;
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
ADDRLP4 0+20
INDIRI4
ASGNI4
line 3239
;3239:				if (curenemy >= 0) bs->enemysight_time = FloatTime() - 2;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1160
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
ADDRGP4 $1161
JUMPV
LABELV $1160
line 3240
;3240:				else bs->enemysight_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $1161
line 3241
;3241:				bs->enemysuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTI4 0
ASGNI4
line 3242
;3242:				bs->enemydeath_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6136
ADDP4
CNSTF4 0
ASGNF4
line 3243
;3243:				bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3244
;3244:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $996
JUMPV
LABELV $1094
line 3263
;3245:				
;3246:
;3247:
;3248:
;3249:				/*
;3250:				entinfo.number = i;
;3251:				BotEntityInfo(i, &entinfo);
;3252:				bs->enemy = entinfo.number;
;3253:				if (curenemy >= 0) bs->enemysight_time = FloatTime() - 2;
;3254:				else bs->enemysight_time = FloatTime();
;3255:				bs->enemysuicide = qfalse;
;3256:				bs->enemydeath_time = 0;
;3257:				bs->enemyvisible_time = FloatTime();
;3258:				return qtrue;
;3259:				*/
;3260:
;3261:			}
;3262:
;3263:			c++;
ADDRLP4 200
ADDRLP4 200
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3264
;3264:			c2++;	
ADDRLP4 204
ADDRLP4 204
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3266
;3265:		
;3266:		}
LABELV $1090
line 3173
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 176
ADDRLP4 176
INDIRP4
CNSTI4 924
ADDP4
ASGNP4
LABELV $1092
ADDRLP4 140
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $1089
line 3268
;3267:
;3268:	}
LABELV $1086
line 3272
;3269:
;3270:
;3271:
;3272:	return qfalse;
CNSTI4 0
RETI4
LABELV $996
endproc BotFindEnemy 452 20
export BotTeamFlagCarrierVisible
proc BotTeamFlagCarrierVisible 164 20
line 3280
;3273:}
;3274:
;3275:/*
;3276:==================
;3277:BotTeamFlagCarrierVisible
;3278:==================
;3279:*/
;3280:int BotTeamFlagCarrierVisible(bot_state_t *bs) {
line 3285
;3281:	int i;
;3282:	float vis;
;3283:	aas_entityinfo_t entinfo;
;3284:
;3285:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1166
JUMPV
LABELV $1163
line 3286
;3286:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1167
line 3287
;3287:			continue;
ADDRGP4 $1164
JUMPV
LABELV $1167
line 3289
;3288:		//
;3289:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3291
;3290:		//if this player is active
;3291:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1169
line 3292
;3292:			continue;
ADDRGP4 $1164
JUMPV
LABELV $1169
line 3294
;3293:		//if this player is carrying a flag
;3294:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1171
line 3295
;3295:			continue;
ADDRGP4 $1164
JUMPV
LABELV $1171
line 3297
;3296:		//if the flag carrier is not on the same team
;3297:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $1173
line 3298
;3298:			continue;
ADDRGP4 $1164
JUMPV
LABELV $1173
line 3300
;3299:		//if the flag carrier is not visible
;3300:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3301
;3301:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1175
line 3302
;3302:			continue;
ADDRGP4 $1164
JUMPV
LABELV $1175
line 3304
;3303:		//
;3304:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1162
JUMPV
LABELV $1164
line 3285
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1166
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1177
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1163
LABELV $1177
line 3306
;3305:	}
;3306:	return -1;
CNSTI4 -1
RETI4
LABELV $1162
endproc BotTeamFlagCarrierVisible 164 20
export BotTeamFlagCarrier
proc BotTeamFlagCarrier 152 8
line 3314
;3307:}
;3308:
;3309:/*
;3310:==================
;3311:BotTeamFlagCarrier
;3312:==================
;3313:*/
;3314:int BotTeamFlagCarrier(bot_state_t *bs) {
line 3318
;3315:	int i;
;3316:	aas_entityinfo_t entinfo;
;3317:
;3318:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1182
JUMPV
LABELV $1179
line 3319
;3319:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1183
line 3320
;3320:			continue;
ADDRGP4 $1180
JUMPV
LABELV $1183
line 3322
;3321:		//
;3322:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3324
;3323:		//if this player is active
;3324:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1185
line 3325
;3325:			continue;
ADDRGP4 $1180
JUMPV
LABELV $1185
line 3327
;3326:		//if this player is carrying a flag
;3327:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $1187
line 3328
;3328:			continue;
ADDRGP4 $1180
JUMPV
LABELV $1187
line 3330
;3329:		//if the flag carrier is not on the same team
;3330:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1189
line 3331
;3331:			continue;
ADDRGP4 $1180
JUMPV
LABELV $1189
line 3333
;3332:		//
;3333:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1178
JUMPV
LABELV $1180
line 3318
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1182
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1191
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1179
LABELV $1191
line 3335
;3334:	}
;3335:	return -1;
CNSTI4 -1
RETI4
LABELV $1178
endproc BotTeamFlagCarrier 152 8
export BotEnemyFlagCarrierVisible
proc BotEnemyFlagCarrierVisible 164 20
line 3343
;3336:}
;3337:
;3338:/*
;3339:==================
;3340:BotEnemyFlagCarrierVisible
;3341:==================
;3342:*/
;3343:int BotEnemyFlagCarrierVisible(bot_state_t *bs) {
line 3348
;3344:	int i;
;3345:	float vis;
;3346:	aas_entityinfo_t entinfo;
;3347:
;3348:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1196
JUMPV
LABELV $1193
line 3349
;3349:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1197
line 3350
;3350:			continue;
ADDRGP4 $1194
JUMPV
LABELV $1197
line 3352
;3351:		//
;3352:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3354
;3353:		//if this player is active
;3354:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1199
line 3355
;3355:			continue;
ADDRGP4 $1194
JUMPV
LABELV $1199
line 3357
;3356:		//if this player is carrying a flag
;3357:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1201
line 3358
;3358:			continue;
ADDRGP4 $1194
JUMPV
LABELV $1201
line 3360
;3359:		//if the flag carrier is on the same team
;3360:		if (BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1203
line 3361
;3361:			continue;
ADDRGP4 $1194
JUMPV
LABELV $1203
line 3363
;3362:		//if the flag carrier is not visible
;3363:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3364
;3364:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1205
line 3365
;3365:			continue;
ADDRGP4 $1194
JUMPV
LABELV $1205
line 3367
;3366:		//
;3367:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1192
JUMPV
LABELV $1194
line 3348
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1196
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1207
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1193
LABELV $1207
line 3369
;3368:	}
;3369:	return -1;
CNSTI4 -1
RETI4
LABELV $1192
endproc BotEnemyFlagCarrierVisible 164 20
export BotVisibleTeamMatesAndEnemies
proc BotVisibleTeamMatesAndEnemies 192 20
line 3377
;3370:}
;3371:
;3372:/*
;3373:==================
;3374:BotVisibleTeamMatesAndEnemies
;3375:==================
;3376:*/
;3377:void BotVisibleTeamMatesAndEnemies(bot_state_t *bs, int *teammates, int *enemies, float range) {
line 3383
;3378:	int i;
;3379:	float vis;
;3380:	aas_entityinfo_t entinfo;
;3381:	vec3_t dir;
;3382:
;3383:	if (teammates)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1209
line 3384
;3384:		*teammates = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1209
line 3385
;3385:	if (enemies)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1211
line 3386
;3386:		*enemies = 0;
ADDRFP4 8
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1211
line 3387
;3387:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1216
JUMPV
LABELV $1213
line 3388
;3388:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1217
line 3389
;3389:			continue;
ADDRGP4 $1214
JUMPV
LABELV $1217
line 3391
;3390:		//
;3391:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3393
;3392:		//if this player is active
;3393:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1219
line 3394
;3394:			continue;
ADDRGP4 $1214
JUMPV
LABELV $1219
line 3396
;3395:		//if this player is carrying a flag
;3396:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 160
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1221
line 3397
;3397:			continue;
ADDRGP4 $1214
JUMPV
LABELV $1221
line 3399
;3398:		//if not within range
;3399:		VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 4+24
INDIRF4
ADDRLP4 164
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 4+24+4
INDIRF4
ADDRLP4 164
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 4+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3400
;3400:		if (VectorLengthSquared(dir) > Square(range))
ADDRLP4 144
ARGP4
ADDRLP4 168
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 172
ADDRFP4 12
INDIRF4
ASGNF4
ADDRLP4 168
INDIRF4
ADDRLP4 172
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
LEF4 $1230
line 3401
;3401:			continue;
ADDRGP4 $1214
JUMPV
LABELV $1230
line 3403
;3402:		//if the flag carrier is not visible
;3403:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 176
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 180
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 180
INDIRF4
ASGNF4
line 3404
;3404:		if (vis <= 0)
ADDRLP4 156
INDIRF4
CNSTF4 0
GTF4 $1232
line 3405
;3405:			continue;
ADDRGP4 $1214
JUMPV
LABELV $1232
line 3407
;3406:		//if the flag carrier is on the same team
;3407:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 184
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $1234
line 3408
;3408:			if (teammates)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1235
line 3409
;3409:				(*teammates)++;
ADDRLP4 188
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3410
;3410:		}
ADDRGP4 $1235
JUMPV
LABELV $1234
line 3411
;3411:		else {
line 3412
;3412:			if (enemies)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1238
line 3413
;3413:				(*enemies)++;
ADDRLP4 188
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1238
line 3414
;3414:		}
LABELV $1235
line 3415
;3415:	}
LABELV $1214
line 3387
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1216
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1240
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1213
LABELV $1240
line 3416
;3416:}
LABELV $1208
endproc BotVisibleTeamMatesAndEnemies 192 20
lit
align 4
LABELV $1242
byte 4 3229614080
byte 4 3229614080
byte 4 3229614080
align 4
LABELV $1243
byte 4 1082130432
byte 4 1082130432
byte 4 1082130432
export BotAimAtEnemy
code
proc BotAimAtEnemy 1144 52
line 3487
;3417:
;3418:#ifdef MISSIONPACK
;3419:/*
;3420:==================
;3421:BotTeamCubeCarrierVisible
;3422:==================
;3423:*/
;3424:int BotTeamCubeCarrierVisible(bot_state_t *bs) {
;3425:	int i;
;3426:	float vis;
;3427:	aas_entityinfo_t entinfo;
;3428:
;3429:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
;3430:		if (i == bs->client) continue;
;3431:		//
;3432:		BotEntityInfo(i, &entinfo);
;3433:		//if this player is active
;3434:		if (!entinfo.valid) continue;
;3435:		//if this player is carrying a flag
;3436:		if (!EntityCarriesCubes(&entinfo)) continue;
;3437:		//if the flag carrier is not on the same team
;3438:		if (!BotSameTeam(bs, i)) continue;
;3439:		//if the flag carrier is not visible
;3440:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
;3441:		if (vis <= 0) continue;
;3442:		//
;3443:		return i;
;3444:	}
;3445:	return -1;
;3446:}
;3447:
;3448:/*
;3449:==================
;3450:BotEnemyCubeCarrierVisible
;3451:==================
;3452:*/
;3453:int BotEnemyCubeCarrierVisible(bot_state_t *bs) {
;3454:	int i;
;3455:	float vis;
;3456:	aas_entityinfo_t entinfo;
;3457:
;3458:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
;3459:		if (i == bs->client)
;3460:			continue;
;3461:		//
;3462:		BotEntityInfo(i, &entinfo);
;3463:		//if this player is active
;3464:		if (!entinfo.valid)
;3465:			continue;
;3466:		//if this player is carrying a flag
;3467:		if (!EntityCarriesCubes(&entinfo)) continue;
;3468:		//if the flag carrier is on the same team
;3469:		if (BotSameTeam(bs, i))
;3470:			continue;
;3471:		//if the flag carrier is not visible
;3472:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
;3473:		if (vis <= 0)
;3474:			continue;
;3475:		//
;3476:		return i;
;3477:	}
;3478:	return -1;
;3479:}
;3480:#endif
;3481:
;3482:/*
;3483:==================
;3484:BotAimAtEnemy
;3485:==================
;3486:*/
;3487:void BotAimAtEnemy(bot_state_t *bs) {
line 3491
;3488:	int i, enemyvisible;
;3489:	float dist, f, aim_skill, aim_accuracy, speed, reactiontime;
;3490:	vec3_t dir, bestorigin, end, start, groundtarget, cmdmove, enemyvelocity;
;3491:	vec3_t mins = {-4,-4,-4}, maxs = {4, 4, 4};
ADDRLP4 860
ADDRGP4 $1242
INDIRB
ASGNB 12
ADDRLP4 872
ADDRGP4 $1243
INDIRB
ASGNB 12
line 3499
;3492:	weaponinfo_t wi;
;3493:	aas_entityinfo_t entinfo;
;3494:	bot_goal_t goal;
;3495:	bsp_trace_t trace;
;3496:	vec3_t target;
;3497:
;3498:	//if the bot has no enemy
;3499:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1244
line 3500
;3500:		return;
ADDRGP4 $1241
JUMPV
LABELV $1244
line 3503
;3501:	}
;3502:	//get the enemy entity information
;3503:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3505
;3504:	//if this is not a player (should be an obelisk)
;3505:	if (bs->enemy >= MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1246
line 3507
;3506:		//if the obelisk is visible
;3507:		VectorCopy(entinfo.origin, target);
ADDRLP4 828
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3516
;3508:#ifdef MISSIONPACK
;3509:		// if attacking an obelisk
;3510:		if ( bs->enemy == redobelisk.entitynum ||
;3511:			bs->enemy == blueobelisk.entitynum ) {
;3512:			target[2] += 32;
;3513:		}
;3514:#endif
;3515:		//aim at the obelisk
;3516:		VectorSubtract(target, bs->eye, dir);
ADDRLP4 984
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 828
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 828+4
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 828+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3517
;3517:		vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3519
;3518:		//set the aim target before trying to attack
;3519:		VectorCopy(target, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 828
INDIRB
ASGNB 12
line 3520
;3520:		return;
ADDRGP4 $1241
JUMPV
LABELV $1246
line 3525
;3521:	}
;3522:	//
;3523:	//BotAI_Print(PRT_MESSAGE, "client %d: aiming at client %d\n", bs->entitynum, bs->enemy);
;3524:	//
;3525:	aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 984
INDIRF4
ASGNF4
line 3526
;3526:	aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 988
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 988
INDIRF4
ASGNF4
line 3528
;3527:	//
;3528:	if (aim_skill > 0.95) {
ADDRLP4 736
INDIRF4
CNSTF4 1064514355
LEF4 $1253
line 3530
;3529:		//don't aim too early
;3530:		reactiontime = 0.5 * trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 992
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 856
CNSTF4 1056964608
ADDRLP4 992
INDIRF4
MULF4
ASGNF4
line 3531
;3531:		if (bs->enemysight_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 856
INDIRF4
SUBF4
LEF4 $1255
ADDRGP4 $1241
JUMPV
LABELV $1255
line 3532
;3532:		if (bs->teleport_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 856
INDIRF4
SUBF4
LEF4 $1257
ADDRGP4 $1241
JUMPV
LABELV $1257
line 3533
;3533:	}
LABELV $1253
line 3536
;3534:
;3535:	//get the weapon information
;3536:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
ADDRLP4 992
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 992
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 992
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 3538
;3537:	//get the weapon specific aim accuracy and or aim skill
;3538:	if (wi.number == WP_MACHINEGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 2
NEI4 $1259
line 3539
;3539:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_MACHINEGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 8
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3540
;3540:	}
ADDRGP4 $1260
JUMPV
LABELV $1259
line 3541
;3541:	else if (wi.number == WP_SHOTGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 3
NEI4 $1262
line 3542
;3542:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_SHOTGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 9
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3543
;3543:	}
ADDRGP4 $1263
JUMPV
LABELV $1262
line 3544
;3544:	else if (wi.number == WP_GRENADE_LAUNCHER) {
ADDRLP4 160+4
INDIRI4
CNSTI4 4
NEI4 $1265
line 3545
;3545:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 11
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3546
;3546:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 18
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3547
;3547:	}
ADDRGP4 $1266
JUMPV
LABELV $1265
line 3548
;3548:	else if (wi.number == WP_ROCKET_LAUNCHER) {
ADDRLP4 160+4
INDIRI4
CNSTI4 5
NEI4 $1268
line 3549
;3549:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 10
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3550
;3550:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 17
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3551
;3551:	}
ADDRGP4 $1269
JUMPV
LABELV $1268
line 3552
;3552:	else if (wi.number == WP_LIGHTNING) {
ADDRLP4 160+4
INDIRI4
CNSTI4 6
NEI4 $1271
line 3553
;3553:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_LIGHTNING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 12
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3554
;3554:	}
ADDRGP4 $1272
JUMPV
LABELV $1271
line 3555
;3555:	else if (wi.number == WP_RAILGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 7
NEI4 $1274
line 3556
;3556:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_RAILGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 14
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3557
;3557:	}
ADDRGP4 $1275
JUMPV
LABELV $1274
line 3558
;3558:	else if (wi.number == WP_PLASMAGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 8
NEI4 $1277
line 3559
;3559:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3560
;3560:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 19
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3561
;3561:	}
ADDRGP4 $1278
JUMPV
LABELV $1277
line 3562
;3562:	else if (wi.number == WP_BFG) {
ADDRLP4 160+4
INDIRI4
CNSTI4 9
NEI4 $1280
line 3563
;3563:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 15
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3564
;3564:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 20
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3565
;3565:	}
LABELV $1280
LABELV $1278
LABELV $1275
LABELV $1272
LABELV $1269
LABELV $1266
LABELV $1263
LABELV $1260
line 3567
;3566:	//
;3567:	if (aim_accuracy <= 0) aim_accuracy = 0.0001f;
ADDRLP4 156
INDIRF4
CNSTF4 0
GTF4 $1283
ADDRLP4 156
CNSTF4 953267991
ASGNF4
LABELV $1283
line 3569
;3568:	//get the enemy entity information
;3569:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3571
;3570:	//if the enemy is invisible then shoot crappy most of the time
;3571:	if (EntityIsInvisible(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 996
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 0
EQI4 $1285
line 3572
;3572:		if (random() > 0.1) aim_accuracy *= 0.4f;
ADDRLP4 1000
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1036831949
LEF4 $1287
ADDRLP4 156
CNSTF4 1053609165
ADDRLP4 156
INDIRF4
MULF4
ASGNF4
LABELV $1287
line 3573
;3573:	}
LABELV $1285
line 3575
;3574:	//
;3575:	VectorSubtract(entinfo.origin, entinfo.lastvisorigin, enemyvelocity);
ADDRLP4 712
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 712+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 712+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3576
;3576:	VectorScale(enemyvelocity, 1 / entinfo.update_time, enemyvelocity);
ADDRLP4 1000
CNSTF4 1065353216
ASGNF4
ADDRLP4 712
ADDRLP4 712
INDIRF4
ADDRLP4 1000
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 712+4
ADDRLP4 712+4
INDIRF4
ADDRLP4 1000
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 712+8
ADDRLP4 712+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 3578
;3577:	//enemy origin and velocity is remembered every 0.5 seconds
;3578:	if (bs->enemyposition_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6140
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1308
line 3580
;3579:		//
;3580:		bs->enemyposition_time = FloatTime() + 0.5;
ADDRFP4 0
INDIRP4
CNSTI4 6140
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 3581
;3581:		VectorCopy(enemyvelocity, bs->enemyvelocity);
ADDRFP4 0
INDIRP4
CNSTI4 6232
ADDP4
ADDRLP4 712
INDIRB
ASGNB 12
line 3582
;3582:		VectorCopy(entinfo.origin, bs->enemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 6244
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3583
;3583:	}
LABELV $1308
line 3585
;3584:	//if not extremely skilled
;3585:	if (aim_skill < 0.9) {
ADDRLP4 736
INDIRF4
CNSTF4 1063675494
GEF4 $1311
line 3586
;3586:		VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1004
INDIRP4
CNSTI4 6244
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1004
INDIRP4
CNSTI4 6248
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 6252
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3588
;3587:		//if the enemy moved a bit
;3588:		if (VectorLengthSquared(dir) > Square(48)) {
ADDRLP4 140
ARGP4
ADDRLP4 1008
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1008
INDIRF4
CNSTF4 1158676480
LEF4 $1320
line 3590
;3589:			//if the enemy changed direction
;3590:			if (DotProduct(bs->enemyvelocity, enemyvelocity) < 0) {
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1012
INDIRP4
CNSTI4 6232
ADDP4
INDIRF4
ADDRLP4 712
INDIRF4
MULF4
ADDRLP4 1012
INDIRP4
CNSTI4 6236
ADDP4
INDIRF4
ADDRLP4 712+4
INDIRF4
MULF4
ADDF4
ADDRLP4 1012
INDIRP4
CNSTI4 6240
ADDP4
INDIRF4
ADDRLP4 712+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $1322
line 3592
;3591:				//aim accuracy should be worse now
;3592:				aim_accuracy *= 0.7f;
ADDRLP4 156
CNSTF4 1060320051
ADDRLP4 156
INDIRF4
MULF4
ASGNF4
line 3593
;3593:			}
LABELV $1322
line 3594
;3594:		}
LABELV $1320
line 3595
;3595:	}
LABELV $1311
line 3597
;3596:	//check visibility of enemy
;3597:	enemyvisible = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->enemy);
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1004
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 1004
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 1004
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 1004
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 1008
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 824
ADDRLP4 1008
INDIRF4
CVFI4 4
ASGNI4
line 3599
;3598:	//if the enemy is visible
;3599:	if (enemyvisible) {
ADDRLP4 824
INDIRI4
CNSTI4 0
EQI4 $1326
line 3601
;3600:		//
;3601:		VectorCopy(entinfo.origin, bestorigin);
ADDRLP4 724
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3602
;3602:		bestorigin[2] += 8;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3605
;3603:		//get the start point shooting from
;3604:		//NOTE: the x and y projectile start offsets are ignored
;3605:		VectorCopy(bs->origin, start);
ADDRLP4 844
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3606
;3606:		start[2] += bs->cur_ps.viewheight;
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 3607
;3607:		start[2] += wi.offset[2];
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRLP4 160+292+8
INDIRF4
ADDF4
ASGNF4
line 3609
;3608:		//
;3609:		BotAI_Trace(&trace, start, mins, maxs, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
ADDRLP4 860
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 724
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100664321
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3611
;3610:		//if the enemy is NOT hit
;3611:		if (trace.fraction <= 1 && trace.ent != entinfo.number) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
GTF4 $1334
ADDRLP4 740+80
INDIRI4
ADDRLP4 0+20
INDIRI4
EQI4 $1334
line 3612
;3612:			bestorigin[2] += 16;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 3613
;3613:		}
LABELV $1334
line 3615
;3614:		//if it is not an instant hit weapon the bot might want to predict the enemy
;3615:		if (wi.speed) {
ADDRLP4 160+272
INDIRF4
CNSTF4 0
EQF4 $1340
line 3617
;3616:			//
;3617:			VectorSubtract(bestorigin, bs->origin, dir);
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 724
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 724+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3618
;3618:			dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1016
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1016
INDIRF4
ASGNF4
line 3619
;3619:			VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 1020
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1020
INDIRP4
CNSTI4 6244
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1020
INDIRP4
CNSTI4 6248
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 6252
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3621
;3620:			//if the enemy is NOT pretty far away and strafing just small steps left and right
;3621:			if (!(dist > 100 && VectorLengthSquared(dir) < Square(32))) {
ADDRLP4 840
INDIRF4
CNSTF4 1120403456
LEF4 $1356
ADDRLP4 140
ARGP4
ADDRLP4 1024
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1024
INDIRF4
CNSTF4 1149239296
LTF4 $1354
LABELV $1356
line 3623
;3622:				//if skilled anough do exact prediction
;3623:				if (aim_skill > 0.8 &&
ADDRLP4 736
INDIRF4
CNSTF4 1061997773
LEF4 $1357
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1357
line 3625
;3624:						//if the weapon is ready to fire
;3625:						bs->cur_ps.weaponstate == WEAPON_READY) {
line 3629
;3626:					aas_clientmove_t move;
;3627:					vec3_t origin;
;3628:
;3629:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1124
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1124
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3631
;3630:					//distance towards the enemy
;3631:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1128
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1128
INDIRF4
ASGNF4
line 3633
;3632:					//direction the enemy is moving in
;3633:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3635
;3634:					//
;3635:					VectorScale(dir, 1 / entinfo.update_time, dir);
ADDRLP4 1132
CNSTF4 1065353216
ASGNF4
ADDRLP4 140
ADDRLP4 140
INDIRF4
ADDRLP4 1132
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 140+4
INDIRF4
ADDRLP4 1132
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 140+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 3637
;3636:					//
;3637:					VectorCopy(entinfo.origin, origin);
ADDRLP4 1028
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3638
;3638:					origin[2] += 1;
ADDRLP4 1028+8
ADDRLP4 1028+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3640
;3639:					//
;3640:					VectorClear(cmdmove);
ADDRLP4 1136
CNSTF4 0
ASGNF4
ADDRLP4 968+8
ADDRLP4 1136
INDIRF4
ASGNF4
ADDRLP4 968+4
ADDRLP4 1136
INDIRF4
ASGNF4
ADDRLP4 968
ADDRLP4 1136
INDIRF4
ASGNF4
line 3642
;3641:					//AAS_ClearShownDebugLines();
;3642:					trap_AAS_PredictClientMovement(&move, bs->enemy, origin,
ADDRLP4 1040
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 1140
CNSTI4 0
ASGNI4
ADDRLP4 1140
INDIRI4
ARGI4
ADDRLP4 140
ARGP4
ADDRLP4 968
ARGP4
ADDRLP4 1140
INDIRI4
ARGI4
CNSTF4 1092616192
ADDRLP4 840
INDIRF4
MULF4
ADDRLP4 160+272
INDIRF4
DIVF4
CVFI4 4
ARGI4
CNSTF4 1036831949
ARGF4
ADDRLP4 1140
INDIRI4
ARGI4
ADDRLP4 1140
INDIRI4
ARGI4
ADDRLP4 1140
INDIRI4
ARGI4
ADDRGP4 trap_AAS_PredictClientMovement
CALLI4
pop
line 3646
;3643:														PRESENCE_CROUCH, qfalse,
;3644:														dir, cmdmove, 0,
;3645:														dist * 10 / wi.speed, 0.1f, 0, 0, qfalse);
;3646:					VectorCopy(move.endpos, bestorigin);
ADDRLP4 724
ADDRLP4 1040
INDIRB
ASGNB 12
line 3648
;3647:					//BotAI_Print(PRT_MESSAGE, "%1.1f predicted speed = %f, frames = %f\n", FloatTime(), VectorLength(dir), dist * 10 / wi.speed);
;3648:				}
ADDRGP4 $1358
JUMPV
LABELV $1357
line 3650
;3649:				//if not that skilled do linear prediction
;3650:				else if (aim_skill > 0.4) {
ADDRLP4 736
INDIRF4
CNSTF4 1053609165
LEF4 $1390
line 3651
;3651:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1028
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1028
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3653
;3652:					//distance towards the enemy
;3653:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1032
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1032
INDIRF4
ASGNF4
line 3655
;3654:					//direction the enemy is moving in
;3655:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3656
;3656:					dir[2] = 0;
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 3658
;3657:					//
;3658:					speed = VectorNormalize(dir) / entinfo.update_time;
ADDRLP4 140
ARGP4
ADDRLP4 1036
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 980
ADDRLP4 1036
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
ASGNF4
line 3661
;3659:					//botimport.Print(PRT_MESSAGE, "speed = %f, wi->speed = %f\n", speed, wi->speed);
;3660:					//best spot to aim at
;3661:					VectorMA(entinfo.origin, (dist / wi.speed) * speed, dir, bestorigin);
ADDRLP4 1040
ADDRLP4 840
INDIRF4
ASGNF4
ADDRLP4 1044
ADDRLP4 980
INDIRF4
ASGNF4
ADDRLP4 724
ADDRLP4 0+24
INDIRF4
ADDRLP4 140
INDIRF4
ADDRLP4 1040
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 1044
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 724+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 140+4
INDIRF4
ADDRLP4 1040
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 1044
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 724+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 140+8
INDIRF4
ADDRLP4 840
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 980
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 3662
;3662:				}
LABELV $1390
LABELV $1358
line 3663
;3663:			}
LABELV $1354
line 3664
;3664:		}
LABELV $1340
line 3666
;3665:		//if the projectile does radial damage
;3666:		if (aim_skill > 0.6 && wi.proj.damagetype & DAMAGETYPE_RADIAL) {
ADDRLP4 736
INDIRF4
CNSTF4 1058642330
LEF4 $1425
ADDRLP4 160+344+180
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1425
line 3668
;3667:			//if the enemy isn't standing significantly higher than the bot
;3668:			if (entinfo.origin[2] < bs->origin[2] + 16) {
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
GEF4 $1429
line 3670
;3669:				//try to aim at the ground in front of the enemy
;3670:				VectorCopy(entinfo.origin, end);
ADDRLP4 956
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3671
;3671:				end[2] -= 64;
ADDRLP4 956+8
ADDRLP4 956+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 3672
;3672:				BotAI_Trace(&trace, entinfo.origin, NULL, NULL, end, entinfo.number, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 1012
CNSTP4 0
ASGNP4
ADDRLP4 1012
INDIRP4
ARGP4
ADDRLP4 1012
INDIRP4
ARGP4
ADDRLP4 956
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
CNSTI4 100664321
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3674
;3673:				//
;3674:				VectorCopy(bestorigin, groundtarget);
ADDRLP4 944
ADDRLP4 724
INDIRB
ASGNB 12
line 3675
;3675:				if (trace.startsolid) groundtarget[2] = entinfo.origin[2] - 16;
ADDRLP4 740+4
INDIRI4
CNSTI4 0
EQI4 $1437
ADDRLP4 944+8
ADDRLP4 0+24+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
ADDRGP4 $1438
JUMPV
LABELV $1437
line 3676
;3676:				else groundtarget[2] = trace.endpos[2] - 8;
ADDRLP4 944+8
ADDRLP4 740+12+8
INDIRF4
CNSTF4 1090519040
SUBF4
ASGNF4
LABELV $1438
line 3678
;3677:				//trace a line from projectile start to ground target
;3678:				BotAI_Trace(&trace, start, NULL, NULL, groundtarget, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
ADDRLP4 1016
CNSTP4 0
ASGNP4
ADDRLP4 1016
INDIRP4
ARGP4
ADDRLP4 1016
INDIRP4
ARGP4
ADDRLP4 944
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100664321
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3680
;3679:				//if hitpoint is not vertically too far from the ground target
;3680:				if (fabs(trace.endpos[2] - groundtarget[2]) < 50) {
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 944+8
INDIRF4
SUBF4
ARGF4
ADDRLP4 1020
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 1020
INDIRF4
CNSTF4 1112014848
GEF4 $1446
line 3681
;3681:					VectorSubtract(trace.endpos, groundtarget, dir);
ADDRLP4 140
ADDRLP4 740+12
INDIRF4
ADDRLP4 944
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 740+12+4
INDIRF4
ADDRLP4 944+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 944+8
INDIRF4
SUBF4
ASGNF4
line 3683
;3682:					//if the hitpoint is near anough the ground target
;3683:					if (VectorLengthSquared(dir) < Square(60)) {
ADDRLP4 140
ARGP4
ADDRLP4 1024
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1024
INDIRF4
CNSTF4 1163984896
GEF4 $1460
line 3684
;3684:						VectorSubtract(trace.endpos, start, dir);
ADDRLP4 140
ADDRLP4 740+12
INDIRF4
ADDRLP4 844
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 740+12+4
INDIRF4
ADDRLP4 844+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 844+8
INDIRF4
SUBF4
ASGNF4
line 3686
;3685:						//if the hitpoint is far anough from the bot
;3686:						if (VectorLengthSquared(dir) > Square(100)) {
ADDRLP4 140
ARGP4
ADDRLP4 1028
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1028
INDIRF4
CNSTF4 1176256512
LEF4 $1471
line 3688
;3687:							//check if the bot is visible from the ground target
;3688:							trace.endpos[2] += 1;
ADDRLP4 740+12+8
ADDRLP4 740+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3689
;3689:							BotAI_Trace(&trace, trace.endpos, NULL, NULL, entinfo.origin, entinfo.number, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 740+12
ARGP4
ADDRLP4 1032
CNSTP4 0
ASGNP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
CNSTI4 100664321
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3690
;3690:							if (trace.fraction >= 1) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
LTF4 $1478
line 3692
;3691:								//botimport.Print(PRT_MESSAGE, "%1.1f aiming at ground\n", AAS_Time());
;3692:								VectorCopy(groundtarget, bestorigin);
ADDRLP4 724
ADDRLP4 944
INDIRB
ASGNB 12
line 3693
;3693:							}
LABELV $1478
line 3694
;3694:						}
LABELV $1471
line 3695
;3695:					}
LABELV $1460
line 3696
;3696:				}
LABELV $1446
line 3697
;3697:			}
LABELV $1429
line 3698
;3698:		}
LABELV $1425
line 3699
;3699:		bestorigin[0] += 20 * crandom() * (1 - aim_accuracy);
ADDRLP4 1012
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724
ADDRLP4 724
INDIRF4
CNSTF4 1101004800
CNSTF4 1073741824
ADDRLP4 1012
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3700
;3700:		bestorigin[1] += 20 * crandom() * (1 - aim_accuracy);
ADDRLP4 1016
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724+4
ADDRLP4 724+4
INDIRF4
CNSTF4 1101004800
CNSTF4 1073741824
ADDRLP4 1016
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3701
;3701:		bestorigin[2] += 10 * crandom() * (1 - aim_accuracy);
ADDRLP4 1020
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1092616192
CNSTF4 1073741824
ADDRLP4 1020
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3702
;3702:	}
ADDRGP4 $1327
JUMPV
LABELV $1326
line 3703
;3703:	else {
line 3705
;3704:		//
;3705:		VectorCopy(bs->lastenemyorigin, bestorigin);
ADDRLP4 724
ADDRFP4 0
INDIRP4
CNSTI4 6548
ADDP4
INDIRB
ASGNB 12
line 3706
;3706:		bestorigin[2] += 8;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3708
;3707:		//if the bot is skilled anough
;3708:		if (aim_skill > 0.5) {
ADDRLP4 736
INDIRF4
CNSTF4 1056964608
LEF4 $1484
line 3710
;3709:			//do prediction shots around corners
;3710:			if (wi.number == WP_BFG ||
ADDRLP4 160+4
INDIRI4
CNSTI4 9
EQI4 $1492
ADDRLP4 160+4
INDIRI4
CNSTI4 5
EQI4 $1492
ADDRLP4 160+4
INDIRI4
CNSTI4 4
NEI4 $1486
LABELV $1492
line 3712
;3711:				wi.number == WP_ROCKET_LAUNCHER ||
;3712:				wi.number == WP_GRENADE_LAUNCHER) {
line 3714
;3713:				//create the chase goal
;3714:				goal.entitynum = bs->client;
ADDRLP4 884+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 3715
;3715:				goal.areanum = bs->areanum;
ADDRLP4 884+12
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 3716
;3716:				VectorCopy(bs->eye, goal.origin);
ADDRLP4 884
ADDRFP4 0
INDIRP4
CNSTI4 4936
ADDP4
INDIRB
ASGNB 12
line 3717
;3717:				VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 884+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 884+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 884+16+8
CNSTF4 3238002688
ASGNF4
line 3718
;3718:				VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 884+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 884+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 884+28+8
CNSTF4 1090519040
ASGNF4
line 3720
;3719:				//
;3720:				if (trap_BotPredictVisiblePosition(bs->lastenemyorigin, bs->lastenemyareanum, &goal, TFL_DEFAULT, target)) {
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1012
INDIRP4
CNSTI4 6548
ADDP4
ARGP4
ADDRLP4 1012
INDIRP4
CNSTI4 6544
ADDP4
INDIRI4
ARGI4
ADDRLP4 884
ARGP4
CNSTI4 18616254
ARGI4
ADDRLP4 828
ARGP4
ADDRLP4 1016
ADDRGP4 trap_BotPredictVisiblePosition
CALLI4
ASGNI4
ADDRLP4 1016
INDIRI4
CNSTI4 0
EQI4 $1505
line 3721
;3721:					VectorSubtract(target, bs->eye, dir);
ADDRLP4 1020
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 828
INDIRF4
ADDRLP4 1020
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 828+4
INDIRF4
ADDRLP4 1020
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 828+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3722
;3722:					if (VectorLengthSquared(dir) > Square(80)) {
ADDRLP4 140
ARGP4
ADDRLP4 1024
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1024
INDIRF4
CNSTF4 1170735104
LEF4 $1511
line 3723
;3723:						VectorCopy(target, bestorigin);
ADDRLP4 724
ADDRLP4 828
INDIRB
ASGNB 12
line 3724
;3724:						bestorigin[2] -= 20;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 3725
;3725:					}
LABELV $1511
line 3726
;3726:				}
LABELV $1505
line 3727
;3727:				aim_accuracy = 1;
ADDRLP4 156
CNSTF4 1065353216
ASGNF4
line 3728
;3728:			}
LABELV $1486
line 3729
;3729:		}
LABELV $1484
line 3730
;3730:	}
LABELV $1327
line 3732
;3731:	//
;3732:	if (enemyvisible) {
ADDRLP4 824
INDIRI4
CNSTI4 0
EQI4 $1514
line 3733
;3733:		BotAI_Trace(&trace, bs->eye, NULL, NULL, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1012
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 1016
CNSTP4 0
ASGNP4
ADDRLP4 1016
INDIRP4
ARGP4
ADDRLP4 1016
INDIRP4
ARGP4
ADDRLP4 724
ARGP4
ADDRLP4 1012
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100664321
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3734
;3734:		VectorCopy(trace.endpos, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 740+12
INDIRB
ASGNB 12
line 3735
;3735:	}
ADDRGP4 $1515
JUMPV
LABELV $1514
line 3736
;3736:	else {
line 3737
;3737:		VectorCopy(bestorigin, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 724
INDIRB
ASGNB 12
line 3738
;3738:	}
LABELV $1515
line 3740
;3739:	//get aim direction
;3740:	VectorSubtract(bestorigin, bs->eye, dir);
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 724
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 724+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3742
;3741:	//
;3742:	if (wi.number == WP_MACHINEGUN ||
ADDRLP4 160+4
INDIRI4
CNSTI4 2
EQI4 $1529
ADDRLP4 160+4
INDIRI4
CNSTI4 3
EQI4 $1529
ADDRLP4 160+4
INDIRI4
CNSTI4 6
EQI4 $1529
ADDRLP4 160+4
INDIRI4
CNSTI4 7
NEI4 $1521
LABELV $1529
line 3745
;3743:		wi.number == WP_SHOTGUN ||
;3744:		wi.number == WP_LIGHTNING ||
;3745:		wi.number == WP_RAILGUN) {
line 3747
;3746:		//distance towards the enemy
;3747:		dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1016
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1016
INDIRF4
ASGNF4
line 3748
;3748:		if (dist > 150) dist = 150;
ADDRLP4 840
INDIRF4
CNSTF4 1125515264
LEF4 $1530
ADDRLP4 840
CNSTF4 1125515264
ASGNF4
LABELV $1530
line 3749
;3749:		f = 0.6 + dist / 150 * 0.4;
ADDRLP4 940
CNSTF4 1053609165
ADDRLP4 840
INDIRF4
CNSTF4 1125515264
DIVF4
MULF4
CNSTF4 1058642330
ADDF4
ASGNF4
line 3750
;3750:		aim_accuracy *= f;
ADDRLP4 156
ADDRLP4 156
INDIRF4
ADDRLP4 940
INDIRF4
MULF4
ASGNF4
line 3751
;3751:	}
LABELV $1521
line 3753
;3752:	//add some random stuff to the aim direction depending on the aim accuracy
;3753:	if (aim_accuracy < 0.8) {
ADDRLP4 156
INDIRF4
CNSTF4 1061997773
GEF4 $1532
line 3754
;3754:		VectorNormalize(dir);
ADDRLP4 140
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 3755
;3755:		for (i = 0; i < 3; i++) dir[i] += 0.3 * crandom() * (1 - aim_accuracy);
ADDRLP4 152
CNSTI4 0
ASGNI4
LABELV $1534
ADDRLP4 1016
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1020
ADDRLP4 152
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
ADDP4
ASGNP4
ADDRLP4 1020
INDIRP4
ADDRLP4 1020
INDIRP4
INDIRF4
CNSTF4 1050253722
CNSTF4 1073741824
ADDRLP4 1016
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
LABELV $1535
ADDRLP4 152
ADDRLP4 152
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 3
LTI4 $1534
line 3756
;3756:	}
LABELV $1532
line 3758
;3757:	//set the ideal view angles
;3758:	vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3760
;3759:	//take the weapon spread into account for lower skilled bots
;3760:	bs->ideal_viewangles[PITCH] += 6 * wi.vspread * crandom() * (1 - aim_accuracy);
ADDRLP4 1016
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1020
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1020
INDIRP4
ADDRLP4 1020
INDIRP4
INDIRF4
CNSTF4 1086324736
ADDRLP4 160+268
INDIRF4
MULF4
CNSTF4 1073741824
ADDRLP4 1016
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3761
;3761:	bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 1024
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1024
INDIRP4
INDIRF4
ARGF4
ADDRLP4 1028
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1024
INDIRP4
ADDRLP4 1028
INDIRF4
ASGNF4
line 3762
;3762:	bs->ideal_viewangles[YAW] += 6 * wi.hspread * crandom() * (1 - aim_accuracy);
ADDRLP4 1032
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 1036
INDIRP4
ADDRLP4 1036
INDIRP4
INDIRF4
CNSTF4 1086324736
ADDRLP4 160+264
INDIRF4
MULF4
CNSTF4 1073741824
ADDRLP4 1032
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3763
;3763:	bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 1040
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 1040
INDIRP4
INDIRF4
ARGF4
ADDRLP4 1044
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1040
INDIRP4
ADDRLP4 1044
INDIRF4
ASGNF4
line 3765
;3764:	//if the bots should be really challenging
;3765:	if (bot_challenge.integer) {
ADDRGP4 bot_challenge+12
INDIRI4
CNSTI4 0
EQI4 $1540
line 3767
;3766:		//if the bot is really accurate and has the enemy in view for some time
;3767:		if (aim_accuracy > 0.9 && bs->enemysight_time < FloatTime() - 1) {
ADDRLP4 156
INDIRF4
CNSTF4 1063675494
LEF4 $1543
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1543
line 3769
;3768:			//set the view angles directly
;3769:			if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $1545
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $1545
line 3770
;3770:			VectorCopy(bs->ideal_viewangles, bs->viewangles);
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 6564
ADDP4
ADDRLP4 1052
INDIRP4
CNSTI4 6576
ADDP4
INDIRB
ASGNB 12
line 3771
;3771:			trap_EA_View(bs->client, bs->viewangles);
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1056
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRGP4 trap_EA_View
CALLV
pop
line 3772
;3772:		}
LABELV $1543
line 3773
;3773:	}
LABELV $1540
line 3774
;3774:}
LABELV $1241
endproc BotAimAtEnemy 1144 52
lit
align 4
LABELV $1548
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $1549
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCheckAttack
code
proc BotCheckAttack 1028 28
line 3781
;3775:
;3776:/*
;3777:==================
;3778:BotCheckAttack
;3779:==================
;3780:*/
;3781:void BotCheckAttack(bot_state_t *bs) {
line 3790
;3782:	float points, reactiontime, fov, firethrottle;
;3783:	int attackentity;
;3784:	bsp_trace_t bsptrace;
;3785:	//float selfpreservation;
;3786:	vec3_t forward, right, start, end, dir, angles;
;3787:	weaponinfo_t wi;
;3788:	bsp_trace_t trace;
;3789:	aas_entityinfo_t entinfo;
;3790:	vec3_t mins = {-8, -8, -8}, maxs = {8, 8, 8};
ADDRLP4 808
ADDRGP4 $1548
INDIRB
ASGNB 12
ADDRLP4 820
ADDRGP4 $1549
INDIRB
ASGNB 12
line 3792
;3791:
;3792:	attackentity = bs->enemy;
ADDRLP4 576
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ASGNI4
line 3794
;3793:	//
;3794:	BotEntityInfo(attackentity, &entinfo);
ADDRLP4 576
INDIRI4
ARGI4
ADDRLP4 832
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3796
;3795:	// if not attacking a player
;3796:	if (attackentity >= MAX_CLIENTS) {
ADDRLP4 576
INDIRI4
CNSTI4 64
LTI4 $1550
line 3808
;3797:#ifdef MISSIONPACK
;3798:		// if attacking an obelisk
;3799:		if ( entinfo.number == redobelisk.entitynum ||
;3800:			entinfo.number == blueobelisk.entitynum ) {
;3801:			// if obelisk is respawning return
;3802:			if ( g_entities[entinfo.number].activator &&
;3803:				g_entities[entinfo.number].activator->s.frame == 2 ) {
;3804:				return;
;3805:			}
;3806:		}
;3807:#endif
;3808:	}
LABELV $1550
line 3810
;3809:
;3810:	reactiontime = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 976
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 700
ADDRLP4 976
INDIRF4
ASGNF4
line 3811
;3811:	if (bs->enemysight_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 700
INDIRF4
SUBF4
LEF4 $1552
ADDRGP4 $1547
JUMPV
LABELV $1552
line 3812
;3812:	if (bs->teleport_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 700
INDIRF4
SUBF4
LEF4 $1554
ADDRGP4 $1547
JUMPV
LABELV $1554
line 3814
;3813:	//if changing weapons
;3814:	if (bs->weaponchange_time > FloatTime() - 0.1) return;
ADDRFP4 0
INDIRP4
CNSTI4 6192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1036831949
SUBF4
LEF4 $1556
ADDRGP4 $1547
JUMPV
LABELV $1556
line 3816
;3815:	//check fire throttle characteristic
;3816:	if (bs->firethrottlewait_time > FloatTime()) return;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1558
ADDRGP4 $1547
JUMPV
LABELV $1558
line 3817
;3817:	firethrottle = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_FIRETHROTTLE, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 47
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 980
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 792
ADDRLP4 980
INDIRF4
ASGNF4
line 3818
;3818:	if (bs->firethrottleshoot_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1560
line 3819
;3819:		if (random() > firethrottle) {
ADDRLP4 984
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 984
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 792
INDIRF4
LEF4 $1562
line 3820
;3820:			bs->firethrottlewait_time = FloatTime() + firethrottle;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 792
INDIRF4
ADDF4
ASGNF4
line 3821
;3821:			bs->firethrottleshoot_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
CNSTF4 0
ASGNF4
line 3822
;3822:		}
ADDRGP4 $1563
JUMPV
LABELV $1562
line 3823
;3823:		else {
line 3824
;3824:			bs->firethrottleshoot_time = FloatTime() + 1 - firethrottle;
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 792
INDIRF4
SUBF4
ASGNF4
line 3825
;3825:			bs->firethrottlewait_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
CNSTF4 0
ASGNF4
line 3826
;3826:		}
LABELV $1563
line 3827
;3827:	}
LABELV $1560
line 3830
;3828:	//
;3829:	//
;3830:	VectorSubtract(bs->aimtarget, bs->eye, dir);
ADDRLP4 984
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 580
ADDRLP4 984
INDIRP4
CNSTI4 6220
ADDP4
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 580+4
ADDRLP4 984
INDIRP4
CNSTI4 6224
ADDP4
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 988
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 580+8
ADDRLP4 988
INDIRP4
CNSTI4 6228
ADDP4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3832
;3831:	//
;3832:	if (bs->weaponnum == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1566
line 3833
;3833:		if (VectorLengthSquared(dir) > Square(60)) {
ADDRLP4 580
ARGP4
ADDRLP4 992
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 992
INDIRF4
CNSTF4 1163984896
LEF4 $1568
line 3834
;3834:			return;
ADDRGP4 $1547
JUMPV
LABELV $1568
line 3836
;3835:		}
;3836:	}
LABELV $1566
line 3837
;3837:	if (VectorLengthSquared(dir) < Square(100))
ADDRLP4 580
ARGP4
ADDRLP4 992
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 992
INDIRF4
CNSTF4 1176256512
GEF4 $1570
line 3838
;3838:		fov = 120;
ADDRLP4 788
CNSTF4 1123024896
ASGNF4
ADDRGP4 $1571
JUMPV
LABELV $1570
line 3840
;3839:	else
;3840:		fov = 50;
ADDRLP4 788
CNSTF4 1112014848
ASGNF4
LABELV $1571
line 3842
;3841:	//
;3842:	vectoangles(dir, angles);
ADDRLP4 580
ARGP4
ADDRLP4 796
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3843
;3843:	if (!InFieldOfVision(bs->viewangles, fov, angles))
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 788
INDIRF4
ARGF4
ADDRLP4 796
ARGP4
ADDRLP4 996
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 0
NEI4 $1572
line 3844
;3844:		return;
ADDRGP4 $1547
JUMPV
LABELV $1572
line 3845
;3845:	BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, bs->aimtarget, bs->client, CONTENTS_SOLID|CONTENTS_PLAYERCLIP);
ADDRLP4 704
ARGP4
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1000
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 1004
CNSTP4 0
ASGNP4
ADDRLP4 1004
INDIRP4
ARGP4
ADDRLP4 1004
INDIRP4
ARGP4
ADDRLP4 1000
INDIRP4
CNSTI4 6220
ADDP4
ARGP4
ADDRLP4 1000
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3846
;3846:	if (bsptrace.fraction < 1 && bsptrace.ent != attackentity)
ADDRLP4 704+8
INDIRF4
CNSTF4 1065353216
GEF4 $1574
ADDRLP4 704+80
INDIRI4
ADDRLP4 576
INDIRI4
EQI4 $1574
line 3847
;3847:		return;
ADDRGP4 $1547
JUMPV
LABELV $1574
line 3850
;3848:
;3849:	//get the weapon info
;3850:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 1008
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 3852
;3851:	//get the start point shooting from
;3852:	VectorCopy(bs->origin, start);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3853
;3853:	start[2] += bs->cur_ps.viewheight;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 3854
;3854:	AngleVectors(bs->viewangles, forward, right, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 676
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3855
;3855:	start[0] += forward[0] * wi.offset[0] + right[0] * wi.offset[1];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3856
;3856:	start[1] += forward[1] * wi.offset[0] + right[1] * wi.offset[1];
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676+4
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3857
;3857:	start[2] += forward[2] * wi.offset[0] + right[2] * wi.offset[1] + wi.offset[2];
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676+8
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 24+292+8
INDIRF4
ADDF4
ADDF4
ASGNF4
line 3859
;3858:	//end point aiming at
;3859:	VectorMA(start, 1000, forward, end);
ADDRLP4 1012
CNSTF4 1148846080
ASGNF4
ADDRLP4 688
ADDRLP4 0
INDIRF4
ADDRLP4 1012
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 688+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 1012
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 688+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1148846080
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3861
;3860:	//a little back to make sure not inside a very close enemy
;3861:	VectorMA(start, -12, forward, start);
ADDRLP4 1016
CNSTF4 3242196992
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 1016
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 1016
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 3242196992
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3862
;3862:	BotAI_Trace(&trace, start, mins, maxs, end, bs->entitynum, MASK_SHOT);
ADDRLP4 592
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 808
ARGP4
ADDRLP4 820
ARGP4
ADDRLP4 688
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100664321
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3864
;3863:	//if the entity is a client
;3864:	if (trace.ent > 0 && trace.ent <= MAX_CLIENTS) {
ADDRLP4 592+80
INDIRI4
CNSTI4 0
LEI4 $1608
ADDRLP4 592+80
INDIRI4
CNSTI4 64
GTI4 $1608
line 3865
;3865:		if (trace.ent != attackentity) {
ADDRLP4 592+80
INDIRI4
ADDRLP4 576
INDIRI4
EQI4 $1612
line 3867
;3866:			//if a teammate is hit
;3867:			if (BotSameTeam(bs, trace.ent))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 592+80
INDIRI4
ARGI4
ADDRLP4 1020
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1020
INDIRI4
CNSTI4 0
EQI4 $1615
line 3868
;3868:				return;
ADDRGP4 $1547
JUMPV
LABELV $1615
line 3869
;3869:		}
LABELV $1612
line 3870
;3870:	}
LABELV $1608
line 3872
;3871:	//if won't hit the enemy or not attacking a player (obelisk)
;3872:	if (trace.ent != attackentity || attackentity >= MAX_CLIENTS) {
ADDRLP4 592+80
INDIRI4
ADDRLP4 576
INDIRI4
NEI4 $1621
ADDRLP4 576
INDIRI4
CNSTI4 64
LTI4 $1618
LABELV $1621
line 3874
;3873:		//if the projectile does radial damage
;3874:		if (wi.proj.damagetype & DAMAGETYPE_RADIAL) {
ADDRLP4 24+344+180
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1622
line 3875
;3875:			if (trace.fraction * 1000 < wi.proj.radius) {
CNSTF4 1148846080
ADDRLP4 592+8
INDIRF4
MULF4
ADDRLP4 24+344+172
INDIRF4
GEF4 $1626
line 3876
;3876:				points = (wi.proj.damage - 0.5 * trace.fraction * 1000) * 0.5;
ADDRLP4 1024
CNSTF4 1056964608
ASGNF4
ADDRLP4 972
ADDRLP4 1024
INDIRF4
ADDRLP4 24+344+168
INDIRI4
CVIF4 4
CNSTF4 1148846080
ADDRLP4 1024
INDIRF4
ADDRLP4 592+8
INDIRF4
MULF4
MULF4
SUBF4
MULF4
ASGNF4
line 3877
;3877:				if (points > 0) {
ADDRLP4 972
INDIRF4
CNSTF4 0
LEF4 $1634
line 3878
;3878:					return;
ADDRGP4 $1547
JUMPV
LABELV $1634
line 3880
;3879:				}
;3880:			}
LABELV $1626
line 3882
;3881:			//FIXME: check if a teammate gets radial damage
;3882:		}
LABELV $1622
line 3883
;3883:	}
LABELV $1618
line 3885
;3884:	//if fire has to be release to activate weapon
;3885:	if (wi.flags & WFL_FIRERELEASED) {
ADDRLP4 24+176
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1636
line 3886
;3886:		if (bs->flags & BFL_ATTACKED) {
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1637
line 3887
;3887:			trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3888
;3888:		}
line 3889
;3889:	}
ADDRGP4 $1637
JUMPV
LABELV $1636
line 3890
;3890:	else {
line 3891
;3891:		trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3892
;3892:	}
LABELV $1637
line 3893
;3893:	bs->flags ^= BFL_ATTACKED;
ADDRLP4 1024
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 1024
INDIRP4
ADDRLP4 1024
INDIRP4
INDIRI4
CNSTI4 2
BXORI4
ASGNI4
line 3894
;3894:}
LABELV $1547
endproc BotCheckAttack 1028 28
lit
align 4
LABELV $1647
byte 4 1143930880
byte 4 1129054208
byte 4 1143472128
align 4
LABELV $1648
byte 4 1148256256
byte 4 1139408896
byte 4 1143603200
align 4
LABELV $1649
byte 4 1134034944
byte 4 1135607808
byte 4 1147535360
export BotMapScripts
code
proc BotMapScripts 1424 16
line 3901
;3895:
;3896:/*
;3897:==================
;3898:BotMapScripts
;3899:==================
;3900:*/
;3901:void BotMapScripts(bot_state_t *bs) {
line 3909
;3902:	char info[1024];
;3903:	char mapname[128];
;3904:	int i, shootbutton;
;3905:	float aim_accuracy;
;3906:	aas_entityinfo_t entinfo;
;3907:	vec3_t dir;
;3908:
;3909:	trap_GetServerinfo(info, sizeof(info));
ADDRLP4 272
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 3911
;3910:
;3911:	strncpy(mapname, Info_ValueForKey( info, "mapname" ), sizeof(mapname)-1);
ADDRLP4 272
ARGP4
ADDRGP4 $1642
ARGP4
ADDRLP4 1316
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 144
ARGP4
ADDRLP4 1316
INDIRP4
ARGP4
CNSTI4 127
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 3912
;3912:	mapname[sizeof(mapname)-1] = '\0';
ADDRLP4 144+127
CNSTI1 0
ASGNI1
line 3914
;3913:
;3914:	if (!Q_stricmp(mapname, "q3tourney6")) {
ADDRLP4 144
ARGP4
ADDRGP4 $1646
ARGP4
ADDRLP4 1320
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1320
INDIRI4
CNSTI4 0
NEI4 $1644
line 3915
;3915:		vec3_t mins = {700, 204, 672}, maxs = {964, 468, 680};
ADDRLP4 1324
ADDRGP4 $1647
INDIRB
ASGNB 12
ADDRLP4 1336
ADDRGP4 $1648
INDIRB
ASGNB 12
line 3916
;3916:		vec3_t buttonorg = {304, 352, 920};
ADDRLP4 1348
ADDRGP4 $1649
INDIRB
ASGNB 12
line 3918
;3917:		//NOTE: NEVER use the func_bobbing in q3tourney6
;3918:		bs->tfl &= ~TFL_FUNCBOB;
ADDRLP4 1360
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ASGNP4
ADDRLP4 1360
INDIRP4
ADDRLP4 1360
INDIRP4
INDIRI4
CNSTI4 -16777217
BANDI4
ASGNI4
line 3920
;3919:		//if the bot is below the bounding box
;3920:		if (bs->origin[0] > mins[0] && bs->origin[0] < maxs[0]) {
ADDRLP4 1364
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1364
INDIRF4
ADDRLP4 1324
INDIRF4
LEF4 $1650
ADDRLP4 1364
INDIRF4
ADDRLP4 1336
INDIRF4
GEF4 $1650
line 3921
;3921:			if (bs->origin[1] > mins[1] && bs->origin[1] < maxs[1]) {
ADDRLP4 1368
ADDRFP4 0
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1368
INDIRF4
ADDRLP4 1324+4
INDIRF4
LEF4 $1652
ADDRLP4 1368
INDIRF4
ADDRLP4 1336+4
INDIRF4
GEF4 $1652
line 3922
;3922:				if (bs->origin[2] < mins[2]) {
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 1324+8
INDIRF4
GEF4 $1656
line 3923
;3923:					return;
ADDRGP4 $1641
JUMPV
LABELV $1656
line 3925
;3924:				}
;3925:			}
LABELV $1652
line 3926
;3926:		}
LABELV $1650
line 3927
;3927:		shootbutton = qfalse;
ADDRLP4 1296
CNSTI4 0
ASGNI4
line 3929
;3928:		//if an enemy is below this bounding box then shoot the button
;3929:		for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $1662
JUMPV
LABELV $1659
line 3931
;3930:
;3931:			if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1663
ADDRGP4 $1660
JUMPV
LABELV $1663
line 3933
;3932:			//
;3933:			BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3935
;3934:			//
;3935:			if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1665
ADDRGP4 $1660
JUMPV
LABELV $1665
line 3937
;3936:			//if the enemy isn't dead and the enemy isn't the bot self
;3937:			if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 1368
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 1368
INDIRI4
CNSTI4 0
NEI4 $1670
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $1667
LABELV $1670
ADDRGP4 $1660
JUMPV
LABELV $1667
line 3939
;3938:			//
;3939:			if (entinfo.origin[0] > mins[0] && entinfo.origin[0] < maxs[0]) {
ADDRLP4 0+24
INDIRF4
ADDRLP4 1324
INDIRF4
LEF4 $1671
ADDRLP4 0+24
INDIRF4
ADDRLP4 1336
INDIRF4
GEF4 $1671
line 3940
;3940:				if (entinfo.origin[1] > mins[1] && entinfo.origin[1] < maxs[1]) {
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1324+4
INDIRF4
LEF4 $1675
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1336+4
INDIRF4
GEF4 $1675
line 3941
;3941:					if (entinfo.origin[2] < mins[2]) {
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 1324+8
INDIRF4
GEF4 $1683
line 3943
;3942:						//if there's a team mate below the crusher
;3943:						if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 1372
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1372
INDIRI4
CNSTI4 0
EQI4 $1688
line 3944
;3944:							shootbutton = qfalse;
ADDRLP4 1296
CNSTI4 0
ASGNI4
line 3945
;3945:							break;
ADDRGP4 $1661
JUMPV
LABELV $1688
line 3947
;3946:						}
;3947:						else {
line 3948
;3948:							shootbutton = qtrue;
ADDRLP4 1296
CNSTI4 1
ASGNI4
line 3949
;3949:						}
line 3950
;3950:					}
LABELV $1683
line 3951
;3951:				}
LABELV $1675
line 3952
;3952:			}
LABELV $1671
line 3953
;3953:		}
LABELV $1660
line 3929
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1662
ADDRLP4 140
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1690
ADDRLP4 140
INDIRI4
CNSTI4 64
LTI4 $1659
LABELV $1690
LABELV $1661
line 3954
;3954:		if (shootbutton) {
ADDRLP4 1296
INDIRI4
CNSTI4 0
EQI4 $1645
line 3955
;3955:			bs->flags |= BFL_IDEALVIEWSET;
ADDRLP4 1372
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 1372
INDIRP4
ADDRLP4 1372
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 3956
;3956:			VectorSubtract(buttonorg, bs->eye, dir);
ADDRLP4 1376
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1300
ADDRLP4 1348
INDIRF4
ADDRLP4 1376
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1300+4
ADDRLP4 1348+4
INDIRF4
ADDRLP4 1376
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1300+8
ADDRLP4 1348+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3957
;3957:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 1300
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3958
;3958:			aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1380
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 1312
ADDRLP4 1380
INDIRF4
ASGNF4
line 3959
;3959:			bs->ideal_viewangles[PITCH] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 1384
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1388
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1388
INDIRP4
ADDRLP4 1388
INDIRP4
INDIRF4
CNSTF4 1090519040
CNSTF4 1073741824
ADDRLP4 1384
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 1312
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3960
;3960:			bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 1392
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1392
INDIRP4
INDIRF4
ARGF4
ADDRLP4 1396
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1392
INDIRP4
ADDRLP4 1396
INDIRF4
ASGNF4
line 3961
;3961:			bs->ideal_viewangles[YAW] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 1400
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1404
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 1404
INDIRP4
ADDRLP4 1404
INDIRP4
INDIRF4
CNSTF4 1090519040
CNSTF4 1073741824
ADDRLP4 1400
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 1312
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3962
;3962:			bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 1408
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 1408
INDIRP4
INDIRF4
ARGF4
ADDRLP4 1412
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1408
INDIRP4
ADDRLP4 1412
INDIRF4
ASGNF4
line 3964
;3963:			//
;3964:			if (InFieldOfVision(bs->viewangles, 20, bs->ideal_viewangles)) {
ADDRLP4 1416
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1416
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 1416
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRLP4 1420
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 1420
INDIRI4
CNSTI4 0
EQI4 $1645
line 3965
;3965:				trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3966
;3966:			}
line 3967
;3967:		}
line 3968
;3968:	}
ADDRGP4 $1645
JUMPV
LABELV $1644
line 3969
;3969:	else if (!Q_stricmp(mapname, "mpq3tourney6")) {
ADDRLP4 144
ARGP4
ADDRGP4 $1701
ARGP4
ADDRLP4 1324
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 0
NEI4 $1699
line 3971
;3970:		//NOTE: NEVER use the func_bobbing in mpq3tourney6
;3971:		bs->tfl &= ~TFL_FUNCBOB;
ADDRLP4 1328
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ASGNP4
ADDRLP4 1328
INDIRP4
ADDRLP4 1328
INDIRP4
INDIRI4
CNSTI4 -16777217
BANDI4
ASGNI4
line 3972
;3972:	}
LABELV $1699
LABELV $1645
line 3973
;3973:}
LABELV $1641
endproc BotMapScripts 1424 16
data
align 4
LABELV VEC_UP
byte 4 0
byte 4 3212836864
byte 4 0
align 4
LABELV MOVEDIR_UP
byte 4 0
byte 4 0
byte 4 1065353216
align 4
LABELV VEC_DOWN
byte 4 0
byte 4 3221225472
byte 4 0
align 4
LABELV MOVEDIR_DOWN
byte 4 0
byte 4 0
byte 4 3212836864
export BotSetMovedir
code
proc BotSetMovedir 12 16
line 3986
;3974:
;3975:/*
;3976:==================
;3977:BotSetMovedir
;3978:==================
;3979:*/
;3980:// bk001205 - made these static
;3981:static vec3_t VEC_UP		= {0, -1,  0};
;3982:static vec3_t MOVEDIR_UP	= {0,  0,  1};
;3983:static vec3_t VEC_DOWN		= {0, -2,  0};
;3984:static vec3_t MOVEDIR_DOWN	= {0,  0, -1};
;3985:
;3986:void BotSetMovedir(vec3_t angles, vec3_t movedir) {
line 3987
;3987:	if (VectorCompare(angles, VEC_UP)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_UP
ARGP4
ADDRLP4 0
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1703
line 3988
;3988:		VectorCopy(MOVEDIR_UP, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_UP
INDIRB
ASGNB 12
line 3989
;3989:	}
ADDRGP4 $1704
JUMPV
LABELV $1703
line 3990
;3990:	else if (VectorCompare(angles, VEC_DOWN)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_DOWN
ARGP4
ADDRLP4 4
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1705
line 3991
;3991:		VectorCopy(MOVEDIR_DOWN, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_DOWN
INDIRB
ASGNB 12
line 3992
;3992:	}
ADDRGP4 $1706
JUMPV
LABELV $1705
line 3993
;3993:	else {
line 3994
;3994:		AngleVectors(angles, movedir, NULL, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
CNSTP4 0
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3995
;3995:	}
LABELV $1706
LABELV $1704
line 3996
;3996:}
LABELV $1702
endproc BotSetMovedir 12 16
export BotModelMinsMaxs
proc BotModelMinsMaxs 40 0
line 4005
;3997:
;3998:/*
;3999:==================
;4000:BotModelMinsMaxs
;4001:
;4002:this is ugly
;4003:==================
;4004:*/
;4005:int BotModelMinsMaxs(int modelindex, int eType, int contents, vec3_t mins, vec3_t maxs) {
line 4009
;4006:	gentity_t *ent;
;4007:	int i;
;4008:
;4009:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 4010
;4010:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1711
JUMPV
LABELV $1708
line 4011
;4011:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1713
line 4012
;4012:			continue;
ADDRGP4 $1709
JUMPV
LABELV $1713
line 4014
;4013:		}
;4014:		if ( eType && ent->s.eType != eType) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1715
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $1715
line 4015
;4015:			continue;
ADDRGP4 $1709
JUMPV
LABELV $1715
line 4017
;4016:		}
;4017:		if ( contents && ent->r.contents != contents) {
ADDRLP4 12
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1717
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1717
line 4018
;4018:			continue;
ADDRGP4 $1709
JUMPV
LABELV $1717
line 4020
;4019:		}
;4020:		if (ent->s.modelindex == modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $1719
line 4021
;4021:			if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1721
line 4022
;4022:				VectorAdd(ent->r.currentOrigin, ent->r.mins, mins);
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $1721
line 4023
;4023:			if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1723
line 4024
;4024:				VectorAdd(ent->r.currentOrigin, ent->r.maxs, maxs);
ADDRFP4 16
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $1723
line 4025
;4025:			return i;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $1707
JUMPV
LABELV $1719
line 4027
;4026:		}
;4027:	}
LABELV $1709
line 4010
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 924
ADDP4
ASGNP4
LABELV $1711
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $1708
line 4028
;4028:	if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1725
line 4029
;4029:		VectorClear(mins);
ADDRLP4 8
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
LABELV $1725
line 4030
;4030:	if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1727
line 4031
;4031:		VectorClear(maxs);
ADDRLP4 16
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
CNSTF4 0
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRF4
ASGNF4
LABELV $1727
line 4032
;4032:	return 0;
CNSTI4 0
RETI4
LABELV $1707
endproc BotModelMinsMaxs 40 0
lit
align 4
LABELV $1730
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $1731
byte 4 3212836864
byte 4 3212836864
byte 4 3212836864
export BotFuncButtonActivateGoal
code
proc BotFuncButtonActivateGoal 648 28
line 4040
;4033:}
;4034:
;4035:/*
;4036:==================
;4037:BotFuncButtonGoal
;4038:==================
;4039:*/
;4040:int BotFuncButtonActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 4046
;4041:	int i, areas[10], numareas, modelindex, entitynum;
;4042:	char model[128];
;4043:	float lip, dist, health, angle;
;4044:	vec3_t size, start, end, mins, maxs, angles, points[10];
;4045:	vec3_t movedir, origin, goalorigin, bboxmins, bboxmaxs;
;4046:	vec3_t extramins = {1, 1, 1}, extramaxs = {-1, -1, -1};
ADDRLP4 304
ADDRGP4 $1730
INDIRB
ASGNB 12
ADDRLP4 316
ADDRGP4 $1731
INDIRB
ASGNB 12
line 4049
;4047:	bsp_trace_t bsptrace;
;4048:
;4049:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 4050
;4050:	VectorClear(activategoal->target);
ADDRLP4 560
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 564
CNSTF4 0
ASGNF4
ADDRLP4 560
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 564
INDIRF4
ASGNF4
ADDRLP4 560
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 564
INDIRF4
ASGNF4
ADDRLP4 560
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 564
INDIRF4
ASGNF4
line 4052
;4051:	//create a bot goal towards the button
;4052:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $306
ARGP4
ADDRLP4 160
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4053
;4053:	if (!*model)
ADDRLP4 160
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1732
line 4054
;4054:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1729
JUMPV
LABELV $1732
line 4055
;4055:	modelindex = atoi(model+1);
ADDRLP4 160+1
ARGP4
ADDRLP4 568
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 288
ADDRLP4 568
INDIRI4
ASGNI4
line 4056
;4056:	if (!modelindex)
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $1735
line 4057
;4057:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1729
JUMPV
LABELV $1735
line 4058
;4058:	VectorClear(angles);
ADDRLP4 572
CNSTF4 0
ASGNF4
ADDRLP4 96+8
ADDRLP4 572
INDIRF4
ASGNF4
ADDRLP4 96+4
ADDRLP4 572
INDIRF4
ASGNF4
ADDRLP4 96
ADDRLP4 572
INDIRF4
ASGNF4
line 4059
;4059:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 288
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 576
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 344
ADDRLP4 576
INDIRI4
ASGNI4
line 4061
;4060:	//get the lip of the button
;4061:	trap_AAS_FloatForBSPEpairKey(bspent, "lip", &lip);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $1739
ARGP4
ADDRLP4 328
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 4062
;4062:	if (!lip) lip = 4;
ADDRLP4 328
INDIRF4
CNSTF4 0
NEF4 $1740
ADDRLP4 328
CNSTF4 1082130432
ASGNF4
LABELV $1740
line 4064
;4063:	//get the move direction from the angle
;4064:	trap_AAS_FloatForBSPEpairKey(bspent, "angle", &angle);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $1742
ARGP4
ADDRLP4 352
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 4065
;4065:	VectorSet(angles, 0, angle, 0);
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 96+4
ADDRLP4 352
INDIRF4
ASGNF4
ADDRLP4 96+8
CNSTF4 0
ASGNF4
line 4066
;4066:	BotSetMovedir(angles, movedir);
ADDRLP4 96
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 BotSetMovedir
CALLV
pop
line 4068
;4067:	//button size
;4068:	VectorSubtract(maxs, mins, size);
ADDRLP4 112
ADDRLP4 84
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 72+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 72+8
INDIRF4
SUBF4
ASGNF4
line 4070
;4069:	//button origin
;4070:	VectorAdd(mins, maxs, origin);
ADDRLP4 16
ADDRLP4 72
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 72+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 72+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 4071
;4071:	VectorScale(origin, 0.5, origin);
ADDRLP4 580
CNSTF4 1056964608
ASGNF4
ADDRLP4 16
ADDRLP4 580
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 580
INDIRF4
ADDRLP4 16+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 16+8
CNSTF4 1056964608
ADDRLP4 16+8
INDIRF4
MULF4
ASGNF4
line 4073
;4072:	//touch distance of the button
;4073:	dist = fabs(movedir[0]) * size[0] + fabs(movedir[1]) * size[1] + fabs(movedir[2]) * size[2];
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 584
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 588
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 584
INDIRF4
ADDRLP4 112
INDIRF4
MULF4
ADDRLP4 588
INDIRF4
ADDRLP4 112+4
INDIRF4
MULF4
ADDF4
ADDRLP4 592
INDIRF4
ADDRLP4 112+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 4074
;4074:	dist *= 0.5;
ADDRLP4 28
CNSTF4 1056964608
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 4076
;4075:	//
;4076:	trap_AAS_FloatForBSPEpairKey(bspent, "health", &health);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $1765
ARGP4
ADDRLP4 348
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 4078
;4077:	//if the button is shootable
;4078:	if (health) {
ADDRLP4 348
INDIRF4
CNSTF4 0
EQF4 $1766
line 4080
;4079:		//calculate the shoot target
;4080:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 596
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 596
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 596
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 4082
;4081:		//
;4082:		VectorCopy(goalorigin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 124
INDIRB
ASGNB 12
line 4083
;4083:		activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 4085
;4084:		//
;4085:		BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, goalorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 356
ARGP4
ADDRLP4 600
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 600
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 604
CNSTP4 0
ASGNP4
ADDRLP4 604
INDIRP4
ARGP4
ADDRLP4 604
INDIRP4
ARGP4
ADDRLP4 124
ARGP4
ADDRLP4 600
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100664321
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 4087
;4086:		// if the button is visible from the current position
;4087:		if (bsptrace.fraction >= 1.0 || bsptrace.ent == entitynum) {
ADDRLP4 356+8
INDIRF4
CNSTF4 1065353216
GEF4 $1778
ADDRLP4 356+80
INDIRI4
ADDRLP4 344
INDIRI4
NEI4 $1774
LABELV $1778
line 4089
;4088:			//
;4089:			activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable button
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 4090
;4090:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 4091
;4091:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 4092
;4092:			VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 4093
;4093:			activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 4094
;4094:			VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 4095
;4095:			VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 4097
;4096:			//
;4097:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1729
JUMPV
LABELV $1774
line 4099
;4098:		}
;4099:		else {
line 4102
;4100:			//create a goal from where the button is visible and shoot at the button from there
;4101:			//add bounding box size to the dist
;4102:			trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 136
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 4103
;4103:			for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1779
line 4104
;4104:				if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1783
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
ADDP4
INDIRF4
ARGF4
ADDRLP4 612
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 608
INDIRF4
ADDRLP4 612
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $1784
JUMPV
LABELV $1783
line 4105
;4105:				else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 616
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 620
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 616
INDIRF4
ADDRLP4 620
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $1784
line 4106
;4106:			}
LABELV $1780
line 4103
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1779
line 4108
;4107:			//calculate the goal origin
;4108:			VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 608
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 608
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 608
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 4110
;4109:			//
;4110:			VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 124
INDIRB
ASGNB 12
line 4111
;4111:			start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 4112
;4112:			VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 4113
;4113:			end[2] -= 512;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1140850688
SUBF4
ASGNF4
line 4114
;4114:			numareas = trap_AAS_TraceAreas(start, end, areas, points, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 440
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 612
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 612
INDIRI4
ASGNI4
line 4116
;4115:			//
;4116:			for (i = numareas-1; i >= 0; i--) {
ADDRLP4 0
ADDRLP4 108
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $1796
JUMPV
LABELV $1793
line 4117
;4117:				if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 616
INDIRI4
CNSTI4 0
EQI4 $1797
line 4118
;4118:					break;
ADDRGP4 $1795
JUMPV
LABELV $1797
line 4120
;4119:				}
;4120:			}
LABELV $1794
line 4116
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1796
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1793
LABELV $1795
line 4121
;4121:			if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1799
line 4123
;4122:				// FIXME: trace forward and maybe in other directions to find a valid area
;4123:			}
LABELV $1799
line 4124
;4124:			if (i >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1801
line 4126
;4125:				//
;4126:				VectorCopy(points[i], activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 440
ADDP4
INDIRB
ASGNB 12
line 4127
;4127:				activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 4128
;4128:				VectorSet(activategoal->goal.mins, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
line 4129
;4129:				VectorSet(activategoal->goal.maxs, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 3238002688
ASGNF4
line 4131
;4130:				//
;4131:				for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1803
line 4132
;4132:				{
line 4133
;4133:					if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1807
ADDRLP4 616
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 616
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 620
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 624
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 628
ADDRLP4 616
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 628
INDIRP4
ADDRLP4 628
INDIRP4
INDIRF4
ADDRLP4 620
INDIRF4
ADDRLP4 624
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $1808
JUMPV
LABELV $1807
line 4134
;4134:					else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 632
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 632
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 636
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 640
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 644
ADDRLP4 632
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 644
INDIRP4
ADDRLP4 644
INDIRP4
INDIRF4
ADDRLP4 636
INDIRF4
ADDRLP4 640
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $1808
line 4135
;4135:				} //end for
LABELV $1804
line 4131
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1803
line 4137
;4136:				//
;4137:				activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 4138
;4138:				activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 4139
;4139:				activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 4140
;4140:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1729
JUMPV
LABELV $1801
line 4142
;4141:			}
;4142:		}
line 4143
;4143:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1729
JUMPV
LABELV $1766
line 4145
;4144:	}
;4145:	else {
line 4147
;4146:		//add bounding box size to the dist
;4147:		trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 136
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 4148
;4148:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1809
line 4149
;4149:			if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1813
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 596
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
ADDP4
INDIRF4
ARGF4
ADDRLP4 600
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 596
INDIRF4
ADDRLP4 600
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $1814
JUMPV
LABELV $1813
line 4150
;4150:			else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 604
INDIRF4
ADDRLP4 608
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $1814
line 4151
;4151:		}
LABELV $1810
line 4148
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1809
line 4153
;4152:		//calculate the goal origin
;4153:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 596
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 596
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 596
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 4155
;4154:		//
;4155:		VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 124
INDIRB
ASGNB 12
line 4156
;4156:		start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 4157
;4157:		VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 4158
;4158:		end[2] -= 100;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 4159
;4159:		numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 600
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 600
INDIRI4
ASGNI4
line 4161
;4160:		//
;4161:		for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1826
JUMPV
LABELV $1823
line 4162
;4162:			if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 604
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 604
INDIRI4
CNSTI4 0
EQI4 $1827
line 4163
;4163:				break;
ADDRGP4 $1825
JUMPV
LABELV $1827
line 4165
;4164:			}
;4165:		}
LABELV $1824
line 4161
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1826
ADDRLP4 0
INDIRI4
ADDRLP4 108
INDIRI4
LTI4 $1823
LABELV $1825
line 4166
;4166:		if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 108
INDIRI4
GEI4 $1829
line 4168
;4167:			//
;4168:			VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 4169
;4169:			activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 4170
;4170:			VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 4171
;4171:			VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 84
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 84+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 84+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 4173
;4172:			//
;4173:			for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1839
line 4174
;4174:			{
line 4175
;4175:				if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1843
ADDRLP4 604
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 604
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 612
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 616
ADDRLP4 604
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 616
INDIRP4
ADDRLP4 616
INDIRP4
INDIRF4
ADDRLP4 608
INDIRF4
ADDRLP4 612
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $1844
JUMPV
LABELV $1843
line 4176
;4176:				else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 620
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 620
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 624
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 628
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 632
ADDRLP4 620
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 632
INDIRP4
ADDRLP4 632
INDIRP4
INDIRF4
ADDRLP4 624
INDIRF4
ADDRLP4 628
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $1844
line 4177
;4177:			} //end for
LABELV $1840
line 4173
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1839
line 4179
;4178:			//
;4179:			activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 4180
;4180:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 4181
;4181:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 4182
;4182:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1729
JUMPV
LABELV $1829
line 4184
;4183:		}
;4184:	}
line 4185
;4185:	return qfalse;
CNSTI4 0
RETI4
LABELV $1729
endproc BotFuncButtonActivateGoal 648 28
export BotFuncDoorActivateGoal
proc BotFuncDoorActivateGoal 1096 20
line 4193
;4186:}
;4187:
;4188:/*
;4189:==================
;4190:BotFuncDoorGoal
;4191:==================
;4192:*/
;4193:int BotFuncDoorActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 4199
;4194:	int modelindex, entitynum;
;4195:	char model[MAX_INFO_STRING];
;4196:	vec3_t mins, maxs, origin, angles;
;4197:
;4198:	//shoot at the shootable door
;4199:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $306
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4200
;4200:	if (!*model)
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1846
line 4201
;4201:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1845
JUMPV
LABELV $1846
line 4202
;4202:	modelindex = atoi(model+1);
ADDRLP4 12+1
ARGP4
ADDRLP4 1080
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1060
ADDRLP4 1080
INDIRI4
ASGNI4
line 4203
;4203:	if (!modelindex)
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $1849
line 4204
;4204:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1845
JUMPV
LABELV $1849
line 4205
;4205:	VectorClear(angles);
ADDRLP4 1084
CNSTF4 0
ASGNF4
ADDRLP4 1064+8
ADDRLP4 1084
INDIRF4
ASGNF4
ADDRLP4 1064+4
ADDRLP4 1084
INDIRF4
ASGNF4
ADDRLP4 1064
ADDRLP4 1084
INDIRF4
ASGNF4
line 4206
;4206:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 1060
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 1036
ARGP4
ADDRLP4 1048
ARGP4
ADDRLP4 1088
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 1076
ADDRLP4 1088
INDIRI4
ASGNI4
line 4208
;4207:	//door origin
;4208:	VectorAdd(mins, maxs, origin);
ADDRLP4 0
ADDRLP4 1036
INDIRF4
ADDRLP4 1048
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 1036+4
INDIRF4
ADDRLP4 1048+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 1036+8
INDIRF4
ADDRLP4 1048+8
INDIRF4
ADDF4
ASGNF4
line 4209
;4209:	VectorScale(origin, 0.5, origin);
ADDRLP4 1092
CNSTF4 1056964608
ASGNF4
ADDRLP4 0
ADDRLP4 1092
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 1092
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
CNSTF4 1056964608
ADDRLP4 0+8
INDIRF4
MULF4
ASGNF4
line 4210
;4210:	VectorCopy(origin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 4211
;4211:	activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 4213
;4212:	//
;4213:	activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable door
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 1076
INDIRI4
ASGNI4
line 4214
;4214:	activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 4215
;4215:	activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 4216
;4216:	VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 4217
;4217:	activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 4218
;4218:	VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 4219
;4219:	VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 4220
;4220:	return qtrue;
CNSTI4 1
RETI4
LABELV $1845
endproc BotFuncDoorActivateGoal 1096 20
export BotTriggerMultipleActivateGoal
proc BotTriggerMultipleActivateGoal 300 20
line 4228
;4221:	} 
;4222:
;4223:/*
;4224:==================
;4225:BotTriggerMultipleGoal
;4226:==================
;4227:*/
;4228:int BotTriggerMultipleActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 4234
;4229:	int i, areas[10], numareas, modelindex, entitynum;
;4230:	char model[128];
;4231:	vec3_t start, end, mins, maxs, angles;
;4232:	vec3_t origin, goalorigin;
;4233:
;4234:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 4235
;4235:	VectorClear(activategoal->target);
ADDRLP4 268
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 272
CNSTF4 0
ASGNF4
ADDRLP4 268
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 268
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 268
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 272
INDIRF4
ASGNF4
line 4237
;4236:	//create a bot goal towards the trigger
;4237:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $306
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4238
;4238:	if (!*model)
ADDRLP4 84
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1864
line 4239
;4239:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1863
JUMPV
LABELV $1864
line 4240
;4240:	modelindex = atoi(model+1);
ADDRLP4 84+1
ARGP4
ADDRLP4 276
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 224
ADDRLP4 276
INDIRI4
ASGNI4
line 4241
;4241:	if (!modelindex)
ADDRLP4 224
INDIRI4
CNSTI4 0
NEI4 $1867
line 4242
;4242:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1863
JUMPV
LABELV $1867
line 4243
;4243:	VectorClear(angles);
ADDRLP4 280
CNSTF4 0
ASGNF4
ADDRLP4 240+8
ADDRLP4 280
INDIRF4
ASGNF4
ADDRLP4 240+4
ADDRLP4 280
INDIRF4
ASGNF4
ADDRLP4 240
ADDRLP4 280
INDIRF4
ASGNF4
line 4244
;4244:	entitynum = BotModelMinsMaxs(modelindex, 0, CONTENTS_TRIGGER, mins, maxs);
ADDRLP4 224
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1073741824
ARGI4
ADDRLP4 60
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 284
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 264
ADDRLP4 284
INDIRI4
ASGNI4
line 4246
;4245:	//trigger origin
;4246:	VectorAdd(mins, maxs, origin);
ADDRLP4 4
ADDRLP4 60
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 60+4
INDIRF4
ADDRLP4 72+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 60+8
INDIRF4
ADDRLP4 72+8
INDIRF4
ADDF4
ASGNF4
line 4247
;4247:	VectorScale(origin, 0.5, origin);
ADDRLP4 288
CNSTF4 1056964608
ASGNF4
ADDRLP4 4
ADDRLP4 288
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 288
INDIRF4
ADDRLP4 4+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4+8
CNSTF4 1056964608
ADDRLP4 4+8
INDIRF4
MULF4
ASGNF4
line 4248
;4248:	VectorCopy(origin, goalorigin);
ADDRLP4 252
ADDRLP4 4
INDIRB
ASGNB 12
line 4250
;4249:	//
;4250:	VectorCopy(goalorigin, start);
ADDRLP4 212
ADDRLP4 252
INDIRB
ASGNB 12
line 4251
;4251:	start[2] += 24;
ADDRLP4 212+8
ADDRLP4 212+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 4252
;4252:	VectorCopy(start, end);
ADDRLP4 228
ADDRLP4 212
INDIRB
ASGNB 12
line 4253
;4253:	end[2] -= 100;
ADDRLP4 228+8
ADDRLP4 228+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 4254
;4254:	numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 212
ARGP4
ADDRLP4 228
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 292
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 292
INDIRI4
ASGNI4
line 4256
;4255:	//
;4256:	for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1886
JUMPV
LABELV $1883
line 4257
;4257:		if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 296
INDIRI4
CNSTI4 0
EQI4 $1887
line 4258
;4258:			break;
ADDRGP4 $1885
JUMPV
LABELV $1887
line 4260
;4259:		}
;4260:	}
LABELV $1884
line 4256
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1886
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $1883
LABELV $1885
line 4261
;4261:	if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
GEI4 $1889
line 4262
;4262:		VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 4263
;4263:		activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ASGNI4
line 4264
;4264:		VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 60
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 60+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 60+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 4265
;4265:		VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 4267
;4266:		//
;4267:		activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 264
INDIRI4
ASGNI4
line 4268
;4268:		activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 4269
;4269:		activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 4270
;4270:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1863
JUMPV
LABELV $1889
line 4272
;4271:	}
;4272:	return qfalse;
CNSTI4 0
RETI4
LABELV $1863
endproc BotTriggerMultipleActivateGoal 300 20
export BotPopFromActivateGoalStack
proc BotPopFromActivateGoalStack 4 8
line 4280
;4273:}
;4274:
;4275:/*
;4276:==================
;4277:BotPopFromActivateGoalStack
;4278:==================
;4279:*/
;4280:int BotPopFromActivateGoalStack(bot_state_t *bs) {
line 4281
;4281:	if (!bs->activatestack)
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1900
line 4282
;4282:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1899
JUMPV
LABELV $1900
line 4283
;4283:	BotEnableActivateGoalAreas(bs->activatestack, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4284
;4284:	bs->activatestack->inuse = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
CNSTI4 0
ASGNI4
line 4285
;4285:	bs->activatestack->justused_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4286
;4286:	bs->activatestack = bs->activatestack->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4287
;4287:	return qtrue;
CNSTI4 1
RETI4
LABELV $1899
endproc BotPopFromActivateGoalStack 4 8
export BotPushOntoActivateGoalStack
proc BotPushOntoActivateGoalStack 24 12
line 4295
;4288:}
;4289:
;4290:/*
;4291:==================
;4292:BotPushOntoActivateGoalStack
;4293:==================
;4294:*/
;4295:int BotPushOntoActivateGoalStack(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 4299
;4296:	int i, best;
;4297:	float besttime;
;4298:
;4299:	best = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 4300
;4300:	besttime = FloatTime() + 9999;
ADDRLP4 4
ADDRGP4 floattime
INDIRF4
CNSTF4 1176255488
ADDF4
ASGNF4
line 4302
;4301:	//
;4302:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1903
line 4303
;4303:		if (!bs->activategoalheap[i].inuse) {
CNSTI4 244
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1907
line 4304
;4304:			if (bs->activategoalheap[i].justused_time < besttime) {
CNSTI4 244
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $1909
line 4305
;4305:				besttime = bs->activategoalheap[i].justused_time;
ADDRLP4 4
CNSTI4 244
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ASGNF4
line 4306
;4306:				best = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 4307
;4307:			}
LABELV $1909
line 4308
;4308:		}
LABELV $1907
line 4309
;4309:	}
LABELV $1904
line 4302
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $1903
line 4310
;4310:	if (best != -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $1911
line 4311
;4311:		memcpy(&bs->activategoalheap[best], activategoal, sizeof(bot_activategoal_t));
ADDRLP4 12
CNSTI4 244
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4312
;4312:		bs->activategoalheap[best].inuse = qtrue;
CNSTI4 244
ADDRLP4 8
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
CNSTI4 1
ASGNI4
line 4313
;4313:		bs->activategoalheap[best].next = bs->activatestack;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 244
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 16
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
CNSTI4 240
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ASGNP4
line 4314
;4314:		bs->activatestack = &bs->activategoalheap[best];
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 7116
ADDP4
CNSTI4 244
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 20
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
ASGNP4
line 4315
;4315:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1902
JUMPV
LABELV $1911
line 4317
;4316:	}
;4317:	return qfalse;
CNSTI4 0
RETI4
LABELV $1902
endproc BotPushOntoActivateGoalStack 24 12
export BotClearActivateGoalStack
proc BotClearActivateGoalStack 0 4
line 4325
;4318:}
;4319:
;4320:/*
;4321:==================
;4322:BotClearActivateGoalStack
;4323:==================
;4324:*/
;4325:void BotClearActivateGoalStack(bot_state_t *bs) {
ADDRGP4 $1915
JUMPV
LABELV $1914
line 4327
;4326:	while(bs->activatestack)
;4327:		BotPopFromActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotPopFromActivateGoalStack
CALLI4
pop
LABELV $1915
line 4326
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1914
line 4328
;4328:}
LABELV $1913
endproc BotClearActivateGoalStack 0 4
export BotEnableActivateGoalAreas
proc BotEnableActivateGoalAreas 12 8
line 4335
;4329:
;4330:/*
;4331:==================
;4332:BotEnableActivateGoalAreas
;4333:==================
;4334:*/
;4335:void BotEnableActivateGoalAreas(bot_activategoal_t *activategoal, int enable) {
line 4338
;4336:	int i;
;4337:
;4338:	if (activategoal->areasdisabled == !enable)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $1921
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $1922
JUMPV
LABELV $1921
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $1922
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1918
line 4339
;4339:		return;
ADDRGP4 $1917
JUMPV
LABELV $1918
line 4340
;4340:	for (i = 0; i < activategoal->numareas; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1926
JUMPV
LABELV $1923
line 4341
;4341:		trap_AAS_EnableRoutingArea( activategoal->areas[i], enable );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 trap_AAS_EnableRoutingArea
CALLI4
pop
LABELV $1924
line 4340
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1926
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
LTI4 $1923
line 4342
;4342:	activategoal->areasdisabled = !enable;
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $1928
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $1929
JUMPV
LABELV $1928
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1929
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4343
;4343:}
LABELV $1917
endproc BotEnableActivateGoalAreas 12 8
export BotIsGoingToActivateEntity
proc BotIsGoingToActivateEntity 8 0
line 4350
;4344:
;4345:/*
;4346:==================
;4347:BotIsGoingToActivateEntity
;4348:==================
;4349:*/
;4350:int BotIsGoingToActivateEntity(bot_state_t *bs, int entitynum) {
line 4354
;4351:	bot_activategoal_t *a;
;4352:	int i;
;4353:
;4354:	for (a = bs->activatestack; a; a = a->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $1934
JUMPV
LABELV $1931
line 4355
;4355:		if (a->time < FloatTime())
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1935
line 4356
;4356:			continue;
ADDRGP4 $1932
JUMPV
LABELV $1935
line 4357
;4357:		if (a->goal.entitynum == entitynum)
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1937
line 4358
;4358:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1930
JUMPV
LABELV $1937
line 4359
;4359:	}
LABELV $1932
line 4354
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
LABELV $1934
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1931
line 4360
;4360:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $1939
line 4361
;4361:		if (bs->activategoalheap[i].inuse)
CNSTI4 244
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1943
line 4362
;4362:			continue;
ADDRGP4 $1940
JUMPV
LABELV $1943
line 4364
;4363:		//
;4364:		if (bs->activategoalheap[i].goal.entitynum == entitynum) {
CNSTI4 244
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1945
line 4366
;4365:			// if the bot went for this goal less than 2 seconds ago
;4366:			if (bs->activategoalheap[i].justused_time > FloatTime() - 2)
CNSTI4 244
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
LEF4 $1947
line 4367
;4367:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1930
JUMPV
LABELV $1947
line 4368
;4368:		}
LABELV $1945
line 4369
;4369:	}
LABELV $1940
line 4360
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 8
LTI4 $1939
line 4370
;4370:	return qfalse;
CNSTI4 0
RETI4
LABELV $1930
endproc BotIsGoingToActivateEntity 8 0
export BotGetActivateGoal
proc BotGetActivateGoal 3320 20
line 4383
;4371:}
;4372:
;4373:/*
;4374:==================
;4375:BotGetActivateGoal
;4376:
;4377:  returns the number of the bsp entity to activate
;4378:  goal->entitynum will be set to the game entity to activate
;4379:==================
;4380:*/
;4381://#define OBSTACLEDEBUG
;4382:
;4383:int BotGetActivateGoal(bot_state_t *bs, int entitynum, bot_activategoal_t *activategoal) {
line 4393
;4384:	int i, ent, cur_entities[10], spawnflags, modelindex, areas[MAX_ACTIVATEAREAS*2], numareas, t;
;4385:	char model[MAX_INFO_STRING], tmpmodel[128];
;4386:	char target[128], classname[128];
;4387:	float health;
;4388:	char targetname[10][128];
;4389:	aas_entityinfo_t entinfo;
;4390:	aas_areainfo_t areainfo;
;4391:	vec3_t origin, angles, absmins, absmaxs;
;4392:
;4393:	memset(activategoal, 0, sizeof(bot_activategoal_t));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 244
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4394
;4394:	BotEntityInfo(entitynum, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 3052
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4395
;4395:	Com_sprintf(model, sizeof( model ), "*%d", entinfo.modelindex);
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1950
ARGP4
ADDRLP4 3052+104
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4396
;4396:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 3252
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3252
INDIRI4
ASGNI4
ADDRGP4 $1955
JUMPV
LABELV $1952
line 4397
;4397:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", tmpmodel, sizeof(tmpmodel))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $306
ARGP4
ADDRLP4 1584
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3256
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3256
INDIRI4
CNSTI4 0
NEI4 $1956
ADDRGP4 $1953
JUMPV
LABELV $1956
line 4398
;4398:		if (!strcmp(model, tmpmodel)) break;
ADDRLP4 1712
ARGP4
ADDRLP4 1584
ARGP4
ADDRLP4 3260
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3260
INDIRI4
CNSTI4 0
NEI4 $1958
ADDRGP4 $1954
JUMPV
LABELV $1958
line 4399
;4399:	}
LABELV $1953
line 4396
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3256
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3256
INDIRI4
ASGNI4
LABELV $1955
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1952
LABELV $1954
line 4400
;4400:	if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1960
line 4401
;4401:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity found with model %s\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $1962
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4402
;4402:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1949
JUMPV
LABELV $1960
line 4404
;4403:	}
;4404:	trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1963
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4405
;4405:	if (!classname) {
ADDRLP4 1456
CVPU4 4
CNSTU4 0
NEU4 $1964
line 4406
;4406:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model %s has no classname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $1966
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4407
;4407:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1949
JUMPV
LABELV $1964
line 4410
;4408:	}
;4409:	//if it is a door
;4410:	if (!strcmp(classname, "func_door")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1969
ARGP4
ADDRLP4 3260
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3260
INDIRI4
CNSTI4 0
NEI4 $1967
line 4411
;4411:		if (trap_AAS_FloatForBSPEpairKey(ent, "health", &health)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1765
ARGP4
ADDRLP4 3208
ARGP4
ADDRLP4 3264
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3264
INDIRI4
CNSTI4 0
EQI4 $1970
line 4413
;4412:			//if the door has health then the door must be shot to open
;4413:			if (health) {
ADDRLP4 3208
INDIRF4
CNSTF4 0
EQF4 $1972
line 4414
;4414:				BotFuncDoorActivateGoal(bs, ent, activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotFuncDoorActivateGoal
CALLI4
pop
line 4415
;4415:				return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1949
JUMPV
LABELV $1972
line 4417
;4416:			}
;4417:		}
LABELV $1970
line 4420
;4418:
;4419:	//if it is some glass
;4420: 	if (!strcmp(classname, "func_breakable")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1976
ARGP4
ADDRLP4 3268
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $1974
line 4421
;4421: 		return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1949
JUMPV
LABELV $1974
line 4425
;4422: 	}
;4423:	
;4424:		//
;4425:		trap_AAS_IntForBSPEpairKey(ent, "spawnflags", &spawnflags);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1977
ARGP4
ADDRLP4 3204
ARGP4
ADDRGP4 trap_AAS_IntForBSPEpairKey
CALLI4
pop
line 4427
;4426:		// if the door starts open then just wait for the door to return
;4427:		if ( spawnflags & 1 )
ADDRLP4 3204
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1978
line 4428
;4428:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $1949
JUMPV
LABELV $1978
line 4430
;4429:		//get the door origin
;4430:		if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1982
ARGP4
ADDRLP4 3192
ARGP4
ADDRLP4 3272
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
NEI4 $1980
line 4431
;4431:			VectorClear(origin);
ADDRLP4 3276
CNSTF4 0
ASGNF4
ADDRLP4 3192+8
ADDRLP4 3276
INDIRF4
ASGNF4
ADDRLP4 3192+4
ADDRLP4 3276
INDIRF4
ASGNF4
ADDRLP4 3192
ADDRLP4 3276
INDIRF4
ASGNF4
line 4432
;4432:		}
LABELV $1980
line 4434
;4433:		//if the door is open or opening already
;4434:		if (!VectorCompare(origin, entinfo.origin))
ADDRLP4 3192
ARGP4
ADDRLP4 3052+24
ARGP4
ADDRLP4 3276
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 0
NEI4 $1985
line 4435
;4435:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $1949
JUMPV
LABELV $1985
line 4437
;4436:		// store all the areas the door is in
;4437:		trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $306
ARGP4
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4438
;4438:		if (*model) {
ADDRLP4 1712
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1988
line 4439
;4439:			modelindex = atoi(model+1);
ADDRLP4 1712+1
ARGP4
ADDRLP4 3280
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 3212
ADDRLP4 3280
INDIRI4
ASGNI4
line 4440
;4440:			if (modelindex) {
ADDRLP4 3212
INDIRI4
CNSTI4 0
EQI4 $1991
line 4441
;4441:				VectorClear(angles);
ADDRLP4 3284
CNSTF4 0
ASGNF4
ADDRLP4 3216+8
ADDRLP4 3284
INDIRF4
ASGNF4
ADDRLP4 3216+4
ADDRLP4 3284
INDIRF4
ASGNF4
ADDRLP4 3216
ADDRLP4 3284
INDIRF4
ASGNF4
line 4442
;4442:				BotModelMinsMaxs(modelindex, ET_MOVER, 0, absmins, absmaxs);
ADDRLP4 3212
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 3228
ARGP4
ADDRLP4 3240
ARGP4
ADDRGP4 BotModelMinsMaxs
CALLI4
pop
line 4444
;4443:				//
;4444:				numareas = trap_AAS_BBoxAreas(absmins, absmaxs, areas, MAX_ACTIVATEAREAS*2);
ADDRLP4 3228
ARGP4
ADDRLP4 3240
ARGP4
ADDRLP4 2740
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 3288
ADDRGP4 trap_AAS_BBoxAreas
CALLI4
ASGNI4
ADDRLP4 3048
ADDRLP4 3288
INDIRI4
ASGNI4
line 4446
;4445:				// store the areas with reachabilities first
;4446:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $1998
JUMPV
LABELV $1995
line 4447
;4447:					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $1999
line 4448
;4448:						break;
ADDRGP4 $1997
JUMPV
LABELV $1999
line 4449
;4449:					if ( !trap_AAS_AreaReachability(areas[i]) ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3292
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
NEI4 $2001
line 4450
;4450:						continue;
ADDRGP4 $1996
JUMPV
LABELV $2001
line 4452
;4451:					}
;4452:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 4453
;4453:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2003
line 4454
;4454:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3300
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3296
ADDRLP4 3300
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3300
INDIRP4
ADDRLP4 3296
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3304
CNSTI4 2
ASGNI4
ADDRLP4 3296
INDIRI4
ADDRLP4 3304
INDIRI4
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
ADDRLP4 3304
INDIRI4
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 4455
;4455:					}
LABELV $2003
line 4456
;4456:				}
LABELV $1996
line 4446
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1998
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $1995
LABELV $1997
line 4458
;4457:				// store any remaining areas
;4458:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2008
JUMPV
LABELV $2005
line 4459
;4459:					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2009
line 4460
;4460:						break;
ADDRGP4 $2007
JUMPV
LABELV $2009
line 4461
;4461:					if ( trap_AAS_AreaReachability(areas[i]) ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3292
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
EQI4 $2011
line 4462
;4462:						continue;
ADDRGP4 $2006
JUMPV
LABELV $2011
line 4464
;4463:					}
;4464:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 4465
;4465:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2013
line 4466
;4466:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3300
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3296
ADDRLP4 3300
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3300
INDIRP4
ADDRLP4 3296
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3304
CNSTI4 2
ASGNI4
ADDRLP4 3296
INDIRI4
ADDRLP4 3304
INDIRI4
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
ADDRLP4 3304
INDIRI4
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 4467
;4467:					}
LABELV $2013
line 4468
;4468:				}
LABELV $2006
line 4458
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2008
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $2005
LABELV $2007
line 4469
;4469:			}
LABELV $1991
line 4470
;4470:		}
LABELV $1988
line 4471
;4471:	}
LABELV $1967
line 4473
;4472:	// if the bot is blocked by or standing on top of a button
;4473:	if (!strcmp(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2017
ARGP4
ADDRLP4 3264
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3264
INDIRI4
CNSTI4 0
NEI4 $2015
line 4474
;4474:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1949
JUMPV
LABELV $2015
line 4477
;4475:	}
;4476:	// get the targetname so we can find an entity with a matching target
;4477:	if (!trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[0], sizeof(targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2020
ARGP4
ADDRLP4 136
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3268
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $2018
line 4478
;4478:		if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2021
line 4479
;4479:			BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model \"%s\" has no targetname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $2024
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4480
;4480:		}
LABELV $2021
line 4481
;4481:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1949
JUMPV
LABELV $2018
line 4484
;4482:	}
;4483:	// allow tree-like activation
;4484:	cur_entities[0] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 1416
ADDRLP4 3272
INDIRI4
ASGNI4
line 4485
;4485:	for (i = 0; i >= 0 && i < 10;) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2028
JUMPV
LABELV $2025
line 4486
;4486:		for (ent = cur_entities[i]; ent; ent = trap_AAS_NextBSPEntity(ent)) {
ADDRLP4 0
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $2032
JUMPV
LABELV $2029
line 4487
;4487:			if (!trap_AAS_ValueForBSPEpairKey(ent, "target", target, sizeof(target))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2035
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3276
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 0
NEI4 $2033
ADDRGP4 $2030
JUMPV
LABELV $2033
line 4488
;4488:			if (!strcmp(targetname[i], target)) {
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 3280
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $2036
line 4489
;4489:				cur_entities[i] = trap_AAS_NextBSPEntity(ent);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3284
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3284
INDIRI4
ASGNI4
line 4490
;4490:				break;
ADDRGP4 $2031
JUMPV
LABELV $2036
line 4492
;4491:			}
;4492:		}
LABELV $2030
line 4486
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3276
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3276
INDIRI4
ASGNI4
LABELV $2032
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2029
LABELV $2031
line 4493
;4493:		if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2038
line 4494
;4494:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2040
line 4495
;4495:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity with target \"%s\"\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $2043
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4496
;4496:			}
LABELV $2040
line 4497
;4497:			i--;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4498
;4498:			continue;
ADDRGP4 $2026
JUMPV
LABELV $2038
line 4500
;4499:		}
;4500:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1963
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3280
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $2044
line 4501
;4501:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2026
line 4502
;4502:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with target \"%s\" has no classname\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $2049
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4503
;4503:			}
line 4504
;4504:			continue;
ADDRGP4 $2026
JUMPV
LABELV $2044
line 4507
;4505:		}
;4506:		// BSP button model
;4507:		if (!strcmp(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2017
ARGP4
ADDRLP4 3284
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3284
INDIRI4
CNSTI4 0
NEI4 $2050
line 4509
;4508:			//
;4509:			if (!BotFuncButtonActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3288
ADDRGP4 BotFuncButtonActivateGoal
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
NEI4 $2052
line 4510
;4510:				continue;
ADDRGP4 $2026
JUMPV
LABELV $2052
line 4512
;4511:			// if the bot tries to activate this button already
;4512:			if ( bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3292
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ASGNP4
ADDRLP4 3292
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2054
ADDRLP4 3292
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $2054
ADDRLP4 3296
CNSTI4 44
ASGNI4
ADDRLP4 3292
INDIRP4
ADDRLP4 3296
INDIRI4
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
ADDRLP4 3296
INDIRI4
ADDP4
INDIRI4
NEI4 $2054
ADDRLP4 3300
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3292
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3300
INDIRF4
LEF4 $2054
ADDRLP4 3292
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3300
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $2054
line 4516
;4513:				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;4514:				 bs->activatestack->time > FloatTime() &&
;4515:				 bs->activatestack->start_time < FloatTime() - 2)
;4516:				continue;
ADDRGP4 $2026
JUMPV
LABELV $2054
line 4518
;4517:			// if the bot is in a reachability area
;4518:			if ( trap_AAS_AreaReachability(bs->areanum) ) {
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3304
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3304
INDIRI4
CNSTI4 0
EQI4 $2056
line 4520
;4519:				// disable all areas the blocking entity is in
;4520:				BotEnableActivateGoalAreas( activategoal, qfalse );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4522
;4521:				//
;4522:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3308
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3308
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3308
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 3312
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3312
INDIRI4
ASGNI4
line 4524
;4523:				// if the button is not reachable
;4524:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $2058
line 4525
;4525:					continue;
ADDRGP4 $2026
JUMPV
LABELV $2058
line 4527
;4526:				}
;4527:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1008981770
ADDRLP4 2736
INDIRI4
CVIF4 4
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 4528
;4528:			}
LABELV $2056
line 4529
;4529:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1949
JUMPV
LABELV $2050
line 4532
;4530:		}
;4531:		// invisible trigger multiple box
;4532:		else if (!strcmp(classname, "trigger_multiple")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2062
ARGP4
ADDRLP4 3288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
NEI4 $2060
line 4534
;4533:			//
;4534:			if (!BotTriggerMultipleActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3292
ADDRGP4 BotTriggerMultipleActivateGoal
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
NEI4 $2063
line 4535
;4535:				continue;
ADDRGP4 $2026
JUMPV
LABELV $2063
line 4537
;4536:			// if the bot tries to activate this trigger already
;4537:			if ( bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3296
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ASGNP4
ADDRLP4 3296
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2065
ADDRLP4 3296
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $2065
ADDRLP4 3300
CNSTI4 44
ASGNI4
ADDRLP4 3296
INDIRP4
ADDRLP4 3300
INDIRI4
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
ADDRLP4 3300
INDIRI4
ADDP4
INDIRI4
NEI4 $2065
ADDRLP4 3304
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3296
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3304
INDIRF4
LEF4 $2065
ADDRLP4 3296
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3304
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $2065
line 4541
;4538:				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;4539:				 bs->activatestack->time > FloatTime() &&
;4540:				 bs->activatestack->start_time < FloatTime() - 2)
;4541:				continue;
ADDRGP4 $2026
JUMPV
LABELV $2065
line 4543
;4542:			// if the bot is in a reachability area
;4543:			if ( trap_AAS_AreaReachability(bs->areanum) ) {
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3308
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3308
INDIRI4
CNSTI4 0
EQI4 $2067
line 4545
;4544:				// disable all areas the blocking entity is in
;4545:				BotEnableActivateGoalAreas( activategoal, qfalse );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4547
;4546:				//
;4547:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3312
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3312
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3312
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 3316
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3316
INDIRI4
ASGNI4
line 4549
;4548:				// if the trigger is not reachable
;4549:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $2069
line 4550
;4550:					continue;
ADDRGP4 $2026
JUMPV
LABELV $2069
line 4552
;4551:				}
;4552:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1008981770
ADDRLP4 2736
INDIRI4
CVIF4 4
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 4553
;4553:			}
LABELV $2067
line 4554
;4554:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1949
JUMPV
LABELV $2060
line 4556
;4555:		}
;4556:		else if (!strcmp(classname, "func_timer")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2073
ARGP4
ADDRLP4 3292
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
NEI4 $2071
line 4558
;4557:			// just skip the func_timer
;4558:			continue;
ADDRGP4 $2026
JUMPV
LABELV $2071
line 4561
;4559:		}
;4560:		// the actual button or trigger might be linked through a target_relay or target_delay
;4561:		else if (!strcmp(classname, "target_relay") || !strcmp(classname, "target_delay")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2076
ARGP4
ADDRLP4 3296
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3296
INDIRI4
CNSTI4 0
EQI4 $2078
ADDRLP4 1456
ARGP4
ADDRGP4 $2077
ARGP4
ADDRLP4 3300
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3300
INDIRI4
CNSTI4 0
NEI4 $2074
LABELV $2078
line 4562
;4562:			if (trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[i+1], sizeof(targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2020
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136+128
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3304
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3304
INDIRI4
CNSTI4 0
EQI4 $2079
line 4563
;4563:				i++;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4564
;4564:				cur_entities[i] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3308
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3308
INDIRI4
ASGNI4
line 4565
;4565:			}
LABELV $2079
line 4566
;4566:		}
LABELV $2074
line 4567
;4567:	}
LABELV $2026
line 4485
LABELV $2028
ADDRLP4 132
INDIRI4
CNSTI4 0
LTI4 $2082
ADDRLP4 132
INDIRI4
CNSTI4 10
LTI4 $2025
LABELV $2082
line 4571
;4568:#ifdef OBSTACLEDEBUG
;4569:	BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no valid activator for entity with target \"%s\"\n", targetname[0]);
;4570:#endif
;4571:	return 0;
CNSTI4 0
RETI4
LABELV $1949
endproc BotGetActivateGoal 3320 20
export BotGoForActivateGoal
proc BotGoForActivateGoal 144 8
line 4579
;4572:}
;4573:
;4574:/*
;4575:==================
;4576:BotGoForActivateGoal
;4577:==================
;4578:*/
;4579:int BotGoForActivateGoal(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 4582
;4580:	aas_entityinfo_t activateinfo;
;4581:
;4582:	activategoal->inuse = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 4583
;4583:	if (!activategoal->time)
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
CNSTF4 0
NEF4 $2084
line 4584
;4584:		activategoal->time = FloatTime() + 10;
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
LABELV $2084
line 4585
;4585:	activategoal->start_time = FloatTime();
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4586
;4586:	BotEntityInfo(activategoal->goal.entitynum, &activateinfo);
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4587
;4587:	VectorCopy(activateinfo.origin, activategoal->origin);
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 4589
;4588:	//
;4589:	if (BotPushOntoActivateGoalStack(bs, activategoal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotPushOntoActivateGoalStack
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $2087
line 4591
;4590:		// enter the activate entity AI node
;4591:		AIEnter_Seek_ActivateEntity(bs, "BotGoForActivateGoal");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2089
ARGP4
ADDRGP4 AIEnter_Seek_ActivateEntity
CALLV
pop
line 4592
;4592:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2083
JUMPV
LABELV $2087
line 4594
;4593:	}
;4594:	else {
line 4596
;4595:		// enable any routing areas that were disabled
;4596:		BotEnableActivateGoalAreas(activategoal, qtrue);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4597
;4597:		return qfalse;
CNSTI4 0
RETI4
LABELV $2083
endproc BotGoForActivateGoal 144 8
export BotPrintActivateGoalInfo
proc BotPrintActivateGoalInfo 296 36
line 4606
;4598:	}
;4599:}
;4600:
;4601:/*
;4602:==================
;4603:BotPrintActivateGoalInfo
;4604:==================
;4605:*/
;4606:void BotPrintActivateGoalInfo(bot_state_t *bs, bot_activategoal_t *activategoal, int bspent) {
line 4611
;4607:	char netname[MAX_NETNAME];
;4608:	char classname[128];
;4609:	char buf[128];
;4610:
;4611:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 4612
;4612:	trap_AAS_ValueForBSPEpairKey(bspent, "classname", classname, sizeof(classname));
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $1963
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4613
;4613:	if (activategoal->shoot) {
ADDRFP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2091
line 4614
;4614:		Com_sprintf(buf, sizeof(buf), "%s: I have to shoot at a %s from %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $2093
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4620
;4615:						netname, classname,
;4616:						activategoal->goal.origin[0],
;4617:						activategoal->goal.origin[1],
;4618:						activategoal->goal.origin[2],
;4619:						activategoal->goal.areanum);
;4620:	}
ADDRGP4 $2092
JUMPV
LABELV $2091
line 4621
;4621:	else {
line 4622
;4622:		Com_sprintf(buf, sizeof(buf), "%s: I have to activate a %s at %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $2094
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4628
;4623:						netname, classname,
;4624:						activategoal->goal.origin[0],
;4625:						activategoal->goal.origin[1],
;4626:						activategoal->goal.origin[2],
;4627:						activategoal->goal.areanum);
;4628:	}
LABELV $2092
line 4629
;4629:	trap_EA_Say(bs->client, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
ARGP4
ADDRGP4 trap_EA_Say
CALLV
pop
line 4630
;4630:}
LABELV $2090
endproc BotPrintActivateGoalInfo 296 36
export BotRandomMove
proc BotRandomMove 32 16
line 4637
;4631:
;4632:/*
;4633:==================
;4634:BotRandomMove
;4635:==================
;4636:*/
;4637:void BotRandomMove(bot_state_t *bs, bot_moveresult_t *moveresult) {
line 4640
;4638:	vec3_t dir, angles;
;4639:
;4640:	angles[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4641
;4641:	angles[1] = random() * 360;
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1135869952
ADDRLP4 24
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ASGNF4
line 4642
;4642:	angles[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4643
;4643:	AngleVectors(angles, dir, NULL, NULL);
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
CNSTP4 0
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4645
;4644:
;4645:	trap_BotMoveInDirection(bs->ms, dir, 400, MOVE_WALK);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 4647
;4646:
;4647:	moveresult->failure = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4648
;4648:	VectorCopy(dir, moveresult->movedir);
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4649
;4649:}
LABELV $2095
endproc BotRandomMove 32 16
lit
align 4
LABELV $2099
byte 4 0
byte 4 0
byte 4 1065353216
export BotAIBlocked
code
proc BotAIBlocked 528 16
line 4662
;4650:
;4651:/*
;4652:==================
;4653:BotAIBlocked
;4654:
;4655:Very basic handling of bots being blocked by other entities.
;4656:Check what kind of entity is blocking the bot and try to activate
;4657:it. If that's not an option then try to walk around or over the entity.
;4658:Before the bot ends in this part of the AI it should predict which doors to
;4659:open, which buttons to activate etc.
;4660:==================
;4661:*/
;4662:void BotAIBlocked(bot_state_t *bs, bot_moveresult_t *moveresult, int activate) {
line 4664
;4663:	int movetype, bspent;
;4664:	vec3_t hordir, start, end, mins, maxs, sideward, angles, up = {0, 0, 1};
ADDRLP4 228
ADDRGP4 $2099
INDIRB
ASGNB 12
line 4669
;4665:	aas_entityinfo_t entinfo;
;4666:	bot_activategoal_t activategoal;
;4667:
;4668:	// if the bot is not blocked by anything
;4669:	if (!moveresult->blocked) {
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2100
line 4670
;4670:		bs->notblocked_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6204
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4671
;4671:		return;
ADDRGP4 $2098
JUMPV
LABELV $2100
line 4674
;4672:	}
;4673:	// if stuck in a solid area
;4674:	if ( moveresult->type == RESULTTYPE_INSOLIDAREA ) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $2102
line 4676
;4675:		// move in a random direction in the hope to get out
;4676:		BotRandomMove(bs, moveresult);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRandomMove
CALLV
pop
line 4678
;4677:		//
;4678:		return;
ADDRGP4 $2098
JUMPV
LABELV $2102
line 4681
;4679:	}
;4680:	// get info for the entity that is blocking the bot
;4681:	BotEntityInfo(moveresult->blockentity, &entinfo);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4687
;4682:#ifdef OBSTACLEDEBUG
;4683:	ClientName(bs->client, netname, sizeof(netname));
;4684:	BotAI_Print(PRT_MESSAGE, "%s: I'm blocked by model %d\n", netname, entinfo.modelindex);
;4685:#endif OBSTACLEDEBUG
;4686:	// if blocked by a bsp model and the bot wants to activate it
;4687:	if (activate && entinfo.modelindex > 0 && entinfo.modelindex <= max_bspmodelindex) {
ADDRLP4 488
CNSTI4 0
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 488
INDIRI4
EQI4 $2104
ADDRLP4 40+104
INDIRI4
ADDRLP4 488
INDIRI4
LEI4 $2104
ADDRLP4 40+104
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
GTI4 $2104
line 4689
;4688:		// find the bsp entity which should be activated in order to get the blocking entity out of the way
;4689:		bspent = BotGetActivateGoal(bs, entinfo.number, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40+20
INDIRI4
ARGI4
ADDRLP4 240
ARGP4
ADDRLP4 492
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 484
ADDRLP4 492
INDIRI4
ASGNI4
line 4690
;4690:		if (bspent) {
ADDRLP4 484
INDIRI4
CNSTI4 0
EQI4 $2109
line 4692
;4691:			//
;4692:			if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 496
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ASGNP4
ADDRLP4 496
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2111
ADDRLP4 496
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2111
line 4693
;4693:				bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
CNSTP4 0
ASGNP4
LABELV $2111
line 4695
;4694:			// if not already trying to activate this entity
;4695:			if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 240+4+40
INDIRI4
ARGI4
ADDRLP4 500
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 500
INDIRI4
CNSTI4 0
NEI4 $2113
line 4697
;4696:				//
;4697:				BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 240
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 4698
;4698:			}
LABELV $2113
line 4702
;4699:			// if ontop of an obstacle or
;4700:			// if the bot is not in a reachability area it'll still
;4701:			// need some dynamic obstacle avoidance, otherwise return
;4702:			if (!(moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) &&
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $2110
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 504
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 504
INDIRI4
CNSTI4 0
EQI4 $2110
line 4704
;4703:				trap_AAS_AreaReachability(bs->areanum))
;4704:				return;
ADDRGP4 $2098
JUMPV
line 4705
;4705:		}
LABELV $2109
line 4706
;4706:		else {
line 4708
;4707:			// enable any routing areas that were disabled
;4708:			BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 240
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4709
;4709:		}
LABELV $2110
line 4710
;4710:	}
LABELV $2104
line 4712
;4711:	// just some basic dynamic obstacle avoidance code
;4712:	hordir[0] = moveresult->movedir[0];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 4713
;4713:	hordir[1] = moveresult->movedir[1];
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
line 4714
;4714:	hordir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4716
;4715:	// if no direction just take a random direction
;4716:	if (VectorNormalize(hordir) < 0.1) {
ADDRLP4 0
ARGP4
ADDRLP4 492
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 492
INDIRF4
CNSTF4 1036831949
GEF4 $2121
line 4717
;4717:		VectorSet(angles, 0, 360 * random(), 0);
ADDRLP4 216
CNSTF4 0
ASGNF4
ADDRLP4 496
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 216+4
CNSTF4 1135869952
ADDRLP4 496
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ASGNF4
ADDRLP4 216+8
CNSTF4 0
ASGNF4
line 4718
;4718:		AngleVectors(angles, hordir, NULL, NULL);
ADDRLP4 216
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 500
CNSTP4 0
ASGNP4
ADDRLP4 500
INDIRP4
ARGP4
ADDRLP4 500
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4719
;4719:	}
LABELV $2121
line 4723
;4720:	//
;4721:	//if (moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) movetype = MOVE_JUMP;
;4722:	//else
;4723:	movetype = MOVE_WALK;
ADDRLP4 36
CNSTI4 1
ASGNI4
line 4726
;4724:	// if there's an obstacle at the bot's feet and head then
;4725:	// the bot might be able to crouch through
;4726:	VectorCopy(bs->origin, start);
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 4727
;4727:	start[2] += 18;
ADDRLP4 24+8
ADDRLP4 24+8
INDIRF4
CNSTF4 1099956224
ADDF4
ASGNF4
line 4728
;4728:	VectorMA(start, 5, hordir, end);
ADDRLP4 496
CNSTF4 1084227584
ASGNF4
ADDRLP4 180
ADDRLP4 24
INDIRF4
ADDRLP4 496
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 180+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 496
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 180+8
ADDRLP4 24+8
INDIRF4
CNSTF4 1084227584
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 4729
;4729:	VectorSet(mins, -16, -16, -24);
ADDRLP4 500
CNSTF4 3246391296
ASGNF4
ADDRLP4 192
ADDRLP4 500
INDIRF4
ASGNF4
ADDRLP4 192+4
ADDRLP4 500
INDIRF4
ASGNF4
ADDRLP4 192+8
CNSTF4 3250585600
ASGNF4
line 4730
;4730:	VectorSet(maxs, 16, 16, 4);
ADDRLP4 504
CNSTF4 1098907648
ASGNF4
ADDRLP4 204
ADDRLP4 504
INDIRF4
ASGNF4
ADDRLP4 204+4
ADDRLP4 504
INDIRF4
ASGNF4
ADDRLP4 204+8
CNSTF4 1082130432
ASGNF4
line 4735
;4731:	//
;4732:	//bsptrace = AAS_Trace(start, mins, maxs, end, bs->entitynum, MASK_PLAYERSOLID);
;4733:	//if (bsptrace.fraction >= 1) movetype = MOVE_CROUCH;
;4734:	// get the sideward vector
;4735:	CrossProduct(hordir, up, sideward);
ADDRLP4 0
ARGP4
ADDRLP4 228
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 4737
;4736:	//
;4737:	if (bs->flags & BFL_AVOIDRIGHT) VectorNegate(sideward, sideward);
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $2136
ADDRLP4 12
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
NEGF4
ASGNF4
LABELV $2136
line 4739
;4738:	// try to crouch straight forward?
;4739:	if (movetype != MOVE_CROUCH || !trap_BotMoveInDirection(bs->ms, hordir, 400, movetype)) {
ADDRLP4 36
INDIRI4
CNSTI4 2
NEI4 $2144
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 512
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 512
INDIRI4
CNSTI4 0
NEI4 $2142
LABELV $2144
line 4741
;4740:		// perform the movement
;4741:		if (!trap_BotMoveInDirection(bs->ms, sideward, 400, movetype)) {
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 516
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $2145
line 4743
;4742:			// flip the avoid direction flag
;4743:			bs->flags ^= BFL_AVOIDRIGHT;
ADDRLP4 520
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 520
INDIRP4
ADDRLP4 520
INDIRP4
INDIRI4
CNSTI4 16
BXORI4
ASGNI4
line 4746
;4744:			// flip the direction
;4745:			// VectorNegate(sideward, sideward);
;4746:			VectorMA(sideward, -1, hordir, sideward);
ADDRLP4 524
CNSTF4 3212836864
ASGNF4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 524
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 524
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 3212836864
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 4748
;4747:			// move in the other direction
;4748:			trap_BotMoveInDirection(bs->ms, sideward, 400, movetype);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 4749
;4749:		}
LABELV $2145
line 4750
;4750:	}
LABELV $2142
line 4752
;4751:	//
;4752:	if (bs->notblocked_time < FloatTime() - 0.4) {
ADDRFP4 0
INDIRP4
CNSTI4 6204
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1053609165
SUBF4
GEF4 $2153
line 4755
;4753:		// just reset goals and hope the bot will go into another direction?
;4754:		// is this still needed??
;4755:		if (bs->ainode == AINode_Seek_NBG) bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_NBG
CVPU4 4
NEU4 $2155
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $2156
JUMPV
LABELV $2155
line 4756
;4756:		else if (bs->ainode == AINode_Seek_LTG) bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_LTG
CVPU4 4
NEU4 $2157
ADDRFP4 0
INDIRP4
CNSTI4 6068
ADDP4
CNSTF4 0
ASGNF4
LABELV $2157
LABELV $2156
line 4757
;4757:	}
LABELV $2153
line 4758
;4758:}
LABELV $2098
endproc BotAIBlocked 528 16
export BotAIPredictObstacles
proc BotAIPredictObstacles 324 44
line 4770
;4759:
;4760:/*
;4761:==================
;4762:BotAIPredictObstacles
;4763:
;4764:Predict the route towards the goal and check if the bot
;4765:will be blocked by certain obstacles. When the bot has obstacles
;4766:on it's path the bot should figure out if they can be removed
;4767:by activating certain entities.
;4768:==================
;4769:*/
;4770:int BotAIPredictObstacles(bot_state_t *bs, bot_goal_t *goal) {
line 4775
;4771:	int modelnum, entitynum, bspent;
;4772:	bot_activategoal_t activategoal;
;4773:	aas_predictroute_t route;
;4774:
;4775:	if (!bot_predictobstacles.integer)
ADDRGP4 bot_predictobstacles+12
INDIRI4
CNSTI4 0
NEI4 $2160
line 4776
;4776:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2159
JUMPV
LABELV $2160
line 4779
;4777:
;4778:	// always predict when the goal change or at regular intervals
;4779:	if (bs->predictobstacles_goalareanum == goal->areanum &&
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 6216
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $2163
ADDRLP4 292
INDIRP4
CNSTI4 6212
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1086324736
SUBF4
LEF4 $2163
line 4780
;4780:		bs->predictobstacles_time > FloatTime() - 6) {
line 4781
;4781:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2159
JUMPV
LABELV $2163
line 4783
;4782:	}
;4783:	bs->predictobstacles_goalareanum = goal->areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6216
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 4784
;4784:	bs->predictobstacles_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6212
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4787
;4785:
;4786:	// predict at most 100 areas or 10 seconds ahead
;4787:	trap_AAS_PredictRoute(&route, bs->areanum, bs->origin,
ADDRLP4 0
ARGP4
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
CNSTI4 1000
ARGI4
CNSTI4 6
ARGI4
CNSTI4 1024
ARGI4
CNSTI4 67108864
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_AAS_PredictRoute
CALLI4
pop
line 4792
;4788:							goal->areanum, bs->tfl, 100, 1000,
;4789:							RSE_USETRAVELTYPE|RSE_ENTERCONTENTS,
;4790:							AREACONTENTS_MOVER, TFL_BRIDGE, 0);
;4791:	// if bot has to travel through an area with a mover
;4792:	if (route.stopevent & RSE_ENTERCONTENTS) {
ADDRLP4 0+16
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2165
line 4794
;4793:		// if the bot will run into a mover
;4794:		if (route.endcontents & AREACONTENTS_MOVER) {
ADDRLP4 0+20
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2166
line 4796
;4795:			//NOTE: this only works with bspc 2.1 or higher
;4796:			modelnum = (route.endcontents & AREACONTENTS_MODELNUM) >> AREACONTENTS_MODELNUMSHIFT;
ADDRLP4 300
CNSTI4 24
ASGNI4
ADDRLP4 36
ADDRLP4 0+20
INDIRI4
CNSTI4 255
ADDRLP4 300
INDIRI4
LSHI4
BANDI4
ADDRLP4 300
INDIRI4
RSHI4
ASGNI4
line 4797
;4797:			if (modelnum) {
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $2166
line 4799
;4798:				//
;4799:				entitynum = BotModelMinsMaxs(modelnum, ET_MOVER, 0, NULL, NULL);
ADDRLP4 36
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 304
CNSTP4 0
ASGNP4
ADDRLP4 304
INDIRP4
ARGP4
ADDRLP4 304
INDIRP4
ARGP4
ADDRLP4 308
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 308
INDIRI4
ASGNI4
line 4800
;4800:				if (entitynum) {
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $2166
line 4802
;4801:					//NOTE: BotGetActivateGoal already checks if the door is open or not
;4802:					bspent = BotGetActivateGoal(bs, entitynum, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 48
ARGP4
ADDRLP4 312
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 312
INDIRI4
ASGNI4
line 4803
;4803:					if (bspent) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $2166
line 4805
;4804:						//
;4805:						if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 316
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
INDIRP4
ASGNP4
ADDRLP4 316
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2178
ADDRLP4 316
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2178
line 4806
;4806:							bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 7116
ADDP4
CNSTP4 0
ASGNP4
LABELV $2178
line 4808
;4807:						// if not already trying to activate this entity
;4808:						if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48+4+40
INDIRI4
ARGI4
ADDRLP4 320
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 320
INDIRI4
CNSTI4 0
NEI4 $2180
line 4812
;4809:							//
;4810:							//BotAI_Print(PRT_MESSAGE, "blocked by mover model %d, entity %d ?\n", modelnum, entitynum);
;4811:							//
;4812:							BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 4813
;4813:							return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2159
JUMPV
LABELV $2180
line 4815
;4814:						}
;4815:						else {
line 4817
;4816:							// enable any routing areas that were disabled
;4817:							BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 48
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4818
;4818:						}
line 4819
;4819:					}
line 4820
;4820:				}
line 4821
;4821:			}
line 4822
;4822:		}
line 4823
;4823:	}
ADDRGP4 $2166
JUMPV
LABELV $2165
line 4824
;4824:	else if (route.stopevent & RSE_USETRAVELTYPE) {
ADDRLP4 0+16
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2184
line 4825
;4825:		if (route.endtravelflags & TFL_BRIDGE) {
ADDRLP4 0+24
INDIRI4
CNSTI4 67108864
BANDI4
CNSTI4 0
EQI4 $2187
line 4827
;4826:			//FIXME: check if the bridge is available to travel over
;4827:		}
LABELV $2187
line 4828
;4828:	}
LABELV $2184
LABELV $2166
line 4829
;4829:	return qfalse;
CNSTI4 0
RETI4
LABELV $2159
endproc BotAIPredictObstacles 324 44
export BotCheckConsoleMessages
proc BotCheckConsoleMessages 1012 48
line 4837
;4830:}
;4831:
;4832:/*
;4833:==================
;4834:BotCheckConsoleMessages
;4835:==================
;4836:*/
;4837:void BotCheckConsoleMessages(bot_state_t *bs) {
line 4845
;4838:	char botname[MAX_NETNAME], message[MAX_MESSAGE_SIZE], netname[MAX_NETNAME], *ptr;
;4839:	float chat_reply;
;4840:	int context, handle;
;4841:	bot_consolemessage_t m;
;4842:	bot_match_t match;
;4843:
;4844:	//the name of this bot
;4845:	ClientName(bs->client, botname, sizeof(botname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 908
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
ADDRGP4 $2192
JUMPV
LABELV $2191
line 4847
;4846:	//
;4847:	while((handle = trap_BotNextConsoleMessage(bs->cs, &m)) != 0) {
line 4849
;4848:		//if the chat state is flooded with messages the bot will read them quickly
;4849:		if (trap_BotNumConsoleMessages(bs->cs) < 10) {
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 948
ADDRGP4 trap_BotNumConsoleMessages
CALLI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 10
GEI4 $2194
line 4851
;4850:			//if it is a chat message the bot needs some time to read it
;4851:			if (m.type == CMS_CHAT && m.time > FloatTime() - (1 + random())) break;
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2196
ADDRLP4 952
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 952
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1065353216
ADDF4
SUBF4
LEF4 $2196
ADDRGP4 $2193
JUMPV
LABELV $2196
line 4852
;4852:		}
LABELV $2194
line 4854
;4853:		//
;4854:		ptr = m.message;
ADDRLP4 276
ADDRLP4 0+12
ASGNP4
line 4857
;4855:		//if it is a chat message then don't unify white spaces and don't
;4856:		//replace synonyms in the netname
;4857:		if (m.type == CMS_CHAT) {
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2201
line 4859
;4858:			//
;4859:			if (trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
ADDRLP4 0+12
ARGP4
ADDRLP4 288
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 952
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 952
INDIRI4
CNSTI4 0
EQI4 $2204
line 4860
;4860:				ptr = m.message + match.variables[MESSAGE].offset;
ADDRLP4 276
ADDRLP4 288+264+16
INDIRI1
CVII4 1
ADDRLP4 0+12
ADDP4
ASGNP4
line 4861
;4861:			}
LABELV $2204
line 4862
;4862:		}
LABELV $2201
line 4864
;4863:		//unify the white spaces in the message
;4864:		trap_UnifyWhiteSpaces(ptr);
ADDRLP4 276
INDIRP4
ARGP4
ADDRGP4 trap_UnifyWhiteSpaces
CALLV
pop
line 4866
;4865:		//replace synonyms in the right context
;4866:		context = BotSynonymContext(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 952
ADDRGP4 BotSynonymContext
CALLI4
ASGNI4
ADDRLP4 284
ADDRLP4 952
INDIRI4
ASGNI4
line 4867
;4867:		trap_BotReplaceSynonyms(ptr, context);
ADDRLP4 276
INDIRP4
ARGP4
ADDRLP4 284
INDIRI4
CVIU4 4
ARGU4
ADDRGP4 trap_BotReplaceSynonyms
CALLV
pop
line 4869
;4868:		//if there's no match
;4869:		if (!BotMatchMessage(bs, m.message)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 956
ADDRGP4 BotMatchMessage
CALLI4
ASGNI4
ADDRLP4 956
INDIRI4
CNSTI4 0
NEI4 $2210
line 4871
;4870:			//if it is a chat message
;4871:			if (m.type == CMS_CHAT && !bot_nochat.integer) {
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2213
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
NEI4 $2213
line 4873
;4872:				//
;4873:				if (!trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
ADDRLP4 0+12
ARGP4
ADDRLP4 288
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 960
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 960
INDIRI4
CNSTI4 0
NEI4 $2217
line 4874
;4874:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4875
;4875:					continue;
ADDRGP4 $2192
JUMPV
LABELV $2217
line 4878
;4876:				}
;4877:				//don't use eliza chats with team messages
;4878:				if (match.subtype & ST_TEAM) {
ADDRLP4 288+260
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $2220
line 4879
;4879:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4880
;4880:					continue;
ADDRGP4 $2192
JUMPV
LABELV $2220
line 4883
;4881:				}
;4882:				//
;4883:				trap_BotMatchVariable(&match, NETNAME, netname, sizeof(netname));
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 872
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 4884
;4884:				trap_BotMatchVariable(&match, MESSAGE, message, sizeof(message));
ADDRLP4 288
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 616
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 4886
;4885:				//if this is a message from the bot self
;4886:				if (bs->client == ClientFromName(netname)) {
ADDRLP4 872
ARGP4
ADDRLP4 964
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 964
INDIRI4
NEI4 $2223
line 4887
;4887:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4888
;4888:					continue;
ADDRGP4 $2192
JUMPV
LABELV $2223
line 4891
;4889:				}
;4890:				//unify the message
;4891:				trap_UnifyWhiteSpaces(message);
ADDRLP4 616
ARGP4
ADDRGP4 trap_UnifyWhiteSpaces
CALLV
pop
line 4893
;4892:				//
;4893:				trap_Cvar_Update(&bot_testrchat);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 4894
;4894:				if (bot_testrchat.integer) {
ADDRGP4 bot_testrchat+12
INDIRI4
CNSTI4 0
EQI4 $2225
line 4896
;4895:					//
;4896:					trap_BotLibVarSet("bot_testrchat", "1");
ADDRGP4 $2228
ARGP4
ADDRGP4 $2229
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 4898
;4897:					//if bot replies with a chat message
;4898:					if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 968
CNSTP4 0
ASGNP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 908
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 972
ADDRGP4 trap_BotReplyChat
CALLI4
ASGNI4
ADDRLP4 972
INDIRI4
CNSTI4 0
EQI4 $2230
line 4902
;4899:															NULL, NULL,
;4900:															NULL, NULL,
;4901:															NULL, NULL,
;4902:															botname, netname)) {
line 4903
;4903:						BotAI_Print(PRT_MESSAGE, "------------------------\n");
CNSTI4 1
ARGI4
ADDRGP4 $2232
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4904
;4904:					}
ADDRGP4 $2226
JUMPV
LABELV $2230
line 4905
;4905:					else {
line 4906
;4906:						BotAI_Print(PRT_MESSAGE, "**** no valid reply ****\n");
CNSTI4 1
ARGI4
ADDRGP4 $2233
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4907
;4907:					}
line 4908
;4908:				}
ADDRGP4 $2226
JUMPV
LABELV $2225
line 4910
;4909:				//if at a valid chat position and not chatting already and not in teamplay
;4910:				else if (bs->ainode != AINode_Stand && BotValidChatPosition(bs) && !TeamPlayIsOn()) {
ADDRLP4 968
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 968
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Stand
CVPU4 4
EQU4 $2234
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 972
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 972
INDIRI4
CNSTI4 0
EQI4 $2234
ADDRLP4 976
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 976
INDIRI4
CNSTI4 0
NEI4 $2234
line 4911
;4911:					chat_reply = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_REPLY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 35
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 980
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 944
ADDRLP4 980
INDIRF4
ASGNF4
line 4912
;4912:					if (random() < 1.5 / (NumBots()+1) && random() < chat_reply) {
ADDRLP4 984
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 988
ADDRGP4 NumBots
CALLI4
ASGNI4
ADDRLP4 984
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1069547520
ADDRLP4 988
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
DIVF4
GEF4 $2236
ADDRLP4 992
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 992
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 944
INDIRF4
GEF4 $2236
line 4914
;4913:						//if bot replies with a chat message
;4914:						if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 996
CNSTP4 0
ASGNP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 908
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 1000
ADDRGP4 trap_BotReplyChat
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 0
EQI4 $2238
line 4918
;4915:																NULL, NULL,
;4916:																NULL, NULL,
;4917:																NULL, NULL,
;4918:																botname, netname)) {
line 4920
;4919:							//remove the console message
;4920:							trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4921
;4921:							bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1004
INDIRP4
ARGP4
ADDRLP4 1008
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 1004
INDIRP4
CNSTI4 6096
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1008
INDIRF4
ADDF4
ASGNF4
line 4922
;4922:							AIEnter_Stand(bs, "BotCheckConsoleMessages: reply chat");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2240
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 4924
;4923:							//EA_Say(bs->client, bs->cs.chatmessage);
;4924:							break;
ADDRGP4 $2193
JUMPV
LABELV $2238
line 4926
;4925:						}
;4926:					}
LABELV $2236
line 4927
;4927:				}
LABELV $2234
LABELV $2226
line 4928
;4928:			}
LABELV $2213
line 4929
;4929:		}
LABELV $2210
line 4931
;4930:		//remove the console message
;4931:		trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4932
;4932:	}
LABELV $2192
line 4847
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 948
ADDRGP4 trap_BotNextConsoleMessage
CALLI4
ASGNI4
ADDRLP4 280
ADDRLP4 948
INDIRI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 0
NEI4 $2191
LABELV $2193
line 4933
;4933:}
LABELV $2190
endproc BotCheckConsoleMessages 1012 48
export BotCheckForGrenades
proc BotCheckForGrenades 8 16
line 4940
;4934:
;4935:/*
;4936:==================
;4937:BotCheckEvents
;4938:==================
;4939:*/
;4940:void BotCheckForGrenades(bot_state_t *bs, entityState_t *state) {
line 4942
;4941:	// if this is not a grenade
;4942:	if (state->eType != ET_MISSILE || state->weapon != WP_GRENADE_LAUNCHER)
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2244
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $2242
LABELV $2244
line 4943
;4943:		return;
ADDRGP4 $2241
JUMPV
LABELV $2242
line 4945
;4944:	// try to avoid the grenade
;4945:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1126170624
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 4946
;4946:}
LABELV $2241
endproc BotCheckForGrenades 8 16
export BotCheckEvents
proc BotCheckEvents 164 12
line 4998
;4947:
;4948:#ifdef MISSIONPACK
;4949:/*
;4950:==================
;4951:BotCheckForProxMines
;4952:==================
;4953:*/
;4954:void BotCheckForProxMines(bot_state_t *bs, entityState_t *state) {
;4955:	// if this is not a prox mine
;4956:	if (state->eType != ET_MISSILE || state->weapon != WP_PROX_LAUNCHER)
;4957:		return;
;4958:	// if this prox mine is from someone on our own team
;4959:	if (state->generic1 == BotTeam(bs))
;4960:		return;
;4961:	// if the bot doesn't have a weapon to deactivate the mine
;4962:	if (!(bs->inventory[INVENTORY_PLASMAGUN] > 0 && bs->inventory[INVENTORY_CELLS] > 0) &&
;4963:		!(bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 && bs->inventory[INVENTORY_ROCKETS] > 0) &&
;4964:		!(bs->inventory[INVENTORY_BFG10K] > 0 && bs->inventory[INVENTORY_BFGAMMO] > 0) ) {
;4965:		return;
;4966:	}
;4967:	// try to avoid the prox mine
;4968:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
;4969:	//
;4970:	if (bs->numproxmines >= MAX_PROXMINES)
;4971:		return;
;4972:	bs->proxmines[bs->numproxmines] = state->number;
;4973:	bs->numproxmines++;
;4974:}
;4975:
;4976:/*
;4977:==================
;4978:BotCheckForKamikazeBody
;4979:==================
;4980:*/
;4981:void BotCheckForKamikazeBody(bot_state_t *bs, entityState_t *state) {
;4982:	// if this entity is not wearing the kamikaze
;4983:	if (!(state->eFlags & EF_KAMIKAZE))
;4984:		return;
;4985:	// if this entity isn't dead
;4986:	if (!(state->eFlags & EF_DEAD))
;4987:		return;
;4988:	//remember this kamikaze body
;4989:	bs->kamikazebody = state->number;
;4990:}
;4991:#endif
;4992:
;4993:/*
;4994:==================
;4995:BotCheckEvents
;4996:==================
;4997:*/
;4998:void BotCheckEvents(bot_state_t *bs, entityState_t *state) {
line 5007
;4999:	int event;
;5000:	char buf[128];
;5001:#ifdef MISSIONPACK
;5002:	aas_entityinfo_t entinfo;
;5003:#endif
;5004:
;5005:	//NOTE: this sucks, we're accessing the gentity_t directly
;5006:	//but there's no other fast way to do it right now
;5007:	if (bs->entityeventTime[state->number] == g_entities[state->number].eventTime) {
ADDRLP4 132
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
INDIRI4
CNSTI4 924
ADDRLP4 132
INDIRI4
MULI4
ADDRGP4 g_entities+560
ADDP4
INDIRI4
NEI4 $2246
line 5008
;5008:		return;
ADDRGP4 $2245
JUMPV
LABELV $2246
line 5010
;5009:	}
;5010:	bs->entityeventTime[state->number] = g_entities[state->number].eventTime;
ADDRLP4 136
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
CNSTI4 924
ADDRLP4 136
INDIRI4
MULI4
ADDRGP4 g_entities+560
ADDP4
INDIRI4
ASGNI4
line 5012
;5011:	//if it's an event only entity
;5012:	if (state->eType > ET_EVENTS) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 14
LEI4 $2250
line 5013
;5013:		event = (state->eType - ET_EVENTS) & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 14
SUBI4
CNSTI4 -769
BANDI4
ASGNI4
line 5014
;5014:	}
ADDRGP4 $2251
JUMPV
LABELV $2250
line 5015
;5015:	else {
line 5016
;5016:		event = state->event & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 5017
;5017:	}
LABELV $2251
line 5019
;5018:	//
;5019:	switch(event) {
ADDRLP4 140
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 1
LTI4 $2252
ADDRLP4 140
INDIRI4
CNSTI4 77
GTI4 $2252
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2301-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2301
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2252
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2253
address $2252
address $2252
address $2252
address $2286
address $2252
address $2252
address $2252
address $2287
address $2265
address $2273
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2254
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2252
address $2253
code
LABELV $2254
line 5022
;5020:		//client obituary event
;5021:		case EV_OBITUARY:
;5022:		{
line 5025
;5023:			int target, attacker, mod;
;5024:
;5025:			target = state->otherEntityNum;
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 5026
;5026:			attacker = state->otherEntityNum2;
ADDRLP4 148
ADDRFP4 4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 5027
;5027:			mod = state->eventParm;
ADDRLP4 152
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 5029
;5028:			//
;5029:			if (target == bs->client) {
ADDRLP4 144
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2255
line 5030
;5030:				bs->botdeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 5031
;5031:				bs->lastkilledby = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
ADDRLP4 148
INDIRI4
ASGNI4
line 5033
;5032:				//
;5033:				if (target == attacker ||
ADDRLP4 156
ADDRLP4 144
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
ADDRLP4 148
INDIRI4
EQI4 $2260
ADDRLP4 156
INDIRI4
CNSTI4 1023
EQI4 $2260
ADDRLP4 156
INDIRI4
CNSTI4 1022
NEI4 $2257
LABELV $2260
line 5035
;5034:					target == ENTITYNUM_NONE ||
;5035:					target == ENTITYNUM_WORLD) bs->botsuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTI4 1
ASGNI4
ADDRGP4 $2258
JUMPV
LABELV $2257
line 5036
;5036:				else bs->botsuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTI4 0
ASGNI4
LABELV $2258
line 5038
;5037:				//
;5038:				bs->num_deaths++;
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5039
;5039:			}
ADDRGP4 $2253
JUMPV
LABELV $2255
line 5041
;5040:			//else if this client was killed by the bot
;5041:			else if (attacker == bs->client) {
ADDRLP4 148
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2261
line 5042
;5042:				bs->enemydeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 5043
;5043:				bs->lastkilledplayer = target;
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
line 5044
;5044:				bs->killedenemy_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6168
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5046
;5045:				//
;5046:				bs->num_kills++;
ADDRLP4 156
ADDRFP4 0
INDIRP4
CNSTI4 6032
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5047
;5047:			}
ADDRGP4 $2253
JUMPV
LABELV $2261
line 5048
;5048:			else if (attacker == bs->enemy && target == attacker) {
ADDRLP4 156
ADDRLP4 148
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
NEI4 $2253
ADDRLP4 144
INDIRI4
ADDRLP4 156
INDIRI4
NEI4 $2253
line 5049
;5049:				bs->enemysuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTI4 1
ASGNI4
line 5050
;5050:			}
line 5064
;5051:			//
;5052:#ifdef MISSIONPACK			
;5053:			if (gametype == GT_1FCTF) {
;5054:				//
;5055:				BotEntityInfo(target, &entinfo);
;5056:				if ( entinfo.powerups & ( 1 << PW_NEUTRALFLAG ) ) {
;5057:					if (!BotSameTeam(bs, target)) {
;5058:						bs->neutralflagstatus = 3;	//enemy dropped the flag
;5059:						bs->flagstatuschanged = qtrue;
;5060:					}
;5061:				}
;5062:			}
;5063:#endif
;5064:			break;
ADDRGP4 $2253
JUMPV
LABELV $2265
line 5067
;5065:		}
;5066:		case EV_GLOBAL_SOUND:
;5067:		{
line 5068
;5068:			if (state->eventParm < 0 || state->eventParm > MAX_SOUNDS) {
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
LTI4 $2268
ADDRLP4 144
INDIRI4
CNSTI4 256
LEI4 $2266
LABELV $2268
line 5069
;5069:				BotAI_Print(PRT_ERROR, "EV_GLOBAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2269
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 5070
;5070:				break;
ADDRGP4 $2253
JUMPV
LABELV $2266
line 5072
;5071:			}
;5072:			trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 5092
;5073:			/*
;5074:			if (!strcmp(buf, "sound/teamplay/flagret_red.wav")) {
;5075:				//red flag is returned
;5076:				bs->redflagstatus = 0;
;5077:				bs->flagstatuschanged = qtrue;
;5078:			}
;5079:			else if (!strcmp(buf, "sound/teamplay/flagret_blu.wav")) {
;5080:				//blue flag is returned
;5081:				bs->blueflagstatus = 0;
;5082:				bs->flagstatuschanged = qtrue;
;5083:			}
;5084:			else*/
;5085:#ifdef MISSIONPACK
;5086:			if (!strcmp(buf, "sound/items/kamikazerespawn.wav" )) {
;5087:				//the kamikaze respawned so dont avoid it
;5088:				BotDontAvoid(bs, "Kamikaze");
;5089:			}
;5090:			else
;5091:#endif
;5092:				if (!strcmp(buf, "sound/items/poweruprespawn.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2272
ARGP4
ADDRLP4 148
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $2253
line 5094
;5093:				//powerup respawned... go get it
;5094:				BotGoForPowerups(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoForPowerups
CALLV
pop
line 5095
;5095:			}
line 5096
;5096:			break;
ADDRGP4 $2253
JUMPV
LABELV $2273
line 5099
;5097:		}
;5098:		case EV_GLOBAL_TEAM_SOUND:
;5099:		{
line 5100
;5100:			if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $2253
line 5101
;5101:				switch(state->eventParm) {
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
LTI4 $2253
ADDRLP4 144
INDIRI4
CNSTI4 5
GTI4 $2253
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2285
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2285
address $2279
address $2280
address $2281
address $2282
address $2283
address $2284
code
LABELV $2279
line 5103
;5102:					case GTS_RED_CAPTURE:
;5103:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 5104
;5104:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
CNSTI4 0
ASGNI4
line 5105
;5105:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 1
ASGNI4
line 5106
;5106:						break; //see BotMatch_CTF
ADDRGP4 $2253
JUMPV
LABELV $2280
line 5108
;5107:					case GTS_BLUE_CAPTURE:
;5108:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 5109
;5109:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
CNSTI4 0
ASGNI4
line 5110
;5110:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 1
ASGNI4
line 5111
;5111:						break; //see BotMatch_CTF
ADDRGP4 $2253
JUMPV
LABELV $2281
line 5114
;5112:					case GTS_RED_RETURN:
;5113:						//blue flag is returned
;5114:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 5115
;5115:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 1
ASGNI4
line 5116
;5116:						break;
ADDRGP4 $2253
JUMPV
LABELV $2282
line 5119
;5117:					case GTS_BLUE_RETURN:
;5118:						//red flag is returned
;5119:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
CNSTI4 0
ASGNI4
line 5120
;5120:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 1
ASGNI4
line 5121
;5121:						break;
ADDRGP4 $2253
JUMPV
LABELV $2283
line 5124
;5122:					case GTS_RED_TAKEN:
;5123:						//blue flag is taken
;5124:						bs->blueflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 1
ASGNI4
line 5125
;5125:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 1
ASGNI4
line 5126
;5126:						break; //see BotMatch_CTF
ADDRGP4 $2253
JUMPV
LABELV $2284
line 5129
;5127:					case GTS_BLUE_TAKEN:
;5128:						//red flag is taken
;5129:						bs->redflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
CNSTI4 1
ASGNI4
line 5130
;5130:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 1
ASGNI4
line 5131
;5131:						break; //see BotMatch_CTF
line 5133
;5132:				}
;5133:			}
line 5166
;5134:#ifdef MISSIONPACK
;5135:			else if (gametype == GT_1FCTF) {
;5136:				switch(state->eventParm) {
;5137:					case GTS_RED_CAPTURE:
;5138:						bs->neutralflagstatus = 0;
;5139:						bs->flagstatuschanged = qtrue;
;5140:						break;
;5141:					case GTS_BLUE_CAPTURE:
;5142:						bs->neutralflagstatus = 0;
;5143:						bs->flagstatuschanged = qtrue;
;5144:						break;
;5145:					case GTS_RED_RETURN:
;5146:						//flag has returned
;5147:						bs->neutralflagstatus = 0;
;5148:						bs->flagstatuschanged = qtrue;
;5149:						break;
;5150:					case GTS_BLUE_RETURN:
;5151:						//flag has returned
;5152:						bs->neutralflagstatus = 0;
;5153:						bs->flagstatuschanged = qtrue;
;5154:						break;
;5155:					case GTS_RED_TAKEN:
;5156:						bs->neutralflagstatus = BotTeam(bs) == TEAM_RED ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
;5157:						bs->flagstatuschanged = qtrue;
;5158:						break;
;5159:					case GTS_BLUE_TAKEN:
;5160:						bs->neutralflagstatus = BotTeam(bs) == TEAM_BLUE ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
;5161:						bs->flagstatuschanged = qtrue;
;5162:						break;
;5163:				}
;5164:			}
;5165:#endif
;5166:			break;
ADDRGP4 $2253
JUMPV
LABELV $2286
line 5169
;5167:		}
;5168:		case EV_PLAYER_TELEPORT_IN:
;5169:		{
line 5170
;5170:			VectorCopy(state->origin, lastteleport_origin);
ADDRGP4 lastteleport_origin
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 5171
;5171:			lastteleport_time = FloatTime();
ADDRGP4 lastteleport_time
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5172
;5172:			break;
ADDRGP4 $2253
JUMPV
LABELV $2287
line 5175
;5173:		}
;5174:		case EV_GENERAL_SOUND:
;5175:		{
line 5177
;5176:			//if this sound is played on the bot
;5177:			if (state->number == bs->client) {
ADDRFP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2253
line 5178
;5178:				if (state->eventParm < 0 || state->eventParm > MAX_SOUNDS) {
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
LTI4 $2292
ADDRLP4 144
INDIRI4
CNSTI4 256
LEI4 $2290
LABELV $2292
line 5179
;5179:					BotAI_Print(PRT_ERROR, "EV_GENERAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2293
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 5180
;5180:					break;
ADDRGP4 $2253
JUMPV
LABELV $2290
line 5183
;5181:				}
;5182:				//check out the sound
;5183:				trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 5185
;5184:				//if falling into a death pit
;5185:				if (!strcmp(buf, "*falling1.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2296
ARGP4
ADDRLP4 148
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $2253
line 5187
;5186:					//if the bot has a personal teleporter
;5187:					if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5072
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2253
line 5189
;5188:						//use the holdable item
;5189:						trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 5190
;5190:					}
line 5191
;5191:				}
line 5192
;5192:			}
line 5193
;5193:			break;
line 5220
;5194:		}
;5195:		case EV_FOOTSTEP:
;5196:		case EV_FOOTSTEP_METAL:
;5197:		case EV_FOOTSPLASH:
;5198:		case EV_FOOTWADE:
;5199:		case EV_SWIM:
;5200:		case EV_FALL_SHORT:
;5201:		case EV_FALL_MEDIUM:
;5202:		case EV_FALL_FAR:
;5203:		case EV_STEP_4:
;5204:		case EV_STEP_8:
;5205:		case EV_STEP_12:
;5206:		case EV_STEP_16:
;5207:		case EV_JUMP_PAD:
;5208:		case EV_JUMP:
;5209:		case EV_TAUNT:
;5210:		case EV_WATER_TOUCH:
;5211:		case EV_WATER_LEAVE:
;5212:		case EV_WATER_UNDER:
;5213:		case EV_WATER_CLEAR:
;5214:		case EV_ITEM_PICKUP:
;5215:		case EV_GLOBAL_ITEM_PICKUP:
;5216:		case EV_NOAMMO:
;5217:		case EV_CHANGE_WEAPON:
;5218:		case EV_FIRE_WEAPON:
;5219:			//FIXME: either add to sound queue or mark player as someone making noise
;5220:			break;
line 5236
;5221:		case EV_USE_ITEM0:
;5222:		case EV_USE_ITEM1:
;5223:		case EV_USE_ITEM2:
;5224:		case EV_USE_ITEM3:
;5225:		case EV_USE_ITEM4:
;5226:		case EV_USE_ITEM5:
;5227:		case EV_USE_ITEM6:
;5228:		case EV_USE_ITEM7:
;5229:		case EV_USE_ITEM8:
;5230:		case EV_USE_ITEM9:
;5231:		case EV_USE_ITEM10:
;5232:		case EV_USE_ITEM11:
;5233:		case EV_USE_ITEM12:
;5234:		case EV_USE_ITEM13:
;5235:		case EV_USE_ITEM14:
;5236:			break;
LABELV $2252
LABELV $2253
line 5238
;5237:	}
;5238:}
LABELV $2245
endproc BotCheckEvents 164 12
export BotCheckSnapshot
proc BotCheckSnapshot 220 16
line 5245
;5239:
;5240:/*
;5241:==================
;5242:BotCheckSnapshot
;5243:==================
;5244:*/
;5245:void BotCheckSnapshot(bot_state_t *bs) {
line 5250
;5246:	int ent;
;5247:	entityState_t state;
;5248:
;5249:	//remove all avoid spots
;5250:	trap_BotAddAvoidSpot(bs->ms, vec3_origin, 0, AVOID_CLEAR);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 5252
;5251:	//reset kamikaze body
;5252:	bs->kamikazebody = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6256
ADDP4
CNSTI4 0
ASGNI4
line 5254
;5253:	//reset number of proxmines
;5254:	bs->numproxmines = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6516
ADDP4
CNSTI4 0
ASGNI4
line 5256
;5255:	//
;5256:	ent = 0;
ADDRLP4 212
CNSTI4 0
ASGNI4
ADDRGP4 $2305
JUMPV
LABELV $2304
line 5257
;5257:	while( ( ent = BotAI_GetSnapshotEntity( bs->client, ent, &state ) ) != -1 ) {
line 5259
;5258:		//check the entity state for events
;5259:		BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 5261
;5260:		//check for grenades the bot should avoid
;5261:		BotCheckForGrenades(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForGrenades
CALLV
pop
line 5269
;5262:		//
;5263:#ifdef MISSIONPACK
;5264:		//check for proximity mines which the bot should deactivate
;5265:		BotCheckForProxMines(bs, &state);
;5266:		//check for dead bodies with the kamikaze effect which should be gibbed
;5267:		BotCheckForKamikazeBody(bs, &state);
;5268:#endif
;5269:	}
LABELV $2305
line 5257
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 212
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 216
ADDRGP4 BotAI_GetSnapshotEntity
CALLI4
ASGNI4
ADDRLP4 212
ADDRLP4 216
INDIRI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 -1
NEI4 $2304
line 5271
;5270:	//check the player state for events
;5271:	BotAI_GetEntityState(bs->client, &state);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 5273
;5272:	//copy the player state events to the entity state
;5273:	state.event = bs->cur_ps.externalEvent;
ADDRLP4 0+180
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 5274
;5274:	state.eventParm = bs->cur_ps.externalEventParm;
ADDRLP4 0+184
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 5276
;5275:	//
;5276:	BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 5277
;5277:}
LABELV $2303
endproc BotCheckSnapshot 220 16
export BotCheckAir
proc BotCheckAir 4 4
line 5284
;5278:
;5279:/*
;5280:==================
;5281:BotCheckAir
;5282:==================
;5283:*/
;5284:void BotCheckAir(bot_state_t *bs) {
line 5285
;5285:	if (bs->inventory[INVENTORY_ENVIRONMENTSUIT] <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5096
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2310
line 5286
;5286:		if (trap_AAS_PointContents(bs->eye) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA)) {
ADDRFP4 0
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $2312
line 5287
;5287:			return;
ADDRGP4 $2309
JUMPV
LABELV $2312
line 5289
;5288:		}
;5289:	}
LABELV $2310
line 5290
;5290:	bs->lastair_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6176
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5291
;5291:}
LABELV $2309
endproc BotCheckAir 4 4
export BotAlternateRoute
proc BotAlternateRoute 16 16
line 5298
;5292:
;5293:/*
;5294:==================
;5295:BotAlternateRoute
;5296:==================
;5297:*/
;5298:bot_goal_t *BotAlternateRoute(bot_state_t *bs, bot_goal_t *goal) {
line 5302
;5299:	int t;
;5300:
;5301:	// if the bot has an alternative route goal
;5302:	if (bs->altroutegoal.areanum) {
ADDRFP4 0
INDIRP4
CNSTI4 6692
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2315
line 5304
;5303:		//
;5304:		if (bs->reachedaltroutegoal_time)
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2317
line 5305
;5305:			return goal;
ADDRFP4 4
INDIRP4
RETP4
ADDRGP4 $2314
JUMPV
LABELV $2317
line 5307
;5306:		// travel time towards alternative route goal
;5307:		t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, bs->altroutegoal.areanum, bs->tfl);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 6692
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 5308
;5308:		if (t && t < 20) {
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2319
ADDRLP4 12
INDIRI4
CNSTI4 20
GEI4 $2319
line 5310
;5309:			//BotAI_Print(PRT_MESSAGE, "reached alternate route goal\n");
;5310:			bs->reachedaltroutegoal_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5311
;5311:		}
LABELV $2319
line 5312
;5312:		memcpy(goal, &bs->altroutegoal, sizeof(bot_goal_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 5313
;5313:		return &bs->altroutegoal;
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
RETP4
ADDRGP4 $2314
JUMPV
LABELV $2315
line 5315
;5314:	}
;5315:	return goal;
ADDRFP4 4
INDIRP4
RETP4
LABELV $2314
endproc BotAlternateRoute 16 16
export BotGetAlternateRouteGoal
proc BotGetAlternateRouteGoal 24 0
line 5323
;5316:}
;5317:
;5318:/*
;5319:==================
;5320:BotGetAlternateRouteGoal
;5321:==================
;5322:*/
;5323:int BotGetAlternateRouteGoal(bot_state_t *bs, int base) {
line 5328
;5324:	aas_altroutegoal_t *altroutegoals;
;5325:	bot_goal_t *goal;
;5326:	int numaltroutegoals, rnd;
;5327:
;5328:	if (base == TEAM_RED) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $2322
line 5329
;5329:		altroutegoals = red_altroutegoals;
ADDRLP4 12
ADDRGP4 red_altroutegoals
ASGNP4
line 5330
;5330:		numaltroutegoals = red_numaltroutegoals;
ADDRLP4 4
ADDRGP4 red_numaltroutegoals
INDIRI4
ASGNI4
line 5331
;5331:	}
ADDRGP4 $2323
JUMPV
LABELV $2322
line 5332
;5332:	else {
line 5333
;5333:		altroutegoals = blue_altroutegoals;
ADDRLP4 12
ADDRGP4 blue_altroutegoals
ASGNP4
line 5334
;5334:		numaltroutegoals = blue_numaltroutegoals;
ADDRLP4 4
ADDRGP4 blue_numaltroutegoals
INDIRI4
ASGNI4
line 5335
;5335:	}
LABELV $2323
line 5336
;5336:	if (!numaltroutegoals)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2324
line 5337
;5337:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2321
JUMPV
LABELV $2324
line 5338
;5338:	rnd = (float) random() * numaltroutegoals;
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 5339
;5339:	if (rnd >= numaltroutegoals)
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $2326
line 5340
;5340:		rnd = numaltroutegoals-1;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $2326
line 5341
;5341:	goal = &bs->altroutegoal;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
ASGNP4
line 5342
;5342:	goal->areanum = altroutegoals[rnd].areanum;
ADDRLP4 20
CNSTI4 12
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
CNSTI4 24
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
ADDP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 5343
;5343:	VectorCopy(altroutegoals[rnd].origin, goal->origin);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 5344
;5344:	VectorSet(goal->mins, -8, -8, -8);
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
line 5345
;5345:	VectorSet(goal->maxs, 8, 8, 8);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
line 5346
;5346:	goal->entitynum = 0;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTI4 0
ASGNI4
line 5347
;5347:	goal->iteminfo = 0;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 5348
;5348:	goal->number = 0;
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 5349
;5349:	goal->flags = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 5351
;5350:	//
;5351:	bs->reachedaltroutegoal_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
CNSTF4 0
ASGNF4
line 5352
;5352:	return qtrue;
CNSTI4 1
RETI4
LABELV $2321
endproc BotGetAlternateRouteGoal 24 0
export BotSetupAlternativeRouteGoals
proc BotSetupAlternativeRouteGoals 0 0
line 5360
;5353:}
;5354:
;5355:/*
;5356:==================
;5357:BotSetupAlternateRouteGoals
;5358:==================
;5359:*/
;5360:void BotSetupAlternativeRouteGoals(void) {
line 5362
;5361:
;5362:	if (altroutegoals_setup)
ADDRGP4 altroutegoals_setup
INDIRI4
CNSTI4 0
EQI4 $2329
line 5363
;5363:		return;
ADDRGP4 $2328
JUMPV
LABELV $2329
line 5432
;5364:#ifdef MISSIONPACK
;5365:	if (gametype == GT_CTF) {
;5366:		if (trap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
;5367:			BotAI_Print(PRT_WARNING, "no alt routes without Neutral Flag\n");
;5368:		if (ctf_neutralflag.areanum) {
;5369:			//
;5370:			red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5371:										ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5372:										ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;5373:										red_altroutegoals, MAX_ALTROUTEGOALS,
;5374:										ALTROUTEGOAL_CLUSTERPORTALS|
;5375:										ALTROUTEGOAL_VIEWPORTALS);
;5376:			blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5377:										ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5378:										ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;5379:										blue_altroutegoals, MAX_ALTROUTEGOALS,
;5380:										ALTROUTEGOAL_CLUSTERPORTALS|
;5381:										ALTROUTEGOAL_VIEWPORTALS);
;5382:		}
;5383:	}
;5384:	else if (gametype == GT_1FCTF) {
;5385:		//
;5386:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5387:									ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5388:									ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;5389:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5390:									ALTROUTEGOAL_CLUSTERPORTALS|
;5391:									ALTROUTEGOAL_VIEWPORTALS);
;5392:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5393:									ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5394:									ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;5395:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5396:									ALTROUTEGOAL_CLUSTERPORTALS|
;5397:									ALTROUTEGOAL_VIEWPORTALS);
;5398:	}
;5399:	else if (gametype == GT_OBELISK) {
;5400:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
;5401:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
;5402:		//
;5403:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5404:									neutralobelisk.origin, neutralobelisk.areanum,
;5405:									redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;5406:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5407:									ALTROUTEGOAL_CLUSTERPORTALS|
;5408:									ALTROUTEGOAL_VIEWPORTALS);
;5409:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5410:									neutralobelisk.origin, neutralobelisk.areanum,
;5411:									blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;5412:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5413:									ALTROUTEGOAL_CLUSTERPORTALS|
;5414:									ALTROUTEGOAL_VIEWPORTALS);
;5415:	}
;5416:	else if (gametype == GT_HARVESTER) {
;5417:		//
;5418:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5419:									neutralobelisk.origin, neutralobelisk.areanum,
;5420:									redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;5421:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5422:									ALTROUTEGOAL_CLUSTERPORTALS|
;5423:									ALTROUTEGOAL_VIEWPORTALS);
;5424:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5425:									neutralobelisk.origin, neutralobelisk.areanum,
;5426:									blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;5427:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5428:									ALTROUTEGOAL_CLUSTERPORTALS|
;5429:									ALTROUTEGOAL_VIEWPORTALS);
;5430:	}
;5431:#endif
;5432:	altroutegoals_setup = qtrue;
ADDRGP4 altroutegoals_setup
CNSTI4 1
ASGNI4
line 5433
;5433:}
LABELV $2328
endproc BotSetupAlternativeRouteGoals 0 0
export BotDeathmatchAI
proc BotDeathmatchAI 1492 20
line 5440
;5434:
;5435:/*
;5436:==================
;5437:BotDeathmatchAI
;5438:==================
;5439:*/
;5440:void BotDeathmatchAI(bot_state_t *bs, float thinktime) {
line 5446
;5441:	char gender[144], name[144], buf[144];
;5442:	char userinfo[MAX_INFO_STRING];
;5443:	int i;
;5444:
;5445:	//if the bot has just been setup
;5446:	if (bs->setupcount > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2332
line 5447
;5447:		bs->setupcount--;
ADDRLP4 1460
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
ASGNP4
ADDRLP4 1460
INDIRP4
ADDRLP4 1460
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 5448
;5448:		if (bs->setupcount > 0) return;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2334
ADDRGP4 $2331
JUMPV
LABELV $2334
line 5450
;5449:		//get the gender characteristic
;5450:		trap_Characteristic_String(bs->character, CHARACTERISTIC_GENDER, gender, sizeof(gender));
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 148
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 5452
;5451:		//set the bot gender
;5452:		trap_GetUserinfo(bs->client, userinfo, sizeof(userinfo));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 5453
;5453:		Info_SetValueForKey(userinfo, "sex", gender);
ADDRLP4 292
ARGP4
ADDRGP4 $2336
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 5454
;5454:		trap_SetUserinfo(bs->client, userinfo);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 5456
;5455:		//set the team
;5456:		if ( !bs->map_restart && g_gametype.integer != GT_TOURNAMENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2337
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
EQI4 $2337
line 5457
;5457:			Com_sprintf(buf, sizeof(buf), "team %s", bs->settings.team);
ADDRLP4 1316
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 $2340
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 5458
;5458:			trap_EA_Command(bs->client, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1316
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 5459
;5459:		}
LABELV $2337
line 5461
;5460:		//set the chat gender
;5461:		if (gender[0] == 'm') trap_BotSetChatGender(bs->cs, CHAT_GENDERMALE);
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 109
NEI4 $2341
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $2342
JUMPV
LABELV $2341
line 5462
;5462:		else if (gender[0] == 'f')  trap_BotSetChatGender(bs->cs, CHAT_GENDERFEMALE);
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 102
NEI4 $2343
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $2344
JUMPV
LABELV $2343
line 5463
;5463:		else  trap_BotSetChatGender(bs->cs, CHAT_GENDERLESS);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
LABELV $2344
LABELV $2342
line 5465
;5464:		//set the chat name
;5465:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 5466
;5466:		trap_BotSetChatName(bs->cs, name, bs->client);
ADDRLP4 1464
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1464
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 1464
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotSetChatName
CALLV
pop
line 5468
;5467:		//
;5468:		bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1468
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1468
INDIRP4
CNSTI4 6044
ADDP4
ADDRLP4 1468
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
ASGNI4
line 5469
;5469:		bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1472
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1472
INDIRP4
CNSTI4 6048
ADDP4
ADDRLP4 1472
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 5471
;5470:		//
;5471:		bs->setupcount = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
CNSTI4 0
ASGNI4
line 5473
;5472:		//
;5473:		BotSetupAlternativeRouteGoals();
ADDRGP4 BotSetupAlternativeRouteGoals
CALLV
pop
line 5474
;5474:	}
LABELV $2332
line 5476
;5475:	//no ideal view set
;5476:	bs->flags &= ~BFL_IDEALVIEWSET;
ADDRLP4 1460
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 1460
INDIRP4
ADDRLP4 1460
INDIRP4
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 5478
;5477:	//
;5478:	if (!BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1464
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1464
INDIRI4
CNSTI4 0
NEI4 $2345
line 5480
;5479:		//set the teleport time
;5480:		BotSetTeleportTime(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeleportTime
CALLV
pop
line 5482
;5481:		//update some inventory values
;5482:		BotUpdateInventory(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotUpdateInventory
CALLV
pop
line 5484
;5483:		//check out the snapshot
;5484:		BotCheckSnapshot(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckSnapshot
CALLV
pop
line 5486
;5485:		//check for air
;5486:		BotCheckAir(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAir
CALLV
pop
line 5487
;5487:	}
LABELV $2345
line 5489
;5488:	//check the console messages
;5489:	BotCheckConsoleMessages(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckConsoleMessages
CALLV
pop
line 5491
;5490:	//if not in the intermission and not in observer mode
;5491:	if (!BotIntermission(bs) && !BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1468
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1468
INDIRI4
CNSTI4 0
NEI4 $2347
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1472
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 1472
INDIRI4
CNSTI4 0
NEI4 $2347
line 5493
;5492:		//do team AI
;5493:		BotTeamAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamAI
CALLV
pop
line 5494
;5494:	}
LABELV $2347
line 5496
;5495:	//if the bot has no ai node
;5496:	if (!bs->ainode) {
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2349
line 5497
;5497:		AIEnter_Seek_LTG(bs, "BotDeathmatchAI: no ai node");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2351
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 5498
;5498:	}
LABELV $2349
line 5500
;5499:	//if the bot entered the game less than 8 seconds ago
;5500:	if (!bs->entergamechat && bs->entergame_time > FloatTime() - 8) {
ADDRLP4 1476
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1476
INDIRP4
CNSTI4 6024
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2352
ADDRLP4 1476
INDIRP4
CNSTI4 6064
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1090519040
SUBF4
LEF4 $2352
line 5501
;5501:		if (BotChat_EnterGame(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1480
ADDRGP4 BotChat_EnterGame
CALLI4
ASGNI4
ADDRLP4 1480
INDIRI4
CNSTI4 0
EQI4 $2354
line 5502
;5502:			bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 1484
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1484
INDIRP4
ARGP4
ADDRLP4 1488
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 1484
INDIRP4
CNSTI4 6096
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1488
INDIRF4
ADDF4
ASGNF4
line 5503
;5503:			AIEnter_Stand(bs, "BotDeathmatchAI: chat enter game");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2356
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 5504
;5504:		}
LABELV $2354
line 5505
;5505:		bs->entergamechat = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6024
ADDP4
CNSTI4 1
ASGNI4
line 5506
;5506:	}
LABELV $2352
line 5508
;5507:	//reset the node switches from the previous frame
;5508:	BotResetNodeSwitches();
ADDRGP4 BotResetNodeSwitches
CALLV
pop
line 5510
;5509:	//execute AI nodes
;5510:	for (i = 0; i < MAX_NODESWITCHES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2357
line 5511
;5511:		if (bs->ainode(bs)) break;
ADDRLP4 1480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1480
INDIRP4
ARGP4
ADDRLP4 1484
ADDRLP4 1480
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1484
INDIRI4
CNSTI4 0
EQI4 $2361
ADDRGP4 $2359
JUMPV
LABELV $2361
line 5512
;5512:	}
LABELV $2358
line 5510
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $2357
LABELV $2359
line 5514
;5513:	//if the bot removed itself :)
;5514:	if (!bs->inuse) return;
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2363
ADDRGP4 $2331
JUMPV
LABELV $2363
line 5516
;5515:	//if the bot executed too many AI nodes
;5516:	if (i >= MAX_NODESWITCHES) {
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $2365
line 5517
;5517:		trap_BotDumpGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotDumpGoalStack
CALLV
pop
line 5518
;5518:		trap_BotDumpAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotDumpAvoidGoals
CALLV
pop
line 5519
;5519:		BotDumpNodeSwitches(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDumpNodeSwitches
CALLV
pop
line 5520
;5520:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 5521
;5521:		BotAI_Print(PRT_ERROR, "%s at %1.1f switched more than %d AI nodes\n", name, FloatTime(), MAX_NODESWITCHES);
CNSTI4 3
ARGI4
ADDRGP4 $2367
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 floattime
INDIRF4
ARGF4
CNSTI4 50
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 5522
;5522:	}
LABELV $2365
line 5524
;5523:	//
;5524:	bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1480
INDIRP4
CNSTI4 6044
ADDP4
ADDRLP4 1480
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
ASGNI4
line 5525
;5525:	bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1484
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1484
INDIRP4
CNSTI4 6048
ADDP4
ADDRLP4 1484
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 5526
;5526:}
LABELV $2331
endproc BotDeathmatchAI 1492 20
export BotSetEntityNumForGoalWithModel
proc BotSetEntityNumForGoalWithModel 44 4
line 5533
;5527:
;5528:/*
;5529:==================
;5530:BotSetEntityNumForGoalWithModel
;5531:==================
;5532:*/
;5533:void BotSetEntityNumForGoalWithModel(bot_goal_t *goal, int eType, char *modelname) {
line 5538
;5534:	gentity_t *ent;
;5535:	int i, modelindex;
;5536:	vec3_t dir;
;5537:
;5538:	modelindex = G_ModelIndex( modelname );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_ModelIndex
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 5539
;5539:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 5540
;5540:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $2372
JUMPV
LABELV $2369
line 5541
;5541:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2374
line 5542
;5542:			continue;
ADDRGP4 $2370
JUMPV
LABELV $2374
line 5544
;5543:		}
;5544:		if ( eType && ent->s.eType != eType) {
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2376
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $2376
line 5545
;5545:			continue;
ADDRGP4 $2370
JUMPV
LABELV $2376
line 5547
;5546:		}
;5547:		if (ent->s.modelindex != modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $2378
line 5548
;5548:			continue;
ADDRGP4 $2370
JUMPV
LABELV $2378
line 5550
;5549:		}
;5550:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5551
;5551:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 40
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1120403456
GEF4 $2382
line 5552
;5552:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5553
;5553:			return;
ADDRGP4 $2368
JUMPV
LABELV $2382
line 5555
;5554:		}
;5555:	}
LABELV $2370
line 5540
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 924
ADDP4
ASGNP4
LABELV $2372
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2369
line 5556
;5556:}
LABELV $2368
endproc BotSetEntityNumForGoalWithModel 44 4
export BotSetEntityNumForGoal
proc BotSetEntityNumForGoal 36 8
line 5563
;5557:
;5558:/*
;5559:==================
;5560:BotSetEntityNumForGoal
;5561:==================
;5562:*/
;5563:void BotSetEntityNumForGoal(bot_goal_t *goal, char *classname) {
line 5568
;5564:	gentity_t *ent;
;5565:	int i;
;5566:	vec3_t dir;
;5567:
;5568:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 5569
;5569:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $2388
JUMPV
LABELV $2385
line 5570
;5570:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2390
line 5571
;5571:			continue;
ADDRGP4 $2386
JUMPV
LABELV $2390
line 5573
;5572:		}
;5573:		if ( !Q_stricmp(ent->classname, classname) ) {
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2392
line 5574
;5574:			continue;
ADDRGP4 $2386
JUMPV
LABELV $2392
line 5576
;5575:		}
;5576:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5577
;5577:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
GEF4 $2396
line 5578
;5578:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5579
;5579:			return;
ADDRGP4 $2384
JUMPV
LABELV $2396
line 5581
;5580:		}
;5581:	}
LABELV $2386
line 5569
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 924
ADDP4
ASGNP4
LABELV $2388
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2385
line 5582
;5582:}
LABELV $2384
endproc BotSetEntityNumForGoal 36 8
export BotGoalForBSPEntity
proc BotGoalForBSPEntity 1128 20
line 5589
;5583:
;5584:/*
;5585:==================
;5586:BotGoalForBSPEntity
;5587:==================
;5588:*/
;5589:int BotGoalForBSPEntity( char *classname, bot_goal_t *goal ) {
line 5594
;5590:	char value[MAX_INFO_STRING];
;5591:	vec3_t origin, start, end;
;5592:	int ent, numareas, areas[10];
;5593:
;5594:	memset(goal, 0, sizeof(bot_goal_t));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5595
;5595:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 1108
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1108
INDIRI4
ASGNI4
ADDRGP4 $2402
JUMPV
LABELV $2399
line 5596
;5596:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", value, sizeof(value)))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1963
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $2403
line 5597
;5597:			continue;
ADDRGP4 $2400
JUMPV
LABELV $2403
line 5598
;5598:		if (!strcmp(value, classname)) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1116
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $2405
line 5599
;5599:			if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1982
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1120
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $2407
line 5600
;5600:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2398
JUMPV
LABELV $2407
line 5601
;5601:			VectorCopy(origin, goal->origin);
ADDRFP4 4
INDIRP4
ADDRLP4 1028
INDIRB
ASGNB 12
line 5602
;5602:			VectorCopy(origin, start);
ADDRLP4 1040
ADDRLP4 1028
INDIRB
ASGNB 12
line 5603
;5603:			start[2] -= 32;
ADDRLP4 1040+8
ADDRLP4 1040+8
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 5604
;5604:			VectorCopy(origin, end);
ADDRLP4 1052
ADDRLP4 1028
INDIRB
ASGNB 12
line 5605
;5605:			end[2] += 32;
ADDRLP4 1052+8
ADDRLP4 1052+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 5606
;5606:			numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 1040
ARGP4
ADDRLP4 1052
ARGP4
ADDRLP4 1068
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 1124
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 1064
ADDRLP4 1124
INDIRI4
ASGNI4
line 5607
;5607:			if (!numareas)
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $2411
line 5608
;5608:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2398
JUMPV
LABELV $2411
line 5609
;5609:			goal->areanum = areas[0];
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 5610
;5610:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2398
JUMPV
LABELV $2405
line 5612
;5611:		}
;5612:	}
LABELV $2400
line 5595
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1112
INDIRI4
ASGNI4
LABELV $2402
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2399
line 5613
;5613:	return qfalse;
CNSTI4 0
RETI4
LABELV $2398
endproc BotGoalForBSPEntity 1128 20
export BotSetupDeathmatchAI
proc BotSetupDeathmatchAI 156 16
line 5621
;5614:}
;5615:
;5616:/*
;5617:==================
;5618:BotSetupDeathmatchAI
;5619:==================
;5620:*/
;5621:void BotSetupDeathmatchAI(void) {
line 5625
;5622:	int ent, modelnum;
;5623:	char model[128];
;5624:
;5625:	gametype = trap_Cvar_VariableIntegerValue("g_gametype");
ADDRGP4 $2414
ARGP4
ADDRLP4 136
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 gametype
ADDRLP4 136
INDIRI4
ASGNI4
line 5626
;5626:	maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $311
ARGP4
ADDRLP4 140
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 maxclients
ADDRLP4 140
INDIRI4
ASGNI4
line 5628
;5627:
;5628:	trap_Cvar_Register(&bot_rocketjump, "bot_rocketjump", "1", 0);
ADDRGP4 bot_rocketjump
ARGP4
ADDRGP4 $2415
ARGP4
ADDRGP4 $2229
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5629
;5629:	trap_Cvar_Register(&bot_grapple, "bot_grapple", "0", 0);
ADDRGP4 bot_grapple
ARGP4
ADDRGP4 $2416
ARGP4
ADDRGP4 $2417
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5630
;5630:	trap_Cvar_Register(&bot_fastchat, "bot_fastchat", "0", 0);
ADDRGP4 bot_fastchat
ARGP4
ADDRGP4 $2418
ARGP4
ADDRGP4 $2417
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5631
;5631:	trap_Cvar_Register(&bot_nochat, "bot_nochat", "0", 0);
ADDRGP4 bot_nochat
ARGP4
ADDRGP4 $2419
ARGP4
ADDRGP4 $2417
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5632
;5632:	trap_Cvar_Register(&bot_testrchat, "bot_testrchat", "0", 0);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 $2228
ARGP4
ADDRGP4 $2417
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5633
;5633:	trap_Cvar_Register(&bot_challenge, "bot_challenge", "0", 0);
ADDRGP4 bot_challenge
ARGP4
ADDRGP4 $2420
ARGP4
ADDRGP4 $2417
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5634
;5634:	trap_Cvar_Register(&bot_predictobstacles, "bot_predictobstacles", "1", 0);
ADDRGP4 bot_predictobstacles
ARGP4
ADDRGP4 $2421
ARGP4
ADDRGP4 $2229
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5635
;5635:	trap_Cvar_Register(&g_spSkill, "g_spSkill", "2", 0);
ADDRGP4 g_spSkill
ARGP4
ADDRGP4 $2422
ARGP4
ADDRGP4 $2423
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5637
;5636:	//
;5637:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $2424
line 5638
;5638:		if (trap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2428
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
GEI4 $2426
line 5639
;5639:			BotAI_Print(PRT_WARNING, "CTF without Red Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $2429
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2426
line 5640
;5640:		if (trap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2432
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 148
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
GEI4 $2430
line 5641
;5641:			BotAI_Print(PRT_WARNING, "CTF without Blue Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $2433
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2430
line 5642
;5642:	}
LABELV $2424
line 5673
;5643:#ifdef MISSIONPACK
;5644:	else if (gametype == GT_1FCTF) {
;5645:		if (trap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
;5646:			BotAI_Print(PRT_WARNING, "One Flag CTF without Neutral Flag\n");
;5647:		if (trap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
;5648:			BotAI_Print(PRT_WARNING, "CTF without Red Flag\n");
;5649:		if (trap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
;5650:			BotAI_Print(PRT_WARNING, "CTF without Blue Flag\n");
;5651:	}
;5652:	else if (gametype == GT_OBELISK) {
;5653:		if (trap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
;5654:			BotAI_Print(PRT_WARNING, "Obelisk without red obelisk\n");
;5655:		BotSetEntityNumForGoal(&redobelisk, "team_redobelisk");
;5656:		if (trap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
;5657:			BotAI_Print(PRT_WARNING, "Obelisk without blue obelisk\n");
;5658:		BotSetEntityNumForGoal(&blueobelisk, "team_blueobelisk");
;5659:	}
;5660:	else if (gametype == GT_HARVESTER) {
;5661:		if (trap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
;5662:			BotAI_Print(PRT_WARNING, "Harvester without red obelisk\n");
;5663:		BotSetEntityNumForGoal(&redobelisk, "team_redobelisk");
;5664:		if (trap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
;5665:			BotAI_Print(PRT_WARNING, "Harvester without blue obelisk\n");
;5666:		BotSetEntityNumForGoal(&blueobelisk, "team_blueobelisk");
;5667:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
;5668:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
;5669:		BotSetEntityNumForGoal(&neutralobelisk, "team_neutralobelisk");
;5670:	}
;5671:#endif
;5672:
;5673:	max_bspmodelindex = 0;
ADDRGP4 max_bspmodelindex
CNSTI4 0
ASGNI4
line 5674
;5674:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 144
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 144
INDIRI4
ASGNI4
ADDRGP4 $2437
JUMPV
LABELV $2434
line 5675
;5675:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $306
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 148
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $2438
ADDRGP4 $2435
JUMPV
LABELV $2438
line 5676
;5676:		if (model[0] == '*') {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $2440
line 5677
;5677:			modelnum = atoi(model+1);
ADDRLP4 4+1
ARGP4
ADDRLP4 152
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 152
INDIRI4
ASGNI4
line 5678
;5678:			if (modelnum > max_bspmodelindex)
ADDRLP4 132
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
LEI4 $2443
line 5679
;5679:				max_bspmodelindex = modelnum;
ADDRGP4 max_bspmodelindex
ADDRLP4 132
INDIRI4
ASGNI4
LABELV $2443
line 5680
;5680:		}
LABELV $2440
line 5681
;5681:	}
LABELV $2435
line 5674
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 148
INDIRI4
ASGNI4
LABELV $2437
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2434
line 5683
;5682:	//initialize the waypoint heap
;5683:	BotInitWaypoints();
ADDRGP4 BotInitWaypoints
CALLV
pop
line 5684
;5684:}
LABELV $2413
endproc BotSetupDeathmatchAI 156 16
export BotShutdownDeathmatchAI
proc BotShutdownDeathmatchAI 0 0
line 5691
;5685:
;5686:/*
;5687:==================
;5688:BotShutdownDeathmatchAI
;5689:==================
;5690:*/
;5691:void BotShutdownDeathmatchAI(void) {
line 5692
;5692:	altroutegoals_setup = qfalse;
ADDRGP4 altroutegoals_setup
CNSTI4 0
ASGNI4
line 5693
;5693:}
LABELV $2445
endproc BotShutdownDeathmatchAI 0 0
bss
export blue_numaltroutegoals
align 4
LABELV blue_numaltroutegoals
skip 4
export blue_altroutegoals
align 4
LABELV blue_altroutegoals
skip 768
export red_numaltroutegoals
align 4
LABELV red_numaltroutegoals
skip 4
export red_altroutegoals
align 4
LABELV red_altroutegoals
skip 768
export altroutegoals_setup
align 4
LABELV altroutegoals_setup
skip 4
export max_bspmodelindex
align 4
LABELV max_bspmodelindex
skip 4
export lastteleport_time
align 4
LABELV lastteleport_time
skip 4
export lastteleport_origin
align 4
LABELV lastteleport_origin
skip 12
import bot_developer
export g_spSkill
align 4
LABELV g_spSkill
skip 272
export bot_predictobstacles
align 4
LABELV bot_predictobstacles
skip 272
export botai_freewaypoints
align 4
LABELV botai_freewaypoints
skip 4
export botai_waypoints
align 4
LABELV botai_waypoints
skip 12800
import BotVoiceChatOnly
import BotVoiceChat
import BotSetTeamMateTaskPreference
import BotGetTeamMateTaskPreference
import BotTeamAI
import BotDumpNodeSwitches
import BotResetNodeSwitches
import AINode_Battle_NBG
import AINode_Battle_Retreat
import AINode_Battle_Chase
import AINode_Battle_Fight
import AINode_Seek_LTG
import AINode_Seek_NBG
import AINode_Seek_ActivateEntity
import AINode_Stand
import AINode_Respawn
import AINode_Observer
import AINode_Intermission
import AIEnter_Battle_NBG
import AIEnter_Battle_Retreat
import AIEnter_Battle_Chase
import AIEnter_Battle_Fight
import AIEnter_Seek_Camp
import AIEnter_Seek_LTG
import AIEnter_Seek_NBG
import AIEnter_Seek_ActivateEntity
import AIEnter_Stand
import AIEnter_Respawn
import AIEnter_Observer
import AIEnter_Intermission
import BotPrintTeamGoal
import BotMatchMessage
import notleader
import BotChatTest
import BotValidChatPosition
import BotChatTime
import BotChat_Random
import BotChat_EnemySuicide
import BotChat_Kill
import BotChat_Death
import BotChat_HitNoKill
import BotChat_HitNoDeath
import BotChat_HitTalking
import BotChat_EndLevel
import BotChat_StartLevel
import BotChat_ExitGame
import BotChat_EnterGame
export ctf_blueflag
align 4
LABELV ctf_blueflag
skip 56
export ctf_redflag
align 4
LABELV ctf_redflag
skip 56
export bot_challenge
align 4
LABELV bot_challenge
skip 272
export bot_testrchat
align 4
LABELV bot_testrchat
skip 272
export bot_nochat
align 4
LABELV bot_nochat
skip 272
export bot_fastchat
align 4
LABELV bot_fastchat
skip 272
export bot_rocketjump
align 4
LABELV bot_rocketjump
skip 272
export bot_grapple
align 4
LABELV bot_grapple
skip 272
export maxclients
align 4
LABELV maxclients
skip 4
export gametype
align 4
LABELV gametype
skip 4
import BotTeamLeader
import BotAI_GetSnapshotEntity
import BotAI_GetEntityState
import BotAI_GetClientState
import BotAI_Trace
import BotAI_BotInitialChat
import BotAI_Print
import floattime
import BotEntityInfo
import NumBots
import BotResetState
import BotResetWeaponState
import BotFreeWeaponState
import BotAllocWeaponState
import BotLoadWeaponWeights
import BotGetWeaponInfo
import BotChooseBestFightWeapon
import BotShutdownWeaponAI
import BotSetupWeaponAI
import BotShutdownMoveAI
import BotSetupMoveAI
import BotSetBrushModelTypes
import BotAddAvoidSpot
import BotInitMoveState
import BotFreeMoveState
import BotAllocMoveState
import BotPredictVisiblePosition
import BotMovementViewTarget
import BotReachabilityArea
import BotResetLastAvoidReach
import BotResetAvoidReach
import BotMoveInDirection
import BotMoveToGoal
import BotResetMoveState
import BotShutdownGoalAI
import BotSetupGoalAI
import BotFreeGoalState
import BotAllocGoalState
import BotFreeItemWeights
import BotLoadItemWeights
import BotMutateGoalFuzzyLogic
import BotSaveGoalFuzzyLogic
import BotInterbreedGoalFuzzyLogic
import BotUpdateEntityItems
import BotInitLevelItems
import BotSetAvoidGoalTime
import BotAvoidGoalTime
import BotGetMapLocationGoal
import BotGetNextCampSpotGoal
import BotGetLevelItemGoal
import BotItemGoalInVisButNotVisible
import BotTouchingGoal
import BotChooseNBGItem
import BotChooseLTGItem
import BotGetSecondGoal
import BotGetTopGoal
import BotGoalName
import BotDumpGoalStack
import BotDumpAvoidGoals
import BotEmptyGoalStack
import BotPopGoal
import BotPushGoal
import BotRemoveFromAvoidGoals
import BotResetAvoidGoals
import BotResetGoalState
import GeneticParentsAndChildSelection
import BotSetChatName
import BotSetChatGender
import BotLoadChatFile
import BotReplaceSynonyms
import UnifyWhiteSpaces
import BotMatchVariable
import BotFindMatch
import StringContains
import BotGetChatMessage
import BotEnterChat
import BotChatLength
import BotReplyChat
import BotNumInitialChats
import BotInitialChat
import BotNumConsoleMessages
import BotNextConsoleMessage
import BotRemoveConsoleMessage
import BotQueueConsoleMessage
import BotFreeChatState
import BotAllocChatState
import BotShutdownChatAI
import BotSetupChatAI
import BotShutdownCharacters
import Characteristic_String
import Characteristic_BInteger
import Characteristic_Integer
import Characteristic_BFloat
import Characteristic_Float
import BotFreeCharacter
import BotLoadCharacter
import EA_Shutdown
import EA_Setup
import EA_ResetInput
import EA_GetInput
import EA_EndRegular
import EA_View
import EA_Move
import EA_DelayedJump
import EA_Jump
import EA_SelectWeapon
import EA_Use
import EA_Gesture
import EA_Talk
import EA_Respawn
import EA_Attack
import EA_MoveRight
import EA_MoveLeft
import EA_MoveBack
import EA_MoveForward
import EA_MoveDown
import EA_MoveUp
import EA_Walk
import EA_Crouch
import EA_Action
import EA_Command
import EA_SayTeam
import EA_Say
import GetBotLibAPI
import CheckPlayerPostions
import G_SendCommandToClient
import visible
import findradius
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaLadder
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Milliseconds
import trap_Error
import trap_Printf
import trep_debug
import g_CurrentRound
import g_NumRounds
import g_RegenAmmo
import g_RegenHealth
import g_AutoChangeMap
import g_lastmap2
import g_lastmap
import g_randommap
import g_mapfile
import g_ReverseCTF
import g_GuassRate
import g_GuassSelfDamage
import g_GuassKnockBack
import g_GuassJump
import g_PCTeamkills
import g_GrappleMode
import g_MaxTurrets
import g_Turrets
import g_StartRandom
import g_StartBFG
import g_StartPlasma
import g_StartGauss
import g_StartFlame
import g_StartSingCan
import g_StartGrenade
import g_StartSG
import g_StartMG
import g_StartGauntlet
import g_RedMC
import g_BlueMC
import g_GameMode
import g_instagib
import sv_fps
import g_lightningDamage
import g_truePing
import g_unlaggedVersion
import g_delagHitscan
import g_proxMineTimeout
import g_singlePlayer
import g_enableBreath
import g_enableDust
import g_rankings
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_filterBan
import g_banIPs
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_doWarmup
import g_warmup
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugDamage
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import g_entities
import level
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_WriteSessionData
import G_InitWorldSession
import G_InitSessionData
import G_ReadSessionData
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import Team_DropFlags
import CheckObeliskAttack
import Team_CheckDroppedItem
import OnSameTeam
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import Team_Point
import G_Error
import G_Printf
import SendScoreboardMessageToAllClients
import G_LogPrintf
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import DeathmatchScoreboardMessage
import G_SetStats
import MoveClientToIntermission
import FireWeapon2
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import PlaceMC
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import BalanceTeams
import TeamCount
import BuildDisplacer
import BuildMC
import BuildGenerator
import BuildTurret
import G_PredictPlayerMove
import G_UnTimeShiftClient
import G_UndoTimeShiftFor
import G_DoTimeShiftFor
import G_UnTimeShiftAllClients
import G_TimeShiftAllClients
import G_StoreHistory
import G_ResetHistory
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletAttack
import CalcMuzzlePoint
import LogAccuracyHit
import G_BreakGlass
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
import fire_mg
import fire_turret
import fire_alt_gata
import fire_grapple
import fire_bfg
import fire_rocket
import fire_flame
import fire_alt_rocket
import fire_altgrenade
import fire_bomb
import fire_pdgrenade
import fire_grenade
import fire_plasma2
import fire_plasma
import fire_blaster
import G_RunMissile
import TossClientCubes
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import G_ExplodeBomb
import G_ExplodeMissile
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
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
import irandom
import flrandom
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
LABELV $2433
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2432
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2429
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2428
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2423
byte 1 50
byte 1 0
align 1
LABELV $2422
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $2421
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 111
byte 1 98
byte 1 115
byte 1 116
byte 1 97
byte 1 99
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $2420
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $2419
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2418
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 97
byte 1 115
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2417
byte 1 48
byte 1 0
align 1
LABELV $2416
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2415
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $2414
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $2367
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 65
byte 1 73
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2356
byte 1 66
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2351
byte 1 66
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $2340
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2336
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $2296
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2293
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
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
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
byte 1 10
byte 1 0
align 1
LABELV $2272
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2269
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
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
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
byte 1 10
byte 1 0
align 1
LABELV $2240
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 67
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2233
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 10
byte 1 0
align 1
LABELV $2232
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $2229
byte 1 49
byte 1 0
align 1
LABELV $2228
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2094
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2093
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2089
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 111
byte 1 70
byte 1 111
byte 1 114
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $2077
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $2076
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $2073
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2062
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2049
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2043
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $2035
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $2024
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2020
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2017
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1982
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $1977
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $1976
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 114
byte 1 101
byte 1 97
byte 1 107
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $1969
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $1966
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1963
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1962
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1950
byte 1 42
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $1765
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $1742
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $1739
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $1701
byte 1 109
byte 1 112
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $1646
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $1642
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $715
byte 1 70
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $714
byte 1 73
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $713
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $712
byte 1 66
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $711
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $710
byte 1 81
byte 1 117
byte 1 97
byte 1 100
byte 1 32
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $538
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 87
byte 1 97
byte 1 121
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 79
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $356
byte 1 93
byte 1 0
align 1
LABELV $355
byte 1 91
byte 1 0
align 1
LABELV $354
byte 1 32
byte 1 0
align 1
LABELV $311
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $306
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $305
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
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
byte 1 10
byte 1 0
align 1
LABELV $300
byte 1 110
byte 1 0
align 1
LABELV $299
byte 1 91
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
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
byte 1 93
byte 1 0
align 1
LABELV $298
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
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
byte 1 10
byte 1 0
align 1
LABELV $195
byte 1 111
byte 1 110
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $170
byte 1 105
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $169
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $168
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $145
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $77
byte 1 116
byte 1 0
