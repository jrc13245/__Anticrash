local PREFIX = "|cffff0000!!|r|cffaa00ffAnticrash|r"

Anticrash_SavedData = Anticrash_SavedData or {}

local isLogout = false

local function DoShutdown()
  local count = 0
  local frame = EnumerateFrames()
  while frame do
    if frame.UnregisterAllEvents then
      frame:UnregisterAllEvents()
      count = count + 1
    end
    frame = EnumerateFrames(frame)
  end
  Anticrash_SavedData.lastCount = count
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGOUT")
f:RegisterEvent("PLAYER_LEAVING_WORLD")
f:RegisterEvent("VARIABLES_LOADED")
f:SetScript("OnEvent", function()
  if event == "PLAYER_LOGOUT" then
    -- mark as logout so PLAYER_LEAVING_WORLD knows to shutdown
    isLogout = true
  elseif event == "PLAYER_LEAVING_WORLD" then
    -- only shutdown on real logout, not zone changes
    if isLogout then
      DoShutdown()
    end
  elseif event == "VARIABLES_LOADED" then
    if Anticrash_SavedData.lastCount then
      f.loginTimer = 0
      f.showMessage = true
    end
  end
end)

f:SetScript("OnUpdate", function()
  if not f.showMessage then return end
  f.loginTimer = (f.loginTimer or 0) + arg1
  if f.loginTimer < 2 then return end
  f.showMessage = false
  DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. " |cffff0000UNREGISTERED " .. Anticrash_SavedData.lastCount .. " FRAMES BEFORE LAST LOGOUT|r")
end)