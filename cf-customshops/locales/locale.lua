LocaleConfig = {}
if Config.Locale == "tr" then

    LocaleConfig.Locales = {
        DontThis = "Buraya erişemezsiniz !",
        MarkeTT = "market",
        MarkerText = "~g~[E]~w~ Marketi Aç"

    }

elseif Config.Locale == "en" then

    LocaleConfig.Locales = {
        DontThis = "You can't access here !",
        MarkeTT = "market",
        MarkerText = "~g~[E]~w~ Open Market"
    }

elseif Config.Locale == "de" then

    LocaleConfig.Locales = {
        DontThis = "Sie können hier nicht darauf zugreifen !",
        MarkeTT = "markt",
        MarkerText = "~g~[E]~w~ Offener Markt"
    }

else
    print("^2[cf-customshops] ^1PLEASE SELECT YOUR LANGUAGE IN CONFIG.LUA (TR / EN / DE)")
    return
end
