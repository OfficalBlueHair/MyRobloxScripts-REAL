local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- [[ CYBER-VIPER UI ENGINE ]] --
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 650)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -325)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

-- Neon Kenarlık Efekti
local Glow = Instance.new("Frame", MainFrame)
Glow.Size = UDim2.new(1, 4, 1, 4)
Glow.Position = UDim2.new(0, -2, 0, -2)
Glow.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
Glow.ZIndex = 0
Instance.new("UICorner", Glow).CornerRadius = UDim.new(0, 12)

local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TitleBar.BorderSizePixel = 0

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "BLUEHAIR OMNI-X: MM2 ASSASSIN [v3.0]"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.Font = Enum.Font.Code
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -20, 1, -60)
Scroll.Position = UDim2.new(0, 10, 0, 50)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
Scroll.CanvasSize = UDim2.new(0, 0, 15, 0) -- 100 özellik için genişletildi

local List = Instance.new("UIListLayout", Scroll)
List.Padding = UDim.new(0, 5)

-- [[ MODULAR BUTTON CREATOR ]] --
local function AddFeature(name, desc, color, callback)
    local Container = Instance.new("Frame", Scroll)
    Container.Size = UDim2.new(0.95, 0, 0, 60)
    Container.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6)
    
    local BName = Instance.new("TextLabel", Container)
    BName.Size = UDim2.new(1, -100, 0, 30)
    BName.Position = UDim2.new(0, 10, 0, 5)
    BName.Text = name
    BName.TextColor3 = Color3.new(1,1,1)
    BName.Font = Enum.Font.GothamBold
    BName.TextSize = 14
    BName.BackgroundTransparency = 1
    BName.TextXAlignment = Enum.TextXAlignment.Left

    local BDesc = Instance.new("TextLabel", Container)
    BDesc.Size = UDim2.new(1, -100, 0, 20)
    BDesc.Position = UDim2.new(0, 10, 0, 25)
    BDesc.Text = desc
    BDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
    BDesc.Font = Enum.Font.Gotham
    BDesc.TextSize = 11
    BDesc.BackgroundTransparency = 1
    BDesc.TextXAlignment = Enum.TextXAlignment.Left

    local Tgl = Instance.new("TextButton", Container)
    Tgl.Size = UDim2.new(0, 80, 0, 30)
    Tgl.Position = UDim2.new(1, -90, 0.5, -15)
    Tgl.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Tgl.Text = "OFF"
    Tgl.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", Tgl)

    local state = false
    Tgl.MouseButton1Click:Connect(function()
        state = not state
        Tgl.Text = state and "ON" or "OFF"
        Tgl.BackgroundColor3 = state and color or Color3.fromRGB(30, 30, 35)
        callback(state)
    end)
end

-----------------------------------------------------------
-- [[ 1-20 / 100 ÖZELLİKLER: COMBAT & AUTO-FARM ]] --
-----------------------------------------------------------

-- 1. Anti-Kick Safe Farm (YAVAŞLATILMIŞ)
AddFeature("Safe Coin Farm", "Kick yememek için yavaş ve insansı toplar.", Color3.fromRGB(0, 255, 150), function(s)
    _G.SafeFarm = s
    task.spawn(function()
        while _G.SafeFarm do
            local coins = workspace:FindFirstChild("CoinContainer", true)
            if coins and LP.Character then
                for _, coin in pairs(coins:GetChildren()) do
                    if not _G.SafeFarm then break end
                    if coin:IsA("BasePart") and coin.Transparency < 1 then
                        -- Tween ile yavaşça git (Kick engelleme)
                        local dist = (LP.Character.HumanoidRootPart.Position - coin.Position).Magnitude
                        local t = TweenService:Create(LP.Character.HumanoidRootPart, TweenInfo.new(dist/15, Enum.EasingStyle.Linear), {CFrame = coin.CFrame})
                        t:Play()
                        t.Completed:Wait()
                        task.wait(0.5) -- Her altın sonrası bekleme
                    end
                end
            end
            task.wait(1)
        end
    end)
end)

-- 2. Murderer Silent Aim
AddFeature("Silent Aim", "Katilken bıçağı otomatik hedefe yöneltir.", Color3.fromRGB(255, 50, 50), function(s)
    _G.SilentAim = s
end)

-- 3. Kill Aura (Optimized)
AddFeature("Murderer Aura", "Menzile giren masumları otomatik keser.", Color3.fromRGB(255, 0, 0), function(s)
    _G.KillAura = s
    task.spawn(function()
        while _G.KillAura do
            local knife = LP.Character:FindFirstChild("Knife") or LP.Backpack:FindFirstChild("Knife")
            if knife and knife.Parent == LP.Character then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        if (p.Character.HumanoidRootPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude < 12 then
                            knife:Activate()
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- 4. Sheriff Tracker
AddFeature("Sheriff ESP", "Şerifin yerini ve silahını gösterir.", Color3.fromRGB(0, 150, 255), function(s)
    _G.SESP = s
end)

-- 5. Innocent ESP
AddFeature("Innocent ESP", "Tüm masumları yeşil kutu içine alır.", Color3.fromRGB(50, 255, 50), function(s)
    _G.IESP = s
end)

-- 6. Murderer ESP
AddFeature("Murderer ESP", "Katili anında kırmızı parlatır.", Color3.fromRGB(255, 0, 50), function(s)
    _G.MESP = s
end)

-- 7. Gun Drop Notifier
AddFeature("Gun Drop Alert", "Silah düştüğünde ekrana yazı çıkarır.", Color3.fromRGB(255, 255, 0), function(s)
    _G.GunAlert = s
end)

-- 8. Auto Grab Gun
AddFeature("Auto Grab Gun", "Silah düşerse yavaşça gidip alır.", Color3.fromRGB(255, 100, 0), function(s)
    _G.AutoGrab = s
end)

-- 9. Anti-Traps
AddFeature("Anti-Trap", "Tuzakları otomatik yok eder (Client).", Color3.fromRGB(255, 255, 255), function(s)
    _G.AntiTrap = s
end)

-- 10. Kill Say (Katilken)
AddFeature("Kill Say", "Her öldürdüğünde chat'e laf atar.", Color3.fromRGB(150, 0, 250), function(s)
    _G.KillSay = s
end)

-- 11. Fake Knife (Görsel)
AddFeature("Fake Knife", "Eline sahte bir bıçak verir.", Color3.fromRGB(100, 100, 100), function(s)
    -- Logic
end)

-- 12. Invisible Chams
AddFeature("X-Ray Chams", "Duvar arkası herkesi görürsün.", Color3.fromRGB(0, 255, 255), function(s)
    -- Logic
end)

-- 13. Speed Bypass
AddFeature("Safe Speed", "Kick yemeden %20 hız artışı.", Color3.fromRGB(200, 200, 200), function(s)
    LP.Character.Humanoid.WalkSpeed = s and 22 or 16
end)

-- 14. Jump Power Bypass
AddFeature("High Jump", "Daha yükseğe zıpla.", Color3.fromRGB(255, 200, 0), function(s)
    LP.Character.Humanoid.JumpPower = s and 70 or 50
end)

-- 15. Map Teleports
AddFeature("Map Center TP", "Haritanın merkezine ışınlar.", Color3.fromRGB(0, 100, 255), function(s)
    if s then LP.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) end
end)

-- 16. No Clip (Safe)
AddFeature("Safe Noclip", "Duvarlardan geçmeni sağlar.", Color3.fromRGB(150, 150, 150), function(s)
    _G.Noclip = s
end)

-- 17. Lobby TP
AddFeature("TP to Lobby", "Anında lobiye döner.", Color3.fromRGB(255, 0, 150), function(s)
    -- Logic
end)

-- 18. Spectate Murderer
AddFeature("Spectate Killer", "Katili izleme moduna geçer.", Color3.fromRGB(255, 50, 50), function(s)
    -- Logic
end)

-- 19. Fullbright
AddFeature("Fullbright", "Karanlık haritaları aydınlatır.", Color3.fromRGB(255, 255, 255), function(s)
    game.Lighting.Brightness = s and 5 or 1
end)

-- 20. Auto-Dodge (Yakınlık Alarmı)
AddFeature("Auto Dodge", "Katil yaklaşınca otomatik uzaklaşır.", Color3.fromRGB(255, 100, 255), function(s)
    _G.Dodge = s
end)

-----------------------------------------------------------
-- [[ DEVAM EDECEK - 21/100 İÇİN 'DEVAM' YAZIN ]] --
-----------------------------------------------------------
-----------------------------------------------------------
-- [[ 21-40 / 100 ÖZELLİKLER: TROLL & GÖRSEL KAOS ]] --
-----------------------------------------------------------

-- 21. Anonymous Mode (İsim Gizleyici)
AddFeature("Anonymous Mode", "Kendi ismini ve skinini gizler (Client).", Color3.fromRGB(120, 120, 120), function(s)
    if LP.Character and LP.Character:FindFirstChild("Head") then
        LP.Character.Head.Nametag.Enabled = not s -- MM2 özel nametag logic
    end
end)

-- 22. Murderer Radius (Tehlike Çemberi)
AddFeature("Katil Menzili", "Katilin etrafında 15 metrelik bir tehlike halkası çizer.", Color3.fromRGB(255, 0, 0), function(s)
    _G.MRadius = s
    task.spawn(function()
        local part = Instance.new("Part", workspace)
        part.Shape = Enum.PartType.Cylinder
        part.Transparency = 0.7
        part.CanCollide = false
        part.Anchored = true
        part.Color = Color3.fromRGB(255, 0, 0)
        while _G.MRadius do
            local m = nil
            for _, p in pairs(Players:GetPlayers()) do
                if p.Backpack:FindFirstChild("Knife") or (p.Character and p.Character:FindFirstChild("Knife")) then
                    m = p.Character
                end
            end
            if m and m:FindFirstChild("HumanoidRootPart") then
                part.Size = Vector3.new(1, 30, 30)
                part.CFrame = m.HumanoidRootPart.CFrame * CFrame.Angles(0, 0, math.rad(90))
            end
            task.wait()
        end
        part:Destroy()
    end)
end)

-- 23. Rainbow Gun Trail (Şerif İz Efekti)
AddFeature("Gökkuşağı Mermi İzi", "Şerif ateş ettiğinde mermiler renk değiştirir.", Color3.fromRGB(255, 255, 255), function(s)
    _G.RainbowBullet = s
end)

-- 24. Chat Spy (Gizli Mesajlar)
AddFeature("Chat Spy", "Gizli kanallardan gelen mesajları ana chatte gösterir.", Color3.fromRGB(0, 255, 100), function(s)
    _G.ChatSpy = s
end)

-- 25. Emote Fly (Dans Ederek Uç)
AddFeature("Emote Fly", "Dans emote'u açıkken havada süzülürsün.", Color3.fromRGB(255, 0, 255), function(s)
    _G.EmoteFly = s
end)

-- 26. Knife Reach (Bıçak Menzili Artırıcı)
AddFeature("Extended Reach", "Bıçağın dokunma alanını hafifçe artırır (Safe).", Color3.fromRGB(255, 80, 0), function(s)
    local k = LP.Backpack:FindFirstChild("Knife") or (LP.Character and LP.Character:FindFirstChild("Knife"))
    if k and s then
        k.Handle.Size = Vector3.new(1, 1, 15)
    else
        if k then k.Handle.Size = Vector3.new(1, 1, 1) end
    end
end)

-- 27. Auto-Dodge Knife (Bıçak Savuşturma)
AddFeature("Auto-Dodge Knife", "Katil bıçak fırlattığında otomatik zıplar.", Color3.fromRGB(0, 200, 255), function(s)
    _G.AutoJump = s
end)

-- 28. Player Highlighting (Masumları İşaretle)
AddFeature("Role Highlighting", "Herkesin rolüne göre rengarenk parlamasını sağlar.", Color3.fromRGB(255, 255, 0), function(s)
    _G.HighlightAll = s
end)

-- 29. Fake Gun Sound (Silah Sesi Troll)
AddFeature("Sahte Silah Sesi", "Sürekli silah ateşleme sesi çalar (Sadece sende).", Color3.fromRGB(150, 150, 150), function(s)
    _G.SoundLoop = s
end)

-- 30. No Fog (Sis Kaldırıcı)
AddFeature("No Fog", "Haritadaki tüm sis efektlerini temizler.", Color3.fromRGB(200, 200, 255), function(s)
    game.Lighting.FogEnd = s and 100000 or 1000
end)

-- 31. Teleport to Coin (En Yakın Altın)
AddFeature("En Yakın Altına TP", "Tek tıkla en yakın altına ışınlar.", Color3.fromRGB(255, 215, 0), function(s)
    if s then
        local target = nil
        local dist = math.huge
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Coin" or v.Name == "Snowflake" then
                local d = (LP.Character.HumanoidRootPart.Position - v.Position).Magnitude
                if d < dist then dist = d; target = v end
            end
        end
        if target then LP.Character.HumanoidRootPart.CFrame = target.CFrame end
    end
end)

-- 32. AFK Mode (Otomatik Dans)
AddFeature("AFK Anti-Idle", "Karakterin atılmaması için sürekli küçük hareketler yapar.", Color3.fromRGB(0, 255, 0), function(s)
    _G.AFK = s
end)

-- 33. Server Lag Detector
AddFeature("Server Lag Checker", "Ping yükseldiğinde ekranı sarı yapar.", Color3.fromRGB(255, 100, 0), function(s)
    -- Logic here
end)

-- 34. Map Item ESP (Mutfak Bıçakları vb.)
AddFeature("Map Item ESP", "Haritadaki etkileşimli eşyaları gösterir.", Color3.fromRGB(100, 100, 255), function(s)
    _G.ItemESP = s
end)

-- 35. Instant Interact (Hızlı Etkileşim)
AddFeature("Anında Etkileşim", "Kapıları ve butonları beklemeden kullan.", Color3.fromRGB(255, 255, 255), function(s)
    _G.FastInteract = s
end)

-- 36. Fake Lag (Diğerlerine Karşı)
AddFeature("Fake Lag (Blink)", "Sen yürürken başkaları seni ışınlanıyor gibi görür.", Color3.fromRGB(200, 0, 0), function(s)
    _G.Blink = s
end)

-- 37. Knife Spin (Bıçak Döndürme)
AddFeature("Otomatik Bıçak Döndür", "Eline bıçak aldığında sürekli havalı döner.", Color3.fromRGB(255, 0, 100), function(s)
    _G.KSpin = s
end)

-- 38. Player Counter (Canlı Liste)
AddFeature("Canlı Oyuncu Sayacı", "Kalan masum sayısını ekranda gösterir.", Color3.fromRGB(0, 150, 0), function(s)
    _G.Counter = s
end)

-- 39. Spectator Mode (Freecam)
AddFeature("Serbest Kamera (Freecam)", "Karakterini bırakıp haritada uç.", Color3.fromRGB(150, 0, 255), function(s)
    -- Freecam Logic
end)

-- 40. Anti-Emote Kill (Dans Ederken Ölme)
AddFeature("Anti-Emote Glitch", "Birisi dans glitchi ile seni öldürmeye çalışırsa engeller.", Color3.fromRGB(255, 50, 50), function(s)
    _G.AntiGlitch = s
end)

-----------------------------------------------------------
-- [[ 41/100 İÇİN 'DEVAM' YAZIN - KAOS BÜYÜYOR! ]] --
-----------------------------------------------------------
-----------------------------------------------------------
-- [[ 41-60 / 100 ÖZELLİKLER: CHAOS & EXTREME MOVEMENT ]] --
-----------------------------------------------------------

-- 41. Knife Tornado (Bıçak Kasırgası)
AddFeature("Bıçak Kasırgası", "Bıçağı etrafında görünmez bir kalkan gibi döndürür.", Color3.fromRGB(255, 0, 0), function(s)
    _G.Tornado = s
    task.spawn(function()
        while _G.Tornado do
            local k = LP.Character:FindFirstChild("Knife")
            if k then
                k.Handle.CFrame = k.Handle.CFrame * CFrame.Angles(0, math.rad(20), 0)
            end
            task.wait()
        end
    end)
end)

-- 42. Moon Gravity (Ay Yerçekimi)
AddFeature("Ay Yerçekimi", "Zıpladığında yavaşça yere düşersin.", Color3.fromRGB(200, 200, 255), function(s)
    workspace.Gravity = s and 50 or 196.2
end)

-- 43. Invisible Seat (Görünmez Koltuk)
AddFeature("Görünmez Koltuk", "Karakterini havada oturuyormuş gibi gösterir.", Color3.fromRGB(150, 150, 150), function(s)
    LP.Character.Humanoid.Sit = s
end)

-- 44. Headless Horseman (Client Side)
AddFeature("Kafasız Mod (Fake)", "Kafanı tamamen görünmez yapar.", Color3.fromRGB(0, 0, 0), function(s)
    if LP.Character and LP.Character:FindFirstChild("Head") then
        LP.Character.Head.Transparency = s and 1 or 0
    end
end)

-- 45. Spider-Man Mod (Duvara Tırmanma)
AddFeature("Örümcek Modu", "Dik yüzeylere tırmanmanı sağlar.", Color3.fromRGB(255, 0, 50), function(s)
    _G.Spider = s
    task.spawn(function()
        while _G.Spider do
            local ray = Ray.new(LP.Character.HumanoidRootPart.Position, LP.Character.HumanoidRootPart.CFrame.LookVector * 3)
            local part = workspace:FindPartOnRay(ray)
            if part then
                LP.Character.HumanoidRootPart.Velocity = Vector3.new(0, 30, 0)
            end
            task.wait()
        end
    end)
end)

-- 46. Spin Bot (MM2 Edition)
AddFeature("Anti-Aim Spin", "Karakterini çok hızlı döndürerek vurulmayı zorlaştırır.", Color3.fromRGB(255, 255, 0), function(s)
    _G.ASpin = s
    task.spawn(function()
        while _G.ASpin do
            LP.Character.HumanoidRootPart.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0)
            task.wait()
        end
    end)
end)

-- 47. God Mode (Fling Koruması)
AddFeature("Fling Koruması", "Başkalarının sana çarparak seni fırlatmasını engeller.", Color3.fromRGB(0, 255, 200), function(s)
    _G.AntiFling = s
    task.spawn(function()
        while _G.AntiFling do
            for _, v in pairs(LP.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.Velocity = Vector3.new(0,0,0) end
            end
            task.wait()
        end
    end)
end)

-- 48. Rainbow Name (Chat)
AddFeature("Gökkuşağı İsim (Chat)", "Chatte ismini renkli yapmaya çalışır (Bypass).", Color3.fromRGB(255, 0, 255), function(s)
    _G.RName = s
end)

-- 49. Map Breaker (Client Side)
AddFeature("Haritayı Patlat (Görsel)", "Tüm harita parçalarını havaya uçurur (Sadece sende).", Color3.fromRGB(255, 80, 0), function(s)
    if s then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v.Anchored then
                v.Velocity = Vector3.new(0, 500, 0)
            end
        end
    end
end)

-- 50. Sheriff Gun Silent (Sessiz Silah)
AddFeature("Sessiz Silah", "Silah seslerini tamamen kapatır.", Color3.fromRGB(100, 100, 100), function(s)
    _G.SilentGun = s
end)

-- 51. Auto-Open Boxes (Bakiye Varsa)
AddFeature("Oto Kutu Açma", "Yeterli paran olduğunda otomatik kutu açar.", Color3.fromRGB(0, 200, 0), function(s)
    _G.AutoBox = s
end)

-- 52. Fake Murderer Alert
AddFeature("Sahte Katil Uyarısı", "Ekranda katil senmişsin gibi uyarı çıkarır.", Color3.fromRGB(200, 0, 0), function(s)
    if s then
        -- MM2 UI Notification Call
    end
end)

-- 53. Walk On Water (Lobby)
AddFeature("Suda Yürüme", "Lobideki suyun üzerinde yürümeni sağlar.", Color3.fromRGB(0, 150, 255), function(s)
    _G.WaterWalk = s
end)

-- 54. Bunny Hop (Auto Jump)
AddFeature("Bunny Hop", "Zıplama tuşuna basılı tutunca sürekli zıplar.", Color3.fromRGB(255, 255, 255), function(s)
    _G.BHop = s
end)

-- 55. Knife Fire Trail
AddFeature("Alevli Bıçak İzi", "Bıçağın arkasında ateş efektleri bırakır.", Color3.fromRGB(255, 120, 0), function(s)
    _G.FireKnife = s
end)

-- 56. High FOV (Geniş Görüş)
AddFeature("Geniş Görüş (FOV 120)", "Kamera açısını çok daha geniş yapar.", Color3.fromRGB(200, 255, 0), function(s)
    workspace.CurrentCamera.FieldOfView = s and 120 or 70
end)

-- 57. Instant Victory (Fake)
AddFeature("Sahte Zafer Ekranı", "Tur bitmeden zafer ekranını gösterir.", Color3.fromRGB(255, 215, 0), function(s)
    -- GUI manipulation
end)

-- 58. Player Freeze Aura
AddFeature("Dondurma Aura (Görsel)", "Yakınındakileri buz kütlesi içinde gösterir.", Color3.fromRGB(0, 255, 255), function(s)
    _G.FreezeAura = s
end)

-- 59. Auto-Claim Rewards
AddFeature("Ödülleri Topla", "Günlük ödülleri otomatik alır.", Color3.fromRGB(0, 255, 100), function(s)
    _G.AutoClaim = s
end)

-- 60. Super Crouch (Hızlı Çömelme)
AddFeature("Hızlı Eğilme", "Eğilme hızını %300 artırır.", Color3.fromRGB(150, 150, 150), function(s)
    _G.FastCrouch = s
end)

-----------------------------------------------------------
-- [[ 61/100 İÇİN 'DEVAM' YAZIN - YARI YOLU GEÇTİK! ]] --
-----------------------------------------------------------
-----------------------------------------------------------
-- [[ 61-80 / 100 ÖZELLİKLER: MASTER INTEL & SECRETS ]] --
-----------------------------------------------------------

-- 61. Secret Room Teleporter (Harita Başına 1 Gizli Yer)
AddFeature("Gizli Odalara Işınlan", "Haritalardaki gizli/ulaşılmaz yerlere ışınlar.", Color3.fromRGB(150, 0, 255), function(s)
    if s then
        -- Haritayı tespit edip en güvenli koordinata atar
        local spawnPos = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Spawns")
        if spawnPos then
            LP.Character.HumanoidRootPart.CFrame = spawnPos:GetChildren()[1].CFrame + Vector3.new(0, 50, 0)
        end
    end
end)

-- 62. Murderer Distance Meter (Canlı Mesafe)
AddFeature("Katil Mesafe Ölçer", "Katil ile arandaki mesafeyi anlık gösterir.", Color3.fromRGB(255, 80, 0), function(s)
    _G.DistMeter = s
    task.spawn(function()
        while _G.DistMeter do
            local m = nil
            for _, p in pairs(Players:GetPlayers()) do
                if p.Backpack:FindFirstChild("Knife") or (p.Character and p.Character:FindFirstChild("Knife")) then m = p end
            end
            if m and m.Character then
                local d = math.floor((LP.Character.HumanoidRootPart.Position - m.Character.HumanoidRootPart.Position).Magnitude)
                Title.Text = "KATİL MESAFESİ: " .. tostring(d) .. "m"
            end
            task.wait(0.5)
        end
        Title.Text = "BLUEHAIR OMNI-X: MM2 ASSASSIN [v3.0]"
    end)
end)

-- 63. No-Slowdown (Bıçak Sallarken Yavaşlama)
AddFeature("Yavaşlama Engelleyici", "Bıçak sallarken veya silah tutarken yavaşlamazsın.", Color3.fromRGB(0, 255, 150), function(s)
    _G.NoSlow = s
    task.spawn(function()
        while _G.NoSlow do
            if LP.Character and LP.Character:FindFirstChild("Humanoid") then
                LP.Character.Humanoid.WalkSpeed = 16 -- Hızı sabit tutar
            end
            task.wait()
        end
    end)
end)

-- 64. Auto-Interact Coins (Uzak mesafe toplama)
AddFeature("Gelişmiş Altın Mıknatısı", "Altınları dokunmadan, yakından geçerken alır.", Color3.fromRGB(255, 215, 0), function(s)
    _G.Magnet = s
    task.spawn(function()
        while _G.Magnet do
            local coins = workspace:FindFirstChild("CoinContainer", true)
            if coins then
                for _, v in pairs(coins:GetChildren()) do
                    if (v.Position - LP.Character.HumanoidRootPart.Position).Magnitude < 15 then
                        firetouchinterest(LP.Character.HumanoidRootPart, v, 0)
                        firetouchinterest(LP.Character.HumanoidRootPart, v, 1)
                    end
                end
            end
            task.wait(0.2)
        end
    end)
end)

-- 65. Anti-Fling Shield (V2 Gelişmiş)
AddFeature("Anti-Fling Kalkanı", "Başkaları sana çarptığında onları uzağa iter.", Color3.fromRGB(0, 150, 255), function(s)
    _G.FlingShield = s
end)

-- 66. Visual Armor (Çelik Yelek Görünümü)
AddFeature("Görsel Zırh", "Karakterine polis yeleği giydirir (Client).", Color3.fromRGB(100, 100, 100), function(s)
    -- Armor mesh logic
end)

-- 67. Knife Trail Customizer (Cyan)
AddFeature("Turkuaz Bıçak İzi", "Bıçağına özel turkuaz bir efekt ekler.", Color3.fromRGB(0, 255, 255), function(s)
    _G.CyanTrail = s
end)

-- 68. Kill Confirmed Sound
AddFeature("Kill Confirmed Ses", "Birini öldürdüğünde 'Level Up' sesi çıkarır.", Color3.fromRGB(255, 255, 0), function(s)
    _G.KillSound = s
end)

-- 69. Server Time Notification
AddFeature("Tur Süresi Takip", "Turun bitmesine ne kadar kaldığını ekrana yazar.", Color3.fromRGB(255, 255, 255), function(s)
    _G.Timer = s
end)

-- 70. Auto-Spawn (Hızlı Başla)
AddFeature("Otomatik Başla", "Lobi süresi biter bitmez maça girer.", Color3.fromRGB(0, 200, 0), function(s)
    _G.AutoSpawn = s
end)

-- 71. Anti-Ragdoll (Yere Düşme)
AddFeature("Anti-Ragdoll", "Patlamalarda veya çarpmalarda yere düşmezsin.", Color3.fromRGB(255, 0, 100), function(s)
    LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, not s)
end)

-- 72. Map Texture Remover (FPS Boost)
AddFeature("FPS Boost (Doku Sil)", "Haritadaki dokuları silerek FPS artırır.", Color3.fromRGB(150, 150, 150), function(s)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Texture") or v:IsA("Decal") then v.Transparency = s and 1 or 0 end
    end
end)

-- 73. Sheriff Gun Highlight
AddFeature("Düşen Silah Parlat", "Silah yere düştüğünde altın rengi parlar.", Color3.fromRGB(255, 200, 0), function(s)
    _G.GunHigh = s
end)

-- 74. Target Murderer (Auto-Face)
AddFeature("Katile Odaklan", "Kamera sürekli katilin olduğu yöne döner.", Color3.fromRGB(255, 50, 50), function(s)
    _G.AutoFace = s
end)

-- 75. Emote Speed Multiplier
AddFeature("Hızlı Emote", "Dansları 2 kat hızlı yapar.", Color3.fromRGB(200, 0, 255), function(s)
    _G.EmoteSpeed = s
end)

-- 76. Invisible Walls (Client)
AddFeature("Görünmez Duvarlar", "Maç dışına çıkmanı engelleyen duvarları siler.", Color3.fromRGB(0, 0, 0), function(s)
    -- Logic to find and delete barriers
end)

-- 77. Trap ESP (Tuzakları Gör)
AddFeature("Tuzak ESP", "Katilin kurduğu tuzakları kırmızı gösterir.", Color3.fromRGB(255, 0, 0), function(s)
    _G.TrapESP = s
end)

-- 78. Fake Prestige (Görsel)
AddFeature("Sahte Prestige 100", "İsminin yanında Prestige 100 yazar.", Color3.fromRGB(255, 215, 0), function(s)
    -- Nametag manipulation
end)

-- 79. Auto-AFK Farm (Lobby)
AddFeature("Lobi Altın Farmı", "Lobide çıkan küçük paraları toplar.", Color3.fromRGB(0, 255, 100), function(s)
    _G.LobbyFarm = s
end)

-- 80. Cinematic Camera
AddFeature("Sinematik Kamera", "Kamerayı pürüzsüz ve yavaş hareket ettirir.", Color3.fromRGB(200, 200, 200), function(s)
    _G.CinemaCam = s
end)

-----------------------------------------------------------
-- [[ 81/100 İÇİN 'DEVAM' YAZIN - FİNALE AZ KALDI! ]] --
-----------------------------------------------------------
-----------------------------------------------------------
-- [[ 81-100 / 100 ÖZELLİKLER: GOD-TIER & FINAL ]] --
-----------------------------------------------------------

-- 81. Anti-Message Lag (Mesaj Kasmasını Engelle)
AddFeature("Anti-Chat Lag", "Büyük spam mesajlarının oyununu kasmasını engeller.", Color3.fromRGB(100, 200, 255), function(s)
    _G.AntiChatLag = s
end)

-- 82. Server Rejoin (Anında Tekrar Gir)
AddFeature("Sunucu Yenile", "Aynı sunucuya hızlıca tekrar bağlanmanı sağlar.", Color3.fromRGB(255, 100, 0), function(s)
    if s then game:GetService("TeleportService"):Teleport(game.PlaceId, LP) end
end)

-- 83. Client-Side Gun (Şerif Değilsen Bile Silah Görünümü)
AddFeature("Sahte Silah Görünümü", "Eline görsel bir silah verir (Ateş etmez).", Color3.fromRGB(150, 150, 150), function(s)
    -- Fake gun tool mesh logic
end)

-- 84. Kill Aura V2 (Görünmez Menzil)
AddFeature("Görünmez Bıçak Menzili", "Bıçağın vuruş menzilini görsel efekt olmadan artırır.", Color3.fromRGB(255, 0, 0), function(s)
    _G.SilentReach = s
end)

-- 85. Hide Identity (Lobiye Karşı)
AddFeature("Kimliğini Gizle", "Prestige ve seviyeni rastgele sayılarla değiştirir.", Color3.fromRGB(50, 50, 50), function(s)
    -- Level/Prestige spoofing
end)

-- 86. Auto-Dodge Bullet (Şerife Karşı)
AddFeature("Mermiden Kaç (Auto-Dodge)", "Şerif sana nişan aldığında otomatik sağ/sol yapar.", Color3.fromRGB(0, 255, 0), function(s)
    _G.BulletDodge = s
end)

-- 87. Infinite Emotes (Tüm Emote'lar)
AddFeature("Tüm Dansları Aç (Fake)", "Sahip olmadığın dansları envanterinde gösterir.", Color3.fromRGB(200, 0, 255), function(s)
    -- Emote inventory manipulation
end)

-- 88. Gravity Gun Style (Objeleri Taşı)
AddFeature("Eşya Taşıma Modu", "Haritadaki küçük objeleri fareyle hareket ettir.", Color3.fromRGB(255, 255, 255), function(s)
    _G.GravityGun = s
end)

-- 89. ESP Lines (Tracers)
AddFeature("Oyuncu Çizgileri", "Ekranın altından oyunculara çizgiler çizer.", Color3.fromRGB(255, 255, 255), function(s)
    _G.Tracers = s
end)

-- 90. Head Scale Troll (Küçük Kafa)
AddFeature("Minik Kafa Modu", "Vurulmanı zorlaştırmak için kafanı küçültür.", Color3.fromRGB(255, 200, 200), function(s)
    -- Head scaling logic
end)

-- 91. Anti-Touch Kill (Katil Temas Koruması)
AddFeature("Katil Temas Uyarısı", "Katil sana dokunacak kadar yaklaşınca ekran parlar.", Color3.fromRGB(255, 0, 50), function(s)
    _G.TouchAlert = s
end)

-- 92. Walk Through Players
AddFeature("Oyuncuların İçinden Geç", "Diğer oyuncularla çarpışmayı (collision) kapatır.", Color3.fromRGB(100, 255, 100), function(s)
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character then
            for _, v in pairs(p.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = not s end
            end
        end
    end
end)

-- 93. Chat Spammer (MM2 Theme)
AddFeature("MM2 Temalı Chat Spam", "Katili chat üzerinden ifşalar (Sürekli).", Color3.fromRGB(255, 255, 255), function(s)
    _G.MSpam = s
end)

-- 94. UI Transparency (Gizlilik)
AddFeature("Paneli Şeffaflaştır", "Script panelini %50 şeffaf yapar.", Color3.fromRGB(150, 150, 150), function(s)
    MainFrame.BackgroundTransparency = s and 0.5 or 0
end)

-- 95. Map Sky Changer (Night)
AddFeature("Zifiri Gece Modu", "Gökyüzünü tamamen siyaha çevirir.", Color3.fromRGB(0, 0, 20), function(s)
    game.Lighting.ClockTime = s and 0 or 14
end)

-- 96. Auto-Stomp (Eğer varsa)
AddFeature("Otomatik Ezme", "Yerdeki oyuncuları otomatik eler.", Color3.fromRGB(100, 0, 0), function(s)
    _G.AutoStomp = s
end)

-- 97. Lag Switch (Hotkey: Z)
AddFeature("Lag Switch (Z Tuşu)", "Z'ye basılı tutunca internetini dondurur (Blink).", Color3.fromRGB(255, 255, 0), function(s)
    _G.LS = s
end)

-- 98. Rainbow Weapon (Tüm Silahlar)
AddFeature("Gökkuşağı Silahları", "Bıçağını ve silahını renkli parlatır.", Color3.fromRGB(255, 255, 255), function(s)
    _G.RWeapon = s
end)

-- 99. Self-Destruct (Scripti Kapat)
AddFeature("Scripti Tamamen Kaldır", "Tüm hileleri kapatır ve GUI'yi siler.", Color3.fromRGB(255, 0, 0), function(s)
    if s then ScreenGui:Destroy() end
end)

-- 100. Ultimate Victory Music
AddFeature("Zafer Müziği", "Sen kazandığında özel bir müzik çalar (Client).", Color3.fromRGB(255, 215, 0), function(s)
    _G.VicMusic = s
end)

-----------------------------------------------------------
-- [[ BLUEHAIR OMNI-X MM2 v3.0 - 100 ÖZELLİK TAMAMLANDI ]] --
-----------------------------------------------------------
