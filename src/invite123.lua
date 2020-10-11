local addon_name, I123 = ...

-- Event handling
local frame_events = CreateFrame("FRAME", "CS_EventFrame")
frame_events.OnEvent = function(self, event, arg1, arg2)
    if event == "CHAT_MSG_GUILD" then
        local msg    = arg1
        local player = arg2
        if msg == "123" then
            InviteUnit(player)
        end
    end
end
frame_events:SetScript("OnEvent", frame_events.OnEvent)
frame_events:RegisterEvent "CHAT_MSG_GUILD"
