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
    self:SetSize(ScrW(), ScrH())
    self:SetPos(0, 0)
    self:SetVisible(false)
end

function PANEL:Populate()
    local parent = self:GetParent()
    parent.container:Clear()
    parent.container:SetVisible(false)

    self:SetVisible(true)

    local title = self:Add("ax.text")
    title:Dock(TOP)
    title:DockMargin(ScreenScale(32), ScreenScaleH(32), 0, 0)
    title:SetFont("ax.huge.bold")
    title:SetText(string.upper("mainmenu.options"))

    local navigation = self:Add("EditablePanel")
    navigation:Dock(BOTTOM)
    navigation:DockMargin(ScreenScale(32), 0, ScreenScale(32), ScreenScaleH(32))
    navigation:SetTall(ScreenScaleH(24))

    local backButton = navigation:Add("monolith.button")
    backButton:Dock(LEFT)
    backButton:SetText("back")
    backButton.DoClick = function()
        self.currentCreatePage = 0
        self.currentCreatePayload = {}
        parent:Populate()

        self:Clear()
        self:SetVisible(false)
    end

    navigation:SetTall(backButton:GetTall())

    local options = self:Add("ax.options")
    options:Dock(FILL)
    options:DockMargin(ScreenScale(32), 0, ScreenScale(32), 0)
end

vgui.Register("ax.mainmenu.options", PANEL, "EditablePanel")

ax.gui.OptionsLast = nil