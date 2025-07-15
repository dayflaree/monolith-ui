local MODULE = MODULE

ax.config:Register("monolith.title", {
    Name = "Monolith Title",
    Description = "The title text for the Monolith UI.",
    Category = "Monolith",
    SubCategory = "Title",
    Type = ax.types.string,
    Default = "HALF-LIFE²"
})

ax.config:Register("monolith.title.font", {
    Name = "Monolith Title Font",
    Description = "The font used for the Monolith title.",
    Category = "Monolith",
    SubCategory = "Title",
    Type = ax.types.string,
    Default = "HalfLife2",
    OnChange = function(oldValue, newValue)
        if ( CLIENT ) then
            MODULE:LoadFonts()
        end
    end
})

ax.config:Register("monolith.title.size", {
    Name = "Monolith Title Size",
    Description = "The size of the Monolith title text.",
    Category = "Monolith",
    SubCategory = "Title",
    Type = ax.types.number,
    Default = 16,
    Min = 8,
    Max = 64,
    OnChange = function(oldValue, newValue)
        if ( CLIENT ) then
            MODULE:LoadFonts()
        end
    end
})

ax.config:Register("monolith.title.color", {
    Name = "Monolith Title Color",
    Description = "The color of the Monolith title.",
    Category = "Monolith",
    SubCategory = "Title",
    Type = ax.types.color,
    Default = Color(255, 255, 255)
})

ax.config:Register("monolith.title.spacing", {
    Name = "Monolith Title Spacing",
    Description = "The spacing between characters in the Monolith title.",
    Category = "Monolith",
    SubCategory = "Title",
    Type = ax.types.number,
    Default = 1,
    Min = 0,
    Max = 10
})

ax.config:Register("monolith.subtitle", {
    Name = "Monolith Subtitle",
    Description = "The subtitle text for the Monolith UI.",
    Category = "Monolith",
    SubCategory = "Subtitle",
    Type = ax.types.string,
    Default = "ROLEPLAY"
})

ax.config:Register("monolith.subtitle.font", {
    Name = "Monolith Subtitle Font",
    Description = "The font used for the Monolith subtitle.",
    Category = "Monolith",
    SubCategory = "Subtitle",
    Type = ax.types.string,
    Default = "Alte DIN 1451 Mittelschrift",
    OnChange = function(oldValue, newValue)
        if ( CLIENT ) then
            MODULE:LoadFonts()
        end
    end
})

ax.config:Register("monolith.subtitle.size", {
    Name = "Monolith Subtitle Size",
    Description = "The size of the Monolith subtitle text.",
    Category = "Monolith",
    SubCategory = "Subtitle",
    Type = ax.types.number,
    Default = 12,
    Min = 8,
    Max = 32,
    OnChange = function(oldValue, newValue)
        if ( CLIENT ) then
            MODULE:LoadFonts()
        end
    end
})

ax.config:Register("monolith.subtitle.color", {
    Name = "Monolith Subtitle Color",
    Description = "The color of the Monolith subtitle.",
    Category = "Monolith",
    SubCategory = "Subtitle",
    Type = ax.types.color,
    Default = Color(255, 255, 255)
})

ax.config:Register("monolith.subtitle.spacing", {
    Name = "Monolith Subtitle Spacing",
    Description = "The spacing between characters in the Monolith subtitle.",
    Category = "Monolith",
    SubCategory = "Subtitle",
    Type = ax.types.number,
    Default = 3,
    Min = 0,
    Max = 10
})

ax.config:Register("monolith.background", {
    Name = "Monolith Background",
    Description = "The background image for the Monolith UI. This image should be a 16:9 aspect ratio.",
    Category = "Monolith",
    SubCategory = "Background",
    Type = ax.types.string,
    Default = "overlays/hls_background_grunge.png"
})

ax.config:Register("monolith.background.parameters", {
    Name = "Monolith Background Parameters",
    Description = "The parameters for the Monolith background image.",
    Category = "Monolith",
    SubCategory = "Background",
    Type = ax.types.string,
    Default = "smooth mips"
})

ax.config:Register("monolith.background.opacity", {
    Name = "Monolith Background Opacity",
    Description = "The opacity of the background image for the Monolith UI.",
    Category = "Monolith",
    SubCategory = "Background",
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