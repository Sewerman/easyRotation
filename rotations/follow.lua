easyRotation.modules.follow = {}

function easyRotation.modules.follow.init()
  return true
end

function easyRotation.modules.follow.MsgHandler(message, sender)
  if message == "followme" then
    DEFAULT_CHAT_FRAME:AddMessage("Recived a follow command from "..sender,1,1,0);
    FollowUnit(sender);
    return true
  else
    return false
  end
end

function easyRotation.modules.follow.Slash(cmd,val)
  if (cmd == 'followme') then
    if UnitExists("target") then
      SendAddonMessage("easyrotation", "followme", "WHISPER", UnitName("target"))
    elseif UnitInRaid("player") then
      SendAddonMessage("easyrotation", "followme", "RAID")
    elseif UnitInParty("player") then
      SendAddonMessage("easyrotation", "followme", "PARTY")
    else
      DEFAULT_CHAT_FRAME:AddMessage("You do not have a target and are not in a raid or party.",1,1,0);
    end
    return true
  else
    return false
  end
end
