--[[
    Parallax Framework
    Copyright (c) 2025 Parallax Framework Contributors

    This file is part of the Parallax Framework and is licensed under the MIT License.
    You may use, copy, modify, merge, publish, distribute, and sublicense this file
    under the terms of the LICENSE file included with this project.

    Attribution is required. If you use or modify this file, you must retain this notice.
]]

local padding = ScreenScale(32)

DEFINE_BASECLASS("EditablePanel")

local PANEL = {}

AccessorFunc(PANEL, "currentCreatePage", "CurrentCreatePage", FORCE_NUMBER)
AccessorFunc(PANEL, "currentCreatePayload", "CurrentCreatePayload")

function PANEL:Init()
    if ( IsValid(ax.gui.mainmenu) ) then
        ax.gui.mainmenu:Remove()
    end

    ax.gui.mainmenu = self

    local client = ax.client
    if ( IsValid(client) and client:IsTyping() ) then
        chat.Close()
    end

    CloseDermaMenus()

    self:SetSize(ScrW(), ScrH())
    self:SetPos(0, 0)
    self:MakePopup()

    self.createPanel = self:Add("ax.mainmenu.create")
    self.selectPanel = self:Add("ax.mainmenu.load")
    self.optionsPanel = self:Add("ax.mainmenu.options")

    self.container = self:Add("EditablePanel")
    self.container:SetSize(self:GetWide(), self:GetTall())
    self.container:SetPos(0, 0)

    if ( ax.config:Get("mainmenu.branchwarning") and BRANCH != "x86-64" )  then
        Derma_Query(ax.localization:GetPhrase("mainmenu.branchwarning"), "Parallax", "I acknowledge")
    end

    self:Populate()
end

function PANEL:Populate()
    -- Hide all other panels
    self.createPanel:SetVisible(false)
    self.selectPanel:SetVisible(false)
    self.optionsPanel:SetVisible(false)

    -- And clear them
    self.createPanel:Clear()
    self.selectPanel:Clear()
    self.optionsPanel:Clear()

    -- Set the container to be visible and clear it
    self.container:SetVisible(true)
    self.container:Clear()

    local buttons = self.container:Add("EditablePanel")

    local halfWidth = ScrW() / 2
    local halfHeight = ScrH() / 2

    local titleConfig = ax.config:Get("monolith.title", "HALF-LIFE²")
    local titleText = ""
    local titleSpacing = ax.config:Get("monolith.title.spacing", 1)

    -- Add spacing between each character
    for i = 1, #titleConfig do
        titleText = titleText .. utf8.sub(titleConfig, i, i) .. string.rep(" ", titleSpacing)
    end

    -- Remove trailing spaces
    titleText = titleText:Trim()

    local title = self:Add("ax.text")
    title:SetFont("monolith.title")
    title:SetText(titleText, true)
    title:SetTextColor(ax.config:Get("monolith.title.color", color_white))
    title:SetPos(halfWidth - title:GetWide() / 2, halfHeight - title:GetTall() * 2)
    title:SetExpensiveShadow(4, Color(0, 0, 0, 200))

    local subtitleConfig = ax.config:Get("monolith.subtitle", "ROLEPLAY")
    local subtitleText = ""
    local subtitleSpacing = ax.config:Get("monolith.subtitle.spacing", 3)

    -- Add spacing between each character
    for i = 1, #subtitleConfig do
        subtitleText = subtitleText .. utf8.sub(subtitleConfig, i, i) .. string.rep(" ", subtitleSpacing)
    end

    -- Remove trailing spaces
    subtitleText = subtitleText:Trim()

    local subtitle = self:Add("ax.text")
    subtitle:SetFont("monolith.subtitle")
    subtitle:SetText(subtitleText)
    subtitle:SetTextColor(ax.config:Get("monolith.subtitle.color", Color(150, 150, 150)))
    subtitle:SetWide(title:GetWide())
    subtitle:SetContentAlignment(5)
    subtitle:SetPos(halfWidth - subtitle:GetWide() / 2, halfHeight - subtitle:GetTall())
    subtitle:SetExpensiveShadow(4, Color(0, 0, 0, 200))
    subtitle.PaintOver = function(this, width, height)
        surface.SetDrawColor(color_white)
        surface.DrawRect(0, height / 2, width / 5, 2)
        surface.DrawRect(width / 5 * 4, height / 2, width / 5, 2)
    end

    local client = ax.client
    local clientTable = client:GetTable()
    if ( clientTable.axCharacter ) then -- client:GetCharacter() isn't validated yet, since it this panel is created before the meta tables are loaded
        local playButton = buttons:Add("monolith.button")
        playButton:Dock(LEFT)
        playButton:DockMargin(0, 0, 8, 0)
        playButton:SetText("mainmenu.play")

        playButton.DoClick = function(this)
            self:Remove()
        end
    end

    local createButton = buttons:Add("monolith.button")
    createButton:Dock(LEFT)
    createButton:DockMargin(0, 0, 8, 0)
    createButton:SetText("mainmenu.create.character")

    createButton.DoClick = function(this)
        local availableFactions = 0
        for i = 1, #ax.faction:GetAll() do
            local v = ax.faction:GetAll()[i]
            if ( ax.faction:CanSwitchTo(ax.client, v:GetID()) ) then
                availableFactions = availableFactions + 1
            end
        end

        if ( availableFactions > 1 ) then
            self.createPanel:PopulateFactionSelect()
        elseif ( availableFactions == 1 ) then
            self.createPanel:PopulateCreateCharacter()
        else
            ax.client:Notify("You do not have any factions available to create a character for.", NOTIFY_ERROR)
            return
        end
    end

    local bHasCharacters = table.Count(clientTable.axCharacters or {}) > 0
    if ( bHasCharacters ) then
        local selectButton = buttons:Add("monolith.button")
        selectButton:Dock(LEFT)
        selectButton:DockMargin(0, 0, 8, 0)
        selectButton:SetText("mainmenu.select.character")

        selectButton.DoClick = function()
            self.selectPanel:Populate()
        end
    end

    local optionsButton = buttons:Add("monolith.button")
    optionsButton:Dock(LEFT)
    optionsButton:DockMargin(0, 0, 8, 0)
    optionsButton:SetText("mainmenu.options")

    optionsButton.DoClick = function()
        self.optionsPanel:Populate()
    end

    local disconnectButton = buttons:Add("monolith.button")
    disconnectButton:Dock(LEFT)
    disconnectButton:DockMargin(0, 0, 8, 0)
    disconnectButton:SetText("mainmenu.leave")
    disconnectButton:SetTextColorProperty(ax.color:Get("maroon"))

    disconnectButton.DoClick = function()
        Derma_Query(ax.localization:GetPhrase("mainmenu.disconnect.confirmation"), "Disconnect", "Yes", function()
            RunConsoleCommand("disconnect")
        end, "No")
    end

    local buttonsWidth = 0
    for _, button in ipairs(buttons:GetChildren()) do
        buttonsWidth = buttonsWidth + button:GetWide()
        local marginLeft, marginTop, marginRight, marginBottom = button:GetDockMargin()
        buttonsWidth = buttonsWidth + marginLeft + marginRight
    end

    buttons:SetSize(buttonsWidth, disconnectButton:GetTall())
    buttons:CenterHorizontal()
    buttons:SetY(halfHeight + subtitle:GetTall() * 2)
end

function PANEL:Paint(width, height)
    ax.util:DrawBlur(self, 8)

    surface.SetDrawColor(0, 0, 0, 100)
    surface.DrawRect(0, 0, width, height)

    local background = ax.util:GetMaterial(ax.config:Get("monolith.background"), ax.config:Get("monolith.background.parameters"))
    surface.SetDrawColor(255, 255, 255, ax.config:Get("monolith.background.opacity"))
    surface.SetMaterial(background)
    surface.DrawTexturedRect(0, 0, width, height)
end

vgui.Register("ax.mainmenu", PANEL, "EditablePanel")

if ( IsValid(ax.gui.mainmenu) ) then
    ax.gui.mainmenu:Remove()

    timer.Simple(0.1, function()
        vgui.Create("ax.mainmenu")
    end)
end

concommand.Add("ax_mainmenu", function(client, command, arguments)
    if ( client:Team() == 0 ) then
        return
    end

    if ( IsValid(ax.gui.mainmenu) ) then
        ax.gui.mainmenu:Remove()
    end

    vgui.Create("ax.mainmenu")
end, nil, "Opens the main menu.", FCVAR_CLIENTCMD_CAN_EXECUTE)