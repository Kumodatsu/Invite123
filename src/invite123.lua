local addon_name, I123 = ...

local keywords = {
    "123",
    "321"
}

local events = {
    "CHAT_MSG_WHISPER",
    "CHAT_MSG_GUILD"
}

local contains = function(xs, y)
    for _, x in ipairs(xs) do
        if x == y then return true end
    end
    return false
end

local is_keyword = function(word)
    return contains(keywords, word)
end

local is_event = function(event)
    return contains(events, event)
end

local _self = UnitName "player"

local in_group = function()
    return IsInGroup() or IsInRaid()
end

local invite = function(player)
    if player == _self or not in_group() then return end
    C_PartyInfo.InviteUnit(player)
end

-- Event handling
local frame_events = CreateFrame("FRAME", "CS_EventFrame")
frame_events.OnEvent = function(self, event, arg1, arg2)
    if is_event(event) then
        local msg    = arg1
        local player = arg2
        if is_keyword(msg) then
            invite(player)
        end
    end
end
frame_events:SetScript("OnEvent", frame_events.OnEvent)

for _, event in ipairs(events) do
    frame_events:RegisterEvent(event)
end
