local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayerlocal screenGui = Instance.new("ScreenGui")
screenGui.Name = "CrowUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")-- ===================== 主視窗 =====================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 520, 0, 380)
mainFrame.Position = UDim2.new(0, 40, 0, 60)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.Parent = screenGuilocal mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFramelocal mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(40, 40, 60)
mainStroke.Thickness = 1
mainStroke.Transparency = 0.4
mainStroke.Parent = mainFrame-- 頂部標題列
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 42)
titleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFramelocal titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBarlocal titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -200, 1, 0)
titleLabel.Position = UDim2.new(0, 16, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "crow"
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBarlocal minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
minimizeBtn.Position = UDim2.new(1, -38, 0, 7)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 16
minimizeBtn.Parent = titleBarlocal minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeBtn-- 左側導航
local navFrame = Instance.new("Frame")
navFrame.Size = UDim2.new(0, 140, 1, -42)
navFrame.Position = UDim2.new(0, 0, 0, 42)
navFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
navFrame.BorderSizePixel = 0
navFrame.Parent = mainFramelocal navStroke = Instance.new("UIStroke")
navStroke.Color = Color3.fromRGB(30, 30, 50)
navStroke.Thickness = 1
navStroke.Transparency = 0.5
navStroke.Parent = navFramelocal funcBtn = Instance.new("TextButton")
funcBtn.Size = UDim2.new(1, -16, 0, 60)
funcBtn.Position = UDim2.new(0, 8, 0, 30)
funcBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 80)
funcBtn.BorderSizePixel = 0
funcBtn.Text = "功能"
funcBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
funcBtn.Font = Enum.Font.GothamBold
funcBtn.TextSize = 18
funcBtn.TextWrapped = true
funcBtn.Parent = navFramelocal funcCorner = Instance.new("UICorner")
funcCorner.CornerRadius = UDim.new(0, 8)
funcCorner.Parent = funcBtnlocal thanksBtn = Instance.new("TextButton")
thanksBtn.Size = UDim2.new(1, -16, 0, 60)
thanksBtn.Position = UDim2.new(0, 8, 0, 100)
thanksBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 80)
thanksBtn.BorderSizePixel = 0
thanksBtn.Text = "感謝"
thanksBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
thanksBtn.Font = Enum.Font.GothamBold
thanksBtn.TextSize = 18
thanksBtn.TextWrapped = true
thanksBtn.Parent = navFramelocal thanksCorner = Instance.new("UICorner")
thanksCorner.CornerRadius = UDim.new(0, 8)
thanksCorner.Parent = thanksBtn-- 中間內容區域（功能列表不變）
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -140, 1, -42)
contentArea.Position = UDim2.new(0, 140, 0, 42)
contentArea.BackgroundTransparency = 1
contentArea.Parent = mainFramelocal contentFunc = Instance.new("ScrollingFrame")
contentFunc.Size = UDim2.new(1, 0, 1, 0)
contentFunc.BackgroundTransparency = 1
contentFunc.ScrollBarThickness = 4
contentFunc.Visible = true
contentFunc.Parent = contentArealocal funcList = Instance.new("UIListLayout")
funcList.Padding = UDim.new(0, 12)
funcList.SortOrder = Enum.SortOrder.LayoutOrder
funcList.Parent = contentFunclocal funcNames = {"ESP", "Aimbot", "飛行", "穿牆", "鎖頭", "自動擊殺"}
for i, name in ipairs(funcNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.92, 0, 0, 55)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(220, 220, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 17
    btn.Parent = contentFunclocal c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0, 10)
c.Parent = btnend-- ===================== 感謝彈出視窗（可滾動 + 065移底下 + 特別感謝新增名單） =====================
local thanksPopup = Instance.new("Frame")
thanksPopup.Size = UDim2.new(0, 400, 0, 400)  -- 加大高度方便滾動
thanksPopup.Position = UDim2.new(0.5, -200, 0.5, -200)
thanksPopup.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
thanksPopup.BorderSizePixel = 0
thanksPopup.Visible = false
thanksPopup.Active = true
thanksPopup.Draggable = true
thanksPopup.Parent = screenGuilocal popupCorner = Instance.new("UICorner")
popupCorner.CornerRadius = UDim.new(0, 16)
popupCorner.Parent = thanksPopuplocal popupStroke = Instance.new("UIStroke")
popupStroke.Color = Color3.fromRGB(60, 60, 100)
popupStroke.Thickness = 1.5
popupStroke.Transparency = 0.35
popupStroke.Parent = thanksPopup-- 滾動框架
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -10)
scrollFrame.Position = UDim2.new(0, 5, 0, 5)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 120)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = thanksPopuplocal listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 12)
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scrollFrame-- 標題
local popupTitle = Instance.new("TextLabel")
popupTitle.Size = UDim2.new(1, -20, 0, 50)
popupTitle.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
popupTitle.BorderSizePixel = 0
popupTitle.Text = "感謝支持 crow"
popupTitle.TextColor3 = Color3.fromRGB(210, 210, 255)
popupTitle.Font = Enum.Font.GothamBold
popupTitle.TextSize = 22
popupTitle.Parent = scrollFramelocal titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = popupTitle-- 特別感謝（新增名單）
local specialThanks = Instance.new("TextLabel")
specialThanks.Size = UDim2.new(1, -40, 0, 80)
specialThanks.BackgroundTransparency = 1
specialThanks.Text = "特別感謝\n細菌　星凡　洋芋片　天ㄚ"
specialThanks.TextColor3 = Color3.fromRGB(180, 180, 240)
specialThanks.Font = Enum.Font.GothamSemibold
specialThanks.TextSize = 28
specialThanks.TextWrapped = true
specialThanks.TextYAlignment = Enum.TextYAlignment.Top
specialThanks.Parent = scrollFrame-- 065（縮小並移到特別感謝底下）
local thanks065 = Instance.new("TextLabel")
thanks065.Size = UDim2.new(1, -40, 0, 100)
thanks065.BackgroundTransparency = 1
thanks065.Text = "065"
thanks065.TextColor3 = Color3.fromRGB(140, 100, 255)
thanks065.Font = Enum.Font.GothamBlack
thanks065.TextSize = 48  -- 從72縮小到48
thanks065.Parent = scrollFrame-- 一般感謝文字
local supportText = Instance.new("TextLabel")
supportText.Size = UDim2.new(1, -40, 0, 220)
supportText.BackgroundTransparency = 1
supportText.Text = "感謝所有支持 crow 的玩家\n測試者、回饋者、社群朋友\n以及每一位使用 crow 的你\n\n你們的支持\n是我們持續更新的動力"
supportText.TextColor3 = Color3.fromRGB(170, 170, 210)
supportText.Font = Enum.Font.Gotham
supportText.TextSize = 18
supportText.TextWrapped = true
supportText.TextYAlignment = Enum.TextYAlignment.Top
supportText.Parent = scrollFrame-- 自動調整 CanvasSize（讓滾動範圍自動適應內容）
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 40)
end)-- 關閉按鈕
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 24
closeBtn.Parent = thanksPopuplocal closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeBtncloseBtn.MouseButton1Click:Connect(function()
    thanksPopup.Visible = false
end)thanksBtn.MouseButton1Click:Connect(function()
    thanksPopup.Visible = true
end)-- ===================== 最小化功能 =====================
local miniBox = Instance.new("Frame")
miniBox.Size = UDim2.new(0, 54, 0, 54)
miniBox.Position = UDim2.new(0, 20, 0, 20)
miniBox.BackgroundColor3 = Color3.fromRGB(8, 8, 16)
miniBox.BorderSizePixel = 0
miniBox.Visible = false
miniBox.Active = true
miniBox.Draggable = true
miniBox.Parent = screenGuilocal miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 12)
miniCorner.Parent = miniBoxlocal miniLabel = Instance.new("TextLabel")
miniLabel.Size = UDim2.new(1, 0, 1, 0)
miniLabel.BackgroundTransparency = 1
miniLabel.Text = "crow"
miniLabel.TextColor3 = Color3.fromRGB(160, 140, 255)
miniLabel.Font = Enum.Font.GothamBlack
miniLabel.TextSize = 20
miniLabel.TextWrapped = true
miniLabel.Parent = miniBoxminiBox.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        mainFrame.Visible = true
        miniBox.Visible = false
    end
end)minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    miniBox.Visible = true
end)print("crow UI 更新：感謝視窗可滾動、065縮小移到特別感謝底下、特別感謝新增 細菌 星凡 洋芋片 天ㄚ")

