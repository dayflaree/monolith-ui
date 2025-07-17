local MODULE = MODULE

function MODULE:LoadFonts()
    surface.CreateFont("monolith.small", {
        font = "DIN Pro Regular",
        size = ScreenScaleH(6),
        weight = 400
    })

    surface.CreateFont("monolith.small.bold", {
        font = "DIN Pro Bold",
        size = ScreenScaleH(6),
        weight = 400
    })

    surface.CreateFont("monolith.small.italic", {
        font = "DIN Pro Italic",
        size = ScreenScaleH(6),
        weight = 400
    })

    surface.CreateFont("monolith.small.italic.bold", {
        font = "DIN Pro Bold Italic",
        size = ScreenScaleH(6),
        weight = 400
    })

    surface.CreateFont("monolith.title", {
        font = ax.config:Get("monolith.title.font"),
        size = ScreenScaleH(ax.config:Get("monolith.title.size", 16))
    })

    surface.CreateFont("monolith.subtitle", {
        font = ax.config:Get("monolith.subtitle.font"),
        size = ScreenScaleH(ax.config:Get("monolith.subtitle.size", 12))
    })

    surface.CreateFont("monolith.playerinfo.title", {
        font = "DIN Pro Bold",
        size = ScreenScaleH(48)
    })

    surface.CreateFont("monolith.playerinfo.subtitle", {
        font = "DIN Pro Regular",
        size = ScreenScaleH(24)
    })
end

local unknownIcon = ax.util:GetMaterial("icons/unknown_person.png", "smooth mips")
local factionIcons = {
    [FACTION_CITIZEN] = ax.util:GetMaterial("icons/npc_icon_citizen.png", "smooth mips"),
    [FACTION_MPF] = ax.util:GetMaterial("icons/npc_icon_civilprotection.png", "smooth mips"),
    [FACTION_OTA] = ax.util:GetMaterial("icons/npc_icon_transhumanforces.png", "smooth mips"),
    [FACTION_VORTIGAUNT] = ax.util:GetMaterial("icons/npc_icon_vortigaunt.png", "smooth mips"),
    [FACTION_ADMIN] = ax.util:GetMaterial("icons/npc_icon_combineclaw_upright.png", "smooth mips")
}

local function GetHeadPosition(client)
    local head = client:LookupBone("ValveBiped.Bip01_Head1")
    if ( !head or head < 0 ) then
        return client:EyePos()
    end

    return client:GetBonePosition(head)
end

function MODULE:DrawTargetInfo(client, alpha, is3D2D)
    if ( is3D2D and client:IsPlayer() ) then
        if ( !ax.config:Get("monolith.playerinfo.enabled", true) ) then return end

        local trace = LocalPlayer():GetEyeTrace()
        local target = trace.Entity

        if ( !IsValid(target) or !target:IsPlayer() or target == LocalPlayer() ) then
            return
        end

        local distance = LocalPlayer():GetPos():Distance(target:GetPos())
        local maxDistance = ax.config:Get("monolith.playerinfo.distance", 200)

        if ( distance > maxDistance ) then return end

        local character = target:GetCharacter()
        if ( !character ) then return end

        -- Get player info
        local isRecognized = hook.Run("IsCharacterRecognized", character) or false
        local name = hook.Run("GetCharacterName", character) or character:GetName() or "Unknown"
        local statusText = isRecognized and name or "Unrecognized"

        -- Get faction info
        local faction = character:GetFactionData()
        local factionColor = faction and faction.Color or Color(255, 255, 255)
        local factionName = faction and faction.Name or "Citizen"

        local pos = GetHeadPosition(target) + Vector(0, 0, 2)
        local ang = Angle(0, LocalPlayer():EyeAngles().y - 90, 90) -- Face the player

        -- Calculate alpha based on distance
        factionColor.a = alpha
        local icon = factionIcons[faction and faction.ID] or unknownIcon
        if ( !isRecognized ) then
            icon = unknownIcon
            factionColor = Color(125, 137.5, 150, alpha)
            statusText = "Unrecognized"
        end

        local iconSize = ScreenScale(48) + ScreenScaleH(48)
        local textX = iconSize * 2

        cam.IgnoreZ(true)
        cam.Start3D2D(pos, ang, 0.025)
            draw.RoundedBox(0, textX - iconSize, -iconSize / 2, iconSize, iconSize, Color(0, 0, 0, alpha / 1.125))
            surface.SetDrawColor(factionColor.r - 25, factionColor.g - 25, factionColor.b - 25, alpha)
            surface.DrawOutlinedRect(textX - iconSize, -iconSize / 2, iconSize, iconSize, 5)

            surface.SetMaterial(icon)
            surface.SetDrawColor(255, 255, 255, alpha)
            surface.DrawTexturedRect(textX - iconSize, -iconSize / 2, iconSize, iconSize)

            textX = textX + iconSize / 6
            draw.SimpleText(statusText, "monolith.playerinfo.title", textX + 4, 4, Color(0, 0, 0, alpha / 2), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
            draw.SimpleText(statusText, "monolith.playerinfo.title", textX, 0, factionColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
            draw.SimpleText(factionName, "monolith.playerinfo.subtitle", textX + 4, 4, Color(0, 0, 0, alpha / 2), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText(factionName, "monolith.playerinfo.subtitle", textX, 0, Color(150, 150, 150, alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        cam.End3D2D()
        cam.IgnoreZ(false)

        return false -- Prevent default drawing player info
    end
end