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
    surface.CreateFont("monolith.hl2.large", {
        font = "HalfLife2",
        size = ScreenScale(32)
    })

    surface.CreateFont("monolith.hl2.medium", {
        font = "HalfLife2",
        size = ScreenScale(24)
    })

    surface.CreateFont("monolith.hl2.small", {
        font = "HalfLife2",
        size = ScreenScale(16)
    })

    surface.CreateFont("monolith.din.large", {
        font = "Alte DIN 1451 Mittelschrift",
        size = ScreenScale(24)
    })

    surface.CreateFont("monolith.din.medium", {
        font = "Alte DIN 1451 Mittelschrift",
        size = ScreenScale(12)
    })

    surface.CreateFont("monolith.din.small", {
        font = "Alte DIN 1451 Mittelschrift",
        size = ScreenScale(8)
    })
end