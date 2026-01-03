local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
-- Not: Daha birebir Soluna tasarımı için özel çizim kütüphaneleri gerekebilir, 
-- ama Kavo ile en yakın ve stabil görüntüyü bu şekilde sağlarız.

local Window = Library.CreateLib("SOLUNA HUB - BROOKHAVEN", "Midnight")

-- SEKMELER (Görseldeki menü yapısı gibi)
local TrollTab = Window:NewTab("Troll Scripts")
local AvatarTab = Window:NewTab("Avatar")
local HouseTab = Window:NewTab("Houses")
local VehicleTab = Window:NewTab("Vehicle")
local TeleportTab = Window:NewTab("Teleports")

-----------------------------------------------------------
-- TROLL SCRIPTS (Başkalarının Görebileceği Özellikler)
-----------------------------------------------------------
local TrollSection = TrollTab:NewSection("Genel Trolller")

TrollSection:NewButton("Item Dupe & Art (Sembol)", "Eşyaları çoğaltarak sembol oluşturur", function()
    -- GitHub linkini buraya bağla
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OfficalBlueHair/MyRobloxScripts-REAL/main/itemart.lua"))()
end)

TrollSection:NewButton("Fling Everyone (Başkalarını Fırlat)", "Oyuncuları haritadan uçurur", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OfficalBlueHair/MyRobloxScripts-REAL/main/fling.lua"))()
end)

-----------------------------------------------------------
-- HOUSES (Evler)
-----------------------------------------------------------
local HouseSection = HouseTab:NewSection("Ev Manipülasyonu")

HouseSection:NewButton("Unlock All Doors", "Evlerin kapı kilidini açmayı dener", function()
    print("Kapılar zorlanıyor...")
end)

HouseSection:NewButton("Teleport to All Houses", "Sırayla tüm evleri gezer", function()
     -- Işınlanma kodları buraya
end)

-----------------------------------------------------------
-- VEHICLE (Araçlar)
-----------------------------------------------------------
local VehicleSection = VehicleTab:NewSection("Araç Kontrolü")

VehicleSection:NewButton("Car Speed & Fly", "Araba ayarlarını yükler", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OfficalBlueHair/MyRobloxScripts-REAL/main/carfly.lua"))()
end)
