easyRotation.rotations.protPally = {}

function easyRotation.rotations.protPally.init()
  local _,playerClass = UnitClass("player")
    if not easyRotationVars.mode then easyRotationVars.mode = "Single Target" end
    if not easyRotationVars.AvengersShield then easyRotationVars.AvengersShield = true end
    if not easyRotationVars.wings then easyRotationVars.wings = false end
    if not easyRotationVars.AvengersShield then easyRotationVars.DivineSteed = true end

  return playerClass == "PALADIN" and GetSpecialization() == 2
end
  
  
function easyRotation.rotations.protPally.Slash(cmd,val)
  if (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
    easyRotationVars.mode = "AOE"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
    return true
  elseif (cmd == 'mode' and easyRotationVars.mode  == "AOE") then
    easyRotationVars.mode = "Single Target"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",0,0,1)
    return true
  elseif (cmd == 'AS' and easyRotationVars.AvengersShield) then
    easyRotationVars.AvengersShield = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Avenger's Shield",1,0,0)
    return true
  elseif (cmd == 'AS' and not easyRotationVars.AvengersShield) then
    easyRotationVars.AvengersShield = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Avenger's Shield",0,1,0)
    return true
  elseif (cmd == 'wings' and not easyRotationVars.wings) then
    easyRotationVars.wings = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Avenging Wrath",0,1,0)
    return true
  elseif (cmd == 'wings' and easyRotationVars.wings) then
    easyRotationVars.wings = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Avenging Wrath",1,0,1)
    return true
  elseif (cmd == 'Horse' and easyRotationVars.DivineSteed) then
    easyRotationVars.DivineSteed = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking DivineSteed",1,1,0)
    return true
  elseif (cmd == 'Horse' and not easyRotationVars.DivineSteed) then
    easyRotationVars.DivineSteed = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking DivineSteed",0,1,1)
    return true
   else
    return false
  end
end


function easyRotation.rotations.protPally.DecideBuffs()

end
  
function easyRotation.rotations.protPally.DecideSpells()
  if easyRotationVars.mode == "Single Target" then
    easyRotation.rotations.protPally.DecideSingleTargetSpells()
  elseif easyRotationVars.mode == "AOE" then
    easyRotation.rotations.protPally.DecideAOESpells()
  end
end

function easyRotation.rotations.protPally.DecideSingleTargetSpells()

 if easyRotation:IsPlayerSpellReady("Avenging Wrath")
   and easyRotation:PlayerTimeInCombat()>1
   and easyRotation:UnitHasBuff("player", "Consecration")
   and easyRotation:UnitHealthPercent("target")<35
  or easyRotation:IsPlayerSpellReady("Avenging Wrath")
   and easyRotation:PlayerTimeInCombat()>1
   and easyRotation:UnitHealthPercent("player")<40
   and easyRotation:SpellCooldownRemaining("Light of the Protector")< 5
   and easyRotation:UnitHasBuff("player", "Consecration")
   and easyRotationVars.wings
  then easyRotation:UpdateRotationHinterIcon("Avenging Wrath")

 elseif easyRotationVars.DivineSteed 
   and easyRotation:PlayerTimeInCombat()>1
   and easyRotation:UnitHealthPercent("player")<40
   and easyRotation:IsPlayerSpellReady("Divine Steed")
  then easyRotation:UpdateRotationHinterIcon("Divine Steed")
 

 elseif easyRotation:IsPlayerSpellReady("Judgment")
   and easyRotation:UnitHasYourDebuffRemaining("target", "Judgment of Light") < 15
   and easyRotation:GetRange("target") < 30
  or easyRotation:IsPlayerSpellReady("Judgment")
   and easyRotation:IsMoving()
   and easyRotation:GetRange("target") < 30
  then easyRotation:UpdateRotationHinterIcon("Judgment")

 elseif easyRotation:IsPlayerSpellReady("Avenger's Shield")
   and easyRotation:UnitHasBuff("player", "Consecration")
   and easyRotation:GetRange("target") < 30
   and not easyRotationVars.AvengersShield   
  or easyRotation:IsPlayerSpellReady("Avenger's Shield")
   and easyRotation:IsMoving()
   and easyRotation:GetRange("target") < 30
   and not easyRotationVars.AvengersShield
  then easyRotation:UpdateRotationHinterIcon("Avenger's Shield")

 elseif easyRotation:IsPlayerSpellReady( "Shield of the Righteous")
   and not easyRotation:UnitHasBuff("player", "Shield of the Righteous")
   and easyRotation:GetPlayerSpellCharges("Shield of the Righteous") >1
   and easyRotation:UnitHealthPercent("player")>60 
   and easyRotation:GetRange("target") < 6
  or easyRotation:GetPlayerSpellCharges("Shield of the Righteous") >0
   and not easyRotation:UnitHasBuff("player", "Shield of the Righteous")
   and easyRotation:UnitHealthPercent("player")<60 
   and easyRotation:GetRange("target") < 6
   and easyRotation:IsPlayerSpellReady( "Shield of the Righteous")
  then easyRotation:UpdateRotationHinterIcon("Shield of the Righteous")

 elseif easyRotation:IsPlayerSpellReady("Light of the Protector")
   and easyRotation:UnitHasBuff("player", "Consecration")
   and not easyRotation:IsMoving()
  then easyRotation:UpdateRotationHinterIcon("Light of the Protector")

 elseif easyRotation:IsPlayerSpellReady("Consecration")
   and not easyRotation:IsMoving()
   and easyRotation:GetRange("target") < 6
  then easyRotation:UpdateRotationHinterIcon("Consecration")

 elseif easyRotation:IsPlayerSpellReady("Blessed Hammer")
   and easyRotation:GetPlayerSpellCharges("Blessed Hammer") >0 
   and easyRotation:GetRange("target") < 6  
  then easyRotation:UpdateRotationHinterIcon("Blessed Hammer")

 elseif easyRotation:IsPlayerSpellReady("Judgment")
   and easyRotation:GetRange("target") < 30
  then easyRotation:UpdateRotationHinterIcon("Judgment")

 elseif easyRotation:IsPlayerSpellReady("Consecration")
   and not easyRotation:IsMoving()
   and easyRotation:GetRange("target") < 6
  then easyRotation:UpdateRotationHinterIcon("Consecration")

 elseif easyRotation:IsPlayerSpellReady("Avenger's Shield")
   and not easyRotationVars.AvengersShield
   and easyRotation:GetRange("target") < 30
  then easyRotation:UpdateRotationHinterIcon("Avenger's Shield")

 elseif easyRotation:IsPlayerSpellReady("Judgment")
  then easyRotation:IsPlayerSpellReady("Judgment")

 end
end

function easyRotation.rotations.protPally.DecideAOESpells()

 if easyRotation:IsPlayerSpellReady("Avenging Wrath")
   and easyRotation:PlayerTimeInCombat()>1
   and easyRotation:UnitHasBuff("player", "Consecration")
   and easyRotation:UnitHealthPercent("target")<35
  or easyRotation:IsPlayerSpellReady("Avenging Wrath")
   and easyRotation:PlayerTimeInCombat()>1
   and easyRotation:UnitHealthPercent("player")<40
   and easyRotation:UnitHasBuff("player", "Consecration")
   and easyRotationVars.wings
  then easyRotation:UpdateRotationHinterIcon("Avenging Wrath")
 
 elseif easyRotation:IsPlayerSpellReady("Avenger's Shield")
   and easyRotation:UnitHasBuff("player", "Consecration")
   and not easyRotationVars.AvengersShield
  or  easyRotation:IsPlayerSpellReady("Avenger's Shield")
   and not easyRotationVars.AvengersShield
   and easyRotation:IsMoving()
  then easyRotation:UpdateRotationHinterIcon("Avenger's Shield") 

 elseif easyRotationVars.DivineSteed 
   and easyRotation:PlayerTimeInCombat()>1
   and easyRotation:UnitHealthPercent("player")<40
   and easyRotation:IsPlayerSpellReady("Divine Steed")
  then easyRotation:UpdateRotationHinterIcon("Divine Steed")

 elseif easyRotation:IsPlayerSpellReady("Blinding Light")
   and not easyRotation:IsMoving()
   and easyRotation:GetRange("target") < 6
  then easyRotation:UpdateRotationHinterIcon("Blinding Light") 

 elseif easyRotation:IsPlayerSpellReady("Light of the Protector")
   and easyRotation:UnitHasBuff("player", "Consecration")
  then easyRotation:UpdateRotationHinterIcon("Light of the Protector")

elseif easyRotation:IsPlayerSpellReady("Consecration")
   and not easyRotation:IsMoving()
   and easyRotation:GetRange("target") < 6
  then easyRotation:UpdateRotationHinterIcon("Consecration")

elseif easyRotation:IsPlayerSpellReady("Blessed Hammer")
   and easyRotation:GetRange("target") < 6
   and easyRotation:GetPlayerSpellCharges("Blessed Hammer") >0
  then easyRotation:UpdateRotationHinterIcon("Blessed Hammer")

 elseif easyRotation:IsPlayerSpellReady("Shield of the Righteous")
   and not easyRotation:UnitHasBuff("player", "Shield of the Righteous")
   and easyRotation:GetPlayerSpellCharges("Shield of the Righteous") >1
   and easyRotation:UnitHealthPercent("player")>60 
   and easyRotation:GetRange("target") < 6
  or easyRotation:GetPlayerSpellCharges("Shield of the Righteous") >0
   and not easyRotation:UnitHasBuff("player", "Shield of the Righteous")
   and easyRotation:UnitHealthPercent("player")<60 
   and easyRotation:GetRange("target") < 6
   and easyRotation:IsPlayerSpellReady( "Shield of the Righteous")
  then easyRotation:UpdateRotationHinterIcon("Shield of the Righteous")

 elseif easyRotation:IsPlayerSpellReady("Avenger's Shield")
   and not easyRotationVars.AvengersShield
   and easyRotation:GetRange("target") < 30
  then easyRotation:UpdateRotationHinterIcon("Avenger's Shield")

 elseif easyRotation:IsPlayerSpellReady("Judgment")
   and easyRotation:GetRange("target") < 30
  then easyRotation:UpdateRotationHinterIcon("Judgment")
 
 end
end
