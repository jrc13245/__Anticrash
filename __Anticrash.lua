local PREFIX = "|cffff0000__|r|cffaa00ff Anticrash|r"

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGOUT")
f:SetScript("OnEvent", function()
  local count = 0
  local frame = EnumerateFrames()
  while frame do
    if frame.UnregisterAllEvents then
      frame:UnregisterAllEvents()
      count = count + 1
    end
    frame = EnumerateFrames(frame)
  end
  DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. " |cffff0000UNREGISTERED " .. count .. " FRAMES BEFORE LOGOUT|r")
end)