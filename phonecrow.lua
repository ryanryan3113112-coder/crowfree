local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CrowUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- ===================== 主視窗 =====================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 520, 0, 380)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(40, 40, 60)
mainStroke.Thickness = 1
mainStroke.Transparency = 0.4
mainStroke.Parent = mainFrame

-- 頂部標題列
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 42)
titleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -200, 1, 0)
titleLabel.Position = UDim2.new(0, 16, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "crow"
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
minimizeBtn.Position = UDim2.new(1, -38, 0, 7)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 16
minimizeBtn.Parent = titleBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeBtn

-- 左側導航
local navFrame = Instance.new("Frame")
navFrame.Size = UDim2.new(0, 140, 1, -42)
navFrame.Position = UDim2.new(0, 0, 0, 42)
navFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
navFrame.BorderSizePixel = 0
navFrame.Parent = mainFrame

local navStroke = Instance.new("UIStroke")
navStroke.Color = Color3.fromRGB(30, 30, 50)
navStroke.Thickness = 1
navStroke.Transparency = 0.5
navStroke.Parent = navFrame

local funcBtn = Instance.new("TextButton")
funcBtn.Size = UDim2.new(1, -16, 0, 60)
funcBtn.Position = UDim2.new(0, 8, 0, 30)
funcBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 80)
funcBtn.BorderSizePixel = 0
funcBtn.Text = "功能"
funcBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
funcBtn.Font = Enum.Font.GothamBold
funcBtn.TextSize = 18
funcBtn.TextWrapped = true
funcBtn.Parent = navFrame

local funcCorner = Instance.new("UICorner")
funcCorner.CornerRadius = UDim.new(0, 8)
funcCorner.Parent = funcBtn

local thanksBtn = Instance.new("TextButton")
thanksBtn.Size = UDim2.new(1, -16, 0, 60)
thanksBtn.Position = UDim2.new(0, 8, 0, 100)
thanksBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 80)
thanksBtn.BorderSizePixel = 0
thanksBtn.Text = "感謝"
thanksBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
thanksBtn.Font = Enum.Font.GothamBold
thanksBtn.TextSize = 18
thanksBtn.TextWrapped = true
thanksBtn.Parent = navFrame

local thanksCorner = Instance.new("UICorner")
thanksCorner.CornerRadius = UDim.new(0, 8)
thanksCorner.Parent = thanksBtn

-- 中間內容區域
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -140, 1, -42)
contentArea.Position = UDim2.new(0, 140, 0, 42)
contentArea.BackgroundTransparency = 1
contentArea.Parent = mainFrame

local contentFunc = Instance.new("ScrollingFrame")
contentFunc.Size = UDim2.new(1, 0, 1, 0)
contentFunc.BackgroundTransparency = 1
contentFunc.ScrollBarThickness = 4
contentFunc.Visible = true
contentFunc.Parent = contentArea

local funcList = Instance.new("UIListLayout")
funcList.Padding = UDim.new(0, 12)
funcList.SortOrder = Enum.SortOrder.LayoutOrder
funcList.Parent = contentFunc

-- ===================== ESP 功能（不變） =====================
local ESP_ENABLED = false
local ESP_OBJECTS = {}

local MAX_DISTANCE = 1000
local TEAM_CHECK = true

local function isTeammate(player)
    if not TEAM_CHECK then return false end
    if not LocalPlayer.Team then return false end
    return player.Team == LocalPlayer.Team
end

local function createESP(player)
    if player == LocalPlayer or isTeammate(player) then return end
    
    local function onCharacterAdded(char)
        task.wait(0.3)
        
        local root = char:WaitForChild("HumanoidRootPart", 8)
        local humanoid = char:WaitForChild("Humanoid", 8)
        if not (root and humanoid) then return end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.Adornee = char
        highlight.DepthMode = Enum.HighlightDepthMode.Occluded
        highlight.FillColor = Color3.fromRGB(0, 255, 100)
        highlight.FillTransparency = 0.6
        highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
        highlight.OutlineTransparency = 0.1
        highlight.Enabled = ESP_ENABLED
        highlight.Parent = char
        
        local bb = Instance.new("BillboardGui")
        bb.Name = "ESPInfo"
        bb.Adornee = char:WaitForChild("Head")
        bb.Size = UDim2.new(0, 180, 0, 50)
        bb.StudsOffset = Vector3.new(0, 3.2, 0)
        bb.AlwaysOnTop = true
        bb.LightInfluence = 0
        bb.MaxDistance = MAX_DISTANCE
        bb.Enabled = ESP_ENABLED
        bb.Parent = char.Head
        
        local nameLabel = Instance.new("TextLabel", bb)
        nameLabel.Size = UDim2.new(1, 0, 0.4, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextStrokeTransparency = 0.6
        nameLabel.TextStrokeColor3 = Color3.new(0,0,0)
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextSize = 16
        nameLabel.Text = player.Name
        nameLabel.TextXAlignment = Enum.TextXAlignment.Center
        
        local infoLabel = Instance.new("TextLabel", bb)
        infoLabel.Size = UDim2.new(1, 0, 0.4, 0)
        infoLabel.Position = UDim2.new(0, 0, 0.45, 0)
        infoLabel.BackgroundTransparency = 1
        infoLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
        infoLabel.TextStrokeTransparency = 0.7
        infoLabel.TextStrokeColor3 = Color3.new(0,0,0)
        infoLabel.Font = Enum.Font.SourceSans
        infoLabel.TextSize = 14
        infoLabel.TextXAlignment = Enum.TextXAlignment.Center
        
        local barBG = Instance.new("Frame", bb)
        barBG.Size = UDim2.new(0.9, 0, 0.12, 0)
        barBG.Position = UDim2.new(0.05, 0, 0.88, 0)
        barBG.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        barBG.BorderSizePixel = 0
        
        local bar = Instance.new("Frame", barBG)
        bar.Size = UDim2.new(1, 0, 1, 0)
        bar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        bar.BorderSizePixel = 0
        
        ESP_OBJECTS[player] = {
            highlight = highlight,
            bb = bb,
            info = infoLabel,
            bar = bar,
            charConn = RunService.Heartbeat:Connect(function()
                if not ESP_ENABLED or not char.Parent or humanoid.Health <= 0 then
                    highlight.Enabled = false
                    bb.Enabled = false
                    return
                end
                
                local dist = (root.Position - Camera.CFrame.Position).Magnitude
                if dist > MAX_DISTANCE then
                    highlight.Enabled = false
                    bb.Enabled = false
                    return
                end
                
                highlight.Enabled = true
                bb.Enabled = true
                
                infoLabel.Text = string.format("HP: %.0f/%.0f   |   %.0f studs", humanoid.Health, humanoid.MaxHealth, dist)
                
                local hpRatio = humanoid.Health / humanoid.MaxHealth
                bar.Size = UDim2.new(hpRatio, 0, 1, 0)
                
                if hpRatio > 0.6 then
                    bar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                elseif hpRatio > 0.3 then
                    bar.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
                else
                    bar.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                end
            end)
        }
    end
    
    if player.Character then onCharacterAdded(player.Character) end
    player.CharacterAdded:Connect(onCharacterAdded)
end

local function removeESP(player)
    if ESP_OBJECTS[player] then
        if ESP_OBJECTS[player].charConn then ESP_OBJECTS[player].charConn:Disconnect() end
        if ESP_OBJECTS[player].highlight then ESP_OBJECTS[player].highlight:Destroy() end
        if ESP_OBJECTS[player].bb then ESP_OBJECTS[player].bb:Destroy() end
        ESP_OBJECTS[player] = nil
    end
end

for _, plr in ipairs(Players:GetPlayers()) do
    task.spawn(createESP, plr)
end

Players.PlayerAdded:Connect(function(plr)
    task.spawn(createESP, plr)
end)

Players.PlayerRemoving:Connect(removeESP)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1.5)
    for _, plr in ipairs(Players:GetPlayers()) do
        removeESP(plr)
        task.spawn(createESP, plr)
    end
end)

-- ===================== 飛行功能（只有玩家移動才飛） =====================
local flyEnabled = false
local flySpeed = 50
local bv = nil
local bg = nil
local flyConnection = nil

local function startFlying()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local root = LocalPlayer.Character.HumanoidRootPart
    
    bv = Instance.new("BodyVelocity")
    bv.Name = "FlyVelocity"
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = root
    
    bg = Instance.new("BodyGyro")
    bg.Name = "FlyGyro"
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bg.P = 90000
    bg.Parent = root
    
    flyConnection = RunService.Heartbeat:Connect(function()
        if not flyEnabled or not root then return end
        
        local camera = workspace.CurrentCamera
        local moveDirection = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then
            moveDirection = moveDirection + camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then
            moveDirection = moveDirection - camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then
            moveDirection = moveDirection - camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then
            moveDirection = moveDirection + camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit * flySpeed
            bv.Velocity = moveDirection
        else
            bv.Velocity = Vector3.new(0, 0, 0)
        end
        
        bg.CFrame = camera.CFrame
    end)
end

local function stopFlying()
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    if bv then bv:Destroy() bv = nil end
    if bg then bg:Destroy() bg = nil end
end

-- ===================== 白圓框 FOV 自瞄鎖定（鎖頭） =====================
local AIM_ENABLED = false
local FOV_RADIUS = 180
local LOCK_PART = "Head"
local AIM_MAX_DISTANCE = 2000

local whiteCircle = Drawing.new("Circle")
whiteCircle.Thickness = 2
whiteCircle.NumSides = 100
whiteCircle.Radius = FOV_RADIUS
whiteCircle.Color = Color3.fromRGB(255, 255, 255)
whiteCircle.Filled = false
whiteCircle.Transparency = 0.8
whiteCircle.Visible = false

local function getClosestInFOV()
    local closest = nil
    local minDist = math.huge
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetPart = player.Character:FindFirstChild(LOCK_PART)
            local humanoid = player.Character:FindFirstChild("Humanoid")
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            
            if targetPart and humanoid and humanoid.Health > 0 and root then
                local distToPlayer = (root.Position - Camera.CFrame.Position).Magnitude
                if distToPlayer > AIM_MAX_DISTANCE then continue end
                
                local screenPos, visible = Camera:WorldToViewportPoint(targetPart.Position)
                if visible then
                    local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if screenDist <= FOV_RADIUS and screenDist < minDist then
                        minDist = screenDist
                        closest = targetPart
                    end
                end
            end
        end
    end
    return closest
end

local aimConn = nil

-- ===================== 穿牆功能（noclip） =====================
local noclipEnabled = false
local noclipConnection = nil

local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    
    if noclipEnabled then
        if noclipConnection then noclipConnection:Disconnect() end
        
        noclipConnection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        if LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if noclipEnabled then
        toggleNoclip()  -- 先關
        toggleNoclip()  -- 再開，重新連線
    end
end)

-- ===================== 功能按鈕列表 =====================
local funcNames = {"ESP", "飛行", "鎖頭", "穿牆", "Aimbot", "自動擊殺"}

for i, name in ipairs(funcNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.92, 0, 0, 55)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    btn.Text = name .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(220, 220, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 17
    btn.Parent = contentFunc
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if name == "ESP" then
            ESP_ENABLED = not ESP_ENABLED
            if ESP_ENABLED then
                btn.Text = "ESP [ON]"
                btn.BackgroundColor3 = Color3.fromRGB(40, 100, 60)  -- 綠色
            else
                btn.Text = "ESP [OFF]"
                btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            end
            for _, data in pairs(ESP_OBJECTS) do
                if data.highlight then data.highlight.Enabled = ESP_ENABLED end
                if data.bb then data.bb.Enabled = ESP_ENABLED end
            end
        elseif name == "飛行" then
            flyEnabled = not flyEnabled
            if flyEnabled then
                btn.Text = "飛行 [ON]"
                btn.BackgroundColor3 = Color3.fromRGB(40, 100, 60)  -- 綠色
                startFlying()
            else
                btn.Text = "飛行 [OFF]"
                btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
                stopFlying()
            end
        elseif name == "鎖頭" then
            AIM_ENABLED = not AIM_ENABLED
            whiteCircle.Visible = AIM_ENABLED
            if AIM_ENABLED then
                btn.Text = "鎖頭 [ON]"
                btn.BackgroundColor3 = Color3.fromRGB(40, 100, 60)  -- 統一綠色
            else
                btn.Text = "鎖頭 [OFF]"
                btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            end
            if AIM_ENABLED then
                if aimConn then aimConn:Disconnect() end
                aimConn = RunService.RenderStepped:Connect(function()
                    whiteCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    local target = getClosestInFOV()
                    if target then
                        local targetCFrame = CFrame.new(Camera.CFrame.Position, target.Position)
                        Camera.CFrame = targetCFrame
                    end
                end)
            else
                if aimConn then aimConn:Disconnect() aimConn = nil end
            end
        elseif name == "穿牆" then
            toggleNoclip()
            if noclipEnabled then
                btn.Text = "穿牆 [ON]"
                btn.BackgroundColor3 = Color3.fromRGB(40, 100, 60)  -- 綠色
            else
                btn.Text = "穿牆 [OFF]"
                btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            end
        end
    end)
end

-- ===================== 感謝彈出視窗（不變） =====================
local thanksPopup = Instance.new("Frame")
thanksPopup.Size = UDim2.new(0, 400, 0, 400)
thanksPopup.Position = UDim2.new(0.5, -200, 0.5, -200)
thanksPopup.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
thanksPopup.BorderSizePixel = 0
thanksPopup.Visible = false
thanksPopup.Active = true
thanksPopup.Draggable = true
thanksPopup.Parent = screenGui

local popupCorner = Instance.new("UICorner")
popupCorner.CornerRadius = UDim.new(0, 16)
popupCorner.Parent = thanksPopup

local popupStroke = Instance.new("UIStroke")
popupStroke.Color = Color3.fromRGB(60, 60, 100)
popupStroke.Thickness = 1.5
popupStroke.Transparency = 0.35
popupStroke.Parent = thanksPopup

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -10)
scrollFrame.Position = UDim2.new(0, 5, 0, 5)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 120)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = thanksPopup

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 12)
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scrollFrame

local popupTitle = Instance.new("TextLabel")
popupTitle.Size = UDim2.new(1, -20, 0, 50)
popupTitle.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
popupTitle.BorderSizePixel = 0
popupTitle.Text = "感謝支持 crow"
popupTitle.TextColor3 = Color3.fromRGB(210, 210, 255)
popupTitle.Font = Enum.Font.GothamBold
popupTitle.TextSize = 22
popupTitle.Parent = scrollFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = popupTitle

local specialThanks = Instance.new("TextLabel")
specialThanks.Size = UDim2.new(1, -40, 0, 80)
specialThanks.BackgroundTransparency = 1
specialThanks.Text = "特別感謝\n細菌　星凡　洋芋片　天ㄚ"
specialThanks.TextColor3 = Color3.fromRGB(180, 180, 240)
specialThanks.Font = Enum.Font.GothamSemibold
specialThanks.TextSize = 28
specialThanks.TextWrapped = true
specialThanks.TextYAlignment = Enum.TextYAlignment.Top
specialThanks.Parent = scrollFrame

local thanks065 = Instance.new("TextLabel")
thanks065.Size = UDim2.new(1, -40, 0, 100)
thanks065.BackgroundTransparency = 1
thanks065.Text = "065"
thanks065.TextColor3 = Color3.fromRGB(140, 100, 255)
thanks065.Font = Enum.Font.GothamBlack
thanks065.TextSize = 48
thanks065.Parent = scrollFrame

local supportText = Instance.new("TextLabel")
supportText.Size = UDim2.new(1, -40, 0, 220)
supportText.BackgroundTransparency = 1
supportText.Text = "感謝所有支持 crow 的玩家\n測試者、回饋者、社群朋友\n以及每一位使用 crow 的你\n\n你們的支持\n是我們持續更新的動力"
supportText.TextColor3 = Color3.fromRGB(170, 170, 210)
supportText.Font = Enum.Font.Gotham
supportText.TextSize = 18
supportText.TextWrapped = true
supportText.TextYAlignment = Enum.TextYAlignment.Top
supportText.Parent = scrollFrame

listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 40)
end)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 24
closeBtn.Parent = thanksPopup

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    thanksPopup.Visible = false
end)

thanksBtn.MouseButton1Click:Connect(function()
    thanksPopup.Visible = true
end)

-- ===================== 最小化功能 =====================
local miniBox = Instance.new("Frame")
miniBox.Size = UDim2.new(0, 54, 0, 54)
miniBox.Position = UDim2.new(0, 20, 0, 20)
miniBox.BackgroundColor3 = Color3.fromRGB(8, 8, 16)
miniBox.BorderSizePixel = 0
miniBox.Visible = false
miniBox.Active = true
miniBox.Draggable = true
miniBox.Parent = screenGui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 12)
miniCorner.Parent = miniBox

local miniLabel = Instance.new("TextLabel")
miniLabel.Size = UDim2.new(1, 0, 1, 0)
miniLabel.BackgroundTransparency = 1
miniLabel.Text = "crow"
miniLabel.TextColor3 = Color3.fromRGB(160, 140, 255)
miniLabel.Font = Enum.Font.GothamBlack
miniLabel.TextSize = 20
miniLabel.TextWrapped = true
miniLabel.Parent = miniBox

miniBox.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        mainFrame.Visible = true
        miniBox.Visible = false
    end
end)

minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    miniBox.Visible = true
end)

print("crow UI 更新完成：ESP + 飛行 + 鎖頭 + 穿牆已整合，所有開啟狀態統一綠色（手機板專用）")
