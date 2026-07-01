-- ================================================
--   🍌 Hutan Pisang - By Notceenn
--   🔑 Custom Key System dengan efek glowing
-- ================================================

local Players       = game:GetService("Players")
local RunService     = game:GetService("RunService")
local TweenService   = game:GetService("TweenService")
local LocalPlayer    = Players.LocalPlayer

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
-- 🎨 CUSTOM KEY UI (glowing neon style)
-- ================================================

local function ShowKeyUI(onSuccess)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CennKeySystem"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999
    pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    if not ScreenGui.Parent then
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    -- Overlay gelap
    local Overlay = Instance.new("Frame")
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Overlay.BackgroundTransparency = 1
    Overlay.BorderSizePixel = 0
    Overlay.ZIndex = 1
    Overlay.Parent = ScreenGui
    TweenService:Create(Overlay, TweenInfo.new(0.3), { BackgroundTransparency = 0.5 }):Play()

    -- Card utama (meniru layout Rayfield native key system)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(0, 620, 0, 260)
    Card.Position = UDim2.new(0.5, -310, 0.5, -130)
    Card.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    Card.BorderSizePixel = 0
    Card.ZIndex = 2
    Card.Parent = ScreenGui

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 14)
    CardCorner.Parent = Card

    -- Glow border tipis, pulsing pelan
    local Glow = Instance.new("UIStroke")
    Glow.Thickness = 1.5
    Glow.Color = Color3.fromRGB(255, 200, 60)
    Glow.Transparency = 0.5
    Glow.Parent = Card

    task.spawn(function()
        while Glow.Parent do
            TweenService:Create(Glow, TweenInfo.new(1.4, Enum.EasingStyle.Sine), { Transparency = 0.85 }):Play()
            task.wait(1.4)
            if not Glow.Parent then break end
            TweenService:Create(Glow, TweenInfo.new(1.4, Enum.EasingStyle.Sine), { Transparency = 0.35 }):Play()
            task.wait(1.4)
        end
    end)

    -- Tombol X (tutup / batal)
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -46, 0, 16)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 20
    CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 205)
    CloseBtn.ZIndex = 3
    CloseBtn.Parent = Card
    CloseBtn.MouseEnter:Connect(function()
        TweenService:Create(CloseBtn, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(255, 90, 90) }):Play()
    end)
    CloseBtn.MouseLeave:Connect(function()
        TweenService:Create(CloseBtn, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(200, 200, 205) }):Play()
    end)
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Judul
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -80, 0, 26)
    Title.Position = UDim2.new(0, 28, 0, 22)
    Title.BackgroundTransparency = 1
    Title.Text = "Hutan Pisang - Key System"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 3
    Title.Parent = Card

    -- Subjudul
    local Sub = Instance.new("TextLabel")
    Sub.Size = UDim2.new(1, -80, 0, 20)
    Sub.Position = UDim2.new(0, 28, 0, 52)
    Sub.BackgroundTransparency = 1
    Sub.Text = "Masukkan key untuk lanjut"
    Sub.Font = Enum.Font.Gotham
    Sub.TextSize = 14
    Sub.TextColor3 = Color3.fromRGB(160, 160, 168)
    Sub.TextXAlignment = Enum.TextXAlignment.Left
    Sub.ZIndex = 3
    Sub.Parent = Card

    -- === Kolom Kiri: Key ===
    local KeyLabel = Instance.new("TextLabel")
    KeyLabel.Size = UDim2.new(0, 260, 0, 20)
    KeyLabel.Position = UDim2.new(0, 28, 0, 108)
    KeyLabel.BackgroundTransparency = 1
    KeyLabel.Text = "Key"
    KeyLabel.Font = Enum.Font.Gotham
    KeyLabel.TextSize = 14
    KeyLabel.TextColor3 = Color3.fromRGB(190, 190, 196)
    KeyLabel.TextXAlignment = Enum.TextXAlignment.Left
    KeyLabel.ZIndex = 3
    KeyLabel.Parent = Card

    local InputHolder = Instance.new("Frame")
    InputHolder.Size = UDim2.new(0, 260, 0, 42)
    InputHolder.Position = UDim2.new(0, 28, 0, 132)
    InputHolder.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
    InputHolder.BorderSizePixel = 0
    InputHolder.ZIndex = 3
    InputHolder.Parent = Card

    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 8)
    InputCorner.Parent = InputHolder

    local InputStroke = Instance.new("UIStroke")
    InputStroke.Thickness = 1.5
    InputStroke.Color = Color3.fromRGB(70, 70, 80)
    InputStroke.Parent = InputHolder

    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(1, -24, 1, 0)
    KeyBox.Position = UDim2.new(0, 12, 0, 0)
    KeyBox.BackgroundTransparency = 1
    KeyBox.PlaceholderText = "key"
    KeyBox.PlaceholderColor3 = Color3.fromRGB(110, 110, 118)
    KeyBox.Text = ""
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.TextSize = 14
    KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyBox.TextXAlignment = Enum.TextXAlignment.Left
    KeyBox.ClearTextOnFocus = false
    KeyBox.ZIndex = 4
    KeyBox.Parent = InputHolder

    KeyBox.Focused:Connect(function()
        TweenService:Create(InputStroke, TweenInfo.new(0.2), { Color = Color3.fromRGB(255, 200, 60) }):Play()
    end)
    KeyBox.FocusLost:Connect(function()
        TweenService:Create(InputStroke, TweenInfo.new(0.2), { Color = Color3.fromRGB(70, 70, 80) }):Play()
    end)

    -- Status notifikasi (salah / benar), muncul di bawah kotak Key
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(0, 260, 0, 20)
    Status.Position = UDim2.new(0, 28, 0, 180)
    Status.BackgroundTransparency = 1
    Status.Text = ""
    Status.Font = Enum.Font.GothamBold
    Status.TextSize = 13
    Status.TextXAlignment = Enum.TextXAlignment.Left
    Status.TextColor3 = Color3.fromRGB(255, 90, 90)
    Status.ZIndex = 3
    Status.Parent = Card

    -- Tombol Verifikasi
    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0, 260, 0, 38)
    SubmitBtn.Position = UDim2.new(0, 28, 0, 206)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 60)
    SubmitBtn.Text = "VERIFIKASI"
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.TextSize = 14
    SubmitBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
    SubmitBtn.AutoButtonColor = false
    SubmitBtn.ZIndex = 3
    SubmitBtn.Parent = Card

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = SubmitBtn

    SubmitBtn.MouseEnter:Connect(function()
        TweenService:Create(SubmitBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(255, 215, 100) }):Play()
    end)
    SubmitBtn.MouseLeave:Connect(function()
        TweenService:Create(SubmitBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(255, 200, 60) }):Play()
    end)

    -- === Kolom Kanan: Note ===
    local NoteLabel = Instance.new("TextLabel")
    NoteLabel.Size = UDim2.new(0, 260, 0, 20)
    NoteLabel.Position = UDim2.new(0, 330, 0, 108)
    NoteLabel.BackgroundTransparency = 1
    NoteLabel.Text = "Note"
    NoteLabel.Font = Enum.Font.Gotham
    NoteLabel.TextSize = 14
    NoteLabel.TextColor3 = Color3.fromRGB(190, 190, 196)
    NoteLabel.TextXAlignment = Enum.TextXAlignment.Left
    NoteLabel.ZIndex = 3
    NoteLabel.Parent = Card

    local NoteText = Instance.new("TextLabel")
    NoteText.Size = UDim2.new(0, 260, 0, 60)
    NoteText.Position = UDim2.new(0, 330, 0, 132)
    NoteText.BackgroundTransparency = 1
    NoteText.Text = "Minta key ke pemilik script\n(Notceenn)"
    NoteText.Font = Enum.Font.Gotham
    NoteText.TextSize = 14
    NoteText.TextColor3 = Color3.fromRGB(220, 220, 224)
    NoteText.TextXAlignment = Enum.TextXAlignment.Left
    NoteText.TextYAlignment = Enum.TextYAlignment.Top
    NoteText.TextWrapped = true
    NoteText.ZIndex = 3
    NoteText.Parent = Card

    -- Animasi shake kalau salah
    local function ShakeCard()
        local seq = {6, -6, 4, -4, 2, 0}
        for _, off in ipairs(seq) do
            TweenService:Create(Card, TweenInfo.new(0.04), {
                Position = UDim2.new(0.5, -310 + off, 0.5, -130)
            }):Play()
            task.wait(0.04)
        end
    end

    local processing = false

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
            Status.Text = "✅ Key Benar! Selamat datang..."
            Status.TextColor3 = Color3.fromRGB(90, 255, 130)
            TweenService:Create(Glow, TweenInfo.new(0.3), { Color = Color3.fromRGB(90, 255, 130), Transparency = 0 }):Play()

            task.wait(1)

            TweenService:Create(Overlay, TweenInfo.new(0.4), { BackgroundTransparency = 1 }):Play()
            for _, obj in ipairs(Card:GetDescendants()) do
                if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                    TweenService:Create(obj, TweenInfo.new(0.4), { TextTransparency = 1 }):Play()
                end
                if obj:IsA("Frame") then
                    TweenService:Create(obj, TweenInfo.new(0.4), { BackgroundTransparency = 1 }):Play()
                end
            end
            TweenService:Create(Card, TweenInfo.new(0.4), { BackgroundTransparency = 1 }):Play()

            task.wait(0.45)
            ScreenGui:Destroy()

            onSuccess()
        else
            Status.Text = "❌ Key Salah! Coba lagi."
            Status.TextColor3 = Color3.fromRGB(255, 90, 90)
            TweenService:Create(Glow, TweenInfo.new(0.15), { Color = Color3.fromRGB(255, 70, 70), Transparency = 0 }):Play()
            ShakeCard()
            task.wait(0.6)
            TweenService:Create(Glow, TweenInfo.new(0.5), { Color = Color3.fromRGB(255, 200, 60), Transparency = 0.5 }):Play()
            processing = false
        end
    end

    SubmitBtn.MouseButton1Click:Connect(TryVerify)
    KeyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            TryVerify()
        end
    end)
end

-- ================================================
-- 🍌 MAIN SCRIPT (baru di-load setelah key benar)
-- ================================================

local function LoadMainScript()

    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Config       = { Speed = 800 }
    local targetPlayer  = nil
    local active        = false
    local conn          = nil
    local myBananas     = setmetatable({}, {__mode = "k"})

    local function FilterPlayers(input)
        local result, kw = {}, input:lower()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                if kw == ""
                    or plr.Name:lower():find(kw, 1, true)
                    or plr.DisplayName:lower():find(kw, 1, true)
                then
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
                if plr.Name:lower():find(kw, 1, true)
                    or plr.DisplayName:lower():find(kw, 1, true)
                then return plr end
            end
        end
        return nil
    end

    local function FindBananas()
        local list = {}
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj.Name == "Handle" and obj:IsA("BasePart") and myBananas[obj] then
                if obj:FindFirstChild("BananaScript") or obj:FindFirstChild("UpdatedBanana") then
                    table.insert(list, obj)
                end
            end
        end
        return list
    end

    local function ClaimIfMine(obj)
        if not obj or obj.Name ~= "Handle" or not obj:IsA("BasePart") then return end
        if not (obj:FindFirstChild("BananaScript") or obj:FindFirstChild("UpdatedBanana")) then return end

        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        if (obj.Position - root.Position).Magnitude <= 15 then
            myBananas[obj] = true
        end
    end

    workspace.ChildAdded:Connect(function(obj)
        task.defer(function()
            pcall(ClaimIfMine, obj)
        end)
    end)

    for _, obj in ipairs(workspace:GetChildren()) do
        pcall(ClaimIfMine, obj)
    end

    local victimHighlight   = nil
    local victimBillboard   = nil

    local function ClearVictimVisuals()
        if victimHighlight then victimHighlight:Destroy() end
        if victimBillboard then victimBillboard:Destroy() end
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

    local function GetCenter(char)
        if not char then return nil end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        local pos
        pcall(function()
            local cf = char:GetBoundingBox()
            pos = cf.Position
        end)
        return pos or root.Position
    end

    local function StartChase()
        if conn then conn:Disconnect() end
        if targetPlayer == LocalPlayer then return end
        active = true
        SetupVictimVisuals(targetPlayer)

        conn = RunService.Heartbeat:Connect(function()
            if not active then return end
            if not targetPlayer or not targetPlayer.Character then return end
            if targetPlayer == LocalPlayer then return end

            local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            local targetPos  = GetCenter(targetPlayer.Character)
            if not targetPos or not targetRoot then return end

            local targetVel = targetRoot.AssemblyLinearVelocity

            for _, banana in ipairs(FindBananas()) do
                if not banana or not banana.Parent then continue end

                local dist = (targetPos - banana.Position).Magnitude

                local travelTime    = dist / Config.Speed
                local predictedPos  = targetPos + targetVel * (travelTime * 2)
                local toPredicted   = predictedPos - banana.Position
                local dir = toPredicted.Magnitude > 0.01 and toPredicted.Unit or (targetPos - banana.Position).Unit

                banana.Anchored   = false
                banana.CanCollide = false
                banana.AssemblyLinearVelocity  = dir * (Config.Speed * 1.5)
                banana.AssemblyAngularVelocity = Vector3.zero

                if dist <= 6 then
                    targetRoot.AssemblyLinearVelocity = dir * (Config.Speed * 3) + Vector3.new(0, 80, 0)
                end
            end

            UpdateVictimVisuals()
        end)

        Rayfield:Notify({
            Title   = "🍌 Aktif!",
            Content = "Menyerang "..targetPlayer.DisplayName.."!",
            Duration = 3,
        })
    end

    local function StopChase()
        active = false
        if conn then conn:Disconnect() conn = nil end
        ClearVictimVisuals()
        Rayfield:Notify({ Title="🍌 Dimatikan", Duration=2 })
    end

    local Window = Rayfield:CreateWindow({
        Name            = "Hutan Pisang - By Notceenn",
        LoadingTitle    = "Hutan Pisang",
        LoadingSubtitle = "By Notceenn",
        Theme           = "Default",
        ConfigurationSaving = { Enabled = false },
    })

    local MainTab = Window:CreateTab("🍌 Main", 4483362458)
    local SetTab  = Window:CreateTab("⚙️ Settings", 4483362458)

    local playerDropdown
    local function RefreshDrop(kw)
        pcall(function()
            if playerDropdown then
                playerDropdown:Refresh(FilterPlayers(kw or ""), true)
            end
        end)
    end

    MainTab:CreateSection("Target")

    MainTab:CreateInput({
        Name                     = "Cari Nama / Nickname",
        PlaceholderText          = "Ketik 3+ huruf → auto terpilih!",
        RemoveTextAfterFocusLost = false,
        Flag                     = "SearchBox",
        Callback                 = function(input)
            pcall(function() RefreshDrop(input) end)
            local found = AutoSelect(input)
            if found and found ~= targetPlayer then
                targetPlayer = found
                if active then SetupVictimVisuals(targetPlayer) end
                Rayfield:Notify({
                    Title   = "✅ "..found.DisplayName,
                    Content = "Username: "..found.Name,
                    Duration = 2,
                })
            elseif #input == 0 then
                targetPlayer = nil
            end
        end,
    })

    playerDropdown = MainTab:CreateDropdown({
        Name            = "Atau Pilih dari List",
        Options         = FilterPlayers(""),
        CurrentOption   = {"Pilih player..."},
        MultipleOptions = false,
        Flag            = "PlayerSelect",
        Callback        = function(sel)
            local str = type(sel) == "table" and sel[1] or sel
            local plr = ParsePlayer(str)
            if plr then
                targetPlayer = plr
                if active then SetupVictimVisuals(targetPlayer) end
                Rayfield:Notify({
                    Title   = "🎯 "..plr.DisplayName,
                    Content = "Username: "..plr.Name,
                    Duration = 2,
                })
            end
        end,
    })

    MainTab:CreateButton({
        Name     = "🔄 Refresh List",
        Callback = function() RefreshDrop("") end,
    })

    MainTab:CreateDivider()
    MainTab:CreateSection("Control")

    MainTab:CreateToggle({
        Name         = "🍌 Enable Banana Chaser",
        CurrentValue = false,
        Flag         = "EnableToggle",
        Callback     = function(val)
            if val then
                if not targetPlayer then
                    Rayfield:Notify({
                        Title   = "Pilih target dulu!",
                        Duration = 2,
                    })
                    return
                end
                StartChase()
            else
                StopChase()
            end
        end,
    })

    MainTab:CreateParagraph({
        Title   = "Cara Pakai",
        Content = "1. Ketik 3+ huruf → auto terpilih\n2. Enable Banana Chaser\n3. Equip & lempar Banana Peel!\n4. Pisang otomatis terbang menyerang target berapapun jauhnya 🍌💀",
    })

    SetTab:CreateSection("Kecepatan")

    SetTab:CreateSlider({
        Name         = "Speed Pisang",
        Range        = {100, 3000 },
        Increment    = 100,
        Suffix       = " speed",
        CurrentValue = 900,
        Flag         = "BananaSpeed",
        Callback     = function(v)
            Config.Speed = v
            Rayfield:Notify({ Title="Speed: "..v, Duration=1 })
        end,
    })

    SetTab:CreateParagraph({
        Title   = "Panduan Speed",
        Content = "300   = pelan\n500   = sedang\n800   = default\n1200 = kencang\n3000 = MAXIMUM 💀",
    })

    Players.PlayerAdded:Connect(function() task.wait(0.5) RefreshDrop("") end)
    Players.PlayerRemoving:Connect(function(plr)
        if targetPlayer == plr then
            targetPlayer = nil
            StopChase()
            Rayfield:Notify({ Title="Target Keluar", Content=plr.Name.." keluar.", Duration=3 })
        end
        task.wait(0.5) RefreshDrop("")
    end)

    Rayfield:Notify({
        Title   = "Hutan Pisang",
        Content = "By Notceenn | Siap! (Brutal Attack Mode)",
        Duration = 3,
    })
end

-- ================================================
-- MULAI DARI SINI
-- ================================================
ShowKeyUI(LoadMainScript)
