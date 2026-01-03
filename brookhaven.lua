local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- [[ OMNI-SINGLE MODULAR INTERFACE ]] --
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 450, 0, 600)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Active = true
MainFrame.Draggable = true

local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "BLUEHAIR OMNI-X [MODULAR]"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -20, 1, -70)
Scroll.Position = UDim2.new(0, 10, 0, 60)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4
Scroll.CanvasSize = UDim2.new(0, 0, 3, 0)

local List = Instance.new("UIListLayout", Scroll)
List.Padding = UDim.new(0, 8)
List.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- [[ MODULAR COMPONENT CREATOR ]] --
local function CreateFeature(name, color, callback)
    local Btn = Instance.new("TextButton", Scroll)
    Btn.Size = UDim2.new(0.95, 0, 0, 45)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 14
    local btnCorner = Instance.new("UICorner", Btn)
    btnCorner.CornerRadius = UDim.new(0, 8)
    
    local Accent = Instance.new("Frame", Btn)
    Accent.Size = UDim2.new(0, 4, 1, 0)
    Accent.BackgroundColor3 = color
    Instance.new("UICorner", Accent)

    local state = false
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.BackgroundColor3 = state and color or Color3.fromRGB(30, 30, 35)
        Btn.TextColor3 = state and Color3.new(1,1,1) or Color3.fromRGB(220, 220, 220)
        callback(state)
    end)
end

-----------------------------------------------------------
-- [[ 10 FARKLI GELİŞMİŞ ÖZELLİK ]] --
-----------------------------------------------------------

-- 1. Velocity Fling (FE Fırlatma)
CreateFeature("FE Velocity Fling", Color3.fromRGB(255, 50, 50), function(s)
    _G.Fling = s
    task.spawn(function()
        while _G.Fling do
            local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Velocity = Vector3.new(0, 50000, 0)
                hrp.RotVelocity = Vector3.new(50000, 50000, 50000)
            end
            RunService.Heartbeat:Wait()
        end
    end)
end)

-- 2. Anti-Bag (Envanter Koruması)
CreateFeature("Anti-Bag / Anti-Stun", Color3.fromRGB(50, 255, 100), function(s)
    LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, not s)
    LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not s)
end)

-- 3. Unanchored Vacuum (Parçaları Çek)
CreateFeature("Vacuum Unanchored Parts", Color3.fromRGB(150, 50, 255), function(s)
    _G.Vac = s
    while _G.Vac do
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(LP.Character) then
                v.CFrame = LP.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
            end
        end
        task.wait(0.1)
    end
end)

-- 4. Infinite Nitro (Araçlar İçin)
CreateFeature("Infinite Vehicle Nitro", Color3.fromRGB(255, 150, 0), function(s)
    RunService.RenderStepped:Connect(function()
        if s then
            local car = workspace.Vehicles:FindFirstChild(LP.Name .. "Vehicle")
            if car and car:FindFirstChild("DriveSeat") then
                car.DriveSeat.MaxSpeed = 500
                car.DriveSeat.Velocity = car.DriveSeat.CFrame.LookVector * 200
            end
        end
    end)
end)

-- 5. Ghost Mode (Duvarlardan Geç)
CreateFeature("Ghost Mode (Noclip)", Color3.fromRGB(0, 200, 255), function(s)
    _G.Ghost = s
    RunService.Stepped:Connect(function()
        if _G.Ghost then
            for _, v in pairs(LP.Character:GetChildren()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- 6. Remote Door Opener (Tüm Kapılar)
CreateFeature("Open All House Doors", Color3.fromRGB(200, 200, 50), function(s)
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Door" and v:FindFirstChild("ClickDetector") then
            fireclickdetector(v.ClickDetector)
        end
    end
end)

-- 7. Invisible Kill Aura (Yakınındakiler Uçar)
CreateFeature("Kill Aura (V2)", Color3.fromRGB(255, 0, 100), function(s)
    _G.KA = s
    while _G.KA do
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (p.Character.HumanoidRootPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude
                if dist < 15 then
                    p.Character.HumanoidRootPart.Velocity = Vector3.new(0, 1500, 0)
                end
            end
        end
        task.wait(0.1)
    end
end)

-- 8. Fullbright Engine
CreateFeature("Total Fullbright", Color3.fromRGB(255, 255, 255), function(s)
    game.Lighting.Brightness = s and 10 or 2
    game.Lighting.GlobalShadows = not s
end)

-- 9. Auto-Money Rob (Brookhaven Bank)
CreateFeature("Auto Bank Robber", Color3.fromRGB(0, 150, 0), function(s)
    if s then
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(-442, 23, -283) -- Banka Konumu
        task.wait(0.5)
        -- Patlayıcı ve para toplama logic buraya eklenebilir
    end
end)

-- 10. Click TP (Ctrl + Sol Tık)
CreateFeature("Click Teleport (Ctrl)", Color3.fromRGB(100, 100, 100), function(s)
    local mouse = LP:GetMouse()
    mouse.Button1Down:Connect(function()
        if s and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
            LP.Character.HumanoidRootPart.CFrame = mouse.Hit + Vector3.new(0, 3, 0)
        end
    end)
end)
-----------------------------------------------------------
-- [[ YENİ GELİŞMİŞ ÖZELLİKLER - GROK TARAFINDAN EKLENDİ ]] --
-----------------------------------------------------------

-- 11. Fly Mode (Uçma)
CreateFeature("Fly Mode (E Tuşu ile)", Color3.fromRGB(0, 255, 255), function(s)
    _G.FlyEnabled = s
    if s then
        local bodyGyro = Instance.new("BodyGyro")
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyGyro.P = 9000
        bodyGyro.MaxTorque = Vector3.new(900000, 900000, 900000)
        bodyVelocity.MaxForce = Vector3.new(900000, 900000, 900000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        
        task.spawn(function()
            while _G.FlyEnabled do
                local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    bodyGyro.Parent = hrp
                    bodyVelocity.Parent = hrp
                    bodyGyro.CFrame = workspace.CurrentCamera.CFrame
                    local moveDir = Vector3.new(
                        (UIS:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.A) and 1 or 0),
                        (UIS:IsKeyDown(Enum.KeyCode.E) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.Q) and 1 or 0),
                        (UIS:IsKeyDown(Enum.KeyCode.S) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.W) and 1 or 0)
                    )
                    bodyVelocity.Velocity = moveDir * 100
                end
                RunService.Heartbeat:Wait()
            end
            bodyGyro:Destroy()
            bodyVelocity:Destroy()
        end)
    end
end)

-- 12. Speed Hack (Yürüme Hızı)
CreateFeature("Super Speed Hack", Color3.fromRGB(255, 200, 0), function(s)
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = s and 100 or 16
    end
end)

-- 13. Infinite Jump (Sonsuz Zıplama)
CreateFeature("Infinite Jump", Color3.fromRGB(100, 255, 100), function(s)
    _G.InfJump = s
    UIS.JumpRequest:Connect(function()
        if _G.InfJump then
            LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end)

-- 14. Player ESP (Duvar Arkası Görme)
CreateFeature("Player ESP (Names & Boxes)", Color3.fromRGB(255, 0, 255), function(s)
    _G.ESP = s
    task.spawn(function()
        while _G.ESP do
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Character:FindFirstChild("Head") then
                    local head = p.Character.Head
                    if not head:FindFirstChild("ESPBillboard") then
                        local bill = Instance.new("BillboardGui", head)
                        bill.Name = "ESPBillboard"
                        bill.AlwaysOnTop = true
                        bill.Size = UDim2.new(0, 100, 0, 50)
                        bill.Adornee = head
                        
                        local nameLabel = Instance.new("TextLabel", bill)
                        nameLabel.Text = p.Name
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.TextColor3 = Color3.new(1, 0, 0)
                        nameLabel.TextStrokeTransparency = 0
                        nameLabel.TextSize = 14
                        
                        local box = Instance.new("BoxHandleAdornment", head)
                        box.Name = "ESPBox"
                        box.Adornee = p.Character
                        box.AlwaysOnTop = true
                        box.Size = p.Character:GetExtentsSize() + Vector3.new(0, 1, 0)
                        box.Color3 = Color3.new(1, 0, 0)
                        box.Transparency = 0.5
                    end
                end
            end
            task.wait(1)
        end
        -- Kapatınca temizle
        if not _G.ESP then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("Head") then
                    local head = p.Character.Head
                    if head:FindFirstChild("ESPBillboard") then
                        head.ESPBillboard:Destroy()
                        head.ESPBox:Destroy()
                    end
                end
            end
        end
    end)
end)

-- 15. Auto Farm Money (Basit Para Toplama - Banka/İş Yerleri)
CreateFeature("Auto Farm Money (Loop)", Color3.fromRGB(0, 255, 0), function(s)
    _G.AutoFarm = s
    task.spawn(function()
        while _G.AutoFarm do
            -- Brookhaven'de para genellikle iş yerlerinden veya ATM'den gelir, basit bir loop
            -- Gerçek remote'lar varsa fire edebilirsin, ama genel bir TP loop
            local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(-442, 23, -283) -- Banka
                task.wait(2)
                hrp.CFrame = CFrame.new(workspace:FindFirstChild("ATM") and workspace.ATM.Position or Vector3.new(0,0,0))
                task.wait(5)
            end
            task.wait(10)
        end
    end)
end)

-- 16. Teleport to Players (Oyuncuya TP)
CreateFeature("TP to Nearest Player", Color3.fromRGB(255, 100, 255), function(s)
    if s then
        local closest = nil
        local dist = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local d = (p.Character.HumanoidRootPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = p
                end
            end
        end
        if closest then
            LP.Character.HumanoidRootPart.CFrame = closest.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
        end
    end
end)

-- 17. God Mode (Ölümsüzlük - Health Lock)
CreateFeature("God Mode (Invincible)", Color3.fromRGB(255, 255, 0), function(s)
    task.spawn(function()
        while s do
            if LP.Character and LP.Character:FindFirstChild("Humanoid") then
                LP.Character.Humanoid.Health = 100
                LP.Character.Humanoid.MaxHealth = 100
            end
            task.wait()
        end
    end)
end)

-- Bonus: Kapatma butonu falan eklemedim ama istersen söyle daha da geliştiririm 🚀

-----------------------------------------------------------
-- [[ SCRIPT BİTTİ - HAVE FUN CHAOS TIME ]] --
-----------------------------------------------------------
-- 18. Fly Mode (Uçma Özelliği)
CreateFeature("Fly Mode", Color3.fromRGB(0, 150, 255), function(s)
    _G.Fly = s
    task.spawn(function()
        local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        while _G.Fly and hrp do
            hrp.Velocity = Vector3.new(0, 50, 0) -- yukarı doğru hız
            task.wait(0.1)
        end
    end)
end)

-- 19. Size Manipulation (Dev / Minik Mod)
CreateFeature("Size Manipulation", Color3.fromRGB(200, 50, 200), function(s)
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        if s then
            LP.Character.Humanoid.BodyHeightScale.Value = 5
            LP.Character.Humanoid.BodyWidthScale.Value = 5
        else
            LP.Character.Humanoid.BodyHeightScale.Value = 1
            LP.Character.Humanoid.BodyWidthScale.Value = 1
        end
    end
end)

-- 20. Vehicle Speed Boost (Araç Hızı Artırma)
CreateFeature("Vehicle Speed Boost", Color3.fromRGB(255, 120, 0), function(s)
    _G.CarBoost = s
    task.spawn(function()
        while _G.CarBoost do
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChild("DriveSeat") then
                    local seat = v.DriveSeat
                    if seat.Occupant == LP.Character:FindFirstChild("Humanoid") then
                        v.PrimaryPart.Velocity = v.PrimaryPart.Velocity * 2
                    end
                end
            end
            task.wait(1)
        end
    end)
end)

-- 21. Fake Money Rain (Sahte Para Yağmuru)
CreateFeature("Fake Money Rain", Color3.fromRGB(0, 255, 150), function(s)
    _G.MoneyRain = s
    task.spawn(function()
        while _G.MoneyRain do
            local cash = Instance.new("Part", workspace)
            cash.Size = Vector3.new(1,1,1)
            cash.Position = LP.Character.HumanoidRootPart.Position + Vector3.new(math.random(-10,10), 20, math.random(-10,10))
            cash.Anchored = false
            cash.BrickColor = BrickColor.new("Bright green")
            task.wait(0.5)
        end
    end)
end)

-- 22. Clone Army (Kendi Klonlarını Spawnla)
CreateFeature("Clone Army", Color3.fromRGB(255, 50, 50), function(s)
    if s and LP.Character then
        for i = 1,5 do
            local clone = LP.Character:Clone()
            clone.Parent = workspace
            clone:MoveTo(LP.Character.HumanoidRootPart.Position + Vector3.new(i*3,0,0))
        end
    end
end)

-- 23. Random Teleport (Rastgele Işınlanma)
CreateFeature("Random Teleport", Color3.fromRGB(100, 100, 255), function(s)
    if s and LP.Character then
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(math.random(-500,500), 50, math.random(-500,500))
        end
    end
end)
-----------------------------------------------------------
-- [[ YENİ NESİL KAOS ÖZELLİKLERİ - GEMINI TARAFINDAN EKLENDİ ]] --
-----------------------------------------------------------

-- 24. Car Jump (Araç Zıplatma - Space Tuşu)
CreateFeature("Araç Zıplatma (Space)", Color3.fromRGB(0, 120, 255), function(s)
    _G.CarJump = s
    UIS.JumpRequest:Connect(function()
        if _G.CarJump then
            local car = workspace.Vehicles:FindFirstChild(LP.Name .. "Vehicle")
            if car and car:FindFirstChild("DriveSeat") then
                local seat = car.DriveSeat
                if seat.Occupant == LP.Character:FindFirstChild("Humanoid") then
                    car.PrimaryPart.Velocity = car.PrimaryPart.Velocity + Vector3.new(0, 50, 0)
                end
            end
        end
    end)
end)

-- 25. Silent Invisible (Görünmezlik - FE Denemesi)
CreateFeature("Görünmezlik (FE)", Color3.fromRGB(150, 150, 150), function(s)
    if LP.Character then
        for _, v in pairs(LP.Character:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = s and 1 or 0
            end
        end
        if LP.Character:FindFirstChild("Head") and LP.Character.Head:FindFirstChild("face") then
            LP.Character.Head.face.Transparency = s and 1 or 0
        end
    end
end)

-- 26. Rainbow Body (Gökkuşağı Karakter)
CreateFeature("Gökkuşağı Karakter", Color3.fromRGB(255, 0, 0), function(s)
    _G.RainbowBody = s
    task.spawn(function()
        while _G.RainbowBody do
            local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
            if LP.Character then
                for _, v in pairs(LP.Character:GetChildren()) do
                    if v:IsA("BasePart") then v.Color = color end
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- 27. Gravity Controller (Yerçekimi Ayarı)
CreateFeature("Düşük Yerçekimi", Color3.fromRGB(200, 200, 255), function(s)
    workspace.Gravity = s and 50 or 196.2
end)

-- 28. House Fire Troll (Tüm Evleri Yak - Görsel)
CreateFeature("Ev Yangını Troll (Görsel)", Color3.fromRGB(255, 100, 0), function(s)
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "House" or v.Name:find("Home") then
            if s then
                local fire = Instance.new("Fire", v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart)
                fire.Size = 20; fire.Name = "TrollFire"
            else
                if v:FindFirstChild("TrollFire", true) then v:FindFirstChild("TrollFire", true):Destroy() end
            end
        end
    end
end)

-- 29. Spin Bot (Hızlı Dönme)
CreateFeature("Spin Bot", Color3.fromRGB(255, 255, 0), function(s)
    _G.SpinBot = s
    task.spawn(function()
        while _G.SpinBot do
            if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                LP.Character.HumanoidRootPart.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0)
            end
            task.wait()
        end
    end)
end)

-- 30. Headless / Korblox (Client Side)
CreateFeature("Korblox + Headless", Color3.fromRGB(0, 0, 0), function(s)
    if LP.Character then
        if s then
            if LP.Character:FindFirstChild("Head") then LP.Character.Head.Transparency = 1 end
            if LP.Character:FindFirstChild("RightUpperLeg") then LP.Character.RightUpperLeg:Destroy() end
        end
    end
end)

-- 31. Walk on Water (Suda Yürüme)
CreateFeature("Suda Yürüme", Color3.fromRGB(0, 255, 200), function(s)
    if s then
        local p = Instance.new("Part", workspace)
        p.Name = "WaterWalk"
        p.Size = Vector3.new(1000, 1, 1000)
        p.Position = Vector3.new(0, -2, 0) -- Su seviyesine göre ayarla
        p.Anchored = true; p.Transparency = 0.8
    else
        if workspace:FindFirstChild("WaterWalk") then workspace.WaterWalk:Destroy() end
    end
end)

-- 32. Chat Bypass / Spam (Admin Yazısı)
CreateFeature("Admin Duyuru Spam", Color3.fromRGB(255, 20, 147), function(s)
    _G.AdminSpam = s
    while _G.AdminSpam do
        RS.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("[SERVER]: BlueHair Hub Kullanıcısı Tespit Edildi!", "All")
        task.wait(5)
    end
end)

-- 33. Black Hole (Parçaları Havaya Uçur)
CreateFeature("Karadelik Modu", Color3.fromRGB(40, 0, 80), function(s)
    _G.BlackHole = s
    task.spawn(function()
        while _G.BlackHole do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v.Anchored and v.Parent ~= LP.Character then
                    v.Velocity = Vector3.new(0, 100, 0)
                end
            end
            task.wait(0.5)
        end
    end)
end)

-- 34. Camera Shake (Deprem Etkisi)
CreateFeature("Deprem Efekti (Client)", Color3.fromRGB(139, 69, 19), function(s)
    _G.Shake = s
    task.spawn(function()
        while _G.Shake do
            local cam = workspace.CurrentCamera
            cam.CFrame = cam.CFrame * CFrame.new(math.random(-1,1)/10, math.random(-1,1)/10, math.random(-1,1)/10)
            task.wait()
        end
    end)
end)

-- 35. Night Mode (Gece Modu)
CreateFeature("Zifiri Karanlık", Color3.fromRGB(25, 25, 112), function(s)
    game.Lighting.ClockTime = s and 0 or 14
end)
-----------------------------------------------------------
-- [[ YENİ KAOS DALGASI - GROK 4 TARAFINDAN EKLENDİ ]] --
-----------------------------------------------------------

-- 36. Particle Aura (Etrafında Parıltı Efekti)
CreateFeature("Particle Aura (Glow)", Color3.fromRGB(0, 255, 255), function(s)
    _G.ParticleAura = s
    task.spawn(function()
        local attachment = Instance.new("Attachment", LP.Character:FindFirstChild("HumanoidRootPart"))
        local particles = Instance.new("ParticleEmitter", attachment)
        particles.Texture = "rbxassetid://241353019" -- Klasik sparkle
        particles.Lifetime = NumberRange.new(1, 3)
        particles.Rate = 200
        particles.Speed = NumberRange.new(5, 15)
        particles.SpreadAngle = Vector2.new(360, 360)
        particles.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
        }
        
        while _G.ParticleAura do
            particles.Enabled = true
            task.wait(0.1)
        end
        particles.Enabled = false
        particles:Destroy()
        attachment:Destroy()
    end)
end)

-- 37. Explosive Touch (Dokunduğun Yer Patlasın)
CreateFeature("Dokunma Patlaması", Color3.fromRGB(255, 80, 0), function(s)
    _G.ExplosiveTouch = s
    task.spawn(function()
        while _G.ExplosiveTouch do
            for _, part in pairs(LP.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Touched:Connect(function(hit)
                        if hit.Parent and hit.Parent ~= LP.Character and not hit.Parent:FindFirstChild("Humanoid") == LP.Character.Humanoid then
                            local exp = Instance.new("Explosion")
                            exp.Position = hit.Position
                            exp.BlastRadius = 15
                            exp.BlastPressure = 500000
                            exp.Parent = workspace
                        end
                    end)
                end
            end
            task.wait(0.2)
        end
    end)
end)

-- 38. Freeze Players (Yakındaki Oyuncuları Dondur)
CreateFeature("Freeze Aura (Dondur)", Color3.fromRGB(100, 200, 255), function(s)
    _G.FreezeAura = s
    task.spawn(function()
        while _G.FreezeAura do
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (p.Character.HumanoidRootPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 20 then
                        p.Character.HumanoidRootPart.Anchored = true
                        if not p.Character.HumanoidRootPart:FindFirstChild("IceBlock") then
                            local ice = Instance.new("Part", p.Character.HumanoidRootPart)
                            ice.Name = "IceBlock"
                            ice.Size = Vector3.new(6,8,6)
                            ice.Transparency = 0.6
                            ice.BrickColor = BrickColor.new("Light blue")
                            ice.CanCollide = false
                            ice.Anchored = true
                            local weld = Instance.new("WeldConstraint", ice)
                            weld.Part0 = ice
                            weld.Part1 = p.Character.HumanoidRootPart
                        end
                    else
                        p.Character.HumanoidRootPart.Anchored = false
                        if p.Character.HumanoidRootPart:FindFirstChild("IceBlock") then
                            p.Character.HumanoidRootPart.IceBlock:Destroy()
                        end
                    end
                end
            end
            task.wait(0.5)
        end
        -- Kapatınca temizle
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Anchored = false
                if p.Character.HumanoidRootPart:FindFirstChild("IceBlock") then
                    p.Character.HumanoidRootPart.IceBlock:Destroy()
                end
            end
        end
    end)
end)

-- 39. Fake Lag (Sunucu Lagı Taklidi - Görsel Troll)
CreateFeature("Fake Lag Troll", Color3.fromRGB(200, 0, 200), function(s)
    _G.FakeLag = s
    task.spawn(function()
        while _G.FakeLag do
            LP.Character.HumanoidRootPart.CFrame = LP.Character.HumanoidRootPart.CFrame + Vector3.new(math.random(-5,5), 0, math.random(-5,5))
            task.wait(0.05)
            LP.Character.HumanoidRootPart.CFrame = LP.Character.HumanoidRootPart.CFrame - Vector3.new(math.random(-5,5), 0, math.random(-5,5))
            task.wait(0.3)
        end
    end)
end)

-- 40. Disco Lights (Tüm Işıkları Disco Yap)
CreateFeature("Disco Harita Işıkları", Color3.fromRGB(255, 20, 255), function(s)
    _G.Disco = s
    task.spawn(function()
        while _G.Disco do
            for _, light in pairs(game.Lighting:GetChildren()) do
                if light:IsA("Light") then
                    light.Color = Color3.fromHSV(tick() % 1, 1, 1)
                end
            end
            for _, part in pairs(workspace:GetDescendants()) do
                if part:FindFirstChildOfClass("Light") then
                    part:FindFirstChildOfClass("Light").Color = Color3.fromHSV(tick() % 1, 1, 1)
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- Bonus Kaos: GUI'ye Kapatma Butonu Ekleyelim (Artık Çok Doldu 😈)
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 24
local closeCorner = Instance.new("UICorner", CloseBtn)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
-----------------------------------------------------------
-- [[ KAOS SEVİYESİ 3: OMNI-REFINEMENT - GEMINI 3 FLASH ]] --
-----------------------------------------------------------

-- 41. Server Destroyer (Tüm Unanchored Parçaları Fırlat)
CreateFeature("Server Chaos (Fizik Bozucu)", Color3.fromRGB(255, 0, 0), function(s)
    _G.PhysX = s
    task.spawn(function()
        while _G.PhysX do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v.Anchored then
                    v.Velocity = Vector3.new(math.random(-500,500), 1000, math.random(-500,500))
                    v.RotVelocity = Vector3.new(500, 500, 500)
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- 42. Skybox Glitch (Gökyüzü Efekti)
CreateFeature("Glitchy Sky (Görsel)", Color3.fromRGB(0, 0, 0), function(s)
    if s then
        local sbox = Instance.new("Sky", game.Lighting)
        sbox.Name = "GlitchSky"
        sbox.SkyboxBk = "rbxassetid://1562306714"
        sbox.SkyboxDn = "rbxassetid://1562306714"
        sbox.SkyboxFt = "rbxassetid://1562306714"
        sbox.SkyboxLf = "rbxassetid://1562306714"
        sbox.SkyboxRt = "rbxassetid://1562306714"
        sbox.SkyboxUp = "rbxassetid://1562306714"
    else
        if game.Lighting:FindFirstChild("GlitchSky") then game.Lighting.GlitchSky:Destroy() end
    end
end)

-- 43. Ultimate Shield (Dokunulmaz Kalkan)
CreateFeature("Enerji Kalkanı (Shield)", Color3.fromRGB(0, 100, 255), function(s)
    _G.Shield = s
    if s then
        local force = Instance.new("ForceField", LP.Character)
        force.Name = "OmniShield"
        force.Visible = true
    else
        if LP.Character:FindFirstChild("OmniShield") then LP.Character.OmniShield:Destroy() end
    end
end)

-- 44. Player Follower (En Yakın Oyuncuyu İzle)
CreateFeature("En Yakın Oyuncuyu Takip Et", Color3.fromRGB(255, 255, 255), function(s)
    _G.Follow = s
    task.spawn(function()
        while _G.Follow do
            local closest = nil
            local dist = math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (p.Character.HumanoidRootPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude
                    if d < dist then
                        dist = d
                        closest = p
                    end
                end
            end
            if closest then
                LP.Character.Humanoid:MoveTo(closest.Character.HumanoidRootPart.Position)
            end
            task.wait(0.1)
        end
    end)
end)

-- 45. Spin-Kill (Dönerek Fırlat)
CreateFeature("Spin-Kill Aura", Color3.fromRGB(255, 255, 0), function(s)
    _G.SpinKill = s
    task.spawn(function()
        while _G.SpinKill do
            if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                LP.Character.HumanoidRootPart.RotVelocity = Vector3.new(0, 1000, 0)
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local d = (p.Character.HumanoidRootPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude
                        if d < 10 then
                            p.Character.HumanoidRootPart.Velocity = LP.Character.HumanoidRootPart.CFrame.LookVector * 1000
                        end
                    end
                end
            end
            task.wait()
        end
    end)
end)

-- 46. Head Size Troll (Kafa Büyütme - Client)
CreateFeature("Dev Kafa Modu", Color3.fromRGB(255, 150, 150), function(s)
    if LP.Character and LP.Character:FindFirstChild("Head") then
        local mesh = LP.Character.Head:FindFirstChildOfClass("SpecialMesh")
        if mesh then
            mesh.Scale = s and Vector3.new(5, 5, 5) or Vector3.new(1.2, 1.2, 1.2)
        end
    end
end)

-- 47. Fire Trail (Ateş İzi)
CreateFeature("Ateş İzi (Trail)", Color3.fromRGB(255, 69, 0), function(s)
    _G.FireTrail = s
    task.spawn(function()
        while _G.FireTrail do
            local p = Instance.new("Part", workspace)
            p.Size = Vector3.new(1, 0.2, 1)
            p.Position = LP.Character.HumanoidRootPart.Position - Vector3.new(0, 2, 0)
            p.Anchored = true
            p.CanCollide = false
            p.BrickColor = BrickColor.new("Bright orange")
            local fire = Instance.new("Fire", p)
            fire.Size = 5
            task.delay(2, function() p:Destroy() end)
            task.wait(0.1)
        end
    end)
end)

-- 48. Anti-AFK (Oyundan Atılma Koruması)
CreateFeature("Anti-AFK Sistemi", Color3.fromRGB(0, 255, 0), function(s)
    if s then
        LP.Idled:Connect(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end)
    end
end)

-- 49. Map Blackout (Tüm Işıkları Kapat)
CreateFeature("Tüm Şehri Karart", Color3.fromRGB(50, 50, 50), function(s)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("SpotLight") or v:IsA("PointLight") or v:IsA("SurfaceLight") then
            v.Enabled = not s
        end
    end
    game.Lighting.Brightness = s and 0 or 2
end)

-- 50. Jumpscare Sound Troll (Sadece Sende Çalar)
CreateFeature("Kaos Sesi (Sadece Client)", Color3.fromRGB(139, 0, 0), function(s)
    _G.SoundTroll = s
    task.spawn(function()
        local sound = Instance.new("Sound", game.CoreGui)
        sound.SoundId = "rbxassetid://4590662762" -- Yüksek sesli bir efekt
        sound.Volume = 2
        sound.Looped = true
        if s then sound:Play() else sound:Stop() end
    end)
end)
-----------------------------------------------------------
-- [[ KAOS SEVİYESİ 4: GROK ULTRA-CHAOS - xAI POWERED ]] --
-----------------------------------------------------------
-- 51. Para Magneti (Yerdeki Paraları Çek - Brookhaven Özel)
CreateFeature("Para Magneti (Money Pull)", Color3.fromRGB(0, 255, 100), function(s)
    _G.MoneyMagnet = s
    task.spawn(function()
        while _G.MoneyMagnet do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:find("Cash") or v.Name:find("Money") or v.BrickColor == BrickColor.new("Bright green")) and not v:IsDescendantOf(LP.Character) then
                    v.Velocity = (LP.Character.HumanoidRootPart.Position - v.Position).Unit * 50
                    v.CFrame = CFrame.new(v.Position, LP.Character.HumanoidRootPart.Position)
                end
            end
            task.wait(0.05)
        end
    end)
end)

-- 52. Araç Çarpıtıcı (Yakındaki Araçları Havaya Fırlat)
CreateFeature("Vehicle Launcher", Color3.fromRGB(255, 100, 0), function(s)
    _G.VehLauncher = s
    task.spawn(function()
        while _G.VehLauncher do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("VehicleSeat") and v.PrimaryPart then
                    local dist = (v.PrimaryPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 50 then
                        v.PrimaryPart.Velocity = Vector3.new(math.random(-200,200), 300, math.random(-200,200))
                    end
                end
            end
            task.wait(0.3)
        end
    end)
end)

-- 53. Pozisyon Değiştirici (Oyuncuları Yer Değiştir)
CreateFeature("Player Swap Troll", Color3.fromRGB(150, 0, 255), function(s)
    if s then
        local players = Players:GetPlayers()
        for i = 1, #players - 1 do
            local p1 = players[i]
            local p2 = players[i+1]
            if p1 ~= LP and p2 ~= LP and p1.Character and p2.Character and p1.Character:FindFirstChild("HumanoidRootPart") and p2.Character:FindFirstChild("HumanoidRootPart") then
                local temp = p1.Character.HumanoidRootPart.CFrame
                p1.Character.HumanoidRootPart.CFrame = p2.Character.HumanoidRootPart.CFrame
                p2.Character.HumanoidRootPart.CFrame = temp
            end
        end
    end
end)

-- 54. Sahte Ban Mesajı (Chat Spam)
CreateFeature("Fake Ban Chat Spam", Color3.fromRGB(255, 0, 150), function(s)
    _G.FakeBan = s
    task.spawn(function()
        while _G.FakeBan do
            RS.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("[ADMIN] " .. LP.Name .. " Sunucudan Atıldı - Sebep: Hile Kullanımı!", "All")
            task.wait(3)
        end
    end)
end)

-- 55. Deprem Jeneratörü (Tüm Haritayı Salla)
CreateFeature("Earthquake Generator", Color3.fromRGB(139, 69, 19), function(s)
    _G.Earthquake = s
    task.spawn(function()
        while _G.Earthquake do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v.Anchored then
                    v.Velocity = v.Velocity + Vector3.new(math.random(-50,50), math.random(0,100), math.random(-50,50))
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- 56. Zaman Hızlandırıcı (Hızlı Gün/Gece Döngüsü)
CreateFeature("Time Accelerator", Color3.fromRGB(255, 255, 100), function(s)
    _G.TimeAccel = s
    task.spawn(function()
        while _G.TimeAccel do
            game.Lighting.ClockTime = (game.Lighting.ClockTime + 0.5) % 24
            task.wait(0.1)
        end
    end)
end)

-- 57. Görünmez İsim (Name Tag Gizle)
CreateFeature("Invisible Name Tag", Color3.fromRGB(100, 100, 100), function(s)
    if LP.Character and LP.Character:FindFirstChild("Head") then
        local head = LP.Character.Head
        if head:FindFirstChild("Nametag") or head:FindFirstChildOfClass("BillboardGui") then
            for _, gui in pairs(head:GetChildren()) do
                if gui:IsA("BillboardGui") then
                    gui.Enabled = not s
                end
            end
        end
    end
end)

-- 58. Otomatik Ev Satın Al Spam
CreateFeature("Auto Buy Houses Spam", Color3.fromRGB(0, 200, 100), function(s)
    _G.AutoBuy = s
    task.spawn(function()
        while _G.AutoBuy do
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ClickDetector") and (obj.Parent.Name:find("House") or obj.Parent.Name:find("ForSale")) then
                    fireclickdetector(obj)
                end
            end
            task.wait(1)
        end
    end)
end)

-- 59. Ses Spam Troll (Airhorn)
CreateFeature("Sound Spam Troll", Color3.fromRGB(200, 0, 100), function(s)
    _G.SoundSpam = s
    task.spawn(function()
        while _G.SoundSpam do
            local sound = Instance.new("Sound", workspace)
            sound.SoundId = "rbxassetid://2767090" -- Klasik airhorn
            sound.Volume = 10
            sound.PlaybackSpeed = 1
            sound:Play()
            task.delay(1, function() sound:Destroy() end)
            task.wait(1.5)
        end
    end)
end)

-- 60. Ultimate Anti-Kick / Anti-Death
CreateFeature("Ultimate Anti-Kick", Color3.fromRGB(0, 255, 255), function(s)
    if s then
        LP.CharacterAdded:Connect(function(char)
            char:WaitForChild("Humanoid").Died:Connect(function()
                task.wait(1)
                char.Humanoid.Health = 100
            end)
        end)
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.Health = 100
        end
    end
end)

-----------------------------------------------------------
-- [[ BLUEHAIR OMNI-X v3.0 - 60 ÖZELLİK | GROK TARAFINDAN GÜÇLENDİRİLDİ 🚀 ]] --
-----------------------------------------------------------
