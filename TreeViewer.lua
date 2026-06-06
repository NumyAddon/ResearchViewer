local name = ...
--- @class ResearchViewerNS
local ns = select(2, ...)
local TreeViewer = {}
ns.TreeViewer = TreeViewer

local NODE_SIZE = 30
local ENTRY_SIZE = 28
local ENTRY_SPACING = 4
local SELECTOR_PADDING = 6
local PADDING = 48
local ID_COLOR = "|cFFEE6161"
local NODE_FRAME_LEVEL = 20
local MIN_FRAME_WIDTH = 420
local MIN_FRAME_HEIGHT = 280
local MIN_CONTENT_SIZE = 200
local FRAME_CHROME_WIDTH = 24 -- left + right inset
local FRAME_CHROME_HEIGHT = 64 -- title area + bottom inset

function TreeViewer:GetMaxFrameSize()
    return UIParent:GetWidth() * 0.9, UIParent:GetHeight() * 0.85
end

function TreeViewer:GetTreeBounds(nodes)
    local minX, maxX, minY, maxY = math.huge, -math.huge, math.huge, -math.huge
    for _, node in pairs(nodes) do
        local x = node.posX / 10
        local y = node.posY / 10
        minX = math.min(minX, x)
        maxX = math.max(maxX, x)
        minY = math.min(minY, y)
        maxY = math.max(maxY, y)
    end
    return minX, maxX, minY, maxY
end

function TreeViewer:GetContentSize(minX, maxX, minY, maxY)
    local width = (maxX - minX) + NODE_SIZE + (PADDING * 2)
    local height = (maxY - minY) + NODE_SIZE + (PADDING * 2)
    return math.max(width, MIN_CONTENT_SIZE), math.max(height, MIN_CONTENT_SIZE)
end

function TreeViewer:GetFrameSize(contentWidth, contentHeight)
    local maxWidth, maxHeight = self:GetMaxFrameSize()
    local width = math.min(maxWidth, math.max(MIN_FRAME_WIDTH, contentWidth + FRAME_CHROME_WIDTH))
    local height = math.min(maxHeight, math.max(MIN_FRAME_HEIGHT, contentHeight + FRAME_CHROME_HEIGHT))
    return width, height
end

function TreeViewer:GetTreeData(treeID)
    return ns.data.trees[treeID]
end

function TreeViewer:GetPrimarySpellId(node, treeData)
    if node.spellId and node.spellId > 0 then
        return node.spellId
    end
    for _, entryId in ipairs(node.entryIds or {}) do
        local entry = treeData.entries and treeData.entries[entryId]
        if entry and entry.spellId and entry.spellId > 0 then
            return entry.spellId
        end
    end
end

function TreeViewer:GetEntrySpellId(entryId, node, treeData)
    local entry = treeData.entries and treeData.entries[entryId]
    if entry and entry.spellId and entry.spellId > 0 then
        return entry.spellId
    end
    if node.spellId and node.spellId > 0 then
        return node.spellId
    end
end

function TreeViewer:PickDisplayField(node, entry, field)
    local value = entry and entry[field]
    if field == 'overrideIcon' then
        if value and value > 0 then
            return value
        end
        value = node[field]
        if value and value > 0 then
            return value
        end
        return
    end

    if value and value ~= "" then
        return value
    end
    value = node[field]
    if value and value ~= "" then
        return value
    end
end

function TreeViewer:GetDisplayInfo(node, treeData, entryId)
    local entry = entryId and treeData.entries and treeData.entries[entryId]

    return {
        spellId = entryId and self:GetEntrySpellId(entryId, node, treeData) or self:GetPrimarySpellId(node, treeData),
        overrideIcon = self:PickDisplayField(node, entry, 'overrideIcon'),
        overrideAtlas = self:PickDisplayField(node, entry, 'overrideAtlas'),
        overrideName = self:PickDisplayField(node, entry, 'overrideName'),
        overrideDescription = self:PickDisplayField(node, entry, 'overrideDescription'),
    }
end

function TreeViewer:SetDisplayIcon(texture, displayInfo)
    if displayInfo.overrideIcon and displayInfo.overrideIcon > 0 then
        texture:SetTexture(displayInfo.overrideIcon)
        return
    end

    if displayInfo.overrideAtlas and displayInfo.overrideAtlas ~= "" then
        texture:SetAtlas(displayInfo.overrideAtlas)
        return
    end

    if displayInfo.spellId then
        local iconTexture = C_Spell.GetSpellTexture(displayInfo.spellId)
        if iconTexture then
            texture:SetTexture(iconTexture)
            return
        end
    end

    texture:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
end

function TreeViewer:ShowEntryTooltip(owner, nodeID, entryId, node, treeData)
    GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")
    owner.UpdateTooltip = function() self:ShowEntryTooltip(owner, nodeID, entryId, node, treeData) end

    local displayInfo = self:GetDisplayInfo(node, treeData, entryId)
    local hasOverrideName = displayInfo.overrideName and displayInfo.overrideName ~= ""
    local hasOverrideDescription = displayInfo.overrideDescription and displayInfo.overrideDescription ~= ""

    if hasOverrideName then
        GameTooltip:AddLine(displayInfo.overrideName, 1, 1, 1)
    end
    if hasOverrideDescription then
        GameTooltip:AddLine(displayInfo.overrideDescription, nil, nil, nil, true)
    end
    if not hasOverrideName and not hasOverrideDescription and displayInfo.spellId then
        if GetSpellInfo(displayInfo.spellId) then
            GameTooltip:SetSpellByID(displayInfo.spellId)
        else
            GameTooltip:AddLine("Unknown Spell")
        end
    end

    if hasOverrideName or hasOverrideDescription or displayInfo.spellId then
        GameTooltip:AddLine(" ")
    end

    GameTooltip:AddLine((ID_COLOR .. "Node ID|r %d"):format(nodeID))

    if entryId then
        GameTooltip:AddLine((ID_COLOR .. "Entry ID|r %d"):format(entryId))
        GameTooltip:AddLine((ID_COLOR .. "Spell ID|r %s"):format(displayInfo.spellId or "n/a"))
    else
        GameTooltip:AddLine(ID_COLOR .. "Entry ID|r n/a")
        GameTooltip:AddLine((ID_COLOR .. "Spell ID|r %s"):format(displayInfo.spellId or "n/a"))
    end

    GameTooltip:Show()
end

function TreeViewer:ShowNodeTooltip(owner, nodeID, node, treeData, entryId)
    self:ShowEntryTooltip(owner, nodeID, entryId or (node.entryIds or {})[1], node, treeData)
end

function TreeViewer:CancelEntrySelectorHide()
    if self.entrySelectorHideTimer then
        self.entrySelectorHideTimer:Cancel()
        self.entrySelectorHideTimer = nil
    end
end

function TreeViewer:HideEntrySelector()
    self:CancelEntrySelectorHide()
    if self.entrySelector then
        self.entrySelector:Hide()
        self.entrySelector:ClearAllPoints()
    end
    self.activeEntryNodeButton = nil
end

function TreeViewer:ScheduleEntrySelectorHide()
    self:CancelEntrySelectorHide()
    self.entrySelectorHideTimer = C_Timer.NewTimer(0.15, function()
        self:HideEntrySelector()
        GameTooltip_Hide()
    end)
end

function TreeViewer:GetOrCreateEntrySelector()
    if self.entrySelector then
        return self.entrySelector
    end

    local selector = CreateFrame("Frame", "ResearchViewerEntrySelector", self.frame, "BackdropTemplate")
    selector:SetFrameStrata("DIALOG")
    selector:SetFrameLevel(200)
    selector:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    selector:SetBackdropColor(0.05, 0.05, 0.05, 0.92)
    selector:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
    selector:Hide()
    selector.entryButtons = {}

    selector:SetScript("OnEnter", function()
        self:CancelEntrySelectorHide()
    end)
    selector:SetScript("OnLeave", function()
        self:ScheduleEntrySelectorHide()
    end)

    self.entrySelector = selector
    return selector
end

function TreeViewer:ShowEntrySelector(anchorButton, nodeID, node, treeData)
    local entryIds = node.entryIds or {}
    if #entryIds <= 1 then
        self:HideEntrySelector()
        return
    end

    local selector = self:GetOrCreateEntrySelector()
    self:CancelEntrySelectorHide()
    self.activeEntryNodeButton = anchorButton

    for _, button in ipairs(selector.entryButtons) do
        button:Hide()
    end

    local previousButton
    for index, entryId in ipairs(entryIds) do
        local entryButton = selector.entryButtons[index]
        if not entryButton then
            entryButton = CreateFrame("Button", nil, selector)
            entryButton:SetSize(ENTRY_SIZE, ENTRY_SIZE)
            entryButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")

            local icon = entryButton:CreateTexture(nil, "ARTWORK")
            icon:SetAllPoints()
            icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            entryButton.icon = icon

            selector.entryButtons[index] = entryButton
        end

        entryButton:ClearAllPoints()
        if previousButton then
            entryButton:SetPoint("LEFT", previousButton, "RIGHT", ENTRY_SPACING, 0)
            entryButton:SetPoint("TOP", selector, "TOP", 0, -SELECTOR_PADDING)
        else
            entryButton:SetPoint("TOPLEFT", selector, "TOPLEFT", SELECTOR_PADDING, -SELECTOR_PADDING)
        end

        local displayInfo = self:GetDisplayInfo(node, treeData, entryId)
        self:SetDisplayIcon(entryButton.icon, displayInfo)

        entryButton:SetScript("OnEnter", function(btn)
            self:CancelEntrySelectorHide()
            self:ShowEntryTooltip(btn, nodeID, entryId, node, treeData)
        end)
        entryButton:SetScript("OnLeave", function()
            GameTooltip_Hide()
        end)
        entryButton:Show()

        previousButton = entryButton
    end

    local selectorWidth = SELECTOR_PADDING + (#entryIds * ENTRY_SIZE) + ((#entryIds - 1) * ENTRY_SPACING) + SELECTOR_PADDING
    selector:SetSize(selectorWidth, ENTRY_SIZE + (SELECTOR_PADDING * 2))
    selector:ClearAllPoints()
    selector:SetPoint("LEFT", anchorButton, "RIGHT", 2, 0)
    selector:Show()
end

function TreeViewer:ResetCanvas()
    local canvas = self.frame.canvas
    if canvas.linePool then
        canvas.linePool:ReleaseAll()
    end
    if canvas.nodePool then
        canvas.nodePool:ReleaseAll()
    end
    canvas.nodeFrames = {}
end

function TreeViewer:MakeLine(sourceButton, targetButton)
    local canvas = self.frame.canvas
    local line, isNew = canvas.linePool:Acquire()
    if isNew then
        line:SetThickness(2)
    end
    line:SetColorTexture(1, 0.82, 0) -- #ffd100 -- yellow
    line:SetStartPoint("CENTER", sourceButton)
    line:SetEndPoint("CENTER", targetButton)
    line:Show()
end

--- @return ResearchViewerTreeFrame
function TreeViewer:InitFrame()
    if self.frame then
        return self.frame
    end

    --- @class ResearchViewerTreeFrame: Frame, BasicFrameTemplateWithInset
    local frame = CreateFrame("Frame", "ResearchViewerTreeFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(MIN_FRAME_WIDTH, MIN_FRAME_HEIGHT)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetToplevel(true)
    frame:Hide()
    table.insert(UISpecialFrames, "ResearchViewerTreeFrame")

    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.title:SetPoint("TOP", 0, -5)

    frame.subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    frame.subtitle:SetPoint("TOP", frame.title, "BOTTOM", 0, -16)

    local canvas = CreateFrame("Frame", nil, frame)
    frame.canvas = canvas
    --- @type FramePool<Button>
    canvas.nodePool = CreateFramePool("Button", canvas)
    --- @type ObjectPool<Line>
    canvas.linePool = CreateObjectPool(
        function()
            return canvas:CreateLine()
        end,
        function(_, line)
            line:Hide()
        end
    )
    canvas.nodeFrames = {}

    ResearchViewer:MakeDropDownButton(frame)
    frame:HookScript("OnHide", function()
        if ResearchViewer.openingUI then return end
        ResearchViewer.selectedTreeInfo = nil
        self:HideEntrySelector()
    end)

    --- @type BlizzMoveAPI?
    local BlizzMoveAPI = _G.BlizzMoveAPI
    if BlizzMoveAPI then
        BlizzMoveAPI:RegisterAddOnFrames({
            [name] = {
                [frame:GetName()] = {},
            },
        })
    end

    self.frame = frame

    return frame
end

function TreeViewer:Hide()
    self:HideEntrySelector()
    if self.frame then
        self.frame:Hide()
    end
end

function TreeViewer:Show(treeID, treeName)
    local treeData = self:GetTreeData(treeID)
    if not treeData or not treeData.nodes then
        return false
    end

    local frame = self:InitFrame()
    frame.title:SetText(treeName .. " (T" .. treeID .. " - preview)")
    frame.subtitle:SetText("This is a preview render, since you've not unlocked this tree (yet)")

    local canvas = frame.canvas
    self:ResetCanvas()
    self:HideEntrySelector()

    local minX, maxX, minY, maxY = self:GetTreeBounds(treeData.nodes)

    if minX == math.huge then
        return false
    end

    local contentWidth, contentHeight = self:GetContentSize(minX, maxX, minY, maxY)
    canvas:ClearAllPoints()
    canvas:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -52)
    canvas:SetSize(contentWidth, contentHeight)

    local frameWidth, frameHeight = self:GetFrameSize(contentWidth, contentHeight)
    frame:SetSize(frameWidth, frameHeight)

    canvas.nodeFrames = {}
    for nodeID, node in pairs(treeData.nodes) do
        local x = PADDING + ((node.posX / 10) - minX)
        local y = -PADDING - ((node.posY / 10) - minY)

        local button, isNew = canvas.nodePool:Acquire()
        if isNew then
            button:SetSize(NODE_SIZE, NODE_SIZE)
            button.icon = button:CreateTexture(nil, "ARTWORK")
            button.icon:SetAllPoints()
            button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        end
        button:ClearAllPoints()
        button:SetPoint("TOPLEFT", canvas, "TOPLEFT", x, y)
        button:SetFrameLevel(NODE_FRAME_LEVEL)

        local entryIds = node.entryIds or {}
        local displayInfo = self:GetDisplayInfo(node, treeData, entryIds[1])
        self:SetDisplayIcon(button.icon, displayInfo)

        button.node = node
        button.nodeID = nodeID
        button.treeData = treeData

        button:SetScript("OnEnter", function(btn)
            local nodeEntryIds = node.entryIds or {}
            if #nodeEntryIds > 1 then
                GameTooltip_Hide()
                self:ShowEntrySelector(btn, nodeID, node, treeData)
            else
                self:HideEntrySelector()
                self:ShowNodeTooltip(btn, nodeID, node, treeData)
            end
        end)
        button:SetScript("OnLeave", function()
            local nodeEntryIds = node.entryIds or {}
            if #nodeEntryIds > 1 then
                self:ScheduleEntrySelectorHide()
            else
                GameTooltip_Hide()
            end
        end)
        button:Show()

        canvas.nodeFrames[nodeID] = button
    end

    for nodeID, node in pairs(treeData.nodes) do
        local sourceButton = canvas.nodeFrames[nodeID]
        if sourceButton and node.edges then
            for _, edge in ipairs(node.edges) do
                local targetButton = canvas.nodeFrames[edge.targetNode] or canvas.nodeFrames[tonumber(edge.targetNode)]
                if targetButton then
                    self:MakeLine(sourceButton, targetButton)
                end
            end
        end
    end

    frame:Show()
    return true
end

function TreeViewer:Toggle(treeID, treeName)
    if self.frame and self.frame:IsShown() and self.currentTreeID == treeID then
        self:Hide()
        return true
    end

    if self:Show(treeID, treeName) then
        self.currentTreeID = treeID
        return true
    end

    return false
end
