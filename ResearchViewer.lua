local name = ...

ResearchViewer = {}
local LibDBIcon = LibStub("LibDBIcon-1.0")

local playerClass = UnitClassBase("player")
local orderHalls = {
    ["WARRIOR"] = 122,
    ["PALADIN"] = 119,
    ["HUNTER"] = 113,
    ["ROGUE"] = 131,
    ["PRIEST"] = 134,
    ["DEATHKNIGHT"] = 128,
    ["SHAMAN"] = 31,
    ["MAGE"] = 116,
    ["WARLOCK"] = 110,
    ["MONK"] = 4,
    ["DRUID"] = 107,
    ["DEMONHUNTER"] = 125,
    ["EVOKER"] = -1,
}

local increment = CreateCounter();
ResearchViewer.talentTrees = {
    ["The War Within"] = {
        order = increment(),
        { isTraitTree = true, id = 1115, name = GENERIC_TRAIT_FRAME_RESHII_WRAPS_TITLE },
        { isTraitTree = true, id = 672, name = GENERIC_TRAIT_FRAME_DRAGONRIDING_TITLE },
        { isTraitTree = true, id = 1151, name = "Brann Delve Season 3" },
        { isTraitTree = true, id = 1061, name = GENERIC_TRAIT_FRAME_TITAN_CONSOLE_TITLE },
        { isTraitTree = true, id = 1057, name = GENERIC_TRAIT_FRAME_VISIONS_TITLE },
        { isTraitTree = true, id = 1056, name = GENERIC_TRAIT_FRAME_DRIVE_TITLE },
        { isTraitTree = true, id = 1060, name = "Brann Delve Season 2" },
        { isTraitTree = true, id = 1046, name = GENERIC_TRAIT_FRAME_THE_VIZIER_TITLE },
        { isTraitTree = true, id = 1045, name = GENERIC_TRAIT_FRAME_THE_GENERAL_TITLE },
        { isTraitTree = true, id = 1042, name = GENERIC_TRAIT_FRAME_THE_WEAVER_TITLE },
        { isTraitTree = true, id = 1054, name = "??" },
        { isTraitTree = true, id = 898, name = "??" },
        { isTraitTree = true, id = 876, name = "??" },
        { isTraitTree = true, id = 875, name = "??" },
        { isTraitTree = true, id = 775, name = "??" },
        { isTraitTree = true, id = 751, name = "??" },
        { isTraitTree = true, id = 874, name = "Brann Delve Season 1" },
    },
    Dragonflight = {
        order = increment(),
        { isTraitTree = true, id = 672, name = GENERIC_TRAIT_FRAME_DRAGONRIDING_TITLE },
        { type = 111, id = 489, name = "Expedition Supplies" },
        { type = 111, id = 493, name = "Cobalt Assembly Arcana" },
        { type = 111, id = 486, name = "Select Your Companion" },
        { type = 111, id = 491, name = "Hunting Party Loadout" },
    },
    Shadowlands = {
        order = increment(),
        { type = 111, id = 461, name = "The Box of Many Things" },
        { type = 111, id = 474, name = "Cypher Research Console" },
        { type = 111, id = 476, name = "Pocopoc Customization" },
        ["Kyrian (hidden research trees)"] = {
            order = increment(),
            { type = 111, id = 308, name = "Transport Network" },
            { type = 111, id = 312, name = "Anima Conductor" },
            { type = 111, id = 316, name = "Command Table" },
            { type = 111, id = 320, name = "Path of Ascension" },
            { type = 111, id = 357, name = "Pelagos" },
            { type = 111, id = 360, name = "Kleia" },
            { type = 111, id = 365, name = "Mikanikos" },
            { type = 111, id = 345, name = "Channel Anima" },
            { type = 111, id = 393, name = "Bastion - Covenant Abilities" },
        },
        ["Night Fea (hidden research trees)"] = {
            order = increment(),
            { type = 111, id = 307, name = "Transport Network" },
            { type = 111, id = 311, name = "Anima Conductor" },
            { type = 111, id = 315, name = "Command Table" },
            { type = 111, id = 319, name = "The Queen's Conservatory" },
            { type = 111, id = 275, name = "Dreamweaver" },
            { type = 111, id = 276, name = "Niya" },
            { type = 111, id = 334, name = "Korayn" },
            { type = 111, id = 346, name = "Channel Anima" },
            { type = 111, id = 397, name = "Ardenweald - Covenant Abilities" },
        },
        ["Necrolord  (hidden research trees)"] = {
            order = increment(),
            { type = 111, id = 310, name = "Transport Network" },
            { type = 111, id = 313, name = "Anima Conductor" },
            { type = 111, id = 318, name = "Command Table" },
            { type = 111, id = 321, name = "Abomination Factory" },
            { type = 111, id = 325, name = "Plague Deviser Marileth" },
            { type = 111, id = 330, name = "Emeni" },
            { type = 111, id = 349, name = "Bonesmith Heirmir" },
            { type = 111, id = 347, name = "Channel Anima" },
            { type = 111, id = 395, name = "Maldraxxus - Covenant Abilities" },
        },
        ["Venthyr (hidden research trees)"] = {
            order = increment(),
            { type = 111, id = 309, name = "Transport Network" },
            { type = 111, id = 314, name = "Anima Conductor" },
            { type = 111, id = 317, name = "Command Table" },
            { type = 111, id = 324, name = "The Ember Court" },
            { type = 111, id = 368, name = "Nadjia the Mistblade" },
            { type = 111, id = 392, name = "Theotar the Mad Duke" },
            { type = 111, id = 304, name = "General Draven" },
            { type = 111, id = 348, name = "Channel Anima" },
            { type = 111, id = 396, name = "Revendreth - Covenant Abilities" },
        },
    },
    BFA = {
        order = increment(),
        { type = 9, id = 152, name = "War Research - Horde" },
        { type = 9, id = 153, name = "War Research - Aliance" },
        { type = 9, id = 271, name = "MOTHER's Research" },
    },
    Legion = {
        order = increment(),
        { type = 3, id = orderHalls[playerClass], name = "Your class Order Hall", special = true },
        { type = 3, id = 151, name = "Chromie event" },
        { type = 3, id = orderHalls.DEATHKNIGHT, name = "Death Knight Order Hall" },
        { type = 3, id = orderHalls.WARRIOR, name = "Warrior Order Hall" },
        { type = 3, id = orderHalls.MONK, name = "Monk Order Hall" },
        { type = 3, id = orderHalls.SHAMAN, name = "Shaman Order Hall" },
        { type = 3, id = orderHalls.DRUID, name = "Druid Order Hall" },
        { type = 3, id = orderHalls.WARLOCK, name = "Warlock Order Hall" },
        { type = 3, id = orderHalls.HUNTER, name = "Hunter Order Hall" },
        { type = 3, id = orderHalls.MAGE, name = "Mage Order Hall" },
        { type = 3, id = orderHalls.PALADIN, name = "Paladin Order Hall" },
        { type = 3, id = orderHalls.DEMONHUNTER, name = "Demon Hunter Order Hall" },
        { type = 3, id = orderHalls.ROGUE, name = "Rogue Order Hall" },
        { type = 3, id = orderHalls.PRIEST, name = "Priest Order Hall" },
    },
}
ResearchViewer.neverImplemented = {
    ["The War Within"] = {
        order = increment(),
        { type = 111, id = 498, name = "Earthen Obelisk" },
        { type = 111, id = 495, name = "Rexxar's Ability" },
        { type = 111, id = 496, name = "Awakening The Machine" },
        { type = 111, id = 497, name = "The Weaver" },
    },
    Dragonflight = {
        order = increment(),
        { type = 111, id = 463, name = "Drake Mastery Progression" },
        { type = 111, id = 467, name = "Drake Mastery Progression" },
        { type = 111, id = 479, name = "Thunder Lizard Effigy" },
        { type = 111, id = 482, name = "Dragonriding Skills" },
        { type = 111, id = 483, name = "Monster Hunter's Gear Rack" },
        { type = 111, id = 484, name = "Advanced Dragonriding" },
        { type = 111, id = 485, name = "Shikaar Hunting Tactics" },
        { type = 111, id = 487, name = "Clan Teerai Progression" },
        { type = 111, id = 488, name = "Tuskarr Fishing" },
        { type = 111, id = 492, name = "Cobalt Assembly Arcana" },
    },
    Shadowlands = {
        order = increment(),
        { type = 111, id = 150, name = "Unnamed research" },
        { type = 111, id = 272, name = "Nadjia the Mistblade" },
        { type = 111, id = 327, name = "Bastion - Resevoir Upgrades" },
        { type = 111, id = 328, name = "Ardenweald - Resevoir Upgrades" },
        { type = 111, id = 329, name = "Maldraxxus- Resevoir Upgrades" },
        { type = 111, id = 326, name = "Revendreth - Resevoir Upgrades" },
        { type = 111, id = 465, name = "Device Upgrade Console" },
        { type = 111, id = 466, name = "Progenitor Core" },
    },
    BFA = {
        order = increment(),
        { type = 9, id = 468, name = "Progenitor Core JZB" },
        { type = 9, id = 260, name = "Visions Research [NYI]" },
        { type = 9, id = 263, name = "MOTHER's Research - Solo" },
        { type = 9, id = 264, name = "MOTHER's Research - Group" },
        { type = 9, id = 265, name = "MOTHER's Research - Gambler" },
        { type = 9, id = 266, name = "MOTHER's Research - Speedrunner" },
        { type = 9, id = 267, name = "MOTHER's Research - Explorer" },
        { type = 9, id = 268, name = "MOTHER's Research - Milestones" },
    },
    Legion = {
        order = increment(),
        { type = 3, id = 335, name = "Chris Test Tree Set" },
    },
}

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, _, addonName)
    if addonName == name then
        ResearchViewer:OnInitialize()
    end
    if addonName == "Blizzard_OrderHallUI" then
        ResearchViewer:MakeDropDownButton(OrderHallTalentFrame)
        OrderHallTalentFrame:HookScript("OnHide", function()
            ResearchViewer.selectedTreeInfo = nil
        end)
    end
    if addonName == "Blizzard_GenericTraitUI" then
        ResearchViewer:MakeDropDownButton(GenericTraitFrame)
        GenericTraitFrame:HookScript("OnHide", function()
            ResearchViewer.selectedTreeInfo = nil
        end)
    end
end)

function ResearchViewer:OnInitialize()
    ResearchViewerDB = ResearchViewerDB or {}
    ResearchViewerCharDB = ResearchViewerCharDB or { lastSelected = ResearchViewerDB.lastSelected }
    self.db = ResearchViewerDB
    self.charDb = ResearchViewerCharDB

    if not self.db.ldbOptions then
        self.db.ldbOptions = {
            hide = false,
        }
    end

    local original = C_Garrison.GetCurrentGarrTalentTreeID
    C_Garrison.GetCurrentGarrTalentTreeID = function() ---@diagnostic disable-line: duplicate-set-field
        if self.selectedTreeInfo then return self.selectedTreeInfo.id end

        return original()
    end

    local ResearchViewerLDB = LibStub("LibDataBroker-1.1"):NewDataObject(
        name,
        {
            type = "launcher",
            text = "Research Viewer",
            icon = "interface/icons/inv_misc_book_11.blp",
            OnClick = function()
                if IsShiftKeyDown() then
                    self.db.ldbOptions.hide = true
                    LibDBIcon:Hide(name)
                    return
                end
                self:ToggleUI()
            end,
            OnTooltipShow = function(tooltip)
                tooltip:AddLine("Research Viewer")
                tooltip:AddLine("|cffeda55fClick|r to view various research/generic talent trees from the field.")
                tooltip:AddLine("|cffeda55fShift-Click|r to hide this button. ('/rv reset' to restore)")
            end,
        }
    )
    LibDBIcon:Register("ResearchViewer", ResearchViewerLDB, self.db.ldbOptions)

    EventRegistry:RegisterCallback('GarrisonTalentButtonMixin.TalentTooltipShown',
        function(self, tooltip, talentInfo, talentTreeId)
            local talentId = talentInfo.id

            if(talentId) then
                local text = "|cFFEE6161Order Advancement ID|r " .. talentId
                if(not self:AlreadyAdded(text, tooltip)) then
                    tooltip:AddLine(text)
                end
                tooltip:Show()
            end
        end,
        self
    )

    SLASH_RESEARCH_VIEWER1 = "/rv"
    SLASH_RESEARCH_VIEWER2 = "/researchviewer"
    SlashCmdList["RESEARCH_VIEWER"] = function(message)
        if message == "reset" then
            wipe(ResearchViewer.db.ldbOptions)
            ResearchViewer.db.ldbOptions.hide = false
            ResearchViewer.charDb.lastSelected = nil

            LibDBIcon:Hide(name)
            LibDBIcon:Show(name)
            return
        end
        ResearchViewer:ToggleUI()
    end

    -- the first time you get tree info after launching the game, it's very slow
    -- so instead of having a full second of lag when you open the research viewer,
    -- we'll just get the info now, and spread it out a bit over time
    local treeIDList = GetValuesArray(self:GetTreeList())
    local ticker
    local i = 0
    ticker = C_Timer.NewTicker(0.2, function()
        i = i + 1
        local treeID = treeIDList[i]
        if not treeID then
            ticker:Cancel()
            return
        end
        ResearchViewer:TreeExists(treeID)
    end)
end

--- @return table<number, number>
function ResearchViewer:GetTreeList(treeList, tables)
    treeList = treeList or {}
    tables = tables or { ni = self.neverImplemented, tt = self.talentTrees }

    for key, value in pairs(tables) do
        if value and type(key) == "number" then
            if value.id and not value.isTraitTree then
                treeList[value.id] = value.id
            end
        elseif value and key ~= "order" then
            self:GetTreeList(treeList, value)
        end
    end

    return treeList
end

function ResearchViewer:GetOrderedTreeIDs(list, subItems)
    list = list or {}
    if not subItems then
        subItems = CreateFromMixins(self.talentTrees)
        subItems["Never Implemented"] = CreateFromMixins(self.neverImplemented)
        subItems["Never Implemented"].order = 1000
    end

    local temp = {}
    local orderOffset = #subItems + 10
    for key, value in pairs(subItems) do
        if value and type(key) == "number" then
            if not value.special then
                table.insert(temp, { id = value.id, order = key })
            end
        elseif value and key ~= "order" then
            table.insert(temp, { subItems = value, order = value.order + orderOffset })
        end
    end
    table.sort(temp, function(a, b) return a.order < b.order end)

    for _, entry in ipairs(temp) do
        if entry.id then
            table.insert(list, entry.id)
        else
            self:GetOrderedTreeIDs(list, entry.subItems)
        end
    end

    return list
end

function ResearchViewer:AlreadyAdded(textLine, tooltip)
    if textLine == nil then
        return false
    end

    for i = 1,15 do
        local tooltipFrame = _G[tooltip:GetName() .. "TextLeft" .. i]
        local textRight = _G[tooltip:GetName().."TextRight"..i]
        local text, right
        if tooltipFrame then text = tooltipFrame:GetText() end
        if text and string.find(text, textLine, 1, true) then return true end
        if textRight then right = textRight:GetText() end
        if right and string.find(right, textLine, 1, true) then return true end
    end
end

--- @param parent GenericTraitFrame|OrderHallTalentFrame
function ResearchViewer:MakeDropDownButton(parent)
    local dropdown = CreateFrame("DropdownButton", nil, parent, "WowStyle1DropdownTemplate");

    dropdown:OverrideText("Select another tree")
    dropdown:SetWidth(165)
    dropdown:SetPoint("TOPRIGHT", 10, 20)
    dropdown:EnableMouseWheel(true)
    function dropdown:PickTreeID(treeID)
        MenuUtil.TraverseMenu(self:GetMenuDescription(), function(description)
            if description.data and description.data.id == treeID then
                self:Pick(description, MenuInputContext.None)
            end
        end)
    end
    function dropdown:Increment()
        if not ResearchViewer.selectedTreeInfo then return end
        local currentTreeID = ResearchViewer.selectedTreeInfo.id
        local currentIndex = ResearchViewer.orderedTreeIDsMap[currentTreeID]
        local nextIndex = currentIndex + 1
        if nextIndex > #ResearchViewer.orderedTreeIDs then
            nextIndex = 1
        end
        self:PickTreeID(ResearchViewer.orderedTreeIDs[nextIndex])
    end
    function dropdown:Decrement()
        if not ResearchViewer.selectedTreeInfo then return end
        local currentTreeID = ResearchViewer.selectedTreeInfo.id
        local currentIndex = ResearchViewer.orderedTreeIDsMap[currentTreeID]
        local nextIndex = currentIndex - 1
        if nextIndex < 1 then
            nextIndex = #ResearchViewer.orderedTreeIDs
        end
        self:PickTreeID(ResearchViewer.orderedTreeIDs[nextIndex])
    end

    dropdown:SetupMenu(function(_, rootDescription)
        self:GenerateMenu(rootDescription, parent)
    end)

    if C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI then
        ElvUI[1]:GetModule("Skins"):HandleDropDownBox(dropdown)
    end

    return dropdown
end

function ResearchViewer:ToggleUI()
    self.selectedTreeInfo = self.charDb and self.charDb.lastSelected or nil
    if self.selectedTreeInfo and not self.selectedTreeInfo.id then self.selectedTreeInfo = nil end
    if not self.selectedTreeInfo then
        for _, value in ipairs(self.talentTrees['The War Within']) do
            local isAvailable = (value.isTraitTree and self:TraitTreeExists(value.id)) or (not value.isTraitTree and self:TreeExists(value.id))
            if isAvailable then
                self.selectedTreeInfo = value
                break
            end
        end
        if not self.selectedTreeInfo then
            for _, value in ipairs(self.talentTrees['Dragonflight']) do
                local isAvailable = (value.isTraitTree and self:TraitTreeExists(value.id)) or (not value.isTraitTree and self:TreeExists(value.id))
                if isAvailable then
                    self.selectedTreeInfo = value
                    break
                end
            end
        end
    end
    if self.selectedTreeInfo.isTraitTree then
        if GenericTraitFrame and GenericTraitFrame:IsShown() then
            HideUIPanel(GenericTraitFrame)
        else
            if not self:OpenGenericTalentTree(self.selectedTreeInfo.id) then
                self.charDb.lastSelected = nil
                self:ToggleUI()
            end
        end
    else
        if OrderHallTalentFrame and OrderHallTalentFrame:IsShown() then
            HideUIPanel(OrderHallTalentFrame)
        else
            self:OpenSelectedResearch()
        end
    end
end

function ResearchViewer:OpenGenericTalentTree(treeID)
    if not self:TraitTreeExists(treeID) then
        return false;
    end

    self.charDb.lastSelected = self.selectedTreeInfo
    local systemID = C_Traits.GetSystemIDByTreeID(treeID)

    GenericTraitUI_LoadUI();
    GenericTraitFrame:Hide();
    GenericTraitFrame:SetSystemID(systemID);
    GenericTraitFrame:SetTreeID(treeID);
    ShowUIPanel(GenericTraitFrame);
    if GenericTraitFrame:GetNumPoints() == 0 then
        GenericTraitFrame:SetPoint('TOPLEFT', 16, -116); -- roughly where it would normally open
    end
    if not tIndexOf(UISpecialFrames, 'GenericTraitFrame') then
        table.insert(UISpecialFrames, 'GenericTraitFrame');
    end

    return true;
end

function ResearchViewer:OpenSelectedResearch()
    self.charDb.lastSelected = self.selectedTreeInfo
    OrderHall_LoadUI()
    OrderHallTalentFrame:SetGarrisonType(self.selectedTreeInfo.type, self.selectedTreeInfo.id)
    ShowUIPanel(OrderHallTalentFrame);
end

local treeExistsCache = {}
function ResearchViewer:TreeExists(treeId)
    if treeExistsCache[treeId] ~= nil then
        return treeExistsCache[treeId]
    end
    local treeInfo = C_Garrison.GetTalentTreeInfo(treeId)

    local exists = treeInfo and treeInfo.treeID == treeId
    treeExistsCache[treeId] = exists

    return exists
end

function ResearchViewer:TraitTreeExists(treeID)
    return not not C_Traits.GetConfigIDByTreeID(treeID)
end

--- @param rootDescription RootMenuDescriptionProxy
--- @param owner GenericTraitFrame|OrderHallTalentFrame
function ResearchViewer:GenerateMenu(rootDescription, owner)
    if not self.orderedTreeIDs then
        self.orderedTreeIDs = self:GetOrderedTreeIDs()
        self.orderedTreeIDsMap = tInvert(self.orderedTreeIDs)
    end
    local function openTree(data)
        HideUIPanel(owner)

        self.selectedTreeInfo = data
        if data.isTraitTree then
            HideUIPanel(GenericTraitFrame)

            self:OpenGenericTalentTree(data.id)
        else
            HideUIPanel(OrderHallTalentFrame)

            self:OpenSelectedResearch()
        end
    end
    local function isSelected(data)
        if self.selectedTreeInfo then
            return
                data[(self.selectedTreeInfo.isTraitTree and 'T' or 'R') .. self.selectedTreeInfo.id]
                or (
                    data.id == self.selectedTreeInfo.id
                    and (data.type == self.selectedTreeInfo.type or data.isTraitTree == self.selectedTreeInfo.isTraitTree)
                )
        elseif owner == GenericTraitFrame and GenericTraitFrame:GetTalentTreeID() then
            return
                data.isTraitTree and data.id == GenericTraitFrame:GetTalentTreeID()
                or (
                    data['T' .. GenericTraitFrame:GetTalentTreeID()]
                )
        end

        return false
    end

    rootDescription:CreateTitle('Select another tree')
    self:GenerateSubMenuButtons(rootDescription, self.talentTrees, isSelected, openTree)
    local neverImplementedData = {}
    local neverImplemented = rootDescription:CreateRadio("Never Implemented", isSelected, nil, neverImplementedData)
    self:GenerateSubMenuButtons(neverImplemented, self.neverImplemented, isSelected, openTree, { neverImplementedData })
end

--- @param parentDescription RootMenuDescriptionProxy|ElementMenuDescriptionProxy
--- @param list table
--- @param setSelectedFunc fun(data: any)
--- @param isSelectedFunc fun(data: any): boolean
function ResearchViewer:GenerateSubMenuButtons(parentDescription, list, isSelectedFunc, setSelectedFunc, parentDataTables)
    local orderedList = {}
    local notAvailableList = {}
    local orderOffset = #list + 10
    for key, value in pairs(list) do
        if type(key) == "number" then
            local treeExists = (value.isTraitTree and self:TraitTreeExists(value.id)) or (not value.isTraitTree and self:TreeExists(value.id))
            table.insert(
                treeExists and orderedList or notAvailableList,
                {
                    name = ("%s (%s%d%s)"):format(value.name, (value.isTraitTree and 'T' or 'R'), value.id, (treeExists and '' or ' - not available')),
                    order = key,
                    value = value,
                    isTree = true,
                }
            )
        elseif key ~= "order" then
            table.insert(orderedList, { name = key, order = value.order + orderOffset, value = value, isTree = false })
        end
    end
    table.sort(orderedList, function(a, b) return a.order < b.order end)

    for _, entry in ipairs(orderedList) do
        local data
        if entry.isTree then
            data = entry.value
            if parentDataTables then
                for _, parentData in ipairs(parentDataTables) do
                    parentData[(entry.value.isTraitTree and 'T' or 'R') .. entry.value.id] = true
                end
            end
        else
            data = {}
        end
        local subMenuButton = parentDescription:CreateRadio(entry.name, isSelectedFunc, entry.isTree and setSelectedFunc or nil, data)
        if not entry.isTree then
            local dataTables = CreateFromMixins(parentDataTables or {})
            table.insert(dataTables, data)
            self:GenerateSubMenuButtons(subMenuButton, entry.value, isSelectedFunc, setSelectedFunc, dataTables)
        end
    end
    if next(notAvailableList) then
        local dataTables = CreateFromMixins(parentDataTables or {})
        local data = {}
        table.insert(dataTables, data)
        local subParent = parentDescription:CreateRadio("Not Available", isSelectedFunc, nil, data)
        for _, entry in ipairs(notAvailableList) do
            subParent:CreateRadio(entry.name, isSelectedFunc, nil, entry.value)
            for _, parentData in ipairs(dataTables) do
                parentData[(entry.value.isTraitTree and 'T' or 'R') .. entry.value.id] = true
            end
        end
    end
end
