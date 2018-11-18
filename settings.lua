if config.settings.trock_init_settings_ran then return end
config.settings.trock_init_settings_ran = true

-- Init settings
config.settings.trock = config.settings.trock or {}
config.settings.trock.autosave = true

-- DEBUG mode
config.settings.cheat = false
config.settings.debugprint = true
--config.settings.trock.debugsense = true

--config.settings.trock.cheat_start_zone = "gora-town"
--config.settings.trock.cheat_start_zone = "murmon"
config.settings.trock.cheat_start_zone = "arena"


print("[TROCK] TROCK settings loaded")
