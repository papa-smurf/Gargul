---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class LootCouncilSettings
local LootCouncil = {
    description = "Let a loot council vote on players who roll for an item. Council members get |c00F7922E+|r and |c00F7922E-|r buttons in the roll window, the loot master sees the votes in the roll table. Votes can still come in after the roll timer ended.",
};
GL.Interface.Settings.LootCouncil = LootCouncil; ---@type LootCouncilSettings

---@return nil
function LootCouncil:draw(Parent)
    GL:debug("LootCouncilSettings:draw");

    local AceGUI = GL.AceGUI;

    Overview:drawCheckboxes({
        {
            label = "Enabled",
            description = "Rolled items are voted on by the loot council",
            setting = "LootCouncil.enabled",
        },
    }, Parent);

    Overview:drawSpacer(Parent, nil, 10);

    local QualityItems = {
        [0] = "0 - Poor (everything)",
        [1] = "1 - Common",
        [2] = "2 - Uncommon",
        [3] = "3 - Rare",
        [4] = "4 - Epic",
        [5] = "5 - Legendary",
    };

    local QualityLabel = AceGUI:Create("Label");
    QualityLabel:SetColor(1, .95686, .40784);
    QualityLabel:SetText("Loot threshold: the minimum quality an item needs to be voted on");
    QualityLabel:SetFullWidth(true);
    Parent:AddChild(QualityLabel);

    local minimumQuality = tonumber(GL.Settings:get("LootCouncil.minimumQuality", 0)) or 0;
    local Quality = AceGUI:Create("Dropdown");
    Quality:SetList(QualityItems);
    Quality:SetValue(minimumQuality);
    Quality:SetText(QualityItems[minimumQuality]);
    Quality:SetWidth(200);
    Quality:SetCallback("OnValueChanged", function ()
        GL.Settings:set("LootCouncil.minimumQuality", Quality:GetValue());
    end);
    Parent:AddChild(Quality);

    Overview:drawSpacer(Parent, nil, 10);

    local Heading = AceGUI:Create("Heading");
    Heading:SetFullWidth(true);
    Heading:SetText("Council members");
    Parent:AddChild(Heading);

    Overview:drawSpacer(Parent, nil, 5);

    local NameBox = AceGUI:Create("EditBox");
    NameBox:DisableButton(true);
    NameBox:SetLabel("Player name");
    NameBox:SetWidth(200);
    Parent:AddChild(NameBox);

    local MembersList = AceGUI:Create("SimpleGroup");
    MembersList:SetLayout("Flow");
    MembersList:SetFullWidth(true);

    local drawMembers;
    drawMembers = function ()
        MembersList:ReleaseChildren();

        for index, name in ipairs(GL.Settings:get("LootCouncil.Members", {})) do
            local Row = AceGUI:Create("SimpleGroup");
            Row:SetLayout("Flow");
            Row:SetFullWidth(true);
            MembersList:AddChild(Row);

            local Name = AceGUI:Create("Label");
            Name:SetText(name);
            Name:SetFontObject(_G.GameFontNormal);
            Name:SetWidth(200);
            Row:AddChild(Name);

            local RemoveButton = AceGUI:Create("Button");
            RemoveButton:SetText("Remove");
            RemoveButton:SetWidth(90);
            RemoveButton:SetCallback("OnClick", function ()
                local Members = GL:cloneTable(GL.Settings:get("LootCouncil.Members", {}));
                table.remove(Members, index);
                GL.Settings:set("LootCouncil.Members", Members);
                drawMembers();
            end);
            Row:AddChild(RemoveButton);
        end

        Parent:DoLayout();
    end;

    local AddButton = AceGUI:Create("Button");
    AddButton:SetText("Add");
    AddButton:SetWidth(90);
    AddButton:SetCallback("OnClick", function ()
        local name = strtrim(NameBox:GetText() or "");

        if (GL:empty(name)) then
            return;
        end

        local Members = GL:cloneTable(GL.Settings:get("LootCouncil.Members", {}));
        for _, existing in pairs(Members) do
            if (GL:playerNamesMatch(existing, name)) then
                return;
            end
        end

        table.insert(Members, name);
        GL.Settings:set("LootCouncil.Members", Members);
        NameBox:SetText("");
        drawMembers();
    end);
    Parent:AddChild(AddButton);

    Overview:drawSpacer(Parent, nil, 5);
    Parent:AddChild(MembersList);
    drawMembers();

    Overview:drawSpacer(Parent, nil, 10);

    local RanksLabel = AceGUI:Create("Label");
    RanksLabel:SetColor(1, .95686, .40784);
    RanksLabel:SetFullWidth(true);
    Parent:AddChild(RanksLabel);

    local RankItems, RankDetails, rankCount = {}, {}, 0;
    for _, Member in pairs(GL.User:guildMembers()) do
        local Rank = RankDetails[Member.rankIndex];

        if (not Rank) then
            Rank = { name = Member.rank, total = 0, online = 0, };
            RankDetails[Member.rankIndex] = Rank;
            rankCount = rankCount + 1;
        end

        Rank.total = Rank.total + 1;
        Rank.online = Rank.online + (Member.isOnline and 1 or 0);
    end

    for rankIndex, Rank in pairs(RankDetails) do
        RankItems[rankIndex] = ("%s - %s (%s, %s online)"):format(rankIndex, Rank.name, Rank.total, Rank.online);
    end

    if (rankCount < 1) then
        RanksLabel:SetText("Guild ranks: join a guild to include entire guild ranks in the council");
    else
        RanksLabel:SetText("Guild ranks whose members are part of the council");

        local Ranks = AceGUI:Create("Dropdown");
        Ranks:SetMultiselect(true);
        Ranks:SetList(RankItems);
        Ranks:SetWidth(320);

        for rankIndex in pairs(RankItems) do
            Ranks:SetItemValue(rankIndex, GL.Settings:get("LootCouncil.GuildRanks", {})[rankIndex] == true);
        end

        Ranks:SetCallback("OnValueChanged", function (_, _, rankIndex, checked)
            local Selected = GL:cloneTable(GL.Settings:get("LootCouncil.GuildRanks", {}));
            Selected[rankIndex] = checked and true or nil;
            GL.Settings:set("LootCouncil.GuildRanks", Selected);
        end);
        Parent:AddChild(Ranks);
    end

    local VersionCheckButton = AceGUI:Create("Button");
    VersionCheckButton:SetText("Version check");
    VersionCheckButton:SetWidth(130);
    VersionCheckButton:SetCallback("OnClick", function ()
        GL.Settings:close();
        GL.Interface.GroupVersionCheck:open({
            {
                text = "Back",
                onClick = function ()
                    GL.Interface.GroupVersionCheck:close();
                    GL.Settings:draw("LootCouncil");
                end,
                tooltip = "Go back to the loot council settings",
            },
        });
    end);
    VersionCheckButton:SetCallback("OnEnter", function ()
        GameTooltip:SetOwner(VersionCheckButton.frame, "ANCHOR_TOP");
        GameTooltip:AddLine("Check whether everyone in your group runs an up-to-date Gargul");
        GameTooltip:AddLine("Council members need it to vote", 1, 1, 1);
        GameTooltip:Show();
    end);
    VersionCheckButton:SetCallback("OnLeave", function ()
        GameTooltip:Hide();
    end);
    Parent:AddChild(VersionCheckButton);

    Overview:drawSpacer(Parent, nil, 10);

    Overview:drawCheckboxes({
        {
            label = "Guild runs only",
            description = "Only use the loot council when enough of the group is in your guild (see threshold below)",
            setting = "LootCouncil.guildRunsOnly",
        },
    }, Parent);

    local numberSetting = function (label, setting, default, minimum, maximum)
        local Box = AceGUI:Create("EditBox");
        Box:DisableButton(true);
        Box:SetLabel(label);
        Box:SetWidth(250);
        Box:SetText(tostring(GL.Settings:get(setting, default)));
        Box:SetCallback("OnTextChanged", function ()
            local value = tonumber(Box:GetText());

            if (value) then
                GL.Settings:set(setting, math.max(minimum, math.min(maximum, math.floor(value))));
            end
        end);
        Parent:AddChild(Box);
    end;

    numberSetting("Guild run threshold: % of the group that's in your guild", "LootCouncil.guildRunThreshold", 50, 0, 100);
    numberSetting("Votes per council member per item", "LootCouncil.votesPerMember", 1, 1, 40);

    Overview:drawSpacer(Parent, nil, 10);

    Overview:drawCheckboxes({
        {
            label = "Sort rolls by votes",
            description = "Players with the most votes show up on top",
            setting = "LootCouncil.sortByVotes",
        },
        {
            label = "Show vote details on award",
            description = "Add the number of votes to the award message in chat",
            setting = "LootCouncil.showVotesOnAward",
        },
    }, Parent);
end
