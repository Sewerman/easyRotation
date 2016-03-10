easyRotation.modules.targeting = {}

function easyRotation.modules.targeting.init()
  easyRotation.modules.targeting.target = nil
  easyRotation.modules.targeting.interact = nil
  easyRotation.modules.targeting.assist = nil
  return true
end

function easyRotation.modules.targeting.AddonMsg(message, sender)
  if message == "interact" then
    DEFAULT_CHAT_FRAME:AddMessage("Recived a interact command from "..sender,1,1,0);
    easyRotation.modules.targeting.interact = true
    return true
  elseif message == "targetmytarget" then
    DEFAULT_CHAT_FRAME:AddMessage("Recived a target command from "..sender,1,1,0);
    easyRotation.modules.targeting.target = nil
    easyRotation.modules.targeting.assist = sender
    DEFAULT_CHAT_FRAME:AddMessage("Assisting: "..sender,1,1,0);
    return true
  elseif message == "cleartarget" then
    DEFAULT_CHAT_FRAME:AddMessage("Recived a clear target command from "..sender,1,1,0);
    easyRotation.modules.targeting.target = "player"
    easyRotation.modules.targeting.assist = nil
    return true
  else
    return false
  end
end

function easyRotation.modules.targeting.initializeVariables()
  for i=1,5 do
    local index = GetMacroIndexByName("assistparty"..i)
    if(index == 0) then
      CreateMacro("assistparty"..i, 1, "/assist party"..i)
    else
      EditMacro(index, "assistparty"..i, 1, "/assist party"..i)
    end
    SetBindingMacro("CTRL-SHIFT-"..i, "assistparty"..i)
  end
end

function easyRotation.modules.targeting.Slash(cmd,val)
  if (cmd == 'targetmytarget') then
    if UnitInRaid("player") then
      SendAddonMessage("easyrotation", "targetmytarget", "RAID")
    elseif UnitInParty("player") then
      SendAddonMessage("easyrotation", "targetmytarget", "PARTY")
    else
      DEFAULT_CHAT_FRAME:AddMessage("You do not have a target and are not in a raid or party.",1,1,0);
    end
    return true
  elseif (cmd == 'cleartarget') then
    if UnitInRaid("player") then
      SendAddonMessage("easyrotation", "cleartarget", "RAID")
    elseif UnitInParty("player") then
      SendAddonMessage("easyrotation", "cleartarget", "PARTY")
    else
      DEFAULT_CHAT_FRAME:AddMessage("You do not have a target and are not in a raid or party.",1,1,0);
    end
    return true
  else
    return false
  end
end

function easyRotation.modules.targeting.DecideButton()
  if (easyRotation.modules.targeting.interact ~= nil) then
    easyRotation:UpdateButton("interacttarget")
    easyRotation.modules.targeting.interact = nil
  elseif (easyRotation.modules.targeting.target ~= nil) then
    if(easyRotation.modules.targeting.target == "player") then
      if(UnitIsUnit("target","player")) then
        easyRotation.modules.targeting.target = nil
      else
        easyRotation:UpdateButton("targetplayer")
      end
    end
  elseif (easyRotation.modules.targeting.assist ~= nil) then
    local target = nil
    if(UnitInParty(easyRotation.modules.targeting.assist)) then
      for i=1,5 do
        if(UnitIsUnit("party"..i, easyRotation.modules.targeting.assist)) then
          target = "party"..i
          break
        end
      end
    end
    if(target ~= nil) then
      if(UnitIsUnit(target.."target","target")) then
          easyRotation.modules.targeting.assist = nil
      else
          easyRotation:UpdateButton("assist"..target)
      end
    end
  end
end
