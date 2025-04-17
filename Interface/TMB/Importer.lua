local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;

GL:tableSet(GL, "Interface.TMB.Importer", {
    isVisible = false,
});

local Importer = GL.Interface.TMB.Importer;

function Importer:draw(source)
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle((L["Gargul v%s"]):format(GL.version));
    Window:SetLayout("Flow");
    Window:SetWidth(600);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    GL.Interface:set(self, "Window", Window);

    Window:SetPoint(GL.Interface:getPosition("TMBImport"));

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_SOFTRES_IMPORTER_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_SOFTRES_IMPORTER_WINDOW");

    if (source == "dft") then
        Window:SetHeight(480);

        -- Explanation
        local Description = AceGUI:Create("Label");
        Description:SetFontObject(_G["GameFontNormal"]);
        Description:SetFullWidth(true);
        Description:SetText(L["Export your DFT data as per the sheet's instructions. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"]);
        Window:AddChild(Description);
    elseif (source == "cpr") then
        Window:SetHeight(480);

        -- Explanation
        local Description = AceGUI:Create("Label");
        Description:SetFontObject(_G["GameFontNormal"]);
        Description:SetFullWidth(true);
        Description:SetText(L["On your classicpr.io run click on the 'Gargul Export' button and copy the contents. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"]);
        Window:AddChild(Description);
    else
        Window:SetHeight(520);

        local VerticalSpacer = GL.AceGUI:Create("SimpleGroup");
        VerticalSpacer:SetLayout("FILL");
        VerticalSpacer:SetFullWidth(true);
        VerticalSpacer:SetHeight(6);
        Window:AddChild(VerticalSpacer);

        local MoreInfoLabel = GL.AceGUI:Create("Label");
        MoreInfoLabel:SetText(("|c00FFF569%s|r"):format(GL:printfn(L["How to use Gargul with ${source}"], { source = GL.TMB:source(), })));
        MoreInfoLabel:SetFontObject(_G["GameFontGreenLarge"]);
        MoreInfoLabel:SetFullWidth(true);
        MoreInfoLabel:SetJustifyH("CENTER");
        Window:AddChild(MoreInfoLabel);

        local DiscordURL = GL.AceGUI:Create("EditBox");
        DiscordURL:DisableButton(true);
        DiscordURL:SetHeight(20);
        DiscordURL:SetFullWidth(true);
        DiscordURL:SetText(L["https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS"]);
        Window:AddChild(DiscordURL);

        VerticalSpacer = GL.AceGUI:Create("SimpleGroup");
        VerticalSpacer:SetLayout("FILL");
        VerticalSpacer:SetFullWidth(true);
        VerticalSpacer:SetHeight(10);
        Window:AddChild(VerticalSpacer);

        -- Explanation
        local Description = AceGUI:Create("Label");
        Description:SetFontObject(_G["GameFontNormal"]);
        Description:SetFullWidth(true);
        Description:SetText(L["Paste your TMB export contents as-is in the box below and click 'Import'"]);
        Window:AddChild(Description);
    end


    -- Large edit box
    local TMBBoxContent = "";
    local TMBBox = AceGUI:Create("MultiLineEditBox");
    TMBBox:SetFullWidth(true);
    TMBBox:DisableButton(true);
    TMBBox:SetFocus();
    TMBBox:SetLabel("");
    TMBBox:SetNumLines(20);
    TMBBox:SetMaxLetters(999999999);
    Window:AddChild(TMBBox);

    TMBBox:SetCallback("OnTextChanged", function(_, _, text)
        TMBBoxContent = text;
    end)

    -- Status message frame
    local StatusMessageFrame = AceGUI:Create("SimpleGroup");
    StatusMessageFrame:SetLayout("FILL");
    StatusMessageFrame:SetWidth(570);
    StatusMessageFrame:SetHeight(56);
    Window:AddChild(StatusMessageFrame);

    local StatusMessageLabel = AceGUI:Create("Label");
    StatusMessageLabel:SetFontObject(_G["GameFontNormal"]);
    StatusMessageLabel:SetFullWidth(true);
    StatusMessageLabel:SetColor(1, 0, 0);
    StatusMessageFrame:AddChild(StatusMessageLabel);
    GL.Interface:set(self, "StatusMessage", StatusMessageLabel);

    -- Import button
    local ImportButton = AceGUI:Create("Button");
    ImportButton:SetText(L["Import"]);
    ImportButton:SetWidth(140);
    ImportButton:SetCallback("OnClick", function()
        GL.TMB:import(TMBBoxContent, nil, source);
    end);
    Window:AddChild(ImportButton);
end

-- Close the import frame and clean up after ourselves
function Importer:close()
    local Window = GL.Interface:get(self, "Window");

    if (not self.isVisible
        or not Window
    ) then
        return;
    end

    -- Store the frame's last position for future play sessions
    GL.Interface:storePosition(Window, "TMBImport");

    -- Clear the frame and its widgets
    GL.Interface:release(Window);
    self.isVisible = false;
end
