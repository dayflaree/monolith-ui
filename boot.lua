local MODULE = MODULE

MODULE.Name = "Monolith UI"
MODULE.Ddescription = "Replaces all the Parallax Derma with Monolith styled UI."
MODULE.Author = "Riggs"

ax.config:Register("monolith.title", {
    Name = "Monolith Title",
    Description = "The title text for the Monolith UI.",
    Category = "Monolith",
    Type = ax.types.string,
    Default = "H A L F - L I F E ²"
})

ax.config:Register("monolith.title.font", {
    Name = "Monolith Title Font",
    Description = "The font used for the Monolith title.",
    Category = "Monolith",
    Type = ax.types.string,
    Default = "HalfLife2",
    OnChange = function(oldValue, newValue)
        if ( CLIENT ) then
            MODULE:LoadFonts()
        end
    end
})

ax.config:Register("monolith.subtitle", {
    Name = "Monolith Subtitle",
    Description = "The subtitle text for the Monolith UI.",
    Category = "Monolith",
    Type = ax.types.string,
    Default = "R   O   L   E   P   L   A   Y"
})

ax.config:Register("monolith.subtitle.font", {
    Name = "Monolith Subtitle Font",
    Description = "The font used for the Monolith subtitle.",
    Category = "Monolith",
    Type = ax.types.string,
    Default = "Alte DIN 1451 Mittelschrift",
    OnChange = function(oldValue, newValue)
        if ( CLIENT ) then
            MODULE:LoadFonts()
        end
    end
})

ax.config:Register("monolith.background", {
    Name = "Monolith Background",
    Description = "The background image for the Monolith UI. This image should be a 16:9 aspect ratio.",
    Category = "Monolith",
    Type = ax.types.string,
    Default = "overlays/hls_background_grunge.png"
})

ax.config:Register("monolith.background.parameters", {
    Name = "Monolith Background Parameters",
    Description = "The parameters for the Monolith background image.",
    Category = "Monolith",
    Type = ax.types.string,
    Default = "smooth mips"
})

ax.config:Register("monolith.background.opacity", {
    Name = "Monolith Background Opacity",
    Description = "The opacity of the background image for the Monolith UI.",
    Category = "Monolith",
    Type = ax.types.number,
    Default = 240,
    Min = 0,
    Max = 255
})

ax.config:Register("monolith.playerinfo.enabled", {
    Name = "Monolith Player Info Enabled",
    Description = "Enable or disable the player info 3D2D display.",
    Category = "Monolith",
    Type = ax.types.bool,
    Default = true
})

ax.config:Register("monolith.playerinfo.distance", {
    Name = "Monolith Player Info Distance",
    Description = "The distance at which the player info 3D2D display will be shown.",
    Category = "Monolith",
    Type = ax.types.number,
    Default = 200,
    Min = 0,
    Max = 1000
})

function MODULE:Initialize()
    ax.util:Print("I'm gay for Monolith UI!")
end