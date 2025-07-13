--[[
    Parallax Framework
    Copyright (c) 2025 Parallax Framework Contributors

    This file is part of the Parallax Framework and is licensed under the MIT License.
    You may use, copy, modify, merge, publish, distribute, and sublicense this file
    under the terms of the LICENSE file included with this project.

    Attribution is required. If you use or modify this file, you must retain this notice.
]]

DEFINE_BASECLASS("DButton")

local PANEL = {}

function PANEL:Init()
    self:SetFont("monolith.small.italic")
    self:SetFontDefault("monolith.small.italic")
    self:SetFontHovered("monolith.small.italic.bold")
    self:SetBaseHeight(self:GetBaseHeight() / 2)
    self:SetBaseTextColorTarget(ax.color:Get("white"))
    self:SetSoundClick("monolith.button.click")
    self:SetSoundEnter("monolith.button.enter")

    self:SetBackgroundColor(Color(40, 40, 40))
end

function PANEL:SizeToContents()
    BaseClass.SizeToContents(self)

    self:SetSize(self:GetWide() + ScreenScale(16), self:GetTall() + ScreenScaleH(8))
end

local gradient = ax.util:GetMaterial("vgui/gradient-d")
function PANEL:Paint(width, height)
    local alpha = 255 * self:GetInertia()

    surface.SetDrawColor(ColorAlpha(self:GetBackgroundColor(), 255))
    surface.DrawRect(0, 0, width, height)

    surface.SetDrawColor(20, 20, 20, 255)
    surface.SetMaterial(gradient)
    surface.DrawTexturedRect(0, 0, width, height * 1.5)

    surface.SetDrawColor(60, 60, 60, 255)
    surface.DrawOutlinedRect(0, 0, width, height)

    return false
end

vgui.Register("monolith.button", PANEL, "ax.button.flat")

sound.Add({
    name = "monolith.button.click",
    channel = CHAN_STATIC,
    volume = 0.2,
    level = 80,
    pitch = 160,
    sound = "mrp/ui/click.wav"
})

sound.Add({
    name = "monolith.button.enter",
    channel = CHAN_STATIC,
    volume = 0.1,
    level = 80,
    pitch = 200,
    sound = "mrp/ui/hover.mp3"
})