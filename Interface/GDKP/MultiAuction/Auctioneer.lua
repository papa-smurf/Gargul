local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

---@type GDKP
local GDKP = GL.GDKP;

---@type GroupVersionCheckInterface
local GroupVersionCheck = GL.Interface.GroupVersionCheck;

---@class GDKPMultiAuctionAuctioneerInterface
GL:tableSet(GL, "Interface.GDKP.MultiAuction.Auctioneer", {
    windowName = "Gargul.Interface.GDKP.MultiAuction.Auctioneer.Window",

    ItemRows = {},
});

---@type GDKPMultiAuctionAuctioneerInterface
local Auctioneer = GL.Interface.GDKP.MultiAuction.Auctioneer;

--[[ CONSTANTS ]]
local WINDOW_WIDTH = 383;
local WINDOW_HEIGHT = 333;
local FONT;

---@return Frame|nil
function Auctioneer:open()
    if (self:isShown()) then
        return;
    end

    FONT = GL.FONT;

    local Window = self:getWindow() or self:build();

    return Window:Show() and Window;
end

---@return void
function Auctioneer:close()
    local Window = self:getWindow() or self:build();

    Window:Hide();
end

---@return boolean
function Auctioneer:isShown()
    local Window = self:getWindow();

    return Window and Window:IsShown();
end

---@return void
function Auctioneer:addItemByLink(itemLink)
    local Window = self:getWindow();

    if (not Window) then
        return false;
    end

    Window:addItemByLink(itemLink);
end

---@return Frame
function Auctioneer:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    ---@type Frame
    local Window = Interface:createWindow{
        name = self.windowName,
        width = WINDOW_WIDTH,
        minWidth = WINDOW_WIDTH,
        height = WINDOW_HEIGHT,
        minHeight = WINDOW_HEIGHT,
        hideMinimizeButton = true,
    };

    --[[ THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        { text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end }
    }, 100);

    ---@type Frame
    local ItemHolder

    ---@type ScrollFrame
    local ScrollFrame;

    --[[ SELECT ALL ]]
    ---@type CheckButton
    local SelectAll = Interface:createCheckbox{
        Parent = Window,
        checked = true,
        callback = function (_, value)
            for _, Row in pairs(self.ItemRows or {}) do
                if (Row and Row._Select) then
                    Row._Select:SetChecked(value);
                end
            end
        end,
    };
    SelectAll:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -24);
    Interface:addTooltip(SelectAll, "Select / Disable all");

    --[[ SEARCH ]]
    ---@type EditBox
    local Search = Interface:inputBox(Window, nil, "Search name or iLVL");
    Search:SetWidth(150);
    Search:SetPoint("TOPLEFT", SelectAll, "TOPRIGHT", 20, 0);
    Interface:addTooltip(Search, "Supports item names and iLVL e.g. \"252\", \"<252\" etc");

    --[[ INCREMENT ]]
    ---@type FontString
    local IncLabel = Interface:createFontString(Window, L.INCREMENT);
    IncLabel:SetPoint("CENTER", Search, "CENTER");
    IncLabel:SetPoint("RIGHT", Window, "RIGHT", -50, 0);

    --[[ MINIMUM BID ]]
    ---@type FontString
    local MinLabel = Interface:createFontString(Window, L.MINIMUM);
    MinLabel:SetPoint("TOPRIGHT", IncLabel, "TOPLEFT", -20, 0);

    --[[ SCROLLFRAME BOILERPLATE ]]
    ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate")
    ScrollFrame:SetPoint("TOP", SelectAll, "BOTTOM", 0, -10);
    ScrollFrame:SetPoint("BOTTOM", Window, "BOTTOM", 0, 100);
    ScrollFrame:SetPoint("LEFT", Window, "LEFT", 16, 0);
    ScrollFrame:SetPoint("RIGHT", Window, "RIGHT", -44, 0);

    ItemHolder = CreateFrame("Frame");
    ScrollFrame:SetScrollChild(ItemHolder);
    ItemHolder:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
    ItemHolder:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT");
    ItemHolder:SetPoint("BOTTOMRIGHT", ScrollFrame, "BOTTOMRIGHT");

    ---@type Frame
    local Items = CreateFrame("Frame", nil, ItemHolder);
    Items:SetAllPoints(ItemHolder);

    --[[ ADD AN ITEM TO THE QUEUE WINDOW ]]
    local rowHeight = 20;
    Window.addItemByLink = function (_, link)
        GL:onItemLoadDo(GL:getItemIDFromLink(link), function (Details)
            if (not Details) then
                return;
            end

            ---@type Frame
            local ItemRow = CreateFrame("Frame", nil, ItemHolder);
            ItemRow:EnableMouse(true);

            ---@type table
            local PerItemSettings = GDKP:settingsForItemID(Details.id);
            ItemRow:SetHeight(rowHeight);
            ItemRow._itemLink = link;

            ItemRow:SetPoint("TOPLEFT", ItemHolder, "TOPLEFT", 20, (GL:count(self.ItemRows) * 20) * -1);
            ItemRow:SetPoint("TOPRIGHT", ItemHolder, "TOPRIGHT", not GL.elvUILoaded and 0 or -4, 0);

            --[[ SELECT ]]
            ---@type CheckButton
            local Select = Interface:createCheckbox{
                Parent = ItemRow,
                checked = true,
                callback = function (_, value)
                    -- Do stuff
                end,
            };
            ItemRow._Select = Select;
            Select:SetPoint("TOP", ItemRow, "TOP", 0, 2);
            Select:SetPoint("LEFT", SelectAll, "LEFT", 0, 0);

            ItemRow:SetScript("OnMouseUp", function ()
                Select:toggle();
            end);

            --[[ ITEM ICON ]]
            ---@type Frame
            local Icon = CreateFrame("Frame",nil, ItemRow);
            Icon:SetPoint("TOP", ItemRow, "TOP");
            Icon:SetPoint("LEFT", Search, "LEFT", -4, 0);
            Icon:SetSize(rowHeight - 4, rowHeight - 4);

            Interface:addTooltip(Icon, Details.link);

            ItemRow.Icon = Icon;

            ---@type Texture
            local Image = Icon:CreateTexture(nil, "BACKGROUND")
            Image:SetAllPoints(Icon);
            Image:SetTexture(Details.icon);

            --[[ MINIMUM ]]
            ---@type EditBox
            local MinInput = Interface:inputBox(ItemRow);
            MinInput:SetText(PerItemSettings.minimum);
            MinInput:SetWidth(42);
            MinInput:SetPoint("TOP", ItemRow, "TOP");
            MinInput:SetPoint("LEFT", MinLabel, "LEFT", 5, 0);
            MinInput:SetPoint("RIGHT", MinLabel, "RIGHT", 4, 0);
            ItemRow.MinInput = MinInput;

            --[[ INCREMENT ]]
            ---@type EditBox
            local IncInput = Interface:inputBox(ItemRow);
            IncInput:SetText(PerItemSettings.increment);
            IncInput:SetWidth(36);
            IncInput:SetPoint("TOP", ItemRow, "TOP");
            IncInput:SetPoint("LEFT", IncLabel, "LEFT", 5, 0);
            IncInput:SetPoint("RIGHT", IncLabel, "RIGHT", 4, 0);
            ItemRow.IncInput = IncInput;

            ---@type FontString
            local Name = Interface:createFontString(ItemRow, Details.link);
            Name:SetPoint("CENTER", Icon);
            Name:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
            Name:SetPoint("RIGHT", MinInput, "LEFT", -6, 0);
            Name:SetHeight(20);

            tinsert(self.ItemRows, ItemRow);
        end);
    end;

    --[[ HOW TO ADD ITEMS ]]
    ---@type FontString
    local AddItemsLabel = Interface:createFontString(Window, ("With this window open, %s items to add them to the list"):format(GL.Settings:get("ShortcutKeys.rollOffOrAuction")));
    AddItemsLabel:SetFont(.8, "OUTLINE");
    AddItemsLabel:SetColor("GRAY");
    AddItemsLabel:SetPoint("TOPLEFT", ScrollFrame, "BOTTOMLEFT", 10, -10);

    --[[ TIME ]]
    ---@type FontString
    local TimeLabel = Interface:createFontString(Window, "Auction time in seconds");
    TimeLabel:SetPoint("TOPLEFT", AddItemsLabel, "BOTTOMLEFT", 0, -6);

    ---@type EditBox
    local TimeInput = Interface:inputBox(Window);
    TimeInput:SetText(600);
    TimeInput:SetWidth(30);
    TimeInput:SetPoint("TOPLEFT", TimeLabel, "TOPRIGHT", 8, 4);

    --[[ ANTI SNIPE ]]
    ---@type FontString
    local AntiSnipeLabel = Interface:createFontString(Window, "Anti snipe in seconds");
    AntiSnipeLabel:SetPoint("CENTER", TimeLabel, "CENTER");
    AntiSnipeLabel:SetPoint("LEFT", TimeInput, "RIGHT", 4, 0);

    ---@type EditBox
    local AntiSnipeInput = Interface:inputBox(Window);
    AntiSnipeInput:SetText(10);
    AntiSnipeInput:SetWidth(20);
    AntiSnipeInput:SetPoint("TOPLEFT", AntiSnipeLabel, "TOPRIGHT", 8, 4);

    --[[ CLEAR ]]
    ---@type Button
    local Clear = Interface:dynamicPanelButton(Window, "Clear");
    Clear:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 20, 30);
    Clear:SetScript("OnClick", function ()
        self:clearItems();
    end);
    Interface:addTooltip(Clear, "Remove all items from the list", "TOP");

    --[[ FILL FROM INVENTORY ]]
    ---@type Button
    local FillFromInventory = Interface:dynamicPanelButton(Window, "Fill from inventory");
    FillFromInventory:SetPoint("TOPLEFT", Clear, "TOPRIGHT", 2, 0);
    FillFromInventory:SetScript("OnClick", function ()
        GL.Interface.GDKP.MultiAuction.FillFromInventory:open();
    end);
    Interface:addTooltip(FillFromInventory, "Add tradeable items from your inventory to the list", "TOP");

    --[[ NEXT STEP ]]
    ---@type Button
    local Next = Interface:dynamicPanelButton(Window, "Next");
    Next:SetPoint("CENTER", FillFromInventory, "CENTER");
    Next:SetPoint("RIGHT", Window, "RIGHT", -20, 0);
    Next:SetScript("OnClick", function ()
        GroupVersionCheck:open({
            {
                text = "Start",
                onClick = function (Results)
                    -- Everyone is up-to-date on Gargul, start!
                    if (GL:empty(Results.Outdated) and GL:empty(Results.Unresponsive)) then
                        GL.Interface.GDKP.MultiAuction.Client:open();
                        GroupVersionCheck:close();

                        return;
                    end

                    -- Start after double-checking if the user is OK with people potentially missing out
                    Interface.Dialogs.PopupDialog:open{
                        question = "Not everyone is up-to-date, are you sure you want to start the auction? Not everyone will be able to bid!",
                        OnYes = function ()
                            GL.Interface.GDKP.MultiAuction.Client:open();
                            GroupVersionCheck:close();
                        end,
                    };
                end,
                tooltip = "Start auctioning",
            },
            {
                text = "Cancel",
                onClick = function ()
                    GroupVersionCheck:close();
                    self:open();
                end,
                tooltip = "Go back to the item selector",
            },
        });

        self:close();
    end);
    Interface:addTooltip(Next, "Next step: check raider's add-on version for compatibility", "TOP");

    return Window;
end

---@return void
function Auctioneer:clearItems()
    local Window = self:getWindow();

    if (not Window) then
        return;
    end

    for key, Item in pairs(self.ItemRows or {}) do
        Interface:release(Item);
        self.ItemRows[key] = nil;
    end

    self.ItemRows = {};
end

---@return Frame
function Auctioneer:getWindow()
    return _G[self.windowName];
end