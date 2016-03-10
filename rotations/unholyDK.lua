easyRotation.rotations.unholyDK = {}

function easyRotation.rotations.unholyDK.init()
  local _,playerClass = UnitClass("player")
   -- if not easyRotationVars.mode then easyRotationVars.mode = "Single Target" end
  if not easyRotationVars.pest then easyRotationVars.pest = true end 

  return playerClass == "DEATH KNIGHT" and GetSpecialization() == 3
end


function easyRotation.rotations.unholyDK.Slash(cmd,val)
 -- if (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
 --   easyRotationVars.mode = "AOE"
 --   DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
 --   return true
 -- elseif (cmd == 'mode' and easyRotationVars.mode  == "AOE") then
  --  easyRotationVars.mode = "Single Target"
  --  DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",0,0,1)
  if (cmd == 'pest' and easyRotationVars.pest) then
    easyRotationVars.pest = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Pestilence",1,0,0)
    return true
  elseif (cmd == 'pest' and not easyRotationVars.pest) then
    easyRotationVars.pest = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Pestilence",0,0,1)
    return true
    else
    return false
  end
end

function easyRotation.rotations.unholyDK.DecideSpells()

   if  easyRotation:PlayerCanCastSpell("Horn of Winter")
          and not(easyRotation:UnitHasBuff("player","Horn of Winter") 
          or easyRotation:UnitHasBuff("player","Battle Shout"))          
          then easyRotation:UpdateButton("Horn of Winter")
   elseif easyRotation:PlayerCanCastSpell("Unholy Frenzy") 
          and easyRotation:GetRange("target") < 6
          and easyRotation:PlayerTimeInCombat() > 5
          then easyRotation:UpdateButton("Unholy Frenzy")
   elseif easyRotation:PlayerCanCastSpell("Outbreak") 
          --and not easyRotation:UnitHasDebuff("target","Blood Plague") 
         -- and not easyRotation:UnitHasDebuff("target","Frost Fever") 
          --and (easyRotation:SpellNotCastRecently("Plague Strike")
         -- or easyRotation:SpellNotCastRecently("Icy Touch"))           
          and easyRotation:GetRange("target") < 29 
          then easyRotation:UpdateButton("Outbreak")  
  elseif easyRotation:PlayerCanCastSpell("Death Strike") 
          and easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) > 0
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) > 0 
          and easyRotation:UnitHealthPercent("player") < 50
          and easyRotation:GetRange("target") < 6
          then easyRotation:UpdateButton("Death Strike") 
    elseif --easyRotation:UnitHasBuffRemaining("target","Blood Plague") > 10
           easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) >= 1 
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) >= 1 
          and easyRotation:PlayerCanCastSpell("Festering Strike") 
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Festering Strike")
   --elseif easyRotation:PlayerCanCastSpell("Dark Transformation") 
   --       and easyRotation:GetRange("target") < 6 
   --       and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) >= 1
   --       then easyRotation:UpdateButton("Dark Transformation")
   elseif --(not easyRotation:PlayerCanCastSpell("Outbreak")) and
           easyRotation:PlayerCanCastSpell("Plague Strike") 
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) > 0
          and (not easyRotation:UnitHasDebuff("target","Blood Plague") 
          or easyRotation:UnitHasDebuffRemaining("target","Blood Plague") < 3)                     
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Plague Strike")
   elseif easyRotation:PlayerCanCastSpell("Icy Touch")
          and easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) > 0
          and (not easyRotation:UnitHasDebuff("target","Frost Fever") 
          or easyRotation:UnitHasDebuffRemaining("target", "Frost Fever")< 3)             
          and easyRotation:GetRange("target") < 19 
          then easyRotation:UpdateButton("Icy Touch")
    elseif easyRotation:PlayerCanCastSpell("Summon Gargoyle") 
          and easyRotation:GetRange("target") < 29 
          and easyRotation:UnitHealthPercent("target") > 20 
          and easyRotation:GetPlayerResource(SPELL_POWER_RUNIC_POWER) > 60
          then easyRotation:UpdateButton("Summon Gargoyle")   
   elseif easyRotation:PlayerCanCastSpell("Death Coil") 
          and easyRotation:GetRange("target") < 29 
          and (easyRotation:UnitHasBuff("player","Sudden Doom"))
           and easyRotation:UnitHealthPercent("target") > 5 
          then easyRotation:UpdateButton("Death Coil")
   elseif (easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) >= 1 
          or easyRotation:GetPlayerResource(SPELL_POWER_DEATH_RUNE) >= 1)
          and easyRotation:PlayerCanCastSpell("Scourge Strike") 
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Scourge Strike")
   elseif easyRotation:PlayerCanCastSpell("Death Coil") 
          and easyRotation:GetRange("target") < 29 
           and easyRotation:UnitHealthPercent("target") > 5
          and easyRotation:GetPlayerResource(SPELL_POWER_RUNIC_POWER) > 90
    --      then easyRotation:UpdateButton("Death Coil")
  --elseif easyRotation:PlayerCanCastSpell("Death Coil") 
     --     and easyRotation:GetRange("target") < 29 
          or (easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) < 1 
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) < 1 
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) < 1
           and easyRotation:UnitHealthPercent("target") > 5 
          and easyRotation:GetPlayerResource(SPELL_POWER_RUNIC_POWER) > 40)
          then easyRotation:UpdateButton("Death Coil")
  elseif easyRotation:IsSpellReady("Blood Tap")
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) >= 0
          and easyRotation:GetRange("target") < 6 
          and easyRotation:PlayerTimeInCombat() > 25
          then easyRotation:UpdateButton("Blood Tap")
  elseif easyRotation:PlayerCanCastSpell("Empower Rune Weapon") 
          and easyRotation:GetRange("target") < 29 
          and easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) < 1 
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) < 1 
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) < 1
          --or (easyRotation:GetPlayerResource(SPELL_POWER_RUNIC_POWER) <30)
          then easyRotation:UpdateButton("Empower Rune Weapon")


















end
end
