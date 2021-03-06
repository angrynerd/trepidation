data
export pm_stopspeed
align 4
LABELV pm_stopspeed
byte 4 1120403456
export pm_duckScale
align 4
LABELV pm_duckScale
byte 4 1048576000
export pm_swimScale
align 4
LABELV pm_swimScale
byte 4 1056964608
export pm_wadeScale
align 4
LABELV pm_wadeScale
byte 4 1060320051
export pm_ladderScale
align 4
LABELV pm_ladderScale
byte 4 1061997773
export pm_accelerate
align 4
LABELV pm_accelerate
byte 4 1092616192
export pm_airaccelerate
align 4
LABELV pm_airaccelerate
byte 4 1065353216
export pm_ladderAccelerate
align 4
LABELV pm_ladderAccelerate
byte 4 1161527296
export pm_wateraccelerate
align 4
LABELV pm_wateraccelerate
byte 4 1082130432
export pm_flyaccelerate
align 4
LABELV pm_flyaccelerate
byte 4 1090519040
export pm_jetpackaccelerate
align 4
LABELV pm_jetpackaccelerate
byte 4 1090519040
export pm_ladderfriction
align 4
LABELV pm_ladderfriction
byte 4 1161527296
export pm_friction
align 4
LABELV pm_friction
byte 4 1086324736
export pm_waterfriction
align 4
LABELV pm_waterfriction
byte 4 1065353216
export pm_flightfriction
align 4
LABELV pm_flightfriction
byte 4 1077936128
export pm_spectatorfriction
align 4
LABELV pm_spectatorfriction
byte 4 1084227584
export c_pmove
align 4
LABELV c_pmove
byte 4 0
export trep_multijumps
align 4
LABELV trep_multijumps
byte 4 0
export PM_AddEvent
code
proc PM_AddEvent 0 12
file "../bg_pmove.c"
line 44
;1:// 2016 Trepidation Licensed under the GPL2
;2://
;3:// bg_pmove.c -- both games player movement code
;4:// takes a playerstate and a usercmd as input and returns a modifed playerstate
;5:
;6:#include "q_shared.h"
;7:#include "bg_public.h"
;8:#include "bg_local.h"
;9:
;10:
;11:pmove_t		*pm;
;12:pml_t		pml;
;13:
;14:// movement parameters
;15:float	pm_stopspeed = 100.0f;
;16:float	pm_duckScale = 0.25f;
;17:float	pm_swimScale = 0.50f;
;18:float	pm_wadeScale = 0.70f;
;19:float	pm_ladderScale = 0.80f; 	// Shafe - Trep - Ladder Support Set the max movement speed to HALF of normal
;20:
;21:float	pm_accelerate = 10.0f;
;22:float	pm_airaccelerate = 1.0f;
;23:float	pm_ladderAccelerate = 3000; 	// Shafe - Trep - Ladder Support
;24:float	pm_wateraccelerate = 4.0f;
;25:float	pm_flyaccelerate = 8.0f;
;26:float   pm_jetpackaccelerate = 8.0f;
;27:
;28:float	pm_ladderfriction = 3000; // Shafe - Trep - Ladder Support
;29:float	pm_friction = 6.0f;
;30:float	pm_waterfriction = 1.0f;
;31:float	pm_flightfriction = 3.0f;
;32:float	pm_spectatorfriction = 5.0f;
;33:
;34:int		c_pmove = 0;
;35:int		trep_multijumps = 0;
;36:
;37:
;38:/*
;39:===============
;40:PM_AddEvent
;41:
;42:===============
;43:*/
;44:void PM_AddEvent( int newEvent ) {
line 45
;45:	BG_AddPredictableEventToPlayerstate( newEvent, 0, pm->ps );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 pm
INDIRP4
INDIRP4
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 46
;46:}
LABELV $43
endproc PM_AddEvent 0 12
export PM_AddTouchEnt
proc PM_AddTouchEnt 12 0
line 53
;47:
;48:/*
;49:===============
;50:PM_AddTouchEnt
;51:===============
;52:*/
;53:void PM_AddTouchEnt( int entityNum ) {
line 56
;54:	int		i;
;55:
;56:	if ( entityNum == ENTITYNUM_WORLD ) {
ADDRFP4 0
INDIRI4
CNSTI4 1022
NEI4 $45
line 57
;57:		return;
ADDRGP4 $44
JUMPV
LABELV $45
line 59
;58:	}
;59:	if ( pm->numtouch == MAXTOUCH ) {
ADDRGP4 pm
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 32
NEI4 $47
line 60
;60:		return;
ADDRGP4 $44
JUMPV
LABELV $47
line 64
;61:	}
;62:
;63:	// see if it is already added
;64:	for ( i = 0 ; i < pm->numtouch ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $52
JUMPV
LABELV $49
line 65
;65:		if ( pm->touchents[ i ] == entityNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pm
INDIRP4
CNSTI4 52
ADDP4
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $53
line 66
;66:			return;
ADDRGP4 $44
JUMPV
LABELV $53
line 68
;67:		}
;68:	}
LABELV $50
line 64
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $52
ADDRLP4 0
INDIRI4
ADDRGP4 pm
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
LTI4 $49
line 71
;69:
;70:	// add it
;71:	pm->touchents[pm->numtouch] = entityNum;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 72
;72:	pm->numtouch++;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
CNSTI4 48
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 73
;73:}
LABELV $44
endproc PM_AddTouchEnt 12 0
proc PM_StartTorsoAnim 8 0
line 80
;74:
;75:/*
;76:===================
;77:PM_StartTorsoAnim
;78:===================
;79:*/
;80:static void PM_StartTorsoAnim( int anim ) {
line 81
;81:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $56
line 82
;82:		return;
ADDRGP4 $55
JUMPV
LABELV $56
line 84
;83:	}
;84:	pm->ps->torsoAnim = ( ( pm->ps->torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
ASGNP4
ADDRLP4 4
CNSTI4 128
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
ADDRLP4 4
INDIRI4
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 86
;85:		| anim;
;86:}
LABELV $55
endproc PM_StartTorsoAnim 8 0
proc PM_StartLegsAnim 8 0
line 87
;87:static void PM_StartLegsAnim( int anim ) {
line 88
;88:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $59
line 89
;89:		return;
ADDRGP4 $58
JUMPV
LABELV $59
line 91
;90:	}
;91:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $61
line 92
;92:		return;		// a high priority animation is running
ADDRGP4 $58
JUMPV
LABELV $61
line 94
;93:	}
;94:	pm->ps->legsAnim = ( ( pm->ps->legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 4
CNSTI4 128
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
ADDRLP4 4
INDIRI4
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 96
;95:		| anim;
;96:}
LABELV $58
endproc PM_StartLegsAnim 8 0
proc PM_ContinueLegsAnim 0 4
line 98
;97:
;98:static void PM_ContinueLegsAnim( int anim ) {
line 99
;99:	if ( ( pm->ps->legsAnim & ~ANIM_TOGGLEBIT ) == anim ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $64
line 100
;100:		return;
ADDRGP4 $63
JUMPV
LABELV $64
line 102
;101:	}
;102:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $66
line 103
;103:		return;		// a high priority animation is running
ADDRGP4 $63
JUMPV
LABELV $66
line 105
;104:	}
;105:	PM_StartLegsAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 106
;106:}
LABELV $63
endproc PM_ContinueLegsAnim 0 4
proc PM_ContinueTorsoAnim 0 4
line 108
;107:
;108:static void PM_ContinueTorsoAnim( int anim ) {
line 109
;109:	if ( ( pm->ps->torsoAnim & ~ANIM_TOGGLEBIT ) == anim ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $69
line 110
;110:		return;
ADDRGP4 $68
JUMPV
LABELV $69
line 112
;111:	}
;112:	if ( pm->ps->torsoTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $71
line 113
;113:		return;		// a high priority animation is running
ADDRGP4 $68
JUMPV
LABELV $71
line 115
;114:	}
;115:	PM_StartTorsoAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 116
;116:}
LABELV $68
endproc PM_ContinueTorsoAnim 0 4
proc PM_ForceLegsAnim 0 4
line 118
;117:
;118:static void PM_ForceLegsAnim( int anim ) {
line 119
;119:	pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 120
;120:	PM_StartLegsAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 121
;121:}
LABELV $73
endproc PM_ForceLegsAnim 0 4
export PM_ClipVelocity
proc PM_ClipVelocity 32 0
line 131
;122:
;123:
;124:/*
;125:==================
;126:PM_ClipVelocity
;127:
;128:Slide off of the impacting surface
;129:==================
;130:*/
;131:void PM_ClipVelocity( vec3_t in, vec3_t normal, vec3_t out, float overbounce ) {
line 136
;132:	float	backoff;
;133:	float	change;
;134:	int		i;
;135:	
;136:	backoff = DotProduct (in, normal);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
MULF4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 12
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 138
;137:	
;138:	if ( backoff < 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GEF4 $75
line 139
;139:		backoff *= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 140
;140:	} else {
ADDRGP4 $76
JUMPV
LABELV $75
line 141
;141:		backoff /= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
ASGNF4
line 142
;142:	}
LABELV $76
line 144
;143:
;144:	for ( i=0 ; i<3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $77
line 145
;145:		change = normal[i]*backoff;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 146
;146:		out[i] = in[i] - change;
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 28
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 28
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 147
;147:	}
LABELV $78
line 144
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $77
line 148
;148:}
LABELV $74
endproc PM_ClipVelocity 32 0
proc PM_Friction 48 4
line 158
;149:
;150:
;151:/*
;152:==================
;153:PM_Friction
;154:
;155:Handles both ground friction and water friction
;156:==================
;157:*/
;158:static void PM_Friction( void ) {
line 164
;159:	vec3_t	vec;
;160:	float	*vel;
;161:	float	speed, newspeed, control;
;162:	float	drop;
;163:	
;164:	vel = pm->ps->velocity;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
line 166
;165:	
;166:	VectorCopy( vel, vec );
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRB
ASGNB 12
line 167
;167:	if ( pml.walking ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $82
line 168
;168:		vec[2] = 0;	// ignore slope movement
ADDRLP4 16+8
CNSTF4 0
ASGNF4
line 169
;169:	}
LABELV $82
line 171
;170:
;171:	speed = VectorLength(vec);
ADDRLP4 16
ARGP4
ADDRLP4 32
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
line 172
;172:	if (speed < 1) {
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
GEF4 $86
line 173
;173:		vel[0] = 0;
ADDRLP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 174
;174:		vel[1] = 0;		// allow sinking underwater
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 176
;175:		// FIXME: still have z friction underwater?
;176:		return;
ADDRGP4 $81
JUMPV
LABELV $86
line 179
;177:	}
;178:
;179:	drop = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 182
;180:
;181:	// apply ground friction
;182:	if ( pm->waterlevel <= 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
GTI4 $88
line 183
;183:		if ( pml.walking && !(pml.groundTrace.surfaceFlags & SURF_SLICK) ) {
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 pml+44
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $90
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 36
INDIRI4
NEI4 $90
line 185
;184:			// if getting knocked back, no friction
;185:			if ( ! (pm->ps->pm_flags & PMF_TIME_KNOCKBACK) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $95
line 186
;186:				control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 8
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $98
ADDRLP4 40
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $99
JUMPV
LABELV $98
ADDRLP4 40
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $99
ADDRLP4 28
ADDRLP4 40
INDIRF4
ASGNF4
line 187
;187:				drop += control*pm_friction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRF4
ADDRGP4 pm_friction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 188
;188:			}
LABELV $95
line 189
;189:		}
LABELV $90
line 190
;190:	}
LABELV $88
line 193
;191:
;192:	// apply water friction even if just wading
;193:	if ( pm->waterlevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
EQI4 $101
line 194
;194:		drop += speed*pm_waterfriction*pm->waterlevel*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_waterfriction
INDIRF4
MULF4
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 195
;195:	}
LABELV $101
line 198
;196:
;197:	// apply flying friction
;198:	if ( pm->ps->powerups[PW_FLIGHT]) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $104
line 199
;199:		drop += speed*pm_flightfriction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_flightfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 200
;200:	}
LABELV $104
line 204
;201:
;202:
;203:	// Shafe - Trep - Ladder Support
;204:	if ( pml.ladder ) // If they're on a ladder... 
ADDRGP4 pml+108
INDIRI4
CNSTI4 0
EQI4 $107
line 205
;205:	{
line 206
;206:		drop += speed*pm_ladderfriction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_ladderfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 207
;207:	}
LABELV $107
line 210
;208:	///////////////////////// End Shafe Ladder
;209:
;210:	if ( pm->ps->pm_type == PM_SPECTATOR) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $111
line 211
;211:		drop += speed*pm_spectatorfriction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_spectatorfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 212
;212:	}
LABELV $111
line 215
;213:
;214:	// scale the velocity
;215:	newspeed = speed - drop;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 216
;216:	if (newspeed < 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
GEF4 $114
line 217
;217:		newspeed = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 218
;218:	}
LABELV $114
line 219
;219:	newspeed /= speed;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
ASGNF4
line 221
;220:
;221:	vel[0] = vel[0] * newspeed;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 222
;222:	vel[1] = vel[1] * newspeed;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 223
;223:	vel[2] = vel[2] * newspeed;
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 224
;224:}
LABELV $81
endproc PM_Friction 48 4
proc PM_Accelerate 32 0
line 234
;225:
;226:
;227:/*
;228:==============
;229:PM_Accelerate
;230:
;231:Handles user intended acceleration
;232:==============
;233:*/
;234:static void PM_Accelerate( vec3_t wishdir, float wishspeed, float accel ) {
line 240
;235:#if 1
;236:	// q2 style
;237:	int			i;
;238:	float		addspeed, accelspeed, currentspeed;
;239:
;240:	currentspeed = DotProduct (pm->ps->velocity, wishdir);
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 241
;241:	addspeed = wishspeed - currentspeed;
ADDRLP4 8
ADDRFP4 4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 242
;242:	if (addspeed <= 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $117
line 243
;243:		return;
ADDRGP4 $116
JUMPV
LABELV $117
line 245
;244:	}
;245:	accelspeed = accel*pml.frametime*wishspeed;
ADDRLP4 4
ADDRFP4 8
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 246
;246:	if (accelspeed > addspeed) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $120
line 247
;247:		accelspeed = addspeed;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 248
;248:	}
LABELV $120
line 250
;249:	
;250:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $122
line 251
;251:		pm->ps->velocity[i] += accelspeed*wishdir[i];	
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 28
ADDRLP4 24
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 252
;252:	}
LABELV $123
line 250
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $122
line 271
;253:#else
;254:	// proper way (avoids strafe jump maxspeed bug), but feels bad
;255:	vec3_t		wishVelocity;
;256:	vec3_t		pushDir;
;257:	float		pushLen;
;258:	float		canPush;
;259:
;260:	VectorScale( wishdir, wishspeed, wishVelocity );
;261:	VectorSubtract( wishVelocity, pm->ps->velocity, pushDir );
;262:	pushLen = VectorNormalize( pushDir );
;263:
;264:	canPush = accel*pml.frametime*wishspeed;
;265:	if (canPush > pushLen) {
;266:		canPush = pushLen;
;267:	}
;268:
;269:	VectorMA( pm->ps->velocity, canPush, pushDir, pm->ps->velocity );
;270:#endif
;271:}
LABELV $116
endproc PM_Accelerate 32 0
proc PM_CmdScale 44 4
line 284
;272:
;273:
;274:
;275:/*
;276:============
;277:PM_CmdScale
;278:
;279:Returns the scale factor to apply to cmd movements
;280:This allows the clients to use axial -127 to 127 values for all directions
;281:without getting a sqrt(2) distortion in speed.
;282:============
;283:*/
;284:static float PM_CmdScale( usercmd_t *cmd ) {
line 289
;285:	int		max;
;286:	float	total;
;287:	float	scale;
;288:
;289:	max = abs( cmd->forwardmove );
ADDRFP4 0
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 290
;290:	if ( abs( cmd->rightmove ) > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $127
line 291
;291:		max = abs( cmd->rightmove );
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 292
;292:	}
LABELV $127
line 293
;293:	if ( abs( cmd->upmove ) > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $129
line 294
;294:		max = abs( cmd->upmove );
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 24
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 295
;295:	}
LABELV $129
line 296
;296:	if ( !max ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $131
line 297
;297:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $126
JUMPV
LABELV $131
line 300
;298:	}
;299:
;300:	total = sqrt( cmd->forwardmove * cmd->forwardmove
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 36
ADDRLP4 24
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 28
INDIRI4
MULI4
ADDRLP4 32
INDIRI4
ADDRLP4 32
INDIRI4
MULI4
ADDI4
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
MULI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 40
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 40
INDIRF4
ASGNF4
line 302
;301:		+ cmd->rightmove * cmd->rightmove + cmd->upmove * cmd->upmove );
;302:	scale = (float)pm->ps->speed * max / ( 127.0 * total );
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRI4
CVIF4 4
MULF4
CNSTF4 1123942400
ADDRLP4 4
INDIRF4
MULF4
DIVF4
ASGNF4
line 304
;303:
;304:	return scale;
ADDRLP4 8
INDIRF4
RETF4
LABELV $126
endproc PM_CmdScale 44 4
proc PM_SetMovementDir 72 0
line 316
;305:}
;306:
;307:
;308:/*
;309:================
;310:PM_SetMovementDir
;311:
;312:Determine the rotation of the legs reletive
;313:to the facing dir
;314:================
;315:*/
;316:static void PM_SetMovementDir( void ) {
line 317
;317:	if ( pm->cmd.forwardmove || pm->cmd.rightmove ) {
ADDRLP4 0
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
NEI4 $136
ADDRLP4 0
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
EQI4 $134
LABELV $136
line 318
;318:		if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove > 0 ) {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
NEI4 $137
ADDRLP4 8
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
LEI4 $137
line 319
;319:			pm->ps->movementDir = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 320
;320:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove > 0 ) {
ADDRGP4 $135
JUMPV
LABELV $137
ADDRLP4 16
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 20
INDIRI4
GEI4 $139
ADDRLP4 16
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 20
INDIRI4
LEI4 $139
line 321
;321:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 322
;322:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove == 0 ) {
ADDRGP4 $135
JUMPV
LABELV $139
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 28
INDIRI4
GEI4 $141
ADDRLP4 24
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 28
INDIRI4
NEI4 $141
line 323
;323:			pm->ps->movementDir = 2;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 2
ASGNI4
line 324
;324:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $135
JUMPV
LABELV $141
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
GEI4 $143
ADDRLP4 32
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
GEI4 $143
line 325
;325:			pm->ps->movementDir = 3;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 3
ASGNI4
line 326
;326:		} else if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $135
JUMPV
LABELV $143
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
NEI4 $145
ADDRLP4 40
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
GEI4 $145
line 327
;327:			pm->ps->movementDir = 4;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 4
ASGNI4
line 328
;328:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $135
JUMPV
LABELV $145
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 52
INDIRI4
LEI4 $147
ADDRLP4 48
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 52
INDIRI4
GEI4 $147
line 329
;329:			pm->ps->movementDir = 5;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 5
ASGNI4
line 330
;330:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove == 0 ) {
ADDRGP4 $135
JUMPV
LABELV $147
ADDRLP4 56
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 60
INDIRI4
LEI4 $149
ADDRLP4 56
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 60
INDIRI4
NEI4 $149
line 331
;331:			pm->ps->movementDir = 6;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 6
ASGNI4
line 332
;332:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove > 0 ) {
ADDRGP4 $135
JUMPV
LABELV $149
ADDRLP4 64
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 68
INDIRI4
LEI4 $135
ADDRLP4 64
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 68
INDIRI4
LEI4 $135
line 333
;333:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 334
;334:		}
line 335
;335:	} else {
ADDRGP4 $135
JUMPV
LABELV $134
line 339
;336:		// if they aren't actively going directly sideways,
;337:		// change the animation to the diagonal so they
;338:		// don't stop too crooked
;339:		if ( pm->ps->movementDir == 2 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 2
NEI4 $153
line 340
;340:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 341
;341:		} else if ( pm->ps->movementDir == 6 ) {
ADDRGP4 $154
JUMPV
LABELV $153
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 6
NEI4 $155
line 342
;342:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 343
;343:		} 
LABELV $155
LABELV $154
line 344
;344:	}
LABELV $135
line 345
;345:}
LABELV $133
endproc PM_SetMovementDir 72 0
proc PM_CheckJump 12 4
line 356
;346:
;347:
;348:
;349:
;350:
;351:/*
;352:=============
;353:PM_CheckJump
;354:=============
;355:*/
;356:static qboolean PM_CheckJump( void ) {
line 357
;357:	if ( pm->ps->pm_flags & PMF_RESPAWNED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $158
line 358
;358:		return qfalse;		// don't allow jump until all buttons are up
CNSTI4 0
RETI4
ADDRGP4 $157
JUMPV
LABELV $158
line 361
;359:	}
;360:
;361:	if ( pm->cmd.upmove < 10 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $160
line 363
;362:		// not holding jump
;363:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $157
JUMPV
LABELV $160
line 367
;364:	}
;365:
;366:	// must wait for jump to be released
;367:	if ( pm->ps->pm_flags & PMF_JUMP_HELD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $162
line 369
;368:		// clear upmove so cmdscale doesn't lower running speed
;369:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 370
;370:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $157
JUMPV
LABELV $162
line 375
;371:	}
;372:
;373:	
;374:
;375:	pml.groundPlane = qfalse;		// jumping away
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 376
;376:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 377
;377:	pm->ps->pm_flags |= PMF_JUMP_HELD;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 379
;378:
;379:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 380
;380:	pm->ps->velocity[2] = JUMP_VELOCITY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1132920832
ASGNF4
line 381
;381:	PM_AddEvent( EV_JUMP );
CNSTI4 14
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 384
;382:
;383://	pm->ps->MultiJumps++; // Shafe - Trep - Multijumping / wall jumping
;384:	trep_multijumps++;
ADDRLP4 4
ADDRGP4 trep_multijumps
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 386
;385:
;386:	if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $166
line 387
;387:		PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 388
;388:		pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 389
;389:	} else {
ADDRGP4 $167
JUMPV
LABELV $166
line 390
;390:		PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 391
;391:		pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 392
;392:	}
LABELV $167
line 394
;393:
;394:	return qtrue;
CNSTI4 1
RETI4
LABELV $157
endproc PM_CheckJump 12 4
proc PM_CheckWaterJump 56 8
line 402
;395:}
;396:
;397:/*
;398:=============
;399:PM_CheckWaterJump
;400:=============
;401:*/
;402:static qboolean	PM_CheckWaterJump( void ) {
line 407
;403:	vec3_t	spot;
;404:	int		cont;
;405:	vec3_t	flatforward;
;406:
;407:	if (pm->ps->pm_time) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $169
line 408
;408:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $168
JUMPV
LABELV $169
line 412
;409:	}
;410:
;411:	// check for water jump
;412:	if ( pm->waterlevel != 2 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
EQI4 $171
line 413
;413:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $168
JUMPV
LABELV $171
line 416
;414:	}
;415:
;416:	flatforward[0] = pml.forward[0];
ADDRLP4 12
ADDRGP4 pml
INDIRF4
ASGNF4
line 417
;417:	flatforward[1] = pml.forward[1];
ADDRLP4 12+4
ADDRGP4 pml+4
INDIRF4
ASGNF4
line 418
;418:	flatforward[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 419
;419:	VectorNormalize (flatforward);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 421
;420:
;421:	VectorMA (pm->ps->origin, 30, flatforward, spot);
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
CNSTF4 1106247680
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1106247680
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 422
;422:	spot[2] += 4;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1082130432
ADDF4
ASGNF4
line 423
;423:	cont = pm->pointcontents (spot, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRLP4 36
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 40
INDIRI4
ASGNI4
line 424
;424:	if ( !(cont & CONTENTS_SOLID) ) {
ADDRLP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $181
line 425
;425:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $168
JUMPV
LABELV $181
line 428
;426:	}
;427:
;428:	spot[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 429
;429:	cont = pm->pointcontents (spot, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 48
INDIRI4
ASGNI4
line 430
;430:	if ( cont ) {
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $184
line 431
;431:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $168
JUMPV
LABELV $184
line 435
;432:	}
;433:
;434:	// jump out of water
;435:	VectorScale (pml.forward, 200, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1128792064
ADDRGP4 pml
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1128792064
ADDRGP4 pml+4
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1128792064
ADDRGP4 pml+8
INDIRF4
MULF4
ASGNF4
line 436
;436:	pm->ps->velocity[2] = 350;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1135542272
ASGNF4
line 438
;437:
;438:	pm->ps->pm_flags |= PMF_TIME_WATERJUMP;
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 439
;439:	pm->ps->pm_time = 2000;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 2000
ASGNI4
line 441
;440:
;441:	return qtrue;
CNSTI4 1
RETI4
LABELV $168
endproc PM_CheckWaterJump 56 8
proc PM_WaterJumpMove 12 4
line 454
;442:}
;443:
;444://============================================================================
;445:
;446:
;447:/*
;448:===================
;449:PM_WaterJumpMove
;450:
;451:Flying out of the water
;452:===================
;453:*/
;454:static void PM_WaterJumpMove( void ) {
line 457
;455:	// waterjump has no control, but falls
;456:
;457:	PM_StepSlideMove( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 459
;458:
;459:	pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
MULF4
SUBF4
ASGNF4
line 460
;460:	if (pm->ps->velocity[2] < 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
GEF4 $190
line 462
;461:		// cancel as soon as we are falling down again
;462:		pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 463
;463:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 464
;464:	}
LABELV $190
line 465
;465:}
LABELV $188
endproc PM_WaterJumpMove 12 4
proc PM_WaterMove 76 16
line 473
;466:
;467:/*
;468:===================
;469:PM_WaterMove
;470:
;471:===================
;472:*/
;473:static void PM_WaterMove( void ) {
line 481
;474:	int		i;
;475:	vec3_t	wishvel;
;476:	float	wishspeed;
;477:	vec3_t	wishdir;
;478:	float	scale;
;479:	float	vel;
;480:
;481:	if ( PM_CheckWaterJump() ) {
ADDRLP4 40
ADDRGP4 PM_CheckWaterJump
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $193
line 482
;482:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 483
;483:		return;
ADDRGP4 $192
JUMPV
LABELV $193
line 499
;484:	}
;485:#if 0
;486:	// jump = head for surface
;487:	if ( pm->cmd.upmove >= 10 ) {
;488:		if (pm->ps->velocity[2] > -300) {
;489:			if ( pm->watertype == CONTENTS_WATER ) {
;490:				pm->ps->velocity[2] = 100;
;491:			} else if (pm->watertype == CONTENTS_SLIME) {
;492:				pm->ps->velocity[2] = 80;
;493:			} else {
;494:				pm->ps->velocity[2] = 50;
;495:			}
;496:		}
;497:	}
;498:#endif
;499:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 501
;500:
;501:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 44
INDIRF4
ASGNF4
line 505
;502:	//
;503:	// user intentions
;504:	//
;505:	if ( !scale ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $195
line 506
;506:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 507
;507:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 508
;508:		wishvel[2] = -60;		// sink towards bottom
ADDRLP4 8+8
CNSTF4 3262119936
ASGNF4
line 509
;509:	} else {
ADDRGP4 $196
JUMPV
LABELV $195
line 510
;510:		for (i=0 ; i<3 ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $199
line 511
;511:			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
ADDRLP4 48
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 48
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 48
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 56
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 48
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 56
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
LABELV $200
line 510
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $199
line 513
;512:
;513:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 514
;514:	}
LABELV $196
line 516
;515:
;516:	VectorCopy (wishvel, wishdir);
ADDRLP4 24
ADDRLP4 8
INDIRB
ASGNB 12
line 517
;517:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 48
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 48
INDIRF4
ASGNF4
line 519
;518:
;519:	if ( wishspeed > pm->ps->speed * pm_swimScale ) {
ADDRLP4 20
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_swimScale
INDIRF4
MULF4
LEF4 $205
line 520
;520:		wishspeed = pm->ps->speed * pm_swimScale;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_swimScale
INDIRF4
MULF4
ASGNF4
line 521
;521:	}
LABELV $205
line 523
;522:
;523:	PM_Accelerate (wishdir, wishspeed, pm_wateraccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 pm_wateraccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 526
;524:
;525:	// make sure we can go up slopes easily under water
;526:	if ( pml.groundPlane && DotProduct( pm->ps->velocity, pml.groundTrace.plane.normal ) < 0 ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $207
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRLP4 52
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 52
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $207
line 527
;527:		vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 56
INDIRF4
ASGNF4
line 529
;528:		// slide along the ground plane
;529:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 532
;530:			pm->ps->velocity, OVERCLIP );
;531:
;532:		VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 533
;533:		VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
line 534
;534:	}
LABELV $207
line 536
;535:
;536:	PM_SlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_SlideMove
CALLI4
pop
line 537
;537:}
LABELV $192
endproc PM_WaterMove 76 16
proc PM_FlyMove 52 12
line 562
;538:
;539:#ifdef MISSIONPACK
;540:/*
;541:===================
;542:PM_InvulnerabilityMove
;543:
;544:Only with the invulnerability powerup
;545:===================
;546:*/
;547:static void PM_InvulnerabilityMove( void ) {
;548:	pm->cmd.forwardmove = 0;
;549:	pm->cmd.rightmove = 0;
;550:	pm->cmd.upmove = 0;
;551:	VectorClear(pm->ps->velocity);
;552:}
;553:#endif
;554:
;555:/*
;556:===================
;557:PM_FlyMove
;558:
;559:Only with the flight powerup
;560:===================
;561:*/
;562:static void PM_FlyMove( void ) {
line 570
;563:	int		i;
;564:	vec3_t	wishvel;
;565:	float	wishspeed;
;566:	vec3_t	wishdir;
;567:	float	scale;
;568:
;569:	// normal slowdown
;570:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 572
;571:
;572:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 36
INDIRF4
ASGNF4
line 576
;573:	//
;574:	// user intentions
;575:	//
;576:	if ( !scale ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $221
line 577
;577:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 578
;578:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 579
;579:		wishvel[2] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 580
;580:	} else {
ADDRGP4 $222
JUMPV
LABELV $221
line 581
;581:		for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $225
line 582
;582:			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 40
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 40
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 583
;583:		}
LABELV $226
line 581
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $225
line 585
;584:
;585:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 586
;586:	}
LABELV $222
line 588
;587:
;588:	VectorCopy (wishvel, wishdir);
ADDRLP4 20
ADDRLP4 8
INDIRB
ASGNB 12
line 589
;589:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 20
ARGP4
ADDRLP4 40
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 40
INDIRF4
ASGNF4
line 591
;590:
;591:	PM_Accelerate (wishdir, wishspeed, pm_flyaccelerate);
ADDRLP4 20
ARGP4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 pm_flyaccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 593
;592:
;593:	PM_StepSlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 595
;594:
;595:}
LABELV $220
endproc PM_FlyMove 52 12
proc PM_AirMove 80 16
line 637
;596:
;597:
;598:		/*
;599:        int             i;
;600:        vec3_t  wishvel;
;601:        float   wishspeed;
;602:        vec3_t  wishdir;
;603:        float   scale;
;604:
;605:        // normal slowdown
;606:        PM_Friction ();
;607:
;608:        scale = PM_CmdScale( &pm->cmd );
;609:        //
;610:        // user intentions
;611:        //
;612:        if ( !scale ) {
;613:                wishvel[0] = 0;
;614:                wishvel[1] = 0;
;615:                wishvel[2] = 355;       //< this is upward thrust (bigger number, more thrust)
;616:        } else {
;617:                for (i=0 ; i<3 ; i++) {
;618:                        wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
;619:                }
;620:        }
;621:
;622:        VectorCopy (wishvel, wishdir);
;623:        wishspeed = VectorNormalize(wishdir);
;624:
;625:        PM_Accelerate (wishdir, wishspeed, pm_jetpackaccelerate);       //< use the jetpack acceleration factor
;626:
;627:        PM_StepSlideMove( qtrue );      //< make this true to make gravity affect you
;628:	*/
;629:
;630:
;631:/*
;632:===================
;633:PM_AirMove
;634:
;635:===================
;636:*/
;637:static void PM_AirMove( void ) {
line 646
;638:	int			i;
;639:	vec3_t		wishvel;
;640:	float		fmove, smove;
;641:	vec3_t		wishdir;
;642:	float		wishspeed;
;643:	float		scale;
;644:	usercmd_t	cmd;
;645:
;646:	PM_Friction();
ADDRGP4 PM_Friction
CALLV
pop
line 648
;647:
;648:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 649
;649:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 651
;650:
;651:	cmd = pm->cmd;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 652
;652:	scale = PM_CmdScale( &cmd );
ADDRLP4 44
ARGP4
ADDRLP4 68
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 68
INDIRF4
ASGNF4
line 655
;653:
;654:	// set the movementDir so clients can rotate the legs for strafing
;655:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 658
;656:
;657:	// project moves down to flat plane
;658:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 659
;659:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 660
;660:	VectorNormalize (pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 661
;661:	VectorNormalize (pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 663
;662:
;663:	for ( i = 0 ; i < 2 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $236
line 664
;664:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 72
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 72
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 72
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 72
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 665
;665:	}
LABELV $237
line 663
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $236
line 666
;666:	wishvel[2] = 0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 668
;667:
;668:	VectorCopy (wishvel, wishdir);
ADDRLP4 24
ADDRLP4 4
INDIRB
ASGNB 12
line 669
;669:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 72
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 72
INDIRF4
ASGNF4
line 670
;670:	wishspeed *= scale;
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ASGNF4
line 673
;671:
;672:	// not on ground, so little effect on velocity
;673:	PM_Accelerate (wishdir, wishspeed, pm_airaccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 pm_airaccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 678
;674:
;675:	// we may have a ground plane that is very steep, even
;676:	// though we don't have a groundentity
;677:	// slide along the steep plane
;678:	if ( pml.groundPlane ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $242
line 679
;679:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 681
;680:			pm->ps->velocity, OVERCLIP );
;681:	}
LABELV $242
line 693
;682:
;683:#if 0
;684:	//ZOID:  If we are on the grapple, try stair-stepping
;685:	//this allows a player to use the grapple to pull himself
;686:	//over a ledge
;687:	if (pm->ps->pm_flags & PMF_GRAPPLE_PULL)
;688:		PM_StepSlideMove ( qtrue );
;689:	else
;690:		PM_SlideMove ( qtrue );
;691:#endif
;692:
;693:	PM_StepSlideMove ( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 694
;694:}
LABELV $231
endproc PM_AirMove 80 16
proc PM_GrappleMove 52 4
line 702
;695:
;696:/*
;697:===================
;698:PM_GrappleMove
;699:
;700:===================
;701:*/
;702:static void PM_GrappleMove( void ) {
line 706
;703:	vec3_t vel, v;
;704:	float vlen;
;705:
;706:	VectorScale(pml.forward, -16, v);
ADDRLP4 28
CNSTF4 3246391296
ASGNF4
ADDRLP4 12
ADDRLP4 28
INDIRF4
ADDRGP4 pml
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 28
INDIRF4
ADDRGP4 pml+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+8
CNSTF4 3246391296
ADDRGP4 pml+8
INDIRF4
MULF4
ASGNF4
line 707
;707:	VectorAdd(pm->ps->grapplePoint, v, v);
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
line 708
;708:	VectorSubtract(v, pm->ps->origin, vel);
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+8
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 709
;709:	vlen = VectorLength(vel);
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 40
INDIRF4
ASGNF4
line 710
;710:	VectorNormalize( vel );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 712
;711:
;712:	if (vlen <= 100)
ADDRLP4 24
INDIRF4
CNSTF4 1120403456
GTF4 $260
line 713
;713:		VectorScale(vel, 10 * vlen, vel);
ADDRLP4 44
CNSTF4 1092616192
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1092616192
ADDRLP4 24
INDIRF4
MULF4
MULF4
ASGNF4
ADDRGP4 $261
JUMPV
LABELV $260
line 715
;714:	else
;715:		VectorScale(vel, 800, vel);
ADDRLP4 48
CNSTF4 1145569280
ASGNF4
ADDRLP4 0
ADDRLP4 48
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 48
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
CNSTF4 1145569280
ADDRLP4 0+8
INDIRF4
MULF4
ASGNF4
LABELV $261
line 717
;716:
;717:	VectorCopy(vel, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 719
;718:
;719:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 720
;720:}
LABELV $247
endproc PM_GrappleMove 52 4
proc PM_WalkMove 128 16
line 728
;721:
;722:/*
;723:===================
;724:PM_WalkMove
;725:
;726:===================
;727:*/
;728:static void PM_WalkMove( void ) {
line 739
;729:	int			i;
;730:	vec3_t		wishvel;
;731:	float		fmove, smove;
;732:	vec3_t		wishdir;
;733:	float		wishspeed;
;734:	float		scale;
;735:	usercmd_t	cmd;
;736:	float		accelerate;
;737:	float		vel;
;738:
;739:	if ( pm->waterlevel > 2 && DotProduct( pml.forward, pml.groundTrace.plane.normal ) > 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
LEI4 $272
ADDRGP4 pml
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRGP4 pml+4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRGP4 pml+8
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
LEF4 $272
line 741
;740:		// begin swimming
;741:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 742
;742:		return;
ADDRGP4 $271
JUMPV
LABELV $272
line 746
;743:	}
;744:
;745:
;746:	if ( PM_CheckJump () ) {
ADDRLP4 76
ADDRGP4 PM_CheckJump
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $284
line 748
;747:		// jumped away
;748:		if ( pm->waterlevel > 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LEI4 $286
line 749
;749:			PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 750
;750:		} else {
ADDRGP4 $271
JUMPV
LABELV $286
line 751
;751:			PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 752
;752:		}
line 753
;753:		return;
ADDRGP4 $271
JUMPV
LABELV $284
line 756
;754:	}
;755:
;756:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 758
;757:
;758:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 759
;759:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 761
;760:
;761:	cmd = pm->cmd;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 762
;762:	scale = PM_CmdScale( &cmd );
ADDRLP4 48
ARGP4
ADDRLP4 80
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 80
INDIRF4
ASGNF4
line 765
;763:
;764:	// set the movementDir so clients can rotate the legs for strafing
;765:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 768
;766:
;767:	// project moves down to flat plane
;768:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 769
;769:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 772
;770:
;771:	// project the forward and right directions onto the ground plane
;772:	PM_ClipVelocity (pml.forward, pml.groundTrace.plane.normal, pml.forward, OVERCLIP );
ADDRLP4 84
ADDRGP4 pml
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 773
;773:	PM_ClipVelocity (pml.right, pml.groundTrace.plane.normal, pml.right, OVERCLIP );
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRGP4 pml+12
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 775
;774:	//
;775:	VectorNormalize (pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 776
;776:	VectorNormalize (pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 778
;777:
;778:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $298
line 779
;779:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 88
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 88
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 88
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 780
;780:	}
LABELV $299
line 778
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $298
line 784
;781:	// when going up or down slopes the wish velocity should Not be zero
;782://	wishvel[2] = 0;
;783:
;784:	VectorCopy (wishvel, wishdir);
ADDRLP4 32
ADDRLP4 4
INDIRB
ASGNB 12
line 785
;785:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 32
ARGP4
ADDRLP4 88
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 88
INDIRF4
ASGNF4
line 786
;786:	wishspeed *= scale;
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
line 789
;787:
;788:	// clamp the speed lower if ducking
;789:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $303
line 790
;790:		if ( wishspeed > pm->ps->speed * pm_duckScale ) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
LEF4 $305
line 791
;791:			wishspeed = pm->ps->speed * pm_duckScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
ASGNF4
line 792
;792:		}
LABELV $305
line 793
;793:	}
LABELV $303
line 796
;794:
;795:	// clamp the speed lower if wading or walking on the bottom
;796:	if ( pm->waterlevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
EQI4 $307
line 799
;797:		float	waterScale;
;798:
;799:		waterScale = pm->waterlevel / 3.0;
ADDRLP4 92
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1077936128
DIVF4
ASGNF4
line 800
;800:		waterScale = 1.0 - ( 1.0 - pm_swimScale ) * waterScale;
ADDRLP4 96
CNSTF4 1065353216
ASGNF4
ADDRLP4 92
ADDRLP4 96
INDIRF4
ADDRLP4 96
INDIRF4
ADDRGP4 pm_swimScale
INDIRF4
SUBF4
ADDRLP4 92
INDIRF4
MULF4
SUBF4
ASGNF4
line 801
;801:		if ( wishspeed > pm->ps->speed * waterScale ) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
LEF4 $309
line 802
;802:			wishspeed = pm->ps->speed * waterScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
line 803
;803:		}
LABELV $309
line 804
;804:	}
LABELV $307
line 808
;805:
;806:	// when a player gets hit, they temporarily lose
;807:	// full control, which allows them to be moved a bit
;808:	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 92
INDIRI4
NEI4 $315
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 92
INDIRI4
EQI4 $311
LABELV $315
line 809
;809:		accelerate = pm_airaccelerate;
ADDRLP4 72
ADDRGP4 pm_airaccelerate
INDIRF4
ASGNF4
line 810
;810:	} else {
ADDRGP4 $312
JUMPV
LABELV $311
line 811
;811:		accelerate = pm_accelerate;
ADDRLP4 72
ADDRGP4 pm_accelerate
INDIRF4
ASGNF4
line 812
;812:	}
LABELV $312
line 814
;813:
;814:	PM_Accelerate (wishdir, wishspeed, accelerate);
ADDRLP4 32
ARGP4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 819
;815:
;816:	//Com_Printf("velocity = %1.1f %1.1f %1.1f\n", pm->ps->velocity[0], pm->ps->velocity[1], pm->ps->velocity[2]);
;817:	//Com_Printf("velocity1 = %1.1f\n", VectorLength(pm->ps->velocity));
;818:
;819:	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
ADDRLP4 96
CNSTI4 0
ASGNI4
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 96
INDIRI4
NEI4 $320
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 96
INDIRI4
EQI4 $316
LABELV $320
line 820
;820:		pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 100
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 104
ADDRLP4 100
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
MULF4
SUBF4
ASGNF4
line 821
;821:	} else {
LABELV $316
line 824
;822:		// don't reset the z velocity for slopes
;823://		pm->ps->velocity[2] = 0;
;824:	}
LABELV $317
line 826
;825:
;826:	vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 100
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 100
INDIRF4
ASGNF4
line 829
;827:
;828:	// slide along the ground plane
;829:	PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 104
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 833
;830:		pm->ps->velocity, OVERCLIP );
;831:
;832:	// don't decrease velocity when going up or down a slope
;833:	VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 834
;834:	VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 108
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 112
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 116
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 837
;835:
;836:	// don't do anything if standing still
;837:	if (!pm->ps->velocity[0] && !pm->ps->velocity[1]) {
ADDRLP4 120
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 124
CNSTF4 0
ASGNF4
ADDRLP4 120
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 124
INDIRF4
NEF4 $324
ADDRLP4 120
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 124
INDIRF4
NEF4 $324
line 838
;838:		return;
ADDRGP4 $271
JUMPV
LABELV $324
line 841
;839:	}
;840:
;841:	PM_StepSlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 845
;842:
;843:	//Com_Printf("velocity2 = %1.1f\n", VectorLength(pm->ps->velocity));
;844:
;845:}
LABELV $271
endproc PM_WalkMove 128 16
proc PM_DeadMove 20 4
line 853
;846:
;847:
;848:/*
;849:==============
;850:PM_DeadMove
;851:==============
;852:*/
;853:static void PM_DeadMove( void ) {
line 856
;854:	float	forward;
;855:
;856:	if ( !pml.walking ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
NEI4 $327
line 857
;857:		return;
ADDRGP4 $326
JUMPV
LABELV $327
line 862
;858:	}
;859:
;860:	// extra friction
;861:
;862:	forward = VectorLength (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 863
;863:	forward -= 20;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 864
;864:	if ( forward <= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GTF4 $330
line 865
;865:		VectorClear (pm->ps->velocity);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 866
;866:	} else {
ADDRGP4 $331
JUMPV
LABELV $330
line 867
;867:		VectorNormalize (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 868
;868:		VectorScale (pm->ps->velocity, forward, pm->ps->velocity);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 869
;869:	}
LABELV $331
line 870
;870:}
LABELV $326
endproc PM_DeadMove 20 4
proc PM_NoclipMove 104 12
line 878
;871:
;872:
;873:/*
;874:===============
;875:PM_NoclipMove
;876:===============
;877:*/
;878:static void PM_NoclipMove( void ) {
line 887
;879:	float	speed, drop, friction, control, newspeed;
;880:	int			i;
;881:	vec3_t		wishvel;
;882:	float		fmove, smove;
;883:	vec3_t		wishdir;
;884:	float		wishspeed;
;885:	float		scale;
;886:
;887:	pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
line 891
;888:
;889:	// friction
;890:
;891:	speed = VectorLength (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 64
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 64
INDIRF4
ASGNF4
line 892
;892:	if (speed < 1)
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
GEF4 $333
line 893
;893:	{
line 894
;894:		VectorCopy (vec3_origin, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 895
;895:	}
ADDRGP4 $334
JUMPV
LABELV $333
line 897
;896:	else
;897:	{
line 898
;898:		drop = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 900
;899:
;900:		friction = pm_friction*1.5;	// extra friction
ADDRLP4 56
CNSTF4 1069547520
ADDRGP4 pm_friction
INDIRF4
MULF4
ASGNF4
line 901
;901:		control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 24
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $336
ADDRLP4 68
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $337
JUMPV
LABELV $336
ADDRLP4 68
ADDRLP4 24
INDIRF4
ASGNF4
LABELV $337
ADDRLP4 60
ADDRLP4 68
INDIRF4
ASGNF4
line 902
;902:		drop += control*friction*pml.frametime;
ADDRLP4 52
ADDRLP4 52
INDIRF4
ADDRLP4 60
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 905
;903:
;904:		// scale the velocity
;905:		newspeed = speed - drop;
ADDRLP4 28
ADDRLP4 24
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ASGNF4
line 906
;906:		if (newspeed < 0)
ADDRLP4 28
INDIRF4
CNSTF4 0
GEF4 $339
line 907
;907:			newspeed = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
LABELV $339
line 908
;908:		newspeed /= speed;
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
DIVF4
ASGNF4
line 910
;909:
;910:		VectorScale (pm->ps->velocity, newspeed, pm->ps->velocity);
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 911
;911:	}
LABELV $334
line 914
;912:
;913:	// accelerate
;914:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 68
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 68
INDIRF4
ASGNF4
line 916
;915:
;916:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 917
;917:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 919
;918:	
;919:	for (i=0 ; i<3 ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $341
line 920
;920:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 72
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 72
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 72
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 72
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $342
line 919
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $341
line 921
;921:	wishvel[2] += pm->cmd.upmove;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ADDF4
ASGNF4
line 923
;922:
;923:	VectorCopy (wishvel, wishdir);
ADDRLP4 32
ADDRLP4 4
INDIRB
ASGNB 12
line 924
;924:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 32
ARGP4
ADDRLP4 76
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 76
INDIRF4
ASGNF4
line 925
;925:	wishspeed *= scale;
ADDRLP4 44
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 927
;926:
;927:	PM_Accelerate( wishdir, wishspeed, pm_accelerate );
ADDRLP4 32
ARGP4
ADDRLP4 44
INDIRF4
ARGF4
ADDRGP4 pm_accelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 930
;928:
;929:	// move
;930:	VectorMA (pm->ps->origin, pml.frametime, pm->ps->velocity, pm->ps->origin);
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 92
ADDRLP4 88
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 96
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 100
ADDRLP4 96
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 931
;931:}
LABELV $332
endproc PM_NoclipMove 104 12
proc PM_FootstepForSurface 0 0
line 942
;932:
;933://============================================================================
;934:
;935:/*
;936:================
;937:PM_FootstepForSurface
;938:
;939:Returns an event number apropriate for the groundsurface
;940:================
;941:*/
;942:static int PM_FootstepForSurface( void ) {
line 943
;943:	if ( pml.groundTrace.surfaceFlags & SURF_NOSTEPS ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $351
line 944
;944:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $350
JUMPV
LABELV $351
line 946
;945:	}
;946:	if ( pml.groundTrace.surfaceFlags & SURF_METALSTEPS ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $355
line 947
;947:		return EV_FOOTSTEP_METAL;
CNSTI4 2
RETI4
ADDRGP4 $350
JUMPV
LABELV $355
line 949
;948:	}
;949:	return EV_FOOTSTEP;
CNSTI4 1
RETI4
LABELV $350
endproc PM_FootstepForSurface 0 0
proc PM_CrashLand 52 4
line 960
;950:}
;951:
;952:
;953:/*
;954:=================
;955:PM_CrashLand
;956:
;957:Check for hard landings that generate sound events
;958:=================
;959:*/
;960:static void PM_CrashLand( void ) {
line 968
;961:	float		delta;
;962:	float		dist;
;963:	float		vel, acc;
;964:	float		t;
;965:	float		a, b, c, den;
;966:
;967:	// decide which landing animation to use
;968:	if ( pm->ps->pm_flags & PMF_BACKWARDS_JUMP ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $360
line 969
;969:		PM_ForceLegsAnim( LEGS_LANDB );
CNSTI4 21
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 970
;970:	} else {
ADDRGP4 $361
JUMPV
LABELV $360
line 971
;971:		PM_ForceLegsAnim( LEGS_LAND );
CNSTI4 19
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 972
;972:	}
LABELV $361
line 974
;973:
;974:	pm->ps->legsTimer = TIMER_LAND;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 130
ASGNI4
line 977
;975:
;976:	// calculate the exact velocity on landing
;977:	dist = pm->ps->origin[2] - pml.previous_origin[2];
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 pml+116+8
INDIRF4
SUBF4
ASGNF4
line 978
;978:	vel = pml.previous_velocity[2];
ADDRLP4 8
ADDRGP4 pml+128+8
INDIRF4
ASGNF4
line 979
;979:	acc = -pm->ps->gravity;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 981
;980:
;981:	a = acc / 2;
ADDRLP4 16
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 982
;982:	b = vel;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 983
;983:	c = -dist;
ADDRLP4 32
ADDRLP4 24
INDIRF4
NEGF4
ASGNF4
line 985
;984:
;985:	den =  b * b - 4 * a * c;
ADDRLP4 20
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
CNSTF4 1082130432
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 32
INDIRF4
MULF4
SUBF4
ASGNF4
line 986
;986:	if ( den < 0 ) {
ADDRLP4 20
INDIRF4
CNSTF4 0
GEF4 $366
line 987
;987:		return;
ADDRGP4 $359
JUMPV
LABELV $366
line 989
;988:	}
;989:	t = (-b - sqrt( den ) ) / ( 2 * a );
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 40
INDIRF4
SUBF4
CNSTF4 1073741824
ADDRLP4 16
INDIRF4
MULF4
DIVF4
ASGNF4
line 991
;990:
;991:	delta = vel + t * acc;
ADDRLP4 0
ADDRLP4 8
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 992
;992:	delta = delta*delta * 0.0001;
ADDRLP4 0
CNSTF4 953267991
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
MULF4
ASGNF4
line 995
;993:
;994:	// ducking while falling doubles damage
;995:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $368
line 996
;996:		delta *= 2;
ADDRLP4 0
CNSTF4 1073741824
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 997
;997:	}
LABELV $368
line 1000
;998:
;999:	// never take falling damage if completely underwater
;1000:	if ( pm->waterlevel == 3 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 3
NEI4 $370
line 1001
;1001:		return;
ADDRGP4 $359
JUMPV
LABELV $370
line 1005
;1002:	}
;1003:
;1004:	// reduce falling damage if there is standing water
;1005:	if ( pm->waterlevel == 2 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
NEI4 $372
line 1006
;1006:		delta *= 0.25;
ADDRLP4 0
CNSTF4 1048576000
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 1007
;1007:	}
LABELV $372
line 1008
;1008:	if ( pm->waterlevel == 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
NEI4 $374
line 1009
;1009:		delta *= 0.5;
ADDRLP4 0
CNSTF4 1056964608
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 1010
;1010:	}
LABELV $374
line 1012
;1011:
;1012:	if ( delta < 1 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $376
line 1013
;1013:		return;
ADDRGP4 $359
JUMPV
LABELV $376
line 1020
;1014:	}
;1015:
;1016:	// create a local entity event to play the sound
;1017:
;1018:	// SURF_NODAMAGE is used for bounce pads where you don't ever
;1019:	// want to take damage or play a crunch sound
;1020:	if ( !(pml.groundTrace.surfaceFlags & SURF_NODAMAGE) )  {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $378
line 1021
;1021:		if ( delta > 60 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1114636288
LEF4 $382
line 1022
;1022:			PM_AddEvent( EV_FALL_FAR );
CNSTI4 12
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1023
;1023:		} else if ( delta > 40 ) {
ADDRGP4 $383
JUMPV
LABELV $382
ADDRLP4 0
INDIRF4
CNSTF4 1109393408
LEF4 $384
line 1025
;1024:			// this is a pain grunt, so don't play it if dead
;1025:			if ( pm->ps->stats[STAT_HEALTH] > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $385
line 1026
;1026:				PM_AddEvent( EV_FALL_MEDIUM );
CNSTI4 11
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1027
;1027:			}
line 1028
;1028:		} else if ( delta > 7 ) {
ADDRGP4 $385
JUMPV
LABELV $384
ADDRLP4 0
INDIRF4
CNSTF4 1088421888
LEF4 $388
line 1029
;1029:			PM_AddEvent( EV_FALL_SHORT );
CNSTI4 10
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1030
;1030:		} else {
ADDRGP4 $389
JUMPV
LABELV $388
line 1031
;1031:			PM_AddEvent( PM_FootstepForSurface() );
ADDRLP4 48
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1032
;1032:		}
LABELV $389
LABELV $385
LABELV $383
line 1033
;1033:	}
LABELV $378
line 1036
;1034:
;1035:	// start footstep cycle over
;1036:	pm->ps->bobCycle = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 1037
;1037:}
LABELV $359
endproc PM_CrashLand 52 4
proc PM_CorrectAllSolid 36 28
line 1060
;1038:
;1039:/*
;1040:=============
;1041:PM_CheckStuck
;1042:=============
;1043:*/
;1044:/*
;1045:void PM_CheckStuck(void) {
;1046:	trace_t trace;
;1047:
;1048:	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask);
;1049:	if (trace.allsolid) {
;1050:		//int shit = qtrue;
;1051:	}
;1052:}
;1053:*/
;1054:
;1055:/*
;1056:=============
;1057:PM_CorrectAllSolid
;1058:=============
;1059:*/
;1060:static int PM_CorrectAllSolid( trace_t *trace ) {
line 1065
;1061:	int			i, j, k;
;1062:	vec3_t		point;
;1063:	
;1064:
;1065:	if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $391
line 1066
;1066:		Com_Printf("%i:allsolid\n", c_pmove);
ADDRGP4 $393
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1067
;1067:	}
LABELV $391
line 1070
;1068:
;1069:	// jitter around
;1070:	for (i = -1; i <= 1; i++) {
ADDRLP4 20
CNSTI4 -1
ASGNI4
LABELV $394
line 1071
;1071:		for (j = -1; j <= 1; j++) {
ADDRLP4 16
CNSTI4 -1
ASGNI4
LABELV $398
line 1072
;1072:			for (k = -1; k <= 1; k++) {
ADDRLP4 12
CNSTI4 -1
ASGNI4
LABELV $402
line 1073
;1073:				VectorCopy(pm->ps->origin, point);
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1074
;1074:				point[0] += (float) i;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1075
;1075:				point[1] += (float) j;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1076
;1076:				point[2] += (float) k;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1077
;1077:				pm->trace (trace, point, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CALLV
pop
line 1078
;1078:				if ( !trace->allsolid ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $408
line 1079
;1079:					point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1080
;1080:					point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1081
;1081:					point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1083
;1082:
;1083:					pm->trace (trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CALLV
pop
line 1084
;1084:					pml.groundTrace = *trace;
ADDRGP4 pml+52
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 56
line 1085
;1085:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $390
JUMPV
LABELV $408
line 1087
;1086:				}
;1087:			}
LABELV $403
line 1072
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
LEI4 $402
line 1088
;1088:		}
LABELV $399
line 1071
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LEI4 $398
line 1089
;1089:	}
LABELV $395
line 1070
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 1
LEI4 $394
line 1091
;1090:
;1091:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1092
;1092:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1093
;1093:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1095
;1094:
;1095:	return qfalse;
CNSTI4 0
RETI4
LABELV $390
endproc PM_CorrectAllSolid 36 28
proc PM_GroundTraceMissed 80 28
line 1106
;1096:}
;1097:
;1098:
;1099:/*
;1100:=============
;1101:PM_GroundTraceMissed
;1102:
;1103:The ground trace didn't hit a surface, so we are in freefall
;1104:=============
;1105:*/
;1106:static void PM_GroundTraceMissed( void ) {
line 1110
;1107:	trace_t		trace;
;1108:	vec3_t		point;
;1109:
;1110:	if ( pm->ps->groundEntityNum != ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $416
line 1112
;1111:		// we just transitioned into freefall
;1112:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $418
line 1113
;1113:			Com_Printf("%i:lift\n", c_pmove);
ADDRGP4 $420
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1114
;1114:		}
LABELV $418
line 1118
;1115:
;1116:		// if they aren't in a jumping animation and the ground is a ways away, force into it
;1117:		// if we didn't do the trace, the player would be backflipping down staircases
;1118:		VectorCopy( pm->ps->origin, point );
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1119
;1119:		point[2] -= 64;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 1121
;1120:
;1121:		pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 12
ARGP4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CALLV
pop
line 1122
;1122:		if ( trace.fraction == 1.0 ) {
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $422
line 1123
;1123:			if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $425
line 1124
;1124:				PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1125
;1125:				pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1126
;1126:			} else {
ADDRGP4 $426
JUMPV
LABELV $425
line 1127
;1127:				PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1128
;1128:				pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1129
;1129:			}
LABELV $426
line 1130
;1130:		}
LABELV $422
line 1131
;1131:	}
LABELV $416
line 1133
;1132:
;1133:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1134
;1134:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1135
;1135:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1136
;1136:}
LABELV $415
endproc PM_GroundTraceMissed 80 28
proc PM_GroundTrace 88 28
line 1144
;1137:
;1138:
;1139:/*
;1140:=============
;1141:PM_GroundTrace
;1142:=============
;1143:*/
;1144:static void PM_GroundTrace( void ) {
line 1148
;1145:	vec3_t		point;
;1146:	trace_t		trace;
;1147:
;1148:	point[0] = pm->ps->origin[0];
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1149
;1149:	point[1] = pm->ps->origin[1];
ADDRLP4 56+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1150
;1150:	point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 56+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1152
;1151:
;1152:	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CALLV
pop
line 1153
;1153:	pml.groundTrace = trace;
ADDRGP4 pml+52
ADDRLP4 0
INDIRB
ASGNB 56
line 1156
;1154:
;1155:	// do something corrective if the trace starts in a solid...
;1156:	if ( trace.allsolid ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $433
line 1159
;1157:
;1158:
;1159:		if ( !PM_CorrectAllSolid(&trace) )
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 PM_CorrectAllSolid
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $435
line 1160
;1160:			return;
ADDRGP4 $429
JUMPV
LABELV $435
line 1161
;1161:	}
LABELV $433
line 1164
;1162:
;1163:	// if the trace didn't hit anything, we are in free fall
;1164:	if ( trace.fraction == 1.0 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $437
line 1165
;1165:		PM_GroundTraceMissed();
ADDRGP4 PM_GroundTraceMissed
CALLV
pop
line 1166
;1166:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1167
;1167:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1172
;1168:		
;1169:				
;1170:		
;1171:			// Ignore and reset multijumps and wall jump if they have the jetpack
;1172:			if (pm->ps->powerups[PW_FLIGHT]) 
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $442
line 1173
;1173:			{
line 1174
;1174:				trep_multijumps = 0;
ADDRGP4 trep_multijumps
CNSTI4 0
ASGNI4
line 1176
;1175:				
;1176:			} 
ADDRGP4 $429
JUMPV
LABELV $442
line 1178
;1177:			else
;1178:			{
line 1180
;1179:				// Go ahead and do the multijump
;1180:				if(trep_multijumps < 3)
ADDRGP4 trep_multijumps
INDIRI4
CNSTI4 3
GEI4 $444
line 1181
;1181:				{
line 1183
;1182:					//PM_CheckJump ();		
;1183:				} else {
ADDRGP4 $429
JUMPV
LABELV $444
line 1184
;1184:					trep_multijumps = 0;
ADDRGP4 trep_multijumps
CNSTI4 0
ASGNI4
line 1185
;1185:				}
line 1186
;1186:			}
line 1191
;1187:		
;1188:	
;1189:		
;1190:
;1191:		return;
ADDRGP4 $429
JUMPV
LABELV $437
line 1195
;1192:	}
;1193:
;1194:	// check if getting thrown off the ground
;1195:	if ( pm->ps->velocity[2] > 0 && DotProduct( pm->ps->velocity, trace.plane.normal ) > 10 ) {
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 76
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ASGNF4
ADDRLP4 80
INDIRF4
CNSTF4 0
LEF4 $446
ADDRLP4 76
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
MULF4
ADDRLP4 76
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 80
INDIRF4
ADDRLP4 0+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 1092616192
LEF4 $446
line 1196
;1196:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $453
line 1197
;1197:			Com_Printf("%i:kickoff\n", c_pmove);
ADDRGP4 $455
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1198
;1198:		}
LABELV $453
line 1200
;1199:		// go into jump animation
;1200:		if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $456
line 1201
;1201:			PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1202
;1202:			pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1203
;1203:		} else {
ADDRGP4 $457
JUMPV
LABELV $456
line 1204
;1204:			PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1205
;1205:			pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1206
;1206:		}
LABELV $457
line 1208
;1207:
;1208:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1209
;1209:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1210
;1210:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1211
;1211:		return;
ADDRGP4 $429
JUMPV
LABELV $446
line 1219
;1212:	}
;1213:	
;1214:
;1215:	
;1216:
;1217:
;1218:	// slopes that are too steep will not be considered onground
;1219:	if ( trace.plane.normal[2] < MIN_WALK_NORMAL ) {  
ADDRLP4 0+24+8
INDIRF4
CNSTF4 1060320051
GEF4 $460
line 1223
;1220:		
;1221:			
;1222://		if (pm->ps->MultiJumps < 5 ) {
;1223:			PM_CheckJump(); // Allows you to jump up slopes
ADDRGP4 PM_CheckJump
CALLI4
pop
line 1227
;1224://		}
;1225:	
;1226:		
;1227:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $464
line 1228
;1228:			Com_Printf("%i:steep\n", c_pmove);
ADDRGP4 $466
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1230
;1229:			
;1230:		}
LABELV $464
line 1233
;1231:		// FIXME: if they can't slide down the slope, let them
;1232:		// walk (sharp crevices)
;1233:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1234
;1234:		pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1235
;1235:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1236
;1236:		return;
ADDRGP4 $429
JUMPV
LABELV $460
line 1239
;1237:	}
;1238:
;1239:	pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1240
;1240:	pml.walking = qtrue;
ADDRGP4 pml+44
CNSTI4 1
ASGNI4
line 1243
;1241:
;1242:	// hitting solid ground will end a waterjump
;1243:	if (pm->ps->pm_flags & PMF_TIME_WATERJUMP)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $471
line 1244
;1244:	{
line 1245
;1245:		pm->ps->pm_flags &= ~(PMF_TIME_WATERJUMP | PMF_TIME_LAND);
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 -289
BANDI4
ASGNI4
line 1246
;1246:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1247
;1247:	}
LABELV $471
line 1249
;1248:
;1249:	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $473
line 1252
;1250:		// just hit the ground
;1251:		//pm->ps->MultiJumps = 0; // Shafe - Trep - Multijumping / Wall Jumping
;1252:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $475
line 1253
;1253:			Com_Printf("%i:Land\n", c_pmove);
ADDRGP4 $477
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1254
;1254:		}
LABELV $475
line 1256
;1255:		
;1256:		PM_CrashLand();
ADDRGP4 PM_CrashLand
CALLV
pop
line 1259
;1257:
;1258:		// don't do landing time if we were just going down a slope
;1259:		if ( pml.previous_velocity[2] < -200 ) {
ADDRGP4 pml+128+8
INDIRF4
CNSTF4 3276275712
GEF4 $478
line 1261
;1260:			// don't allow another jump for a little while
;1261:			pm->ps->pm_flags |= PMF_TIME_LAND;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1262
;1262:			pm->ps->pm_time = 250;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 250
ASGNI4
line 1263
;1263:		}
LABELV $478
line 1264
;1264:	}
LABELV $473
line 1266
;1265:
;1266:	pm->ps->groundEntityNum = trace.entityNum;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 1271
;1267:
;1268:	// don't reset the z velocity for slopes
;1269:	// pm->ps->velocity[2] = 0;
;1270:
;1271:	PM_AddTouchEnt( trace.entityNum );
ADDRLP4 0+52
INDIRI4
ARGI4
ADDRGP4 PM_AddTouchEnt
CALLV
pop
line 1273
;1272://	pm->ps->MultiJumps = 0; // Shafe - Trep - Multijumping / Wall Jumping
;1273:}
LABELV $429
endproc PM_GroundTrace 88 28
proc PM_SetWaterLevel 48 8
line 1281
;1274:
;1275:
;1276:/*
;1277:=============
;1278:PM_SetWaterLevel	FIXME: avoid this twice?  certainly if not moving
;1279:=============
;1280:*/
;1281:static void PM_SetWaterLevel( void ) {
line 1290
;1282:	vec3_t		point;
;1283:	int			cont;
;1284:	int			sample1;
;1285:	int			sample2;
;1286:
;1287:	//
;1288:	// get waterlevel, accounting for ducking
;1289:	//
;1290:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 0
ASGNI4
line 1291
;1291:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 1293
;1292:
;1293:	point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1294
;1294:	point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1295
;1295:	point[2] = pm->ps->origin[2] + MINS_Z + 1;	
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1296
;1296:	cont = pm->pointcontents( point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 1298
;1297:
;1298:	if ( cont & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $487
line 1299
;1299:		sample2 = pm->ps->viewheight - MINS_Z;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 -24
SUBI4
ASGNI4
line 1300
;1300:		sample1 = sample2 / 2;
ADDRLP4 20
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 1302
;1301:
;1302:		pm->watertype = cont;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1303
;1303:		pm->waterlevel = 1;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 1
ASGNI4
line 1304
;1304:		point[2] = pm->ps->origin[2] + MINS_Z + sample1;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1305
;1305:		cont = pm->pointcontents (point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 1306
;1306:		if ( cont & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $490
line 1307
;1307:			pm->waterlevel = 2;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 2
ASGNI4
line 1308
;1308:			point[2] = pm->ps->origin[2] + MINS_Z + sample2;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1309
;1309:			cont = pm->pointcontents (point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 1310
;1310:			if ( cont & MASK_WATER ){
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $493
line 1311
;1311:				pm->waterlevel = 3;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 3
ASGNI4
line 1312
;1312:			}
LABELV $493
line 1313
;1313:		}
LABELV $490
line 1314
;1314:	}
LABELV $487
line 1316
;1315:
;1316:}
LABELV $484
endproc PM_SetWaterLevel 48 8
proc PM_CheckDuck 76 28
line 1326
;1317:
;1318:/*
;1319:==============
;1320:PM_CheckDuck
;1321:
;1322:Sets mins, maxs, and pm->ps->viewheight
;1323:==============
;1324:*/
;1325:static void PM_CheckDuck (void)
;1326:{
line 1329
;1327:	trace_t	trace;
;1328:
;1329:	if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $496
line 1330
;1330:		if ( pm->ps->pm_flags & PMF_INVULEXPAND ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $498
line 1332
;1331:			// invulnerability sphere has a 42 units radius
;1332:			VectorSet( pm->mins, -42, -42, -42 );
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3257401344
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3257401344
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3257401344
ASGNF4
line 1333
;1333:			VectorSet( pm->maxs, 42, 42, 42 );
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1109917696
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1109917696
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1109917696
ASGNF4
line 1334
;1334:		}
ADDRGP4 $499
JUMPV
LABELV $498
line 1335
;1335:		else {
line 1336
;1336:			VectorSet( pm->mins, -15, -15, MINS_Z );
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3250585600
ASGNF4
line 1337
;1337:			VectorSet( pm->maxs, 15, 15, 16 );
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1098907648
ASGNF4
line 1338
;1338:		}
LABELV $499
line 1339
;1339:		pm->ps->pm_flags |= PMF_DUCKED;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1340
;1340:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 12
ASGNI4
line 1341
;1341:		return;
ADDRGP4 $495
JUMPV
LABELV $496
line 1343
;1342:	}
;1343:	pm->ps->pm_flags &= ~PMF_INVULEXPAND;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 1345
;1344:
;1345:	pm->mins[0] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3245342720
ASGNF4
line 1346
;1346:	pm->mins[1] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3245342720
ASGNF4
line 1348
;1347:
;1348:	pm->maxs[0] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1097859072
ASGNF4
line 1349
;1349:	pm->maxs[1] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1097859072
ASGNF4
line 1351
;1350:
;1351:	pm->mins[2] = MINS_Z;
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3250585600
ASGNF4
line 1353
;1352:
;1353:	if (pm->ps->pm_type == PM_DEAD)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $500
line 1354
;1354:	{
line 1355
;1355:		pm->maxs[2] = -8;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 3238002688
ASGNF4
line 1356
;1356:		pm->ps->viewheight = DEAD_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 -16
ASGNI4
line 1357
;1357:		return;
ADDRGP4 $495
JUMPV
LABELV $500
line 1360
;1358:	}
;1359:
;1360:	if (pm->cmd.upmove < 0)
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $502
line 1361
;1361:	{	// duck
line 1362
;1362:		pm->ps->pm_flags |= PMF_DUCKED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1363
;1363:	}
ADDRGP4 $503
JUMPV
LABELV $502
line 1365
;1364:	else
;1365:	{	// stand up if possible
line 1366
;1366:		if (pm->ps->pm_flags & PMF_DUCKED)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $504
line 1367
;1367:		{
line 1369
;1368:			// try to stand up
;1369:			pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1107296256
ASGNF4
line 1370
;1370:			pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask );
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CALLV
pop
line 1371
;1371:			if (!trace.allsolid)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $506
line 1372
;1372:				pm->ps->pm_flags &= ~PMF_DUCKED;
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
LABELV $506
line 1373
;1373:		}
LABELV $504
line 1374
;1374:	}
LABELV $503
line 1376
;1375:
;1376:	if (pm->ps->pm_flags & PMF_DUCKED)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $508
line 1377
;1377:	{
line 1378
;1378:		pm->maxs[2] = 16;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1098907648
ASGNF4
line 1379
;1379:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 12
ASGNI4
line 1380
;1380:	}
ADDRGP4 $509
JUMPV
LABELV $508
line 1382
;1381:	else
;1382:	{
line 1383
;1383:		pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1107296256
ASGNF4
line 1384
;1384:		pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
line 1385
;1385:	}
LABELV $509
line 1386
;1386:}
LABELV $495
endproc PM_CheckDuck 76 28
proc PM_Footsteps 52 4
line 1398
;1387:
;1388:
;1389:
;1390://===================================================================
;1391:
;1392:
;1393:/*
;1394:===============
;1395:PM_Footsteps
;1396:===============
;1397:*/
;1398:static void PM_Footsteps( void ) {
line 1407
;1399:	float		bobmove;
;1400:	int			old;
;1401:	qboolean	footstep;
;1402:
;1403:	//
;1404:	// calculate speed and cycle to be used for
;1405:	// all cyclic walking effects
;1406:	//
;1407:	pm->xyspeed = sqrt( pm->ps->velocity[0] * pm->ps->velocity[0]
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDRLP4 24
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 28
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 212
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
line 1410
;1408:		+  pm->ps->velocity[1] * pm->ps->velocity[1] );
;1409:
;1410:	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $511
line 1412
;1411:
;1412:		if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $513
line 1413
;1413:			PM_ContinueLegsAnim( LEGS_IDLECR );
CNSTI4 23
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1414
;1414:		}
LABELV $513
line 1416
;1415:		// airborne leaves position in cycle intact, but doesn't advance
;1416:		if ( pm->waterlevel > 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LEI4 $510
line 1417
;1417:			PM_ContinueLegsAnim( LEGS_SWIM );
CNSTI4 17
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1418
;1418:		}
line 1419
;1419:		return;
ADDRGP4 $510
JUMPV
LABELV $511
line 1423
;1420:	}
;1421:
;1422:	// if not trying to move
;1423:	if ( !pm->cmd.forwardmove && !pm->cmd.rightmove ) {
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
NEI4 $517
ADDRLP4 32
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
NEI4 $517
line 1424
;1424:		if (  pm->xyspeed < 5 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
CNSTF4 1084227584
GEF4 $510
line 1425
;1425:			pm->ps->bobCycle = 0;	// start at beginning of cycle again
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 1426
;1426:			if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $521
line 1427
;1427:				PM_ContinueLegsAnim( LEGS_IDLECR );
CNSTI4 23
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1428
;1428:			} else {
ADDRGP4 $510
JUMPV
LABELV $521
line 1429
;1429:				PM_ContinueLegsAnim( LEGS_IDLE );
CNSTI4 22
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1430
;1430:			}
line 1431
;1431:		}
line 1432
;1432:		return;
ADDRGP4 $510
JUMPV
LABELV $517
line 1436
;1433:	}
;1434:	
;1435:
;1436:	footstep = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1438
;1437:
;1438:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $523
line 1439
;1439:		bobmove = 0.5;	// ducked characters bob much faster
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1440
;1440:		if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $525
line 1441
;1441:			PM_ContinueLegsAnim( LEGS_BACKCR );
CNSTI4 32
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1442
;1442:		}
ADDRGP4 $524
JUMPV
LABELV $525
line 1443
;1443:		else {
line 1444
;1444:			PM_ContinueLegsAnim( LEGS_WALKCR );
CNSTI4 13
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1445
;1445:		}
line 1457
;1446:		// ducked characters never play footsteps
;1447:	/*
;1448:	} else 	if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
;1449:		if ( !( pm->cmd.buttons & BUTTON_WALKING ) ) {
;1450:			bobmove = 0.4;	// faster speeds bob faster
;1451:			footstep = qtrue;
;1452:		} else {
;1453:			bobmove = 0.3;
;1454:		}
;1455:		PM_ContinueLegsAnim( LEGS_BACK );
;1456:	*/
;1457:	} else {
ADDRGP4 $524
JUMPV
LABELV $523
line 1458
;1458:		if ( !( pm->cmd.buttons & BUTTON_WALKING ) ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $527
line 1459
;1459:			bobmove = 0.4f;	// faster speeds bob faster
ADDRLP4 4
CNSTF4 1053609165
ASGNF4
line 1460
;1460:			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $529
line 1461
;1461:				PM_ContinueLegsAnim( LEGS_BACK );
CNSTI4 16
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1462
;1462:			}
ADDRGP4 $530
JUMPV
LABELV $529
line 1463
;1463:			else {
line 1464
;1464:				PM_ContinueLegsAnim( LEGS_RUN );
CNSTI4 15
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1465
;1465:			}
LABELV $530
line 1466
;1466:			footstep = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1467
;1467:		} else {
ADDRGP4 $528
JUMPV
LABELV $527
line 1468
;1468:			bobmove = 0.3f;	// walking bobs slow
ADDRLP4 4
CNSTF4 1050253722
ASGNF4
line 1469
;1469:			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $531
line 1470
;1470:				PM_ContinueLegsAnim( LEGS_BACKWALK );
CNSTI4 33
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1471
;1471:			}
ADDRGP4 $532
JUMPV
LABELV $531
line 1472
;1472:			else {
line 1473
;1473:				PM_ContinueLegsAnim( LEGS_WALK );
CNSTI4 14
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1474
;1474:			}
LABELV $532
line 1475
;1475:		}
LABELV $528
line 1476
;1476:	}
LABELV $524
line 1479
;1477:
;1478:	// check for footstep / splash sounds
;1479:	old = pm->ps->bobCycle;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1480
;1480:	pm->ps->bobCycle = (int)( old + bobmove * pml.msec ) & 255;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
ADDRGP4 pml+40
INDIRI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
CNSTI4 255
BANDI4
ASGNI4
line 1483
;1481:
;1482:	// if we just crossed a cycle boundary, play an apropriate footstep event
;1483:	if ( ( ( old + 64 ) ^ ( pm->ps->bobCycle + 64 ) ) & 128 ) {
ADDRLP4 40
CNSTI4 64
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
BXORI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $534
line 1484
;1484:		if ( pm->waterlevel == 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
NEI4 $536
line 1486
;1485:			// on ground will only play sounds if running
;1486:			if ( footstep && !pm->noFootsteps ) {
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $537
ADDRGP4 pm
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
NEI4 $537
line 1487
;1487:				PM_AddEvent( PM_FootstepForSurface() );
ADDRLP4 48
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1488
;1488:			}
line 1489
;1489:		} else if ( pm->waterlevel == 1 ) {
ADDRGP4 $537
JUMPV
LABELV $536
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
NEI4 $540
line 1491
;1490:			// splashing
;1491:			PM_AddEvent( EV_FOOTSPLASH );
CNSTI4 3
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1492
;1492:		} else if ( pm->waterlevel == 2 ) {
ADDRGP4 $541
JUMPV
LABELV $540
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
NEI4 $542
line 1494
;1493:			// wading / swimming at surface
;1494:			PM_AddEvent( EV_SWIM );
CNSTI4 5
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1495
;1495:		} else if ( pm->waterlevel == 3 ) {
ADDRGP4 $543
JUMPV
LABELV $542
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 3
NEI4 $544
line 1498
;1496:			// no sound when completely underwater
;1497:
;1498:		}
LABELV $544
LABELV $543
LABELV $541
LABELV $537
line 1499
;1499:	}
LABELV $534
line 1500
;1500:}
LABELV $510
endproc PM_Footsteps 52 4
proc PM_WaterEvents 16 4
line 1509
;1501:
;1502:/*
;1503:==============
;1504:PM_WaterEvents
;1505:
;1506:Generate sound events for entering and leaving water
;1507:==============
;1508:*/
;1509:static void PM_WaterEvents( void ) {		// FIXME?
line 1513
;1510:	//
;1511:	// if just entered a water volume, play a sound
;1512:	//
;1513:	if (!pml.previous_waterlevel && pm->waterlevel) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 pml+140
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $547
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $547
line 1514
;1514:		PM_AddEvent( EV_WATER_TOUCH );
CNSTI4 15
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1515
;1515:	}
LABELV $547
line 1520
;1516:
;1517:	//
;1518:	// if just completely exited a water volume, play a sound
;1519:	//
;1520:	if (pml.previous_waterlevel && !pm->waterlevel) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 pml+140
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $550
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $550
line 1521
;1521:		PM_AddEvent( EV_WATER_LEAVE );
CNSTI4 16
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1522
;1522:	}
LABELV $550
line 1527
;1523:
;1524:	//
;1525:	// check for head just going under water
;1526:	//
;1527:	if (pml.previous_waterlevel != 3 && pm->waterlevel == 3) {
ADDRLP4 8
CNSTI4 3
ASGNI4
ADDRGP4 pml+140
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $553
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $553
line 1528
;1528:		PM_AddEvent( EV_WATER_UNDER );
CNSTI4 17
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1529
;1529:	}
LABELV $553
line 1534
;1530:
;1531:	//
;1532:	// check for head just coming out of water
;1533:	//
;1534:	if (pml.previous_waterlevel == 3 && pm->waterlevel != 3) {
ADDRLP4 12
CNSTI4 3
ASGNI4
ADDRGP4 pml+140
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $556
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $556
line 1535
;1535:		PM_AddEvent( EV_WATER_CLEAR );
CNSTI4 18
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1536
;1536:	}
LABELV $556
line 1537
;1537:}
LABELV $546
endproc PM_WaterEvents 16 4
data
export altAmmoUsage
align 4
LABELV altAmmoUsage
byte 4 0
byte 4 1
byte 4 1
byte 4 6
byte 4 2
byte 4 3
byte 4 1
byte 4 0
byte 4 2
byte 4 3
byte 4 20
skip 4
code
proc PM_BeginWeaponChange 8 4
line 1565
;1538:
;1539:
;1540:// Shafe - Trep - Alt Ammo Usage 
;1541:// alt ammo usage
;1542:
;1543:int		altAmmoUsage[WP_NUM_WEAPONS] =
;1544:{
;1545:	0,				//WP_NONE,
;1546:	1,				//GAUNTLET,				
;1547:	1,				//machine gun
;1548:	6,				//shotgun
;1549:	2,				//grenade launcher
;1550:	3,				//rocket launcher/singularity cannon
;1551:	1,				//flame thrower
;1552:	0,				//rail gun - it's just the sing cannon..lets make it more than alt sing to piss people off.
;1553:	2,				//Gata Gun
;1554:	3,				//bfg/devastator
;1555:	20,				//hmmmm... dunno what this one is
;1556:
;1557:
;1558:};
;1559:
;1560:/*
;1561:===============
;1562:PM_BeginWeaponChange
;1563:===============
;1564:*/
;1565:static void PM_BeginWeaponChange( int weapon ) {
line 1566
;1566:	if ( weapon <= WP_NONE || weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $562
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $560
LABELV $562
line 1567
;1567:		return;
ADDRGP4 $559
JUMPV
LABELV $560
line 1570
;1568:	}
;1569:
;1570:	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $563
line 1571
;1571:		return;
ADDRGP4 $559
JUMPV
LABELV $563
line 1574
;1572:	}
;1573:	
;1574:	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $565
line 1575
;1575:		return;
ADDRGP4 $559
JUMPV
LABELV $565
line 1578
;1576:	}
;1577:
;1578:	PM_AddEvent( EV_CHANGE_WEAPON );
CNSTI4 22
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1579
;1579:	pm->ps->weaponstate = WEAPON_DROPPING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 2
ASGNI4
line 1580
;1580:	pm->ps->weaponTime += 200;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1581
;1581:	PM_StartTorsoAnim( TORSO_DROP );
CNSTI4 9
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1582
;1582:}
LABELV $559
endproc PM_BeginWeaponChange 8 4
proc PM_FinishWeaponChange 12 4
line 1590
;1583:
;1584:
;1585:/*
;1586:===============
;1587:PM_FinishWeaponChange
;1588:===============
;1589:*/
;1590:static void PM_FinishWeaponChange( void ) {
line 1593
;1591:	int		weapon;
;1592:
;1593:	weapon = pm->cmd.weapon;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 1594
;1594:	if ( weapon < WP_NONE || weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $570
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $568
LABELV $570
line 1595
;1595:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1596
;1596:	}
LABELV $568
line 1598
;1597:
;1598:	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $571
line 1599
;1599:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1600
;1600:	}
LABELV $571
line 1602
;1601:
;1602:	pm->ps->weapon = weapon;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1603
;1603:	pm->ps->weaponstate = WEAPON_RAISING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1
ASGNI4
line 1604
;1604:	pm->ps->weaponTime += 250;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 250
ADDI4
ASGNI4
line 1605
;1605:	PM_StartTorsoAnim( TORSO_RAISE );
CNSTI4 10
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1606
;1606:}
LABELV $567
endproc PM_FinishWeaponChange 12 4
proc PM_TorsoAnimation 0 4
line 1615
;1607:
;1608:
;1609:/*
;1610:==============
;1611:PM_TorsoAnimation
;1612:
;1613:==============
;1614:*/
;1615:static void PM_TorsoAnimation( void ) {
line 1616
;1616:	if ( pm->ps->weaponstate == WEAPON_READY ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
NEI4 $574
line 1617
;1617:		if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $576
line 1618
;1618:			PM_ContinueTorsoAnim( TORSO_STAND2 );
CNSTI4 12
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1619
;1619:		} else {
ADDRGP4 $573
JUMPV
LABELV $576
line 1620
;1620:			PM_ContinueTorsoAnim( TORSO_STAND );
CNSTI4 11
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1621
;1621:		}
line 1622
;1622:		return;
LABELV $574
line 1624
;1623:	}
;1624:}
LABELV $573
endproc PM_TorsoAnimation 0 4
proc PM_Weapon 48 4
line 1635
;1625:
;1626:
;1627:/*
;1628:==============
;1629:PM_Weapon
;1630:
;1631:Generates weapon events and modifes the weapon counter
;1632:==============
;1633:*/
;1634:
;1635:static void PM_Weapon( void ) {
line 1636
;1636:	int		addTime = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1637
;1637:	qboolean	altfired = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1641
;1638:
;1639:
;1640:	// don't allow attack until all buttons are up
;1641:	if ( pm->ps->pm_flags & PMF_RESPAWNED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $579
line 1642
;1642:		return;
ADDRGP4 $578
JUMPV
LABELV $579
line 1646
;1643:	}
;1644:
;1645:	// ignore if spectator
;1646:	if ( pm->ps->persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $581
line 1647
;1647:		return;
ADDRGP4 $578
JUMPV
LABELV $581
line 1651
;1648:	}
;1649:
;1650:	// check for dead player
;1651:	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $583
line 1652
;1652:		pm->ps->weapon = WP_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 1653
;1653:		return;
ADDRGP4 $578
JUMPV
LABELV $583
line 1657
;1654:	}
;1655:
;1656:	// check for item using
;1657:	if ( pm->cmd.buttons & BUTTON_USE_HOLDABLE ) 
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $585
line 1658
;1658:	{
line 1659
;1659:		if ( !( pm->ps->pm_flags & PMF_USE_ITEM_HELD ) ) 
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $586
line 1660
;1660:		{ // Medkits are now holdable -Vincent			
line 1661
;1661:			pm->ps->pm_flags |= PMF_USE_ITEM_HELD;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 1662
;1662:			PM_AddEvent( EV_USE_ITEM0 + bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag );
CNSTI4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1663
;1663:			pm->ps->stats[STAT_HOLDABLE_ITEM] = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 1664
;1664:			return;
ADDRGP4 $578
JUMPV
line 1666
;1665:		}
;1666:	} 
LABELV $585
line 1668
;1667:	else 
;1668:	{
line 1669
;1669:		pm->ps->pm_flags &= ~PMF_USE_ITEM_HELD;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 1670
;1670:	}
LABELV $586
line 1674
;1671:
;1672:
;1673:	// make weapon function
;1674:	if ( pm->ps->weaponTime > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $590
line 1675
;1675:		pm->ps->weaponTime -= pml.msec;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1676
;1676:	}
LABELV $590
line 1681
;1677:
;1678:	// check for weapon change
;1679:	// can't change if weapon is firing, but can change
;1680:	// again if lowering or raising
;1681:	if ( pm->ps->weaponTime <= 0 || pm->ps->weaponstate != WEAPON_FIRING ) {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $595
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 3
EQI4 $593
LABELV $595
line 1682
;1682:		if ( pm->ps->weapon != pm->cmd.weapon ) {
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
EQI4 $596
line 1683
;1683:			PM_BeginWeaponChange( pm->cmd.weapon );
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ARGI4
ADDRGP4 PM_BeginWeaponChange
CALLV
pop
line 1684
;1684:		}
LABELV $596
line 1685
;1685:	}
LABELV $593
line 1687
;1686:
;1687:	if ( pm->ps->weaponTime > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $598
line 1688
;1688:		return;
ADDRGP4 $578
JUMPV
LABELV $598
line 1692
;1689:	}
;1690:
;1691:	// change weapon if time
;1692:	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $600
line 1693
;1693:		PM_FinishWeaponChange();
ADDRGP4 PM_FinishWeaponChange
CALLV
pop
line 1694
;1694:		return;
ADDRGP4 $578
JUMPV
LABELV $600
line 1700
;1695:	}
;1696:
;1697:
;1698:
;1699:
;1700:	if ( pm->ps->weaponstate == WEAPON_RAISING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
NEI4 $602
line 1701
;1701:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1702
;1702:		if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $604
line 1703
;1703:			PM_StartTorsoAnim( TORSO_STAND2 );
CNSTI4 12
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1704
;1704:		} else {
ADDRGP4 $578
JUMPV
LABELV $604
line 1705
;1705:			PM_StartTorsoAnim( TORSO_STAND );
CNSTI4 11
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1706
;1706:		}
line 1707
;1707:		return;
ADDRGP4 $578
JUMPV
LABELV $602
line 1716
;1708:	}
;1709:
;1710:
;1711:
;1712:
;1713:	// check for fire
;1714:	// Shafe - Trep - Alt Fire
;1715:
;1716:	if ( ! ((pm->cmd.buttons & BUTTON_ATTACK) ||( pm->cmd.buttons & 32)) ) 
ADDRLP4 12
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 16
INDIRI4
NEI4 $606
ADDRLP4 12
INDIRI4
CNSTI4 32
BANDI4
ADDRLP4 16
INDIRI4
NEI4 $606
line 1717
;1717:	{
line 1718
;1718:				pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1719
;1719:				pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1720
;1720:				altfired = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1721
;1721:				return;
ADDRGP4 $578
JUMPV
LABELV $606
line 1727
;1722:	}
;1723:	
;1724:
;1725:
;1726:	// start the animation even if out of ammo
;1727:	if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $608
line 1729
;1728:		// the guantlet only "fires" when it actually hits something
;1729:		if ( !pm->gauntletHit ) {
ADDRGP4 pm
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
NEI4 $610
line 1730
;1730:			pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1731
;1731:			pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1732
;1732:			return;
ADDRGP4 $578
JUMPV
LABELV $610
line 1734
;1733:		}
;1734:		PM_StartTorsoAnim( TORSO_ATTACK2 );
CNSTI4 8
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1735
;1735:	} else {
ADDRGP4 $609
JUMPV
LABELV $608
line 1736
;1736:		PM_StartTorsoAnim( TORSO_ATTACK );
CNSTI4 7
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1737
;1737:	}
LABELV $609
line 1739
;1738:
;1739:	pm->ps->weaponstate = WEAPON_FIRING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 3
ASGNI4
line 1742
;1740:
;1741:	// check for out of ammo
;1742:	if ( ! pm->ps->ammo[ pm->ps->weapon ] ) {
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $612
line 1743
;1743:		PM_AddEvent( EV_NOAMMO );
CNSTI4 21
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1744
;1744:		pm->ps->weaponTime += 500;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 1745
;1745:		return;
ADDRGP4 $578
JUMPV
LABELV $612
line 1750
;1746:	}
;1747:
;1748:	// check for out of ammo for alt fire - Shafe - Trep 
;1749:	// There is some sort of issue with this I think.
;1750:	if ( pm->cmd.buttons & 32)
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $614
line 1751
;1751:	{
line 1752
;1752:		if ( (pm->ps->ammo[ pm->ps->weapon ]-altAmmoUsage[pm->ps->weapon]) <= 0) 
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
ADDRGP4 altAmmoUsage
ADDP4
INDIRI4
SUBI4
CNSTI4 0
GTI4 $616
line 1753
;1753:		{
line 1754
;1754:			PM_AddEvent( EV_NOAMMO );
CNSTI4 21
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1755
;1755:			pm->ps->weaponTime += 500;
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 1756
;1756:			return;
ADDRGP4 $578
JUMPV
LABELV $616
line 1759
;1757:		}
;1758:
;1759:	}
LABELV $614
line 1778
;1760:
;1761:	
;1762:	
;1763:
;1764:
;1765:		
;1766:
;1767:
;1768:
;1769:
;1770:	// Shafe - Trep Instagib  Cant get this to work - But This would be the correct way to go about it
;1771:	//if (g_instagib.integer == 1) {  
;1772:	//	if ( pm->ps->weapon != WP_RAILGUN ); // InstaGib - unlimited ammo
;1773:	//}
;1774:
;1775:
;1776:// Shafe - Trep.. All Replaced For Alt Fire Usage
;1777:// Normal Attack Button 
;1778:if (pm->cmd.buttons & 1) { 
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $618
line 1781
;1779:
;1780:  // Normal Fire Event 
;1781:  PM_AddEvent( EV_FIRE_WEAPON ); 
CNSTI4 23
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1783
;1782:
;1783:  switch( pm->ps->weapon ) { 
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 1
LTI4 $620
ADDRLP4 24
INDIRI4
CNSTI4 11
GTI4 $620
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $634-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $634
address $623
address $626
address $625
address $627
address $628
address $624
address $630
address $629
address $631
address $632
address $633
code
LABELV $620
LABELV $623
line 1787
;1784:  default: 
;1785:
;1786:	case WP_GAUNTLET: 
;1787:		addTime = 400; 
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1788
;1788:		break; 
ADDRGP4 $619
JUMPV
LABELV $624
line 1790
;1789:	case WP_LIGHTNING: 
;1790:		addTime = 400;  // Shafe - Trep - Flame Thrower was 50 -- Primary Fire Shoots Flame Balls
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1791
;1791:		break; 
ADDRGP4 $619
JUMPV
LABELV $625
line 1793
;1792:	case WP_SHOTGUN: 
;1793:		addTime = 1000; 
ADDRLP4 0
CNSTI4 1000
ASGNI4
line 1794
;1794:		break; 
ADDRGP4 $619
JUMPV
LABELV $626
line 1796
;1795:	case WP_MACHINEGUN: 
;1796:		addTime = 100; 
ADDRLP4 0
CNSTI4 100
ASGNI4
line 1797
;1797:		break; 
ADDRGP4 $619
JUMPV
LABELV $627
line 1799
;1798:	case WP_GRENADE_LAUNCHER: 
;1799:		addTime = 800; 
ADDRLP4 0
CNSTI4 800
ASGNI4
line 1800
;1800:		break; 
ADDRGP4 $619
JUMPV
LABELV $628
line 1802
;1801:	case WP_ROCKET_LAUNCHER: 
;1802:		addTime = 800; 
ADDRLP4 0
CNSTI4 800
ASGNI4
line 1803
;1803:		break; 
ADDRGP4 $619
JUMPV
LABELV $629
line 1805
;1804:	case WP_PLASMAGUN: 
;1805:		addTime = 100; 
ADDRLP4 0
CNSTI4 100
ASGNI4
line 1806
;1806:		break; 
ADDRGP4 $619
JUMPV
LABELV $630
line 1808
;1807:	case WP_RAILGUN: 
;1808:		addTime = 1200; 
ADDRLP4 0
CNSTI4 1200
ASGNI4
line 1809
;1809:		break; 
ADDRGP4 $619
JUMPV
LABELV $631
line 1812
;1810:	case WP_BFG: 
;1811:		//  addTime = 1000; 
;1812:		addTime = 500; 
ADDRLP4 0
CNSTI4 500
ASGNI4
line 1813
;1813:		break; 
ADDRGP4 $619
JUMPV
LABELV $632
line 1815
;1814:	case WP_GRAPPLING_HOOK: 
;1815:		addTime = 400; 
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1816
;1816:		break; 
ADDRGP4 $619
JUMPV
LABELV $633
line 1818
;1817:	case WP_TURRET:
;1818:		addTime = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 1819
;1819:		break;
line 1823
;1820:	} 
;1821:
;1822: // New Alt Fire Button 
;1823: } else if (pm->cmd.buttons & 32) { 
ADDRGP4 $619
JUMPV
LABELV $618
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $636
line 1826
;1824:
;1825:  // New Event 
;1826:  PM_AddEvent( EV_FIRE_WEAPON2 ); 
CNSTI4 24
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1827
;1827:  altfired = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1829
;1828:
;1829:  switch( pm->ps->weapon ) { 
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 1
LTI4 $638
ADDRLP4 24
INDIRI4
CNSTI4 11
GTI4 $638
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $652-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $652
address $641
address $644
address $643
address $645
address $646
address $642
address $648
address $647
address $649
address $650
address $651
code
LABELV $638
LABELV $641
line 1832
;1830:  default: 
;1831:  	case WP_GAUNTLET: 
;1832:		addTime = 400; 
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1833
;1833:		break; 
ADDRGP4 $639
JUMPV
LABELV $642
line 1835
;1834:	case WP_LIGHTNING: 
;1835:		addTime = 60;  // Shafe - Trep - Flame Thrower was 50  // Streaming Flames
ADDRLP4 0
CNSTI4 60
ASGNI4
line 1836
;1836:		break; 
ADDRGP4 $639
JUMPV
LABELV $643
line 1838
;1837:	case WP_SHOTGUN: 
;1838:		addTime = 1500; 
ADDRLP4 0
CNSTI4 1500
ASGNI4
line 1839
;1839:		break; 
ADDRGP4 $639
JUMPV
LABELV $644
line 1841
;1840:	case WP_MACHINEGUN: 
;1841:		addTime = 100; 
ADDRLP4 0
CNSTI4 100
ASGNI4
line 1842
;1842:		break; 
ADDRGP4 $639
JUMPV
LABELV $645
line 1844
;1843:	case WP_GRENADE_LAUNCHER: 
;1844:		addTime = 800; 
ADDRLP4 0
CNSTI4 800
ASGNI4
line 1845
;1845:		break; 
ADDRGP4 $639
JUMPV
LABELV $646
line 1847
;1846:	case WP_ROCKET_LAUNCHER: 
;1847:		addTime = 800; 
ADDRLP4 0
CNSTI4 800
ASGNI4
line 1848
;1848:		break; 
ADDRGP4 $639
JUMPV
LABELV $647
line 1850
;1849:	case WP_PLASMAGUN: 
;1850:		addTime = 90; 
ADDRLP4 0
CNSTI4 90
ASGNI4
line 1851
;1851:		break; 
ADDRGP4 $639
JUMPV
LABELV $648
line 1853
;1852:	case WP_RAILGUN: 
;1853:		addTime = 1200; 
ADDRLP4 0
CNSTI4 1200
ASGNI4
line 1854
;1854:		break; 
ADDRGP4 $639
JUMPV
LABELV $649
line 1857
;1855:	case WP_BFG: 
;1856:		//  addTime = 100; 
;1857:		addTime = 2000; 
ADDRLP4 0
CNSTI4 2000
ASGNI4
line 1858
;1858:		break; 
ADDRGP4 $639
JUMPV
LABELV $650
line 1860
;1859:	case WP_GRAPPLING_HOOK: 
;1860:		addTime = 400; 
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1861
;1861:		break; 
ADDRGP4 $639
JUMPV
LABELV $651
line 1863
;1862:	case WP_TURRET:
;1863:		addTime = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 1864
;1864:		break;
LABELV $639
line 1866
;1865:	}
;1866: }
LABELV $636
LABELV $619
line 1873
;1867:
;1868:	
;1869: 	// take an ammo away if not infinite
;1870:	// Shafe - Trep - Alt Fire Ammo Mgt
;1871:	// I moved this from above... hmmmm..
;1872:	
;1873:	if (altfired == qtrue) 
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $654
line 1874
;1874:	{
line 1875
;1875:			if ( pm->ps->ammo[ pm->ps->weapon ] != -1 ) 
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $655
line 1876
;1876:			{
line 1878
;1877:				
;1878:				pm->ps->ammo[pm->ps->weapon] -= altAmmoUsage[pm->ps->weapon];
ADDRLP4 28
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 36
ADDRLP4 32
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
ADDRLP4 32
INDIRI4
ADDRGP4 altAmmoUsage
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1883
;1879:				// Let's not let them go -1 (infinite).. That is bad.. Just set the ammo to 0
;1880:				// 
;1881:				// This is gonna screw up mod makers who are used to using -1 for infinite ammo... 
;1882:				// Infinite ammo should now be 9999  - Shafe
;1883:				if (pm->ps->ammo[pm->ps->weapon] < 0) { pm->ps->ammo[pm->ps->weapon] = 0; }
ADDRLP4 40
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
GEI4 $655
ADDRLP4 44
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 44
INDIRP4
CNSTI4 376
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 1884
;1884:			}
line 1885
;1885:	} 
ADDRGP4 $655
JUMPV
LABELV $654
line 1887
;1886:	else 
;1887:	{
line 1888
;1888:		if ( pm->ps->ammo[ pm->ps->weapon ] != -1 ) {
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $660
line 1889
;1889:			pm->ps->ammo[ pm->ps->weapon ]--;
ADDRLP4 28
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1890
;1890:		}
LABELV $660
line 1891
;1891:	}
LABELV $655
line 1894
;1892: 
;1893:
;1894:	if ( pm->ps->powerups[PW_HASTE] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $662
line 1895
;1895:		addTime /= 1.3;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1067869798
DIVF4
CVFI4 4
ASGNI4
line 1896
;1896:	}
LABELV $662
line 1898
;1897:
;1898:	pm->ps->weaponTime += addTime;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 1899
;1899:}
LABELV $578
endproc PM_Weapon 48 4
proc PM_Animate 0 4
line 1907
;1900:
;1901:/*
;1902:================
;1903:PM_Animate
;1904:================
;1905:*/
;1906:
;1907:static void PM_Animate( void ) {
line 1908
;1908:	if ( pm->cmd.buttons & BUTTON_GESTURE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $665
line 1909
;1909:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $667
line 1910
;1910:			PM_StartTorsoAnim( TORSO_GESTURE );
CNSTI4 6
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1911
;1911:			pm->ps->torsoTimer = TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 2294
ASGNI4
line 1912
;1912:			PM_AddEvent( EV_TAUNT );
CNSTI4 77
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1913
;1913:		}
LABELV $667
line 1946
;1914:#ifdef MISSIONPACK
;1915:	} else if ( pm->cmd.buttons & BUTTON_GETFLAG ) {
;1916:		if ( pm->ps->torsoTimer == 0 ) {
;1917:			PM_StartTorsoAnim( TORSO_GETFLAG );
;1918:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1919:		}
;1920:	} else if ( pm->cmd.buttons & BUTTON_GUARDBASE ) {
;1921:		if ( pm->ps->torsoTimer == 0 ) {
;1922:			PM_StartTorsoAnim( TORSO_GUARDBASE );
;1923:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1924:		}
;1925:	} else if ( pm->cmd.buttons & BUTTON_PATROL ) {
;1926:		if ( pm->ps->torsoTimer == 0 ) {
;1927:			PM_StartTorsoAnim( TORSO_PATROL );
;1928:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1929:		}
;1930:	} else if ( pm->cmd.buttons & BUTTON_FOLLOWME ) {
;1931:		if ( pm->ps->torsoTimer == 0 ) {
;1932:			PM_StartTorsoAnim( TORSO_FOLLOWME );
;1933:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1934:		}
;1935:	} else if ( pm->cmd.buttons & BUTTON_AFFIRMATIVE ) {
;1936:		if ( pm->ps->torsoTimer == 0 ) {
;1937:			PM_StartTorsoAnim( TORSO_AFFIRMATIVE);
;1938:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1939:		}
;1940:	} else if ( pm->cmd.buttons & BUTTON_NEGATIVE ) {
;1941:		if ( pm->ps->torsoTimer == 0 ) {
;1942:			PM_StartTorsoAnim( TORSO_NEGATIVE );
;1943:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1944:		}
;1945:#endif
;1946:	}
LABELV $665
line 1947
;1947:}
LABELV $664
endproc PM_Animate 0 4
proc PM_DropTimers 4 0
line 1955
;1948:
;1949:
;1950:/*
;1951:================
;1952:PM_DropTimers
;1953:================
;1954:*/
;1955:static void PM_DropTimers( void ) {
line 1957
;1956:	// drop misc timing counter
;1957:	if ( pm->ps->pm_time ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $670
line 1958
;1958:		if ( pml.msec >= pm->ps->pm_time ) {
ADDRGP4 pml+40
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LTI4 $672
line 1959
;1959:			pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 1960
;1960:			pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1961
;1961:		} else {
ADDRGP4 $673
JUMPV
LABELV $672
line 1962
;1962:			pm->ps->pm_time -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1963
;1963:		}
LABELV $673
line 1964
;1964:	}
LABELV $670
line 1967
;1965:
;1966:	// drop animation counter
;1967:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $676
line 1968
;1968:		pm->ps->legsTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1969
;1969:		if ( pm->ps->legsTimer < 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
GEI4 $679
line 1970
;1970:			pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 1971
;1971:		}
LABELV $679
line 1972
;1972:	}
LABELV $676
line 1974
;1973:
;1974:	if ( pm->ps->torsoTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $681
line 1975
;1975:		pm->ps->torsoTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1976
;1976:		if ( pm->ps->torsoTimer < 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
GEI4 $684
line 1977
;1977:			pm->ps->torsoTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 0
ASGNI4
line 1978
;1978:		}
LABELV $684
line 1979
;1979:	}
LABELV $681
line 1980
;1980:}
LABELV $669
endproc PM_DropTimers 4 0
export PM_UpdateViewAngles
proc PM_UpdateViewAngles 24 0
line 1990
;1981:
;1982:/*
;1983:================
;1984:PM_UpdateViewAngles
;1985:
;1986:This can be used as another entry point when only the viewangles
;1987:are being updated isntead of a full move
;1988:================
;1989:*/
;1990:void PM_UpdateViewAngles( playerState_t *ps, const usercmd_t *cmd ) {
line 1994
;1991:	short		temp;
;1992:	int		i;
;1993:
;1994:	if ( ps->pm_type == PM_INTERMISSION || ps->pm_type == PM_SPINTERMISSION) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 5
EQI4 $689
ADDRLP4 8
INDIRI4
CNSTI4 6
NEI4 $687
LABELV $689
line 1995
;1995:		return;		// no view changes at all
ADDRGP4 $686
JUMPV
LABELV $687
line 1998
;1996:	}
;1997:
;1998:	if ( ps->pm_type != PM_SPECTATOR && ps->stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $690
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $690
line 1999
;1999:		return;		// no view changes at all
ADDRGP4 $686
JUMPV
LABELV $690
line 2003
;2000:	}
;2001:
;2002:	// circularly clamp the angles with deltas
;2003:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $692
line 2004
;2004:		temp = cmd->angles[i] + ps->delta_angles[i];
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
INDIRI4
ADDI4
CVII2 4
ASGNI2
line 2005
;2005:		if ( i == PITCH ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $696
line 2007
;2006:			// don't let the player look up or down more than 90 degrees
;2007:			if ( temp > 16000 ) {
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 16000
LEI4 $698
line 2008
;2008:				ps->delta_angles[i] = 16000 - cmd->angles[i];
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 16000
ADDRLP4 20
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2009
;2009:				temp = 16000;
ADDRLP4 4
CNSTI2 16000
ASGNI2
line 2010
;2010:			} else if ( temp < -16000 ) {
ADDRGP4 $699
JUMPV
LABELV $698
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 -16000
GEI4 $700
line 2011
;2011:				ps->delta_angles[i] = -16000 - cmd->angles[i];
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 -16000
ADDRLP4 20
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2012
;2012:				temp = -16000;
ADDRLP4 4
CNSTI2 -16000
ASGNI2
line 2013
;2013:			}
LABELV $700
LABELV $699
line 2014
;2014:		}
LABELV $696
line 2015
;2015:		ps->viewangles[i] = SHORT2ANGLE(temp);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ADDP4
CNSTF4 1001652224
ADDRLP4 4
INDIRI2
CVII4 2
CVIF4 4
MULF4
ASGNF4
line 2016
;2016:	}
LABELV $693
line 2003
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $692
line 2018
;2017:
;2018:}
LABELV $686
endproc PM_UpdateViewAngles 24 0
proc PM_LadderMove 72 16
line 2031
;2019:
;2020:
;2021:// Shafe - Trep - Ladder Functions - Stolen But Credited ;)
;2022:/*
;2023:===================
;2024:PM_LadderMove()
;2025:by: Calrathan [Arthur Tomlin]
;2026:
;2027:Right now all I know is that this works for VERTICAL ladders. 
;2028:Ladders with angles on them (urban2 for AQ2) Haven't been tested
;2029:===================
;2030:*/
;2031:static void PM_LadderMove( void ) {
line 2039
;2032:        int i;
;2033:        vec3_t wishvel;
;2034:        float wishspeed;
;2035:        vec3_t wishdir;
;2036:        float scale;
;2037:        float vel;
;2038:
;2039:        PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 2041
;2040:
;2041:        scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 40
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 40
INDIRF4
ASGNF4
line 2044
;2042:
;2043:        // user intentions [what the user is attempting to do]
;2044:        if ( !scale ) { 
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $703
line 2045
;2045:                wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 2046
;2046:                wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 2047
;2047:                wishvel[2] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 2048
;2048:        }
ADDRGP4 $704
JUMPV
LABELV $703
line 2049
;2049:        else {   // if they're trying to move... lets calculate it
line 2050
;2050:                for (i=0 ; i<3 ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $707
line 2051
;2051:                        wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove +
ADDRLP4 44
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 52
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 44
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 44
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 52
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 44
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 52
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
LABELV $708
line 2050
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $707
line 2053
;2052:                                     scale * pml.right[i]*pm->cmd.rightmove; 
;2053:                wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 2054
;2054:        }
LABELV $704
line 2056
;2055:
;2056:        VectorCopy (wishvel, wishdir);
ADDRLP4 24
ADDRLP4 8
INDIRB
ASGNB 12
line 2057
;2057:        wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 44
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 44
INDIRF4
ASGNF4
line 2059
;2058:
;2059:        if ( wishspeed > pm->ps->speed * pm_ladderScale ) {
ADDRLP4 20
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_ladderScale
INDIRF4
MULF4
LEF4 $713
line 2060
;2060:                wishspeed = pm->ps->speed * pm_ladderScale;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_ladderScale
INDIRF4
MULF4
ASGNF4
line 2061
;2061:        }
LABELV $713
line 2063
;2062:		
;2063:		PM_CheckJump(); // Shafe - Jump from a ladder?
ADDRGP4 PM_CheckJump
CALLI4
pop
line 2065
;2064:
;2065:        PM_Accelerate (wishdir, wishspeed, pm_ladderAccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 pm_ladderAccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 2068
;2066:
;2067:        // This SHOULD help us with sloped ladders, but it remains untested.
;2068:        if ( pml.groundPlane && DotProduct( pm->ps->velocity, pml.groundTrace.plane.normal ) < 0 ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $715
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 48
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $715
line 2069
;2069:                vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 52
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 52
INDIRF4
ASGNF4
line 2071
;2070:                // slide along the ground plane [the ladder section under our feet] 
;2071:                PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 2074
;2072:                        pm->ps->velocity, OVERCLIP );
;2073:
;2074:                VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2075
;2075:                VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
line 2076
;2076:        }
LABELV $715
line 2078
;2077:
;2078:        PM_SlideMove( qfalse ); // move without gravity
CNSTI4 0
ARGI4
ADDRGP4 PM_SlideMove
CALLI4
pop
line 2079
;2079:}
LABELV $702
endproc PM_LadderMove 72 16
export CheckLadder
proc CheckLadder 96 28
line 2088
;2080:
;2081:
;2082:/*
;2083:=============
;2084:CheckLadder [ ARTHUR TOMLIN ]
;2085:=============
;2086:*/
;2087:void CheckLadder( void )
;2088:{
line 2091
;2089:        vec3_t flatforward,spot;
;2090:        trace_t trace;
;2091:        pml.ladder = qfalse;
ADDRGP4 pml+108
CNSTI4 0
ASGNI4
line 2093
;2092:        // check for ladder
;2093:        flatforward[0] = pml.forward[0];
ADDRLP4 0
ADDRGP4 pml
INDIRF4
ASGNF4
line 2094
;2094:        flatforward[1] = pml.forward[1];
ADDRLP4 0+4
ADDRGP4 pml+4
INDIRF4
ASGNF4
line 2095
;2095:        flatforward[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 2096
;2096:        VectorNormalize (flatforward);
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2097
;2097:        VectorMA (pm->ps->origin, 1, flatforward, spot);
ADDRLP4 80
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 84
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
ADDRLP4 80
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 80
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2098
;2098:        pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, spot, pm->ps->clientNum, MASK_PLAYERSOLID);
ADDRLP4 24
ARGP4
ADDRLP4 88
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 92
ADDRLP4 88
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 33619969
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CALLV
pop
line 2100
;2099:
;2100:        if ((trace.fraction < 1) && (trace.surfaceFlags & SURF_LADDER))
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
GEF4 $737
ADDRLP4 24+44
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $737
line 2101
;2101:                pml.ladder = qtrue;
ADDRGP4 pml+108
CNSTI4 1
ASGNI4
LABELV $737
line 2103
;2102:
;2103:}
LABELV $728
endproc CheckLadder 96 28
export PmoveSingle
proc PmoveSingle 64 16
line 2116
;2104:
;2105:/// End Shafe - Ladder Functions
;2106:
;2107:
;2108:/*
;2109:================
;2110:PmoveSingle
;2111:
;2112:================
;2113:*/
;2114:void trap_SnapVector( float *v );
;2115:
;2116:void PmoveSingle (pmove_t *pmove) {
line 2117
;2117:	pm = pmove;
ADDRGP4 pm
ADDRFP4 0
INDIRP4
ASGNP4
line 2121
;2118:
;2119:	// this counter lets us debug movement problems with a journal
;2120:	// by setting a conditional breakpoint fot the previous frame
;2121:	c_pmove++;
ADDRLP4 0
ADDRGP4 c_pmove
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2124
;2122:
;2123:	// clear results
;2124:	pm->numtouch = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 2125
;2125:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 2126
;2126:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 0
ASGNI4
line 2128
;2127:
;2128:	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $743
line 2129
;2129:		pm->tracemask &= ~CONTENTS_BODY;	// corpses can fly through bodies
ADDRLP4 4
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -33554433
BANDI4
ASGNI4
line 2130
;2130:	}
LABELV $743
line 2134
;2131:
;2132:	// make sure walking button is clear if they are running, to avoid
;2133:	// proxy no-footsteps cheats
;2134:	if ( abs( pm->cmd.forwardmove ) > 64 || abs( pm->cmd.rightmove ) > 64 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 64
GTI4 $747
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LEI4 $745
LABELV $747
line 2135
;2135:		pm->cmd.buttons &= ~BUTTON_WALKING;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2136
;2136:	}
LABELV $745
line 2139
;2137:
;2138:	// set the talk balloon flag
;2139:	if ( pm->cmd.buttons & BUTTON_TALK ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $748
line 2140
;2140:		pm->ps->eFlags |= EF_TALK;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 2141
;2141:	} else {
ADDRGP4 $749
JUMPV
LABELV $748
line 2142
;2142:		pm->ps->eFlags &= ~EF_TALK;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 2143
;2143:	}
LABELV $749
line 2148
;2144:
;2145:	// set the firing flag for continuous beam weapons
;2146:	
;2147:	// Shafe - Trep - Alt Fire Code
;2148:	if ( !(pm->ps->pm_flags & PMF_RESPAWNED) && pm->ps->pm_type != PM_INTERMISSION && ( (pm->cmd.buttons & BUTTON_ATTACK) || (pm->cmd.buttons & 32) ) && pm->ps->ammo[ pm->ps->weapon ] ) { 
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
ADDRLP4 20
INDIRI4
NEI4 $750
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
EQI4 $750
ADDRLP4 24
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 20
INDIRI4
NEI4 $752
ADDRLP4 24
INDIRI4
CNSTI4 32
BANDI4
ADDRLP4 20
INDIRI4
EQI4 $750
LABELV $752
ADDRLP4 28
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $750
line 2149
;2149:		pm->ps->eFlags |= EF_FIRING; 
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2150
;2150:	} else { 
ADDRGP4 $751
JUMPV
LABELV $750
line 2151
;2151:		pm->ps->eFlags &= ~EF_FIRING; 
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 2152
;2152:	}
LABELV $751
line 2161
;2153:	/*if ( !(pm->ps->pm_flags & PMF_RESPAWNED) && pm->ps->pm_type != PM_INTERMISSION
;2154:		&& ( pm->cmd.buttons & BUTTON_ATTACK ) && pm->ps->ammo[ pm->ps->weapon ] ) {
;2155:		pm->ps->eFlags |= EF_FIRING;
;2156:	} else {
;2157:		pm->ps->eFlags &= ~EF_FIRING;
;2158:	}*/
;2159:
;2160:	// clear the respawned flag if attack and use are cleared
;2161:	if ( pm->ps->stats[STAT_HEALTH] > 0 && 
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
LEI4 $753
ADDRLP4 32
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 5
BANDI4
ADDRLP4 36
INDIRI4
NEI4 $753
line 2162
;2162:		!( pm->cmd.buttons & (BUTTON_ATTACK | BUTTON_USE_HOLDABLE) ) ) {
line 2163
;2163:		pm->ps->pm_flags &= ~PMF_RESPAWNED;
ADDRLP4 40
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 2164
;2164:	}
LABELV $753
line 2169
;2165:
;2166:	// if talk button is down, dissallow all other input
;2167:	// this is to prevent any possible intercept proxy from
;2168:	// adding fake talk balloons
;2169:	if ( pmove->cmd.buttons & BUTTON_TALK ) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $755
line 2172
;2170:		// keep the talk button set tho for when the cmd.serverTime > 66 msec
;2171:		// and the same cmd is used multiple times in Pmove
;2172:		pmove->cmd.buttons = BUTTON_TALK;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 2
ASGNI4
line 2173
;2173:		pmove->cmd.forwardmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 2174
;2174:		pmove->cmd.rightmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 2175
;2175:		pmove->cmd.upmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 2176
;2176:	}
LABELV $755
line 2179
;2177:
;2178:	// clear all pmove local vars
;2179:	memset (&pml, 0, sizeof(pml));
ADDRGP4 pml
ARGP4
CNSTI4 0
ARGI4
CNSTI4 144
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2182
;2180:
;2181:	// determine the time
;2182:	pml.msec = pmove->cmd.serverTime - pm->ps->commandTime;
ADDRGP4 pml+40
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 2183
;2183:	if ( pml.msec < 1 ) {
ADDRGP4 pml+40
INDIRI4
CNSTI4 1
GEI4 $758
line 2184
;2184:		pml.msec = 1;
ADDRGP4 pml+40
CNSTI4 1
ASGNI4
line 2185
;2185:	} else if ( pml.msec > 200 ) {
ADDRGP4 $759
JUMPV
LABELV $758
ADDRGP4 pml+40
INDIRI4
CNSTI4 200
LEI4 $762
line 2186
;2186:		pml.msec = 200;
ADDRGP4 pml+40
CNSTI4 200
ASGNI4
line 2187
;2187:	}
LABELV $762
LABELV $759
line 2188
;2188:	pm->ps->commandTime = pmove->cmd.serverTime;
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2191
;2189:
;2190:	// save old org in case we get stuck
;2191:	VectorCopy (pm->ps->origin, pml.previous_origin);
ADDRGP4 pml+116
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2194
;2192:
;2193:	// save old velocity for crashlanding
;2194:	VectorCopy (pm->ps->velocity, pml.previous_velocity);
ADDRGP4 pml+128
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 2196
;2195:
;2196:	pml.frametime = pml.msec * 0.001;
ADDRGP4 pml+36
CNSTF4 981668463
ADDRGP4 pml+40
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 2199
;2197:
;2198:	// update the viewangles
;2199:	PM_UpdateViewAngles( pm->ps, &pm->cmd );
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 2201
;2200:
;2201:	AngleVectors (pm->ps->viewangles, pml.forward, pml.right, pml.up);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 pml
ARGP4
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+24
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2203
;2202:
;2203:	if ( pm->cmd.upmove < 10 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $772
line 2205
;2204:		// not holding jump
;2205:		pm->ps->pm_flags &= ~PMF_JUMP_HELD;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 2206
;2206:	}
LABELV $772
line 2209
;2207:
;2208:	// decide if backpedaling animations should be used
;2209:	if ( pm->cmd.forwardmove < 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $774
line 2210
;2210:		pm->ps->pm_flags |= PMF_BACKWARDS_RUN;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 2211
;2211:	} else if ( pm->cmd.forwardmove > 0 || ( pm->cmd.forwardmove == 0 && pm->cmd.rightmove ) ) {
ADDRGP4 $775
JUMPV
LABELV $774
ADDRLP4 44
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRI4
GTI4 $778
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRI4
NEI4 $776
ADDRLP4 44
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 52
INDIRI4
EQI4 $776
LABELV $778
line 2212
;2212:		pm->ps->pm_flags &= ~PMF_BACKWARDS_RUN;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2213
;2213:	}
LABELV $776
LABELV $775
line 2215
;2214:
;2215:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $779
line 2216
;2216:		pm->cmd.forwardmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 2217
;2217:		pm->cmd.rightmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 2218
;2218:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 2219
;2219:	}
LABELV $779
line 2221
;2220:
;2221:	if ( pm->ps->pm_type == PM_SPECTATOR ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $781
line 2222
;2222:		PM_CheckDuck ();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 2223
;2223:		PM_FlyMove ();
ADDRGP4 PM_FlyMove
CALLV
pop
line 2224
;2224:		PM_DropTimers ();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2225
;2225:		return;
ADDRGP4 $742
JUMPV
LABELV $781
line 2228
;2226:	}
;2227:
;2228:	if ( pm->ps->pm_type == PM_NOCLIP ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $783
line 2229
;2229:		PM_NoclipMove ();
ADDRGP4 PM_NoclipMove
CALLV
pop
line 2230
;2230:		PM_DropTimers ();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2231
;2231:		return;
ADDRGP4 $742
JUMPV
LABELV $783
line 2234
;2232:	}
;2233:
;2234:	if (pm->ps->pm_type == PM_FREEZE) {
ADDRLP4 56
CNSTI4 4
ASGNI4
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $785
line 2235
;2235:		return;		// no movement at all
ADDRGP4 $742
JUMPV
LABELV $785
line 2238
;2236:	}
;2237:
;2238:	if ( pm->ps->pm_type == PM_INTERMISSION || pm->ps->pm_type == PM_SPINTERMISSION) {
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 5
EQI4 $789
ADDRLP4 60
INDIRI4
CNSTI4 6
NEI4 $787
LABELV $789
line 2239
;2239:		return;		// no movement at all
ADDRGP4 $742
JUMPV
LABELV $787
line 2243
;2240:	}
;2241:
;2242:	// set watertype, and waterlevel
;2243:	PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 2244
;2244:	pml.previous_waterlevel = pmove->waterlevel;
ADDRGP4 pml+140
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 2247
;2245:
;2246:	// set mins, maxs, and viewheight
;2247:	PM_CheckDuck ();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 2250
;2248:
;2249:	// set groundentity
;2250:	PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 2252
;2251:
;2252:	if ( pm->ps->pm_type == PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $791
line 2253
;2253:		PM_DeadMove ();
ADDRGP4 PM_DeadMove
CALLV
pop
line 2254
;2254:	}
LABELV $791
line 2256
;2255:
;2256:	PM_DropTimers();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2258
;2257:
;2258:	CheckLadder();	// Shafe - Trep - Ladder Support
ADDRGP4 CheckLadder
CALLV
pop
line 2268
;2259:
;2260:#ifdef MISSIONPACK
;2261:	if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
;2262:		PM_InvulnerabilityMove();
;2263:	} else
;2264:#endif
;2265:
;2266:		
;2267:	
;2268:	if ( pm->ps->powerups[PW_FLIGHT] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $793
line 2270
;2269:		// flight powerup doesn't allow jump and has different friction
;2270:		PM_FlyMove();
ADDRGP4 PM_FlyMove
CALLV
pop
line 2271
;2271:	} else if (pm->ps->pm_flags & PMF_GRAPPLE_PULL) {
ADDRGP4 $794
JUMPV
LABELV $793
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $795
line 2272
;2272:		PM_GrappleMove();
ADDRGP4 PM_GrappleMove
CALLV
pop
line 2274
;2273:		// We can wiggle a bit
;2274:		PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 2275
;2275:	} else if (pm->ps->pm_flags & PMF_TIME_WATERJUMP) {
ADDRGP4 $796
JUMPV
LABELV $795
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $797
line 2276
;2276:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 2277
;2277:	} else if ( pm->waterlevel > 1 ) {
ADDRGP4 $798
JUMPV
LABELV $797
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LEI4 $799
line 2279
;2278:		// swimming
;2279:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 2280
;2280:	} else if (pml.ladder) {        
ADDRGP4 $800
JUMPV
LABELV $799
ADDRGP4 pml+108
INDIRI4
CNSTI4 0
EQI4 $801
line 2281
;2281:        PM_LadderMove();
ADDRGP4 PM_LadderMove
CALLV
pop
line 2282
;2282:	} else if ( pml.walking ) {
ADDRGP4 $802
JUMPV
LABELV $801
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $804
line 2284
;2283:		// walking on ground
;2284:		PM_WalkMove();
ADDRGP4 PM_WalkMove
CALLV
pop
line 2285
;2285:	} else {
ADDRGP4 $805
JUMPV
LABELV $804
line 2287
;2286:		// airborne
;2287:		PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 2288
;2288:	}
LABELV $805
LABELV $802
LABELV $800
LABELV $798
LABELV $796
LABELV $794
line 2290
;2289:
;2290:	PM_Animate();
ADDRGP4 PM_Animate
CALLV
pop
line 2293
;2291:
;2292:	// set groundentity, watertype, and waterlevel
;2293:	PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 2294
;2294:	PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 2297
;2295:
;2296:	// weapons
;2297:	PM_Weapon();
ADDRGP4 PM_Weapon
CALLV
pop
line 2300
;2298:
;2299:	// torso animation
;2300:	PM_TorsoAnimation();
ADDRGP4 PM_TorsoAnimation
CALLV
pop
line 2303
;2301:
;2302:	// footstep events / legs animations
;2303:	PM_Footsteps();
ADDRGP4 PM_Footsteps
CALLV
pop
line 2306
;2304:
;2305:	// entering / leaving water splashes
;2306:	PM_WaterEvents();
ADDRGP4 PM_WaterEvents
CALLV
pop
line 2309
;2307:
;2308:	// snap some parts of playerstate to save network bandwidth
;2309:	trap_SnapVector( pm->ps->velocity );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 trap_SnapVector
CALLV
pop
line 2310
;2310:}
LABELV $742
endproc PmoveSingle 64 16
export Pmove
proc Pmove 16 4
line 2320
;2311:
;2312:
;2313:/*
;2314:================
;2315:Pmove
;2316:
;2317:Can be called by either the server or the client
;2318:================
;2319:*/
;2320:void Pmove (pmove_t *pmove) {
line 2323
;2321:	int			finalTime;
;2322:
;2323:	finalTime = pmove->cmd.serverTime;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2325
;2324:
;2325:	if ( finalTime < pmove->ps->commandTime ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
GEI4 $808
line 2326
;2326:		return;	// should not happen
ADDRGP4 $807
JUMPV
LABELV $808
line 2329
;2327:	}
;2328:
;2329:	if ( finalTime > pmove->ps->commandTime + 1000 ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $810
line 2330
;2330:		pmove->ps->commandTime = finalTime - 1000;
ADDRFP4 0
INDIRP4
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 2331
;2331:	}
LABELV $810
line 2333
;2332:
;2333:	pmove->ps->pmove_framecount = (pmove->ps->pmove_framecount+1) & ((1<<PS_PMOVEFRAMECOUNTBITS)-1);
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 456
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 63
BANDI4
ASGNI4
ADDRGP4 $813
JUMPV
LABELV $812
line 2337
;2334:
;2335:	// chop the move up if it is too long, to prevent framerate
;2336:	// dependent behavior
;2337:	while ( pmove->ps->commandTime != finalTime ) {
line 2340
;2338:		int		msec;
;2339:
;2340:		msec = finalTime - pmove->ps->commandTime;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 2342
;2341:
;2342:		if ( pmove->pmove_fixed ) {
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 0
EQI4 $815
line 2343
;2343:			if ( msec > pmove->pmove_msec ) {
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
LEI4 $816
line 2344
;2344:				msec = pmove->pmove_msec;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ASGNI4
line 2345
;2345:			}
line 2346
;2346:		}
ADDRGP4 $816
JUMPV
LABELV $815
line 2347
;2347:		else {
line 2348
;2348:			if ( msec > 66 ) {
ADDRLP4 8
INDIRI4
CNSTI4 66
LEI4 $819
line 2349
;2349:				msec = 66;
ADDRLP4 8
CNSTI4 66
ASGNI4
line 2350
;2350:			}
LABELV $819
line 2351
;2351:		}
LABELV $816
line 2352
;2352:		pmove->cmd.serverTime = pmove->ps->commandTime + msec;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 2353
;2353:		PmoveSingle( pmove );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 PmoveSingle
CALLV
pop
line 2355
;2354:
;2355:		if ( pmove->ps->pm_flags & PMF_JUMP_HELD ) {
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $821
line 2356
;2356:			pmove->cmd.upmove = 20;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 20
ASGNI1
line 2357
;2357:		}
LABELV $821
line 2358
;2358:	}
LABELV $813
line 2337
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $812
line 2362
;2359:
;2360:	//PM_CheckStuck();
;2361:
;2362:}
LABELV $807
endproc Pmove 16 4
import trap_SnapVector
import PM_StepSlideMove
import PM_SlideMove
bss
export pml
align 4
LABELV pml
skip 144
export pm
align 4
LABELV pm
skip 4
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
LABELV $477
byte 1 37
byte 1 105
byte 1 58
byte 1 76
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $466
byte 1 37
byte 1 105
byte 1 58
byte 1 115
byte 1 116
byte 1 101
byte 1 101
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $455
byte 1 37
byte 1 105
byte 1 58
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 111
byte 1 102
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $420
byte 1 37
byte 1 105
byte 1 58
byte 1 108
byte 1 105
byte 1 102
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $393
byte 1 37
byte 1 105
byte 1 58
byte 1 97
byte 1 108
byte 1 108
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 10
byte 1 0
