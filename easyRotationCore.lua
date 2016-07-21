-- 
-- easyRotation Core
--
--  Sets up all the core variables and handles deligating the update calls, 
--  handles the slash command functionality 
--  and even keeps track of spells, timing data, and gcd
-- 

-- set up core variables
easyRotation.rotations = {}
easyRotation.rotation = nil
easyRotation.updateTimer = 0
easyRotation.buttonUpdated = false

-- core player tracking variables
easyRotation.ignoreMounted = true
easyRotation.gcd = 0.5
easyRotation.latencyAdjustment = 0.7
easyRotation.readyTime = 0
easyRotation.moving = false
easyRotation.startOfCombat = 0

-- keep track of the last time spells and buffs where cast/applied
easyRotation.lastSpell = {}
easyRotation.isCasting = false
easyRotation.channeledSpell = nil
easyRotation.lastBuff = {}
easyRotation.castStart = {}

-- this function initilizes the addon, it fetches saved variables and calls the
-- create ui funtion.
function easyRotation:Init()
  DEFAULT_CHAT_FRAME:AddMessage("EasyRotation 2.0 initilizing...",0,1,0);
  easyRotation.playerName = UnitName("player");
  
  -- Init Saved variables
  if not easyRotationVars then
    easyRotationVars = {} -- fresh start
  end

  -- Set Saved variables Defaults
  if not easyRotationVars.hidden then easyRotationVars.hidden = false end
  if not easyRotationVars.locked then easyRotationVars.locked = false end
  if not easyRotationVars.rotationHinterScale then easyRotationVars.rotationHinterScale = 10 end
  if not easyRotationVars.rotationHinterPosX then easyRotationVars.rotationHinterPosX = 0 end
  if not easyRotationVars.rotationHinterPosY then easyRotationVars.rotationHinterPosY = -150 end
  if not easyRotationVars.rotationHinterPosAnchorPoint then easyRotationVars.rotationHinterPosAnchorPoint = "CENTER" end
  if not easyRotationVars.debug then easyRotationVars.debug = false end
  if not easyRotationVars.ignoreMovement then easyRotationVars.ignoreMovement = false end
  if not easyRotationVars.trackInterrupts then easyRotationVars.trackInterrupts = false end
  if not easyRotationVars.interruptSpells then easyRotationVars.interruptSpells = {} end

  -- Create the Spell Icon Interface
  if not easyRotation:RotationHinterUIInitilized() then
    easyRotation:CreateRotationHinterUI()
    easyRotation:RescaleRotationHinterUI()

    -- Allow dragging if not locked
    if easyRotationVars.locked then
      easyRotation:DisableRotationHinterDragging()
    else
      easyRotation:EnableRotationHinterDragging()
    end

    -- Assign and onUpdate Event Handler
    easyRotation.rotationHinter:SetScript("OnUpdate", function(this, elapsed)
      easyRotation:OnUpdate(elapsed)
    end)
  end

  -- Register for Slash Commands
  SlashCmdList["easyRotation"] = easyRotation.Slash
  SLASH_easyRotation1 = "/easyrotation"
  SLASH_easyRotation2 = "/er"
  
  -- Register for Function Events
  easyRotation.eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
  easyRotation.eventFrame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
  easyRotation.eventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
  easyRotation.eventFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
  easyRotation.eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
  easyRotation.eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
  easyRotation.eventFrame:RegisterEvent("PLAYER_STARTED_MOVING")
  easyRotation.eventFrame:RegisterEvent("PLAYER_STOPPED_MOVING")
  easyRotation.eventFrame:RegisterEvent("CHAT_MSG_ADDON")
  easyRotation.eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

  RegisterAddonMessagePrefix("easyrotation")

  -- hide the frame if the user has configured to do so
  if easyRotationVars.hidden == true then
    easyRotation:HideRotationHinter()
  end
end

-- this function deligates addon mesages to the current rotation msg handler or
-- if there is no handler it returns an error message
function easyRotation:MsgHandler(message, sender)
  if string.sub(message, 1, string.len(17)) == "invalid command: " then
    DEFAULT_CHAT_FRAME:AddMessage("The previous command to " .. sender .. " was invalid. " .. message, 1, 1, 0);
  elseif easyRotation.rotation ~= nil and easyRotation.rotations[easyRotation.rotation].MsgHandler ~= nil and easyRotation.rotations[easyRotation.rotation].MsgHandler(message, sender) then
    -- Rotation MsgHandler fired just return
    return
  else
    SendAddonMessage("easyrotation", "invalid command: " .. message, "WHISPER", sender)
  end
end

-- this function interates through the rotations and 
function easyRotation:LoadRotations()
  for name, loader in pairs(easyRotation.rotations) do
    -- call the rotation init and if it returns true then that rotation is loaded
    if loader.init ~= nil and loader.init() then
      easyRotation.rotation = name
      DEFAULT_CHAT_FRAME:AddMessage("EasyRotation "..name.." Loaded.",0,1,1);
      easyRotation:ShowRotationHinter()
      return
    end
  end

  -- hide if no rotation loaded
  easyRotation:HideRotationHinter()
  DEFAULT_CHAT_FRAME:AddMessage("No EasyRotation Module found",1,1,0);
end

-- Slash Command Handler
function easyRotation:CoreSlash(msg,self)
  local cmd, val = msg:match("^(%S*)%s*(.-)$");
  if (cmd == 'lock') then
    easyRotationVars.locked = true;
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Locked", 1, 0, 0);
    easyRotation:DisableRotationHinterDragging()
  elseif (cmd == 'unlock') then
    easyRotationVars.locked = false;
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Unlocked", 0, 1, 0);
    easyRotation:EnableRotationHinterDragging()
  elseif (cmd == 'debug' and not easyRotationVars.debug) then
    easyRotationVars.debug = true;
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Debuging On", 0, 1, 0);
  elseif (cmd == 'debug' and easyRotationVars.debug) then
    easyRotationVars.debug = false;
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Debuging Off", 1, 0, 0);
  elseif (cmd == 'reload') then
    easyRotation:LoadRotations()
  elseif (cmd == 'show') then
    easyRotation:ShowRotationHinter()
    easyRotationVars.hidden = false
  elseif (cmd == 'hide') then
    easyRotation:HideRotationHinter()
    easyRotationVars.hidden = true
  elseif easyRotation.rotation ~= nil and easyRotation.rotations[easyRotation.rotation].Slash ~= nil and easyRotation.rotations[easyRotation.rotation].Slash(cmd,val) then
    -- Rotation Slash fired just return
    return
  else
    DEFAULT_CHAT_FRAME:AddMessage("Unknown command. Enter '/er show' to display easyRotation, or '/er hide' to hide it, '/er reload' to reload the rotation modules, '/er unlock' to allow moving of the ui, and '/er lock' to lock the ui in place.",1,1,0);
  end
end

-- function evaluates combat log events and records data about spells casts buffs and gcd
function easyRotation:CombatLogEvent(timestamp, event, uknownBoolean, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
  if (event ~= nil and srcName ~= nil and UnitIsUnit(srcName, "player")) then
    -- determine when did now happen?
    -- this might sound confusing but really we need to ajust now to compensate for server time offset, 
    -- otherwise we are not beeing as accurate as we could be.
    -- GetGameTime

    local now = GetTime() * 1000
    if ((event == "SPELL_CAST_START" or event == "SPELL_CAST_SUCCESS")) then
      local arg = {...}

      local name, subText, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo("player")
      if startTime == nil and endTime == nil then
        name, subText, text, te6xture, startTime, endTime, isTradeSkill, notInterruptible = UnitChannelInfo("player")
      end
      if startTime == nil and endTime == nil then
        startTime = now
        endTime = now
      end
      
      -- detect spell casting
      if event == "SPELL_CAST_START" then
        easyRotation.isCasting = true
        easyRotation.castStart[arg[4]] = true
        easyRotation.lastSpellTime = now
        easyRotation.lastSpell[arg[4]] = now
        easyRotation.readyTime = now + (endTime-startTime)
        if easyRotationVars.debug then
          DEFAULT_CHAT_FRAME:AddMessage("spell cast: "..arg[4].." "..(endTime-startTime), 0.5, 0.5, 0.5);
        end

        -- finished cast
      elseif easyRotation.castStart[arg[4]] then
        easyRotation.isCasting = false
        if not easyRotation.castStart[arg[4]] then
            easyRotation.lastSpellTime = now
            easyRotation.lastSpell[arg[4]] = now
        end
        easyRotation.castStart[arg[4]] = false

        if easyRotationVars.debug then
          DEFAULT_CHAT_FRAME:AddMessage("spell cast:"..arg[4].." finished", 0.5, 0.5, 0.5);
        end
        
        -- instant cast or channeled
      else
        easyRotation.isCasting = false
        easyRotation.castStart[arg[4]] = false
        easyRotation.lastSpellTime = now
        easyRotation.lastSpell[arg[4]] = now

        if startTime == nil or endTime == nil then
          easyRotation.readyTime = now + (easyRotation.gcd * 100)

          if easyRotationVars.debug then
            DEFAULT_CHAT_FRAME:AddMessage("instant cast:"..arg[4].." gcd "..(easyRotation.gcd * 1000), 0.5, 0.5, 0.5);
          end
        else
          easyRotation.readyTime = now + (endTime-startTime)

          if easyRotationVars.debug then
            DEFAULT_CHAT_FRAME:AddMessage("channeled cast:"..arg[4].." "..(endTime-startTime), 0.5, 0.5, 0.5);
          end
        end
      end

      --if arg[4] ~= "Arcane Missiles" and arg[4] ~= "Melee" then -- Arcane Missiles and Metamorphosis Melee bug
      --  easyRotation.readyTime = now + easyRotation.gcd
      --elseif arg[4] ~= "Melee" then
      --  local channel, _, _, _, _, endTime2, _, _ = UnitChannelInfo("player");
      --  if endTime2 ~= nil then
      --    easyRotation.readyTime = endTime2;
      --  end
      --end
    elseif event == "SPELL_AURA_APPLIED" then
      local arg = {...}
      easyRotation.lastBuff[arg[4]] = now

    elseif event == "SPELL_CAST_FAILED" or event == "SPELL_MISS" then
      local arg = {...}
      if arg[6] == "Interrupted" then -- failtype = Inturrupted
        easyRotation.lastSpell[arg[4]] = 0
        easyRotation.castStart[arg[4]] = false
        easyRotation.readyTime = 0
      end
    end
  end

  -- call out the the module combat log handler
  if easyRotation.rotation ~= nil and easyRotation.rotations[easyRotation.rotation].CombatLog ~= nil then
    easyRotation.rotations[easyRotation.rotation].CombatLog(timestamp, event, uknownBoolean, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
  end
end

function easyRotation:OnUpdate(elapsed)
  -- increment the timer and check
  easyRotation.updateTimer = easyRotation.updateTimer + elapsed;
  if easyRotation.updateTimer > 0.1 then
    local now = (GetTime() + easyRotation.latencyAdjustment) * 1000

    -- load the rotation for the first time if its not loaded
    if easyRotation.rotation == nil then
      easyRotation:LoadRotations()
    end

   if easyRotation.readyTime == nil or (easyRotation.readyTime ~= 0 and easyRotation.readyTime <= now) then
     easyRotation.readyTime = 0
     if easyRotationVars.debug then
        DEFAULT_CHAT_FRAME:AddMessage("ready!",0.5,0.5,0.5);
      end
   end

    -- call decide spells wrapper
    easyRotation:DecideSpellsWrapper();

    -- zero timer
    easyRotation.updateTimer = 0
  end
end

function easyRotation:OnEvent(event, ...)
  if event == "PLAYER_REGEN_DISABLED" then
    easyRotation.startOfCombat = GetTime()

    if easyRotationVars.debug then
      DEFAULT_CHAT_FRAME:AddMessage("combat started", 0.5, 0.5, 0.5);
    end
  elseif event == "PLAYER_REGEN_ENABLED" then
    easyRotation.startOfCombat = 0

    if easyRotationVars.debug then
      DEFAULT_CHAT_FRAME:AddMessage("combat finished", 0.5, 0.5, 0.5);
    end
  elseif event == "PLAYER_STARTED_MOVING" then
    easyRotation.moving = true

    --if easyRotationVars.debug then
    --  DEFAULT_CHAT_FRAME:AddMessage("moving", 0.5, 0.5, 0.5);
    --end
  elseif event == "PLAYER_STOPPED_MOVING" then
    easyRotation.moving = false
    
    --if easyRotationVars.debug then
    --  DEFAULT_CHAT_FRAME:AddMessage("stopped", 0.5, 0.5, 0.5);
    --end
  end
end

function easyRotation:DecideSpellsWrapper()
  easyRotation.buttonUpdated = false

  -- Interrupts
  if easyRotationVars.trackInterrupts and easyRotation.rotation ~= nil and easyRotation.rotations[easyRotation.rotation].DecideInturrupts ~= nil and easyRotation:TargetNeedsToBeInterrupted() then
    easyRotation.rotations[easyRotation.rotation].DecideInturrupts()
    if easyRotation.buttonUpdated then
      return
    end
  end

  -- Buffs
  if (easyRotation.rotation ~= nil and easyRotation.rotations[easyRotation.rotation].DecideBuffs ~= nil) then
    easyRotation.rotations[easyRotation.rotation].DecideBuffs()
    if easyRotation.buttonUpdated then
      if easyRotation.readyTime ~= 0 or SpellIsTargeting() or UnitIsDead("target") or UnitIsDead("player") or IsMounted() then
        easyRotation:deactivate()
      end
      return
    end
  end
  
  -- Rotation
  if easyRotation.rotation ~= nil and easyRotation.rotations[easyRotation.rotation].DecideSpells ~= nil then
    easyRotation.rotations[easyRotation.rotation].DecideSpells()
    if easyRotation.buttonUpdated then
      if easyRotation.readyTime ~= 0 or not UnitName("target") or UnitIsFriend("player","target") or SpellIsTargeting() or UnitIsDead("target") or UnitIsDead("player") or (not easyRotation.ignoreMounted and IsMounted()) then
        easyRotation:deactivate()
      end
      return
    end
  end
   easyRotation:deactivate()
end
