local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local dataobj = ldb:NewDataObject("HiddenTracker", {type = "data source", text = "Hidden Tracker"})

local f = CreateFrame("frame")

local wqsDone, wqsReq = 0, 0
local dungDone, dungReq = 0, 0
local killsDone, killsRequired = 0, 0
local _

local function dungeons()
    return string.format("Dungeons: %d/%d", dungDone, dungReq)
end

local function world_quests()
    return string.format("World Quests: %d/%d", wqsDone, wqsReq)
end

local function kills()
    return string.format("Kills: %d/%d", killsDone, killsRequired)
end

f:SetScript("OnUpdate", function(self)
    dungDone = 0
    for dungeonId = 1,11 do
        local count
        _,_,_, count, dungReq = GetAchievementCriteriaInfo(11152, dungeonId)
        dungDone = dungDone + count
    end

    _,_,_, wqsDone, wqsReq = GetAchievementCriteriaInfo(11153,1)
    _,_,_, killsDone, killsRequired = GetAchievementCriteriaInfo(11154,1)

    dataobj.text = dungeons()
--    dataobj.text = world_quests()
--    dataobj.text = kills()
end)

function dataobj:OnTooltipShow()
    self:AddLine(dungeons())
    self:AddLine(world_quests())
    self:AddLine(kills())
end

function dataobj:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_NONE")
    GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
    GameTooltip:ClearLines()
    dataobj.OnTooltipShow(GameTooltip)
    GameTooltip:Show()
end

function dataobj:OnLeave()
    GameTooltip:Hide()
end
