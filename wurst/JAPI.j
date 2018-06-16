//设置单位面向（立即）
native EXSetUnitFacing takes unit u, real angle returns nothing
//眩晕
native EXPauseUnit takes unit u, boolean flag returns nothing
//设置碰撞 1单位 3建筑
native EXSetUnitCollisionType takes boolean enable, unit u, integer t returns nothing
//设置移动类型 0没有 1无法移动 2步行 4飞行 8地雷 10疾风步 20未知 40 漂浮 80两栖
native EXSetUnitMoveType takes unit u, integer t returns nothing
//模拟聊天 0所有人 1盟友 2观看者/裁判 3私人
native EXDisplayChat     takes player p, integer chat_recipient, string message returns nothing

native EXGetEffectX takes effect e returns real
native EXGetEffectY takes effect e returns real
native EXGetEffectZ takes effect e returns real
native EXSetEffectXY takes effect e, real x, real y returns nothing
native EXSetEffectZ takes effect e, real z returns nothing
native EXGetEffectSize takes effect e returns real
native EXSetEffectSize takes effect e, real size returns nothing
native EXEffectMatRotateX takes effect e, real angle returns nothing
native EXEffectMatRotateY takes effect e, real angle returns nothing
native EXEffectMatRotateZ takes effect e, real angle returns nothing
native EXEffectMatScale takes effect e, real x, real y, real z returns nothing
native EXEffectMatReset takes effect e returns nothing
native EXSetEffectSpeed takes effect e, real speed returns nothing

globals
	constant integer EVENT_DAMAGE_DATA_VAILD       = 0
	constant integer EVENT_DAMAGE_DATA_IS_PHYSICAL = 1
	constant integer EVENT_DAMAGE_DATA_IS_ATTACK   = 2
	constant integer EVENT_DAMAGE_DATA_IS_RANGED   = 3
	constant integer EVENT_DAMAGE_DATA_DAMAGE_TYPE = 4
	constant integer EVENT_DAMAGE_DATA_WEAPON_TYPE = 5
	constant integer EVENT_DAMAGE_DATA_ATTACK_TYPE = 6
endglobals

//获取伤害信息
native EXGetEventDamageData takes integer edd_type returns integer
//设置伤害值
native EXSetEventDamage takes real amount returns boolean

globals
	constant integer ABILITY_STATE_COOLDOWN         = 1 //冷却时间
	//int
	constant integer ABILITY_DATA_TARGS             = 100 //目标允许
	constant integer ABILITY_DATA_COST              = 104 //魔法消耗
	constant integer ABILITY_DATA_UNITID            = 117 //单位类型
	constant integer ABILITY_DATA_HOTKET            = 200 //热键
	constant integer ABILITY_DATA_UNHOTKET          = 201 //关闭热键
	constant integer ABILITY_DATA_RESEARCH_HOTKEY   = 202 //学习热键
	//real
	constant integer ABILITY_DATA_CAST              = 101 //施放时间
	constant integer ABILITY_DATA_DUR               = 102 //持续时间(普通)
	constant integer ABILITY_DATA_HERODUR           = 103 //持续时间(英雄)
	constant integer ABILITY_DATA_COOL              = 105 //施放间隔
	constant integer ABILITY_DATA_AREA              = 106 //影响区域
	constant integer ABILITY_DATA_RNG               = 107 //施放距离
	constant integer ABILITY_DATA_DATA_A            = 108
	constant integer ABILITY_DATA_DATA_B            = 109
	constant integer ABILITY_DATA_DATA_C            = 110
	constant integer ABILITY_DATA_DATA_D            = 111
	constant integer ABILITY_DATA_DATA_E            = 112
	constant integer ABILITY_DATA_DATA_F            = 113
	constant integer ABILITY_DATA_DATA_G            = 114
	constant integer ABILITY_DATA_DATA_H            = 115
	constant integer ABILITY_DATA_DATA_I            = 116
	//string
	constant integer ABILITY_DATA_NAME              = 203 //名字
	constant integer ABILITY_DATA_ART               = 204 //图标
	constant integer ABILITY_DATA_TARGET_ART        = 205 //目标效果
	constant integer ABILITY_DATA_CASTER_ART        = 206 //施放者效果
	constant integer ABILITY_DATA_EFFECT_ART        = 207 //目标点效果
	constant integer ABILITY_DATA_AREAEFFECT_ART    = 208 //区域效果
	constant integer ABILITY_DATA_MISSILE_ART       = 209 //投射物
	constant integer ABILITY_DATA_SPECIAL_ART       = 210 //特殊效果
	constant integer ABILITY_DATA_LIGHTNING_EFFECT  = 211 //闪电效果
	constant integer ABILITY_DATA_BUFF_TIP          = 212 //buff提示
	constant integer ABILITY_DATA_BUFF_UBERTIP      = 213 //buff提示(扩展)
	constant integer ABILITY_DATA_RESEARCH_TIP      = 214 //学习提示
	constant integer ABILITY_DATA_TIP               = 215 //提示
	constant integer ABILITY_DATA_UNTIP             = 216 //关闭提示
	constant integer ABILITY_DATA_RESEARCH_UBERTIP  = 217 //学习提示(扩展)
	constant integer ABILITY_DATA_UBERTIP           = 218 //提示(扩展)
	constant integer ABILITY_DATA_UNUBERTIP         = 219 //关闭提示(扩展)
	constant integer ABILITY_DATA_UNART             = 220 //关闭图标
endglobals

native EXGetUnitAbility        takes unit u, integer abilcode returns ability
native EXGetUnitAbilityByIndex takes unit u, integer index returns ability
native EXGetAbilityId          takes ability abil returns integer
native EXGetAbilityState       takes ability abil, integer state_type returns real
native EXSetAbilityState       takes ability abil, integer state_type, real value returns boolean
native EXGetAbilityDataReal    takes ability abil, integer level, integer data_type returns real
native EXSetAbilityDataReal    takes ability abil, integer level, integer data_type, real value returns boolean
native EXGetAbilityDataInteger takes ability abil, integer level, integer data_type returns integer
native EXSetAbilityDataInteger takes ability abil, integer level, integer data_type, integer value returns boolean
native EXGetAbilityDataString  takes ability abil, integer level, integer data_type returns string
native EXSetAbilityDataString  takes ability abil, integer level, integer data_type, string value returns boolean

//变身
native EXSetAbilityAEmeDataA takes ability abil, integer unitid returns boolean
//abilcode: 'AEme'
function YDWEUnitTransform takes unit u, integer abilcode, integer targetid returns nothing
	call UnitAddAbility(u, abilcode)
	call EXSetAbilityDataInteger(EXGetUnitAbility(u, abilcode), 1, 117, GetUnitTypeId(u))
	call EXSetAbilityAEmeDataA(EXGetUnitAbility(u, abilcode), GetUnitTypeId(u))
	call UnitRemoveAbility(u, abilcode)
	call UnitAddAbility(u, abilcode)
	call EXSetAbilityAEmeDataA(EXGetUnitAbility(u, abilcode), targetid)
	call UnitRemoveAbility(u, abilcode)
endfunction

native EXGetItemDataString takes integer itemcode, integer data_type returns string
native EXSetItemDataString takes integer itemcode, integer data_type, string value returns boolean
