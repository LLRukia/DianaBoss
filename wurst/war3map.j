globals
    // User-defined
dialog udg_View= null
button udg_A= null
button udg_C= null
button udg_B= null
button udg_D= null
location array udg_YX_dian
unit array udg_YX_danwei
unit udg_uHuojiForDmg= null
    // Generated
rect gg_rct______________000= null
trigger gg_trg_HeroPick= null
trigger gg_trg_HuojiDmg= null
trigger gg_trg_Main= null
trigger gg_trg_Esc= null
trigger gg_trg_EscC= null


//JASSHelper struct globals:

endglobals


//===========================================================================
// 
// PlaywithFun
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Date: Wed Jun 20 18:14:37 2018
//   Map Author: Rukia, AStout
// 
//===========================================================================
//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************
function InitGlobals takes nothing returns nothing
    local integer i= 0
    set udg_View=DialogCreate()
    set udg_A=bj_lastCreatedButton
    set udg_C=bj_lastCreatedButton
    set udg_B=bj_lastCreatedButton
    set udg_D=bj_lastCreatedButton
endfunction
//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************
//===========================================================================
function CreateUnitsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life
    set u=CreateUnit(p, 'hpea', - 649.4, - 975.6, 206.275)
    set u=CreateUnit(p, 'h004', - 852.9, - 919.4, 295.409)
endfunction
//===========================================================================
function CreateUnitsForPlayer8 takes nothing returns nothing
    local player p= Player(8)
    local unit u
    local integer unitID
    local trigger t
    local real life
    set u=CreateUnit(p, 'h004', - 1193.8, - 706.3, 31.631)
endfunction
//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life
    set u=CreateUnit(p, 'ncop', 0.0, - 448.0, 270.000)
    set u=CreateUnit(p, 'ncop', - 448.0, - 448.0, 270.000)
endfunction
//===========================================================================
function CreateNeutralPassive takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life
    set u=CreateUnit(p, 'H000', - 435.5, - 455.0, 268.350)
    set u=CreateUnit(p, 'H001', 5.1, - 449.9, 268.350)
endfunction
//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
endfunction
//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
    call CreateUnitsForPlayer0()
    call CreateUnitsForPlayer8()
endfunction
//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreateNeutralPassiveBuildings()
    call CreatePlayerBuildings()
    call CreateNeutralPassive()
    call CreatePlayerUnits()
endfunction
//***************************************************************************
//*
//*  Regions
//*
//***************************************************************************
function CreateRegions takes nothing returns nothing
    local weathereffect we
    set gg_rct______________000=Rect(- 704.0, - 1248.0, 288.0, - 768.0)
endfunction
//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************
//===========================================================================
// Trigger: HeroPick
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_HeroPickConditions takes nothing returns boolean
    return ( ( IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == true ) and ( GetOwningPlayer(GetTriggerUnit()) == Player(PLAYER_NEUTRAL_PASSIVE) ) and ( udg_YX_danwei[GetConvertedPlayerId(GetTriggerPlayer())] == null ) )
endfunction
function Trig_HeroPickActions takes nothing returns nothing
    local location lcCenter= GetRectCenter(gg_rct______________000)
    if ( ( GetUnitUserData(GetTriggerUnit()) == ( GetConvertedPlayerId(GetTriggerPlayer()) + 1 ) ) ) then
        set udg_YX_danwei[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
        call SetUnitOwner(GetTriggerUnit(), GetTriggerPlayer(), true)
        call SetUnitPositionLoc(GetTriggerUnit(), lcCenter)
        call PanCameraToTimedLocForPlayer(GetTriggerPlayer(), lcCenter, 1.00)
        call SetUnitInvulnerable(GetTriggerUnit(), false)
        call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_UPDATED, ( GetPlayerName(GetTriggerPlayer()) + ( "选择了" + GetUnitName(GetTriggerUnit()) ) ))
    else
        call SetUnitUserData(GetTriggerUnit(), ( GetConvertedPlayerId(GetTriggerPlayer()) + 1 ))
        call TriggerSleepAction(0.20)
        call SetUnitUserData(GetTriggerUnit(), 99)
    endif
    call RemoveLocation(lcCenter)
endfunction
//===========================================================================
function InitTrig_HeroPick takes nothing returns nothing
    set gg_trg_HeroPick=CreateTrigger()
    call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HeroPick, Player(0), true)
    call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HeroPick, Player(1), true)
    call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HeroPick, Player(2), true)
    call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HeroPick, Player(3), true)
    call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HeroPick, Player(4), true)
    call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HeroPick, Player(5), true)
    call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HeroPick, Player(6), true)
    call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HeroPick, Player(7), true)
    call TriggerAddCondition(gg_trg_HeroPick, Condition(function Trig_HeroPickConditions))
    call TriggerAddAction(gg_trg_HeroPick, function Trig_HeroPickActions)
endfunction
//===========================================================================
// Trigger: HuojiDmg
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_HuojiDmgAct takes nothing returns nothing
    call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "火鸡挨揍了！")
    call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, R2S(GetEventDamage()))
endfunction
//===========================================================================
function InitTrig_HuojiDmg takes nothing returns nothing
    set gg_trg_HuojiDmg=CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_HuojiDmg, udg_uHuojiForDmg, EVENT_UNIT_DAMAGED)
    call TriggerAddAction(gg_trg_HuojiDmg, function Trig_HuojiDmgAct)
endfunction
//===========================================================================
// Trigger: Main
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function HideMagicBook takes nothing returns nothing
    local integer i
    set i=0
    loop
        exitwhen i > 7
        call SetPlayerAbilityAvailable(Player(i), 'A003', false)
        set i=i + 1
    endloop
endfunction
//main
function InitTrig_Main takes nothing returns nothing
    local location lcHeroPickCenter= GetRectCenter(gg_rct______________000)
    call HideMagicBook()
    call FogEnableOff()
    call FogMaskEnableOff()
    set udg_uHuojiForDmg=CreateUnitAtLoc(Player(8), 'n000', lcHeroPickCenter, bj_UNIT_FACING)
    call RemoveLocation(lcHeroPickCenter)
endfunction//===========================================================================
// Trigger: Esc
//===========================================================================
function Trig_EscActions takes nothing returns nothing
    call DialogSetMessage(udg_View, "TRIGSTR_053")
    call DialogAddButtonBJ(udg_View, "TRIGSTR_052")
    set udg_A=bj_lastCreatedButton
    call DialogAddButtonBJ(udg_View, "TRIGSTR_051")
    set udg_B=bj_lastCreatedButton
    call DialogAddButtonBJ(udg_View, "TRIGSTR_050")
    set udg_C=bj_lastCreatedButton
    call DialogAddButtonBJ(udg_View, "TRIGSTR_049")
    set udg_D=bj_lastCreatedButton
    call DialogDisplay(GetTriggerPlayer(), udg_View, true)
    if ( true ) then
    else
    endif
endfunction
//===========================================================================
function InitTrig_Esc takes nothing returns nothing
    set gg_trg_Esc=CreateTrigger()

        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(0))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(1))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(2))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(3))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(4))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(5))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(6))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(7))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(8))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(9))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(10))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(11))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(12))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(13))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(14))
        call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc, Player(15))
    call TriggerAddAction(gg_trg_Esc, function Trig_EscActions)
endfunction
//===========================================================================
// Trigger: EscC
//===========================================================================
function Trig_EscCActions takes nothing returns nothing
    if ( ( GetClickedButtonBJ() == udg_A ) ) then
        call SetCameraFieldForPlayer(GetTriggerPlayer(), CAMERA_FIELD_TARGET_DISTANCE, 1500.00, 0)
    else
    endif
    if ( ( GetClickedButtonBJ() == udg_B ) ) then
        call SetCameraFieldForPlayer(GetTriggerPlayer(), CAMERA_FIELD_TARGET_DISTANCE, 2000.00, 0)
    else
    endif
    if ( ( GetClickedButtonBJ() == udg_C ) ) then
        call SetCameraFieldForPlayer(GetTriggerPlayer(), CAMERA_FIELD_TARGET_DISTANCE, 2500.00, 0)
    else
    endif
    if ( ( GetClickedButtonBJ() == udg_D ) ) then
        call SetCameraFieldForPlayer(GetTriggerPlayer(), CAMERA_FIELD_TARGET_DISTANCE, 3000.00, 0)
    else
    endif
    call DialogClear(udg_View)
endfunction
//===========================================================================
function InitTrig_EscC takes nothing returns nothing
    set gg_trg_EscC=CreateTrigger()
    call TriggerRegisterDialogEvent(gg_trg_EscC, udg_View)
    call TriggerAddAction(gg_trg_EscC, function Trig_EscCActions)
endfunction
//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_HeroPick()
    call InitTrig_HuojiDmg()
    call InitTrig_Main()
    call InitTrig_Esc()
    call InitTrig_EscC()
endfunction
//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Main)
endfunction
//***************************************************************************
//*
//*  Players
//*
//***************************************************************************
function InitCustomPlayerSlots takes nothing returns nothing
    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call ForcePlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(0), false)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)
    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(1), false)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)
    // Player 2
    call SetPlayerStartLocation(Player(2), 2)
    call ForcePlayerStartLocation(Player(2), 2)
    call SetPlayerColor(Player(2), ConvertPlayerColor(2))
    call SetPlayerRacePreference(Player(2), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(2), false)
    call SetPlayerController(Player(2), MAP_CONTROL_USER)
    // Player 3
    call SetPlayerStartLocation(Player(3), 3)
    call ForcePlayerStartLocation(Player(3), 3)
    call SetPlayerColor(Player(3), ConvertPlayerColor(3))
    call SetPlayerRacePreference(Player(3), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(3), false)
    call SetPlayerController(Player(3), MAP_CONTROL_USER)
    // Player 4
    call SetPlayerStartLocation(Player(4), 4)
    call ForcePlayerStartLocation(Player(4), 4)
    call SetPlayerColor(Player(4), ConvertPlayerColor(4))
    call SetPlayerRacePreference(Player(4), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(4), false)
    call SetPlayerController(Player(4), MAP_CONTROL_USER)
    // Player 5
    call SetPlayerStartLocation(Player(5), 5)
    call ForcePlayerStartLocation(Player(5), 5)
    call SetPlayerColor(Player(5), ConvertPlayerColor(5))
    call SetPlayerRacePreference(Player(5), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(5), false)
    call SetPlayerController(Player(5), MAP_CONTROL_USER)
    // Player 6
    call SetPlayerStartLocation(Player(6), 6)
    call ForcePlayerStartLocation(Player(6), 6)
    call SetPlayerColor(Player(6), ConvertPlayerColor(6))
    call SetPlayerRacePreference(Player(6), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(6), false)
    call SetPlayerController(Player(6), MAP_CONTROL_USER)
    // Player 7
    call SetPlayerStartLocation(Player(7), 7)
    call ForcePlayerStartLocation(Player(7), 7)
    call SetPlayerColor(Player(7), ConvertPlayerColor(7))
    call SetPlayerRacePreference(Player(7), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(7), false)
    call SetPlayerController(Player(7), MAP_CONTROL_USER)
    // Player 8
    call SetPlayerStartLocation(Player(8), 8)
    call ForcePlayerStartLocation(Player(8), 8)
    call SetPlayerColor(Player(8), ConvertPlayerColor(8))
    call SetPlayerRacePreference(Player(8), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(8), false)
    call SetPlayerController(Player(8), MAP_CONTROL_COMPUTER)
endfunction
function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_002
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(2), 0)
    call SetPlayerState(Player(2), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(3), 0)
    call SetPlayerState(Player(3), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(4), 0)
    call SetPlayerState(Player(4), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(5), 0)
    call SetPlayerState(Player(5), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(6), 0)
    call SetPlayerState(Player(6), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(7), 0)
    call SetPlayerState(Player(7), PLAYER_STATE_ALLIED_VICTORY, 1)
    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(6), true)
    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(6), true)
    // Force: TRIGSTR_023
    call SetPlayerTeam(Player(8), 1)
endfunction
function InitAllyPriorities takes nothing returns nothing
    call SetStartLocPrioCount(0, 7)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 1, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 2, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 5, 6, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 6, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(1, 7)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 1, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 2, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 5, 6, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 6, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(2, 7)
    call SetStartLocPrio(2, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 2, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 5, 6, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 6, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(3, 7)
    call SetStartLocPrio(3, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 5, 6, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 6, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(4, 7)
    call SetStartLocPrio(4, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 5, 6, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 6, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(5, 7)
    call SetStartLocPrio(5, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 4, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 5, 6, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 6, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(6, 7)
    call SetStartLocPrio(6, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 4, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 5, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 6, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(7, 7)
    call SetStartLocPrio(7, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 4, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 5, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 6, 6, MAP_LOC_PRIO_HIGH)
endfunction
//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************
//===========================================================================
function main takes nothing returns nothing
    call SetCameraBounds(- 3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), - 3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("LordaeronSummerDay")
    call SetAmbientNightSound("LordaeronSummerNight")
    call SetMapMusic("Music", true, 0)
    call CreateRegions()
    call CreateAllUnits()
    call InitBlizzard()


    call InitGlobals()
    call InitCustomTriggers()
    call ConditionalTriggerExecute(gg_trg_Main) // INLINED!!
endfunction
//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************
function config takes nothing returns nothing
    call SetMapName("TRIGSTR_011")
    call SetMapDescription("TRIGSTR_013")
    call SetPlayers(9)
    call SetTeams(9)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    call DefineStartLocation(0, 1024.0, - 320.0)
    call DefineStartLocation(1, 1024.0, - 320.0)
    call DefineStartLocation(2, 1024.0, - 320.0)
    call DefineStartLocation(3, 1024.0, - 320.0)
    call DefineStartLocation(4, 1024.0, - 320.0)
    call DefineStartLocation(5, 1024.0, - 320.0)
    call DefineStartLocation(6, 1024.0, - 320.0)
    call DefineStartLocation(7, 1024.0, - 320.0)
    call DefineStartLocation(8, 2816.0, - 2048.0)
    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:

