---@type GL
local _, GL = ...;

---@class PackMuleIgnoredItems
GL:tableSet(GL, "Interface.PackMule.IgnoredItems", {
    isVisible = false,

    Rows = {},
});

local AceGUI = GL.AceGUI;
local IgnoredItems = GL.Interface.PackMule.IgnoredItems; ---@type PlusOnesOverview

---@return void
function IgnoredItems:draw()
    GL:debug("Overview:draw");

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(400);
    Window:SetHeight(500);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:EnableResize(false);
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    GL.Interface:setItem(self, "Window", Window);
    Window:SetPoint(GL.Interface:getPosition("PlusOnesOverview"));
    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_PACKMULE_IGNORED_ITEMS_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_PACKMULE_IGNORED_ITEMS_WINDOW");

    -- LABEL: Info about PackMule
    local Info = AceGUI:Create("Label");
    Info:SetText("By default PackMule ignores all the items listed below unless you create a specific rule for it in /gl pm. Feel like an item is missing then please leave a message in Discord!");
    Info:SetFullWidth(true);
    Info:SetJustifyH("CENTER");
    Info:SetFontObject(_G["GameFontNormal"]);
    Window:AddChild(Info);

    local ItemSearchBox = GL.AceGUI:Create("EditBox");
    ItemSearchBox:DisableButton(false);
    ItemSearchBox:SetHeight(20);
    ItemSearchBox:SetFullWidth(true);
    ItemSearchBox:SetText("");
    ItemSearchBox:SetLabel(string.format(
        "Search using an item Name or ID",
        GL:classHexColor("rogue")
    ));
    ItemSearchBox:SetCallback("OnEnterPressed", function (EditBox)
        self:searchItem(EditBox:GetText());
    end);
    GL.Interface:setItem(self, "Search", ItemSearchBox);
    Window:AddChild(ItemSearchBox);

    local ScrollFrameParent = AceGUI:Create("SimpleGroup");
    ScrollFrameParent:SetLayout("Fill");
    ScrollFrameParent:SetFullWidth(true);
    ScrollFrameParent:SetHeight(318);
    Window:AddChild(ScrollFrameParent);
    GL.Interface:setItem(self, "IgnoredItemsFrame", ScrollFrameParent);

    self:searchItem("");
end

--- Search for an item based on its name or ID
---
---@param search string
---@return void
function IgnoredItems:searchItem(search)
    GL:debug("IgnoredItems:searchItem");

    local SearchBox = GL.Interface:getItem(self, "EditBox.Search");
    local ScrollFrameParent = GL.Interface:getItem(self, "Frame.IgnoredItemsFrame");

    if (not SearchBox
        or not ScrollFrameParent
    ) then
        return;
    end

    local OldScrollFrame = GL.Interface:getItem(self, "ScrollFrame.IgnoredItems");

    if (OldScrollFrame) then
        AceGUI:Release(OldScrollFrame);
    end

    local ScrollFrame = AceGUI:Create("ScrollFrame");
    ScrollFrame:SetLayout("Flow");
    ScrollFrameParent:AddChild(ScrollFrame);
    GL.Interface:setItem(self, "IgnoredItems", ScrollFrame);

    search = tostring(search);
    local concernsID;
    local showAll = GL:empty(search);

    if (not showAll) then
        concernsID = GL:higherThanZero(tonumber(search))
    end

    if (not concernsID) then
        search = string.lower(strtrim(search));
    end

    -- Make sure all items are loaded before we attempt to draw this overview
    GL:onItemLoadDo(GL.Data.Constants.UntradeableItems, function (Items)
        for _, Entry in pairs(Items) do
            local addRow = false;

            if (showAll) then
                addRow = true;
            elseif (concernsID
                and strfind(tostring(Entry.id), search)
            ) then
                addRow = true;
            elseif (strfind(string.lower(Entry.name), search)) then
                addRow = true;
            end

            if (addRow) then
                local IgnoredItemRow = AceGUI:Create("SimpleGroup");
                IgnoredItemRow:SetLayout("Flow");
                IgnoredItemRow:SetFullWidth(true);
                ScrollFrame:AddChild(IgnoredItemRow);

                --[[
                    ITEM ICON
                ]]
                local ItemIcon = AceGUI:Create("Icon");
                ItemIcon:SetWidth(30);
                ItemIcon:SetHeight(30);
                ItemIcon:SetImageSize(30, 30);
                ItemIcon:SetImage(Entry.icon);
                IgnoredItemRow:AddChild(ItemIcon);
                ItemIcon:SetCallback("OnLeave", function()
                    GameTooltip:Hide();
                end);

                --[[
                    ITEM ICON/LABEL SPACER
                ]]
                local IconSpacer = AceGUI:Create("SimpleGroup");
                IconSpacer:SetLayout("FILL")
                IconSpacer:SetWidth(10);
                IconSpacer:SetHeight(20);
                IgnoredItemRow:AddChild(IconSpacer);

                --[[
                    ITEM LABEL
                ]]
                local ItemLabel = AceGUI:Create("Label");
                ItemLabel:SetFontObject(_G["GameFontNormalSmall"]);
                ItemLabel:SetWidth(150);
                ItemLabel:SetText(Entry.link .. "\n#" .. Entry.id);
                IgnoredItemRow:AddChild(ItemLabel);
            end
        end
    end, false, function (a,b)
        return a.name < b.name;
    end);
end

--- Close the window and stop listening for plusone changes
---
---@return void
function IgnoredItems:close()
    GL:debug("Overview:close");

    if (not self.isVisible) then
        return;
    end

    local Window = GL.Interface:getItem(self, "Window");

    if (Window) then
        Window:Hide();
    end

    self.isVisible = false;
    GL.Interface:storePosition(Window, "PackMuleIgnoredItems");
end

GL:debug("Interfaces/PackMule/IgnoredItems.lua");