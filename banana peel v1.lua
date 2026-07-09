-- ================================================
--   🍌 Banana Peel - Hutan @cenntzy
--   UI: WindUI (Footagesus) + Key Gate Terpisah (SEBELUM menu muncul)
--   Key WAJIB dimasukkan setiap kali script dijalankan
-- ================================================

local Players      = game:GetService("Players")
local RunService   = game:GetService("RunService")
local LocalPlayer  = Players.LocalPlayer

-- ================================================
-- 🔑 Ambil Key dari key.txt di GitHub
-- ================================================

local KEY_URL = "https://raw.githubusercontent.com/notceenn/cenn_script/refs/heads/main/key.txt"

local function GetRemoteKey()
    local success, result = pcall(function()
        return game:HttpGet(KEY_URL)
    end)
    if success and result then
        return (result:gsub("^%s+", ""):gsub("%s+$", ""))
    end
    return nil
end

-- ================================================
-- 🔑 KEY GATE (layar terpisah, muncul PALING AWAL,
-- SEBELUM menu WindUI dibuat sama sekali)
-- ================================================

local function ShowKeyGate(onSuccess)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BananaPeelKeyGate"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999

    local parented = pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    if not parented or not ScreenGui.Parent then
        pcall(function()
            ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        end)
    end

    local Overlay = Instance.new("Frame")
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    Overlay.BackgroundTransparency = 0.4
    Overlay.BorderSizePixel = 0
    Overlay.Parent = ScreenGui

    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(0, 380, 0, 250)
    Card.Position = UDim2.new(0.5, -190, 0.5, -125)
    Card.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    Card.BorderSizePixel = 0
    Card.Parent = ScreenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = Card

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 200, 60)
    stroke.Thickness = 1.5
    stroke.Parent = Card

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 24)
    Title.Position = UDim2.new(0, 20, 0, 18)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Text = "Banana Peel - Hutan @cenntzy"
    Title.Parent = Card

    local Sub = Instance.new("TextLabel")
    Sub.Size = UDim2.new(1, -40, 0, 42)
    Sub.Position = UDim2.new(0, 20, 0, 44)
    Sub.BackgroundTransparency = 1
    Sub.Font = Enum.Font.Gotham
    Sub.TextSize = 13
    Sub.TextColor3 = Color3.fromRGB(180, 180, 190)
    Sub.TextXAlignment = Enum.TextXAlignment.Left
    Sub.TextWrapped = true
    Sub.Text = "Masukkan key untuk membuka script. Key WAJIB dimasukkan setiap kali script dijalankan. Minta key ke @cenntzy."
    Sub.Parent = Card

    local InputHolder = Instance.new("Frame")
    InputHolder.Size = UDim2.new(1, -40, 0, 42)
    InputHolder.Position = UDim2.new(0, 20, 0, 96)
    InputHolder.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
    InputHolder.BorderSizePixel = 0
    InputHolder.Parent = Card

    local ihCorner = Instance.new("UICorner")
    ihCorner.CornerRadius = UDim.new(0, 8)
    ihCorner.Parent = InputHolder

    local ihStroke = Instance.new("UIStroke")
    ihStroke.Color = Color3.fromRGB(70, 70, 80)
    ihStroke.Thickness = 1.5
    ihStroke.Parent = InputHolder

    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(1, -24, 1, 0)
    KeyBox.Position = UDim2.new(0, 12, 0, 0)
    KeyBox.BackgroundTransparency = 1
    KeyBox.PlaceholderText = "Ketik key di sini lalu Enter..."
    KeyBox.Text = ""
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.TextSize = 14
    KeyBox.TextColor3 = Color3.new(1, 1, 1)
    KeyBox.TextXAlignment = Enum.TextXAlignment.Left
    KeyBox.ClearTextOnFocus = false
    KeyBox.Parent = InputHolder

    KeyBox.Focused:Connect(function()
        ihStroke.Color = Color3.fromRGB(255, 200, 60)
    end)
    KeyBox.FocusLost:Connect(function()
        ihStroke.Color = Color3.fromRGB(70, 70, 80)
    end)

    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, -40, 0, 20)
    Status.Position = UDim2.new(0, 20, 0, 144)
    Status.BackgroundTransparency = 1
    Status.Font = Enum.Font.GothamBold
    Status.TextSize = 13
    Status.TextXAlignment = Enum.TextXAlignment.Left
    Status.TextColor3 = Color3.fromRGB(255, 90, 90)
    Status.Text = ""
    Status.Parent = Card

    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(1, -40, 0, 40)
    SubmitBtn.Position = UDim2.new(0, 20, 0, 172)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 60)
    SubmitBtn.Text = "MASUK"
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.TextSize = 15
    SubmitBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
    SubmitBtn.AutoButtonColor = false
    SubmitBtn.Parent = Card

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = SubmitBtn

    local processing = false

    local function ShakeCard()
        local seq = {6, -6, 4, -4, 2, 0}
        for _, off in ipairs(seq) do
            Card.Position = UDim2.new(0.5, -190 + off, 0.5, -125)
            task.wait(0.04)
        end
    end

    local function TryVerify()
        if processing then return end
        local input = KeyBox.Text:gsub("^%s+", ""):gsub("%s+$", "")
        if input == "" then
            Status.Text = "⚠️ Key tidak boleh kosong!"
            Status.TextColor3 = Color3.fromRGB(255, 180, 60)
            return
        end

        processing = true
        Status.Text = "⏳ Memverifikasi..."
        Status.TextColor3 = Color3.fromRGB(180, 180, 190)

        local validKey = GetRemoteKey()

        if not validKey then
            Status.Text = "⚠️ Gagal ambil data key. Cek koneksi!"
            Status.TextColor3 = Color3.fromRGB(255, 150, 60)
            processing = false
            return
        end

        if input == validKey then
            Status.Text = "✅ Key Benar! Masuk..."
            Status.TextColor3 = Color3.fromRGB(90, 255, 130)
            stroke.Color = Color3.fromRGB(90, 255, 130)
            task.wait(0.6)
            pcall(function() ScreenGui:Destroy() end)
            onSuccess()
        else
            Status.Text = "❌ Key salah tolol! Coba lagi."
            Status.TextColor3 = Color3.fromRGB(255, 90, 90)
            stroke.Color = Color3.fromRGB(255, 70, 70)
            ShakeCard()
            task.wait(0.4)
            stroke.Color = Color3.fromRGB(255, 200, 60)
            processing = false
        end
    end

    SubmitBtn.MouseButton1Click:Connect(TryVerify)
    KeyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then TryVerify() end
    end)
end

-- ================================================
-- 🍌 SCRIPT UTAMA (baru jalan setelah key benar)
-- ================================================

local function MainScript()

    -- Load WindUI (dibungkus pcall biar kalau gagal di executor tertentu,
    -- ada pemberitahuan jelas, bukan error mentah)
    local successLib, Library = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end)

    if not successLib or not Library then
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title    = "Gagal Load UI",
                Text     = "WindUI gagal dimuat di executor ini. Coba executor lain.",
                Duration = 6
            })
        end)
        return
    end

    local Config = {
        Speed        = 800,
        TargetPart   = "HumanoidRootPart",
        Tracer       = false
    }
    local targetPlayer  = nil
    local active        = false
    local conn          = nil
    local myBananas     = {}
    local lastThrowTime = 0

    local tracerBeam = nil
    local attach0    = nil
    local attach1    = nil

    local bodyPartsList = {
        "Head","UpperTorso","LowerTorso","Torso",
        "LeftUpperArm","LeftLowerArm","LeftHand",
        "RightUpperArm","RightLowerArm","RightHand",
        "LeftUpperLeg","LeftLowerLeg","LeftFoot",
        "RightUpperLeg","RightLowerLeg","RightFoot",
        "HumanoidRootPart"
    }

    -- ================================================
    -- UTILITY
    -- ================================================

    local function FilterPlayers(input)
        local result, kw = {}, input:lower()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                if kw == "" or plr.Name:lower():find(kw, 1, true) or plr.DisplayName:lower():find(kw, 1, true) then
                    table.insert(result, plr.DisplayName.." ("..plr.Name..")")
                end
            end
        end
        if #result == 0 then table.insert(result, "Tidak ditemukan") end
        return result
    end

    local function ParsePlayer(str)
        local u = str:match("%((.-)%)")
        return u and Players:FindFirstChild(u) or nil
    end

    local function AutoSelect(input)
        if #input < 3 then return nil end
        local kw = input:lower()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                if plr.Name:lower():find(kw, 1, true) or plr.DisplayName:lower():find(kw, 1, true) then
                    return plr
                end
            end
        end
        return nil
    end

    local function ClaimIfMine(obj)
        if not obj or obj.Name ~= "Handle" or not obj:IsA("BasePart") then return end
        if LocalPlayer.Character and obj:IsDescendantOf(LocalPlayer.Character) then return end

        if tick() - lastThrowTime <= 2 then
            myBananas[obj] = true
            pcall(function() obj.Anchored = false; obj.CanCollide = false end)
            return
        end
        if obj:FindFirstChild("BananaScript") or obj:FindFirstChild("UpdatedBanana") then
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root and (obj.Position - root.Position).Magnitude <= 20 then
                myBananas[obj] = true
            end
        end
    end

    pcall(function()
        workspace.ChildAdded:Connect(function(obj)
            pcall(ClaimIfMine, obj)
            task.delay(0.1, function() pcall(ClaimIfMine, obj) end)
            task.delay(0.2, function() pcall(ClaimIfMine, obj) end)
        end)
    end)

    pcall(function()
        workspace.DescendantAdded:Connect(function(obj)
            pcall(ClaimIfMine, obj)
        end)
    end)

    for _, obj in ipairs(workspace:GetChildren()) do
        pcall(ClaimIfMine, obj)
    end

    local function FindBananas()
        local list = {}
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj.Name == "Handle" and obj:IsA("BasePart") and myBananas[obj] then
                if not (LocalPlayer.Character and obj:IsDescendantOf(LocalPlayer.Character)) then
                    table.insert(list, obj)
                end
            end
        end
        return list
    end

    -- ================================================
    -- VISUAL: Highlight + Jarak
    -- ================================================

    local victimHighlight   = nil
    local victimBillboard   = nil

    local function ClearVictimVisuals()
        pcall(function() if victimHighlight then victimHighlight:Destroy() end end)
        pcall(function() if victimBillboard then victimBillboard:Destroy() end end)
        victimHighlight, victimBillboard = nil, nil
    end

    local function SetupVictimVisuals(plr)
        ClearVictimVisuals()
        if not plr or not plr.Character then return end
        local char = plr.Character
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        victimHighlight = Instance.new("Highlight")
        victimHighlight.FillColor = Color3.fromRGB(180, 40, 40)
        victimHighlight.OutlineColor = Color3.fromRGB(180, 40, 40)
        victimHighlight.FillTransparency = 0.85
        victimHighlight.OutlineTransparency = 0.6
        victimHighlight.Parent = char

        victimBillboard = Instance.new("BillboardGui")
        victimBillboard.Name = "BananaDistanceGui"
        victimBillboard.Size = UDim2.new(0, 110, 0, 20)
        victimBillboard.StudsOffset = Vector3.new(0, 3, 0)
        victimBillboard.AlwaysOnTop = true
        victimBillboard.Parent = char:FindFirstChild("Head") or root

        local label = Instance.new("TextLabel")
        label.Name = "DistanceLabel"
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamBold
        label.TextSize = 10
        label.TextColor3 = Color3.fromRGB(255, 255, 0)
        label.TextStrokeTransparency = 0
        label.Text = "Jarak Korban: 0 studs"
        label.Parent = victimBillboard
    end

    local function UpdateVictimVisuals()
        if not targetPlayer or not targetPlayer.Character then return end
        local root = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root or not myRoot then return end

        if not victimBillboard or not victimBillboard.Parent then
            SetupVictimVisuals(targetPlayer)
            return
        end

        local dist = (root.Position - myRoot.Position).Magnitude
        local label = victimBillboard:FindFirstChild("DistanceLabel")
        if label then
            label.Text = string.format("Jarak Korban: %.1f studs", dist)
        end
    end

    -- ================================================
    -- TRACER LINE
    -- ================================================

    local function CreateTracer()
        if tracerBeam then return end
        pcall(function()
            local beam = Instance.new("Beam")
            beam.Name = "BananaTracer"
            beam.Color = ColorSequence.new(Color3.fromRGB(255,255,0))
            beam.Width0 = 0.15
            beam.Width1 = 0.15
            beam.FaceCamera = true
            beam.Parent = workspace

            attach0 = Instance.new("Attachment")
            attach0.Parent = workspace.Terrain
            attach1 = Instance.new("Attachment")
            attach1.Parent = workspace.Terrain

            beam.Attachment0 = attach0
            beam.Attachment1 = attach1
            tracerBeam = beam
        end)
    end

    local function DestroyTracer()
        pcall(function() if tracerBeam then tracerBeam:Destroy() end end)
        pcall(function() if attach0 then attach0:Destroy() end end)
        pcall(function() if attach1 then attach1:Destroy() end end)
        tracerBeam, attach0, attach1 = nil, nil, nil
    end

    -- ================================================
    -- 🔥 GLOBAL ATTACK (Prediksi Lari/Loncat + Serangan Ke Atas)
    -- ================================================

    local function StartChase()
        if conn then conn:Disconnect() end
        if targetPlayer == LocalPlayer then return end
        active = true
        SetupVictimVisuals(targetPlayer)

        if Config.Tracer then CreateTracer() end

        conn = RunService.Heartbeat:Connect(function(dt)
            if not active then return end
            if not targetPlayer or not targetPlayer.Character then return end
            if targetPlayer == LocalPlayer then return end

            local character = targetPlayer.Character
            local targetRoot = character:FindFirstChild("HumanoidRootPart")
            local humanoid   = character:FindFirstChildOfClass("Humanoid")
            if not targetRoot then return end

            local targetPart = character:FindFirstChild(Config.TargetPart)
            if not targetPart or not targetPart:IsA("BasePart") then
                targetPart = targetRoot
            end

            for obj, _ in pairs(myBananas) do
                if not obj or not obj.Parent then myBananas[obj] = nil end
            end

            local EXTREME = Vector3.new(999999, 999999, 999999)

            local vel = targetPart.AssemblyLinearVelocity
            local gravity = workspace.Gravity
            local predictTime = 0.15
            local predictedPos = targetPart.Position + vel * predictTime + Vector3.new(0, -0.5 * gravity * predictTime^2, 0)

            for _, banana in ipairs(FindBananas()) do
                if not banana or not banana.Parent then continue end

                if tracerBeam and attach0 and attach1 then
                    pcall(function()
                        attach0.Parent = banana
                        attach1.Parent = targetPart
                    end)
                end

                pcall(function()
                    banana.CFrame = CFrame.new(predictedPos)
                end)
                banana.Anchored = false
                banana.CanCollide = false
                banana.AssemblyLinearVelocity = EXTREME
                banana.AssemblyAngularVelocity = EXTREME

                if humanoid then
                    pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Physics) end)
                    humanoid.PlatformStand = true
                    humanoid.Sit = false
                    humanoid.WalkSpeed = 0
                    humanoid.JumpPower = 0
                end

                for _, child in ipairs(targetRoot:GetChildren()) do
                    if child:IsA("BodyMover") then child:Destroy() end
                end

                local rigVelocity = targetRoot.AssemblyLinearVelocity
                local rigAngular = targetRoot.AssemblyAngularVelocity
                local upBlast = Vector3.new(0, 999999, 0)

                targetRoot.AssemblyLinearVelocity = rigVelocity + upBlast
                targetRoot.AssemblyAngularVelocity = rigAngular + EXTREME

                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bv.Velocity = Vector3.new(0, 999999, 0)
                bv.Parent = targetRoot

                local bav = Instance.new("BodyAngularVelocity")
                bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bav.AngularVelocity = EXTREME
                bav.Parent = targetRoot

                for _, part in ipairs(character:GetChildren()) do
                    if part:IsA("BasePart") and part ~= targetRoot then
                        part.AssemblyLinearVelocity = EXTREME
                        part.AssemblyAngularVelocity = EXTREME
                    end
                end
            end

            UpdateVictimVisuals()
        end)

        Library:Notify({
            Title    = "🍌 GLOBAL ATTACK!",
            Content  = "PREDIKSI LARI/LONCAT + Serangan SELALU KE ATAS!",
            Duration = 3,
        })
    end

    local function StopChase()
        active = false
        if conn then conn:Disconnect() conn = nil end
        ClearVictimVisuals()
        DestroyTracer()
        Library:Notify({ Title="🍌 Dimatikan", Content="", Duration=2 })
    end

    -- ================================================
    -- LEMPAR
    -- ================================================

    local function FindBananaTool()
        local sources = { LocalPlayer:FindFirstChild("Backpack"), LocalPlayer.Character }
        for _, src in ipairs(sources) do
            if src then
                for _, obj in ipairs(src:GetChildren()) do
                    if obj:IsA("Tool") and (obj.Name:lower():find("banana") or obj.Name:lower():find("peel")) then
                        return obj
                    end
                end
            end
        end
        return nil
    end

    local function ThrowBanana()
        local char = LocalPlayer.Character
        if not char then return end
        local tool = FindBananaTool()
        if not tool then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid and tool.Parent ~= char then
            pcall(function() humanoid:EquipTool(tool) end)
            task.wait(0.1)
        end
        lastThrowTime = tick()
        pcall(function() tool:Activate() end)
    end

    -- ================================================
    -- UI (WindUI) - TANPA custom theme, pakai default
    -- ================================================

    local Window = Library:CreateWindow({
        Title    = "Banana Peel - Hutan @cenntzy",
        Folder   = "BananaPeelHutan",
        Size     = UDim2.new(0, 560, 0, 460),
    })

    local MainTab = Window:Tab({ Title = "Main" })
    local SetTab  = Window:Tab({ Title = "Settings" })
    local DevTab  = Window:Tab({ Title = "Developer" })

    -- ================================================
    -- 🍌 TAB MAIN
    -- ================================================

    local playerDropdown

    local function RefreshDrop(kw)
        local newOptions = FilterPlayers(kw or "")
        if not playerDropdown then return end
        -- Coba beberapa nama method yang umum dipakai (biar tetap kompatibel
        -- walau ada perbedaan versi WindUI)
        local tried =
            pcall(function() playerDropdown:Refresh(newOptions) end) or
            pcall(function() playerDropdown:SetValues(newOptions) end) or
            pcall(function() playerDropdown:Reload(newOptions) end)
    end

    MainTab:Paragraph({ Title = "Target", Desc = "Cari dan pilih target untuk diserang." })

    MainTab:Input({
        Title       = "Cari Nama / Nickname",
        Value       = "",
        Placeholder = "Ketik 3+ huruf → auto terpilih!",
        Flag        = "SearchBox",
        Callback    = function(input)
            pcall(function() RefreshDrop(input) end)
            local found = AutoSelect(input)
            if found and found ~= targetPlayer then
                targetPlayer = found
                if active then SetupVictimVisuals(targetPlayer) end
                Library:Notify({ Title = "✅ "..found.DisplayName, Content = "Username: "..found.Name, Duration = 2 })
            elseif #input == 0 then
                targetPlayer = nil
            end
        end,
    })

    playerDropdown = MainTab:Dropdown({
        Title    = "Atau Pilih dari List",
        Values   = FilterPlayers(""),
        Value    = "Pilih player...",
        Flag     = "PlayerSelect",
        Callback = function(sel)
            local str = type(sel) == "table" and (sel.Title or sel[1]) or sel
            local plr = ParsePlayer(str)
            if plr then
                targetPlayer = plr
                if active then SetupVictimVisuals(targetPlayer) end
                Library:Notify({ Title = "🎯 "..plr.DisplayName, Content = "Username: "..plr.Name, Duration = 2 })
            end
        end,
    })

    MainTab:Button({
        Title    = "🔄 Refresh List",
        Callback = function() RefreshDrop("") end
    })

    MainTab:Paragraph({ Title = "Control", Desc = "Aktifkan serangan pisang." })

    MainTab:Toggle({
        Title    = "🍌 Enable Banana Chaser",
        Value    = false,
        Flag     = "EnableToggle",
        Callback = function(val)
            if val then
                if not targetPlayer then
                    Library:Notify({ Title = "Pilih target dulu!", Content = "", Duration = 2 })
                    return
                end
                StartChase()
            else
                StopChase()
            end
        end,
    })

    MainTab:Button({
        Title    = "🎯 Lempar Banana Peel",
        Callback = function()
            ThrowBanana()
            Library:Notify({ Title = "🍌", Content = "Pisang dilempar!", Duration = 2 })
        end
    })

    MainTab:Paragraph({
        Title = "Cara Pakai",
        Desc  = "1. Pilih target\n2. Atur bagian tubuh di Settings\n3. Enable & lempar pisang!\n4. Pisang prediksi lari/loncat & serangan SELALU KE ATAS! 🍌💀"
    })

    -- ================================================
    -- ⚙️ TAB SETTINGS
    -- ================================================

    SetTab:Paragraph({ Title = "Target Bagian Tubuh", Desc = "Pilih bagian tubuh yang jadi titik serang." })
    SetTab:Dropdown({
        Title    = "Bagian Tubuh",
        Values   = bodyPartsList,
        Value    = "HumanoidRootPart",
        Flag     = "BodyPartSelect",
        Callback = function(sel)
            local str = type(sel) == "table" and (sel.Title or sel[1]) or sel
            Config.TargetPart = str
        end
    })

    SetTab:Paragraph({ Title = "Visual", Desc = "Pengaturan tampilan tambahan." })
    SetTab:Toggle({
        Title    = "Tracer Line",
        Value    = false,
        Flag     = "TracerToggle",
        Callback = function(val)
            Config.Tracer = val
            if val then
                if active then CreateTracer() end
            else
                DestroyTracer()
            end
        end
    })

    SetTab:Paragraph({ Title = "Kecepatan", Desc = "Atur kecepatan lemparan pisang." })
    SetTab:Slider({
        Title    = "Speed Pisang",
        Value    = { Min = 100, Max = 3000, Default = 900 },
        Step     = 100,
        Flag     = "BananaSpeed",
        Callback = function(v) Config.Speed = v end
    })

    SetTab:Paragraph({
        Title = "Panduan Speed",
        Desc  = "300 = pelan | 500 = sedang | 800 = default | 1200 = kencang | 3000 = MAXIMUM 💀"
    })

    -- ================================================
    -- 👨‍💻 TAB DEVELOPER
    -- ================================================

    DevTab:Paragraph({
        Title = "Banana Peel - Hutan",
        Desc  = "Dibuat oleh: @cenntzy\nDiscord: @cenntzy\n\nUntuk request key, bug report, atau saran fitur, hubungi langsung lewat Discord."
    })

    DevTab:Button({
        Title    = "📋 Copy Discord: @cenntzy",
        Callback = function()
            local copied = false
            pcall(function()
                if setclipboard then
                    setclipboard("@cenntzy")
                    copied = true
                end
            end)
            if copied then
                Library:Notify({ Title = "📋 Disalin!", Content = "Discord @cenntzy sudah disalin ke clipboard.", Duration = 3 })
            else
                Library:Notify({ Title = "Discord", Content = "@cenntzy (clipboard tidak didukung executor ini)", Duration = 5 })
            end
        end
    })

    pcall(function()
        Players.PlayerAdded:Connect(function() task.wait(0.5) RefreshDrop("") end)
    end)
    pcall(function()
        Players.PlayerRemoving:Connect(function(plr)
            if targetPlayer == plr then targetPlayer = nil StopChase() end
            task.wait(0.5) RefreshDrop("")
        end)
    end)

    Library:Notify({
        Title    = "Banana Peel - Hutan",
        Content  = "By @cenntzy | Prediksi Lari/Loncat + Serangan Ke Atas!",
        Duration = 3
    })
end

-- ================================================
-- MULAI: tampilkan Key Gate dulu, baru load script utama
-- ================================================
ShowKeyGate(MainScript)