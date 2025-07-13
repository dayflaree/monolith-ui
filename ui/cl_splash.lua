--[[
    Parallax Framework
    Copyright (c) 2025 Parallax Framework Contributors

    This file is part of the Parallax Framework and is licensed under the MIT License.
    You may use, copy, modify, merge, publish, distribute, and sublicense this file
    under the terms of the LICENSE file included with this project.

    Attribution is required. If you use or modify this file, you must retain this notice.
]]

DEFINE_BASECLASS("EditablePanel")

local PANEL = {}

function PANEL:Init()
    if ( IsValid(ax.gui.splash) ) then
        ax.gui.splash:Remove()
    end

    ax.gui.splash = self

    if ( system.IsWindows() ) then
        system.FlashWindow()
    end

    self:SetSize(ScrW(), ScrH())
    self:SetPos(0, 0)
    self:MakePopup()

    local halfWidth = ScrW() / 2
    local halfHeight = ScrH() / 2

    local title = self:Add("ax.text")
    title:SetFont("monolith.hl2.small")
    title:SetText(ax.config:Get("monolith.title"))
    title:SetPos(halfWidth - title:GetWide() / 2, halfHeight - title:GetTall() * 2)
    title:SetExpensiveShadow(4, Color(0, 0, 0, 200))

    local subtitle = self:Add("ax.text")
    subtitle:SetFont("monolith.din.medium")
    subtitle:SetText(ax.config:Get("monolith.subtitle"))
    subtitle:SetWide(title:GetWide())
    subtitle:SetContentAlignment(5)
    subtitle:SetPos(halfWidth - subtitle:GetWide() / 2, halfHeight - subtitle:GetTall())
    subtitle:SetExpensiveShadow(4, Color(0, 0, 0, 200))
    subtitle.PaintOver = function(this, width, height)
        surface.SetDrawColor(color_white)
        surface.DrawRect(0, height / 2, width / 5, 2)
        surface.DrawRect(width / 5 * 4, height / 2, width / 5, 2)
    end

    local button  = self:Add("monolith.button")
    button:SetText("splash.continue")
    button:CenterHorizontal()
    button:SetY(halfHeight + subtitle:GetTall() * 2)
    button.DoClick = function()
        self:AlphaTo(0, 0.5, 0, function()
            self:Remove()
        end)

        vgui.Create("ax.mainmenu")
    end

    if ( BRANCH != "x86-64" and !tobool(cookie.GetNumber("ax.low.performance", 0)) ) then
        Derma_Query("You are currently using the 32-bit version of the game, which may limit performance and stability. To enhance your gaming experience, we recommend switching to the 64-bit branch [x86-x64]. To do this, open your game library, navigate to the properties of the game, and update the launch options to select the 64-bit branch. This change ensures improved performance, better resource utilization, and greater compatibility with modern systems.", "Potential Performance Impact", "Disconnect", function()
            RunConsoleCommand("disconnect")
        end, "Play with reduced FPS", function()
            cookie.Set("ax.low.performance", 1)
        end)
    end
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

vgui.Register("ax.splash", PANEL, "EditablePanel")

if ( IsValid(ax.gui.splash) ) then
    ax.gui.splash:Remove()

    timer.Simple(0.1, function()
        vgui.Create("ax.splash")
    end)
end

concommand.Add("ax_splash", function(client, command, arguments)
    if ( client:Team() == 0 ) then
        return
    end

    if ( IsValid(ax.gui.splash) ) then
        ax.gui.splash:Remove()
    end

    vgui.Create("ax.splash")
end, nil, "Open the splash screen", FCVAR_CLIENTCMD_CAN_EXECUTE)