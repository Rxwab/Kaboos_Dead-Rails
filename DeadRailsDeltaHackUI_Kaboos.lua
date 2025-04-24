local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- إنشاء ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeadRailsDeltaHackUI"
screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 550)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -275)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- تدرج خلفية فاخر
local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60))
})
uiGradient.Rotation = 45
uiGradient.Parent = mainFrame

-- زوايا مستديرة
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 20)
uiCorner.Parent = mainFrame

-- عنوان الواجهة
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 70)
titleLabel.Position = UDim2.new(0, 0, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "دالتا هاك - Dead Rails"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- ذهبي
titleLabel.TextSize = 32
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- نص الاعتمادات
local creditsLabel = Instance.new("TextLabel")
creditsLabel.Size = UDim2.new(1, 0, 0, 30)
creditsLabel.Position = UDim2.new(0, 0, 0.92, 0)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Text = "تم الإنشاء بواسطة: Kaboos"
creditsLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
creditsLabel.TextSize = 18
creditsLabel.Font = Enum.Font.Gotham
creditsLabel.Parent = mainFrame

-- زر تفعيل/إيقاف Auto Farm
local autoFarmButton = Instance.new("TextButton")
autoFarmButton.Size = UDim2.new(0.8, 0, 0, 60)
autoFarmButton.Position = UDim2.new(0.1, 0, 0.18, 0)
autoFarmButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
autoFarmButton.Text = "تفعيل الزراعة التلقائية"
autoFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoFarmButton.TextSize = 22
autoFarmButton.Font = Enum.Font.GothamBold
autoFarmButton.Parent = mainFrame

local autoFarmCorner = Instance.new("UICorner")
autoFarmCorner.CornerRadius = UDim.new(0, 12)
autoFarmCorner.Parent = autoFarmButton

-- زر تفعيل/إيقاف ESP
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(0.8, 0, 0, 60)
espButton.Position = UDim2.new(0.1, 0, 0.3, 0)
espButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
espButton.Text = "تفعيل رؤية العناصر"
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.TextSize = 22
espButton.Font = Enum.Font.GothamBold
espButton.Parent = mainFrame

local espCorner = Instance.new("UICorner")
espCorner.CornerRadius = UDim.new(0, 12)
espCorner.Parent = espButton

-- زر تفعيل/إيقاف NoClip
local noClipButton = Instance.new("TextButton")
noClipButton.Size = UDim2.new(0.8, 0, 0, 60)
noClipButton.Position = UDim2.new(0.1, 0, 0.42, 0)
noClipButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
noClipButton.Text = "تفعيل المرور عبر الجدران"
noClipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noClipButton.TextSize = 22
noClipButton.Font = Enum.Font.GothamBold
noClipButton.Parent = mainFrame

local noClipCorner = Instance.new("UICorner")
noClipCorner.CornerRadius = UDim.new(0, 12)
noClipCorner.Parent = noClipButton

-- زر تفعيل/إيقاف Auto Bonds
local autoBondsButton = Instance.new("TextButton")
autoBondsButton.Size = UDim2.new(0.8, 0, 0, 60)
autoBondsButton.Position = UDim2.new(0.1, 0, 0.54, 0)
autoBondsButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
autoBondsButton.Text = "تفعيل جمع السندات"
autoBondsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBondsButton.TextSize = 22
autoBondsButton.Font = Enum.Font.GothamBold
autoBondsButton.Parent = mainFrame

local autoBondsCorner = Instance.new("UICorner")
autoBondsCorner.CornerRadius = UDim.new(0, 12)
autoBondsCorner.Parent = autoBondsButton

-- زر الإغلاق
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 50, 0, 50)
closeButton.Position = UDim2.new(1, -60, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 24
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 12)
closeCorner.Parent = closeButton

-- تأثيرات التمرير على الأزرار
local function applyHoverEffect(button)
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)})
        tween:Play()
    end)
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)})
        tween:Play()
    end)
end

applyHoverEffect(autoFarmButton)
applyHoverEffect(espButton)
applyHoverEffect(noClipButton)
applyHoverEffect(autoBondsButton)
applyHoverEffect(closeButton)

-- متغيرات حالة الهك
local autoFarmEnabled = false
local espEnabled = false
local noClipEnabled = false
local autoBondsEnabled = false

-- وظيفة زر Auto Farm
autoFarmButton.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    autoFarmButton.Text = autoFarmEnabled and "إيقاف الزراعة التلقائية" or "تفعيل الزراعة التلقائية"
    autoFarmButton.BackgroundColor3 = autoFarmEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 30)
    -- استدعاء وظيفة Delta Hack الأصلية، مثل:
    -- DeltaHack:ToggleAutoFarm(autoFarmEnabled)
    print("Auto Farm " .. (autoFarmEnabled and "مفعل" or "معطل"))
end)

-- وظيفة زر ESP
espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espButton.Text = espEnabled and "إيقاف رؤية العناصر" or "تفعيل رؤية العناصر"
    espButton.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 30)
    -- استدعاء وظيفة Delta Hack الأصلية، مثل:
    -- DeltaHack:ToggleESP(espEnabled)
    print("ESP " .. (espEnabled and "مفعل" or "معطل"))
end)

-- وظيفة زر NoClip
noClipButton.MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    noClipButton.Text = noClipEnabled and "إيقاف المرور عبر الجدران" or "تفعيل المرور عبر الجدران"
    noClipButton.BackgroundColor3 = noClipEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 30)
    -- استدعاء وظيفة Delta Hack الأصلية، مثل:
    -- DeltaHack:ToggleNoClip(noClipEnabled)
    print("NoClip " .. (noClipEnabled and "مفعل" or "معطل"))
end)

-- وظيفة زر Auto Bonds
autoBondsButton.MouseButton1Click:Connect(function()
    autoBondsEnabled = not autoBondsEnabled
    autoBondsButton.Text = autoBondsEnabled and "إيقاف جمع السندات" or "تفعيل جمع السندات"
    autoBondsButton.BackgroundColor3 = autoBondsEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 30)
    -- استدعاء وظيفة Delta Hack الأصلية، مثل:
    -- DeltaHack:ToggleAutoBonds(autoBondsEnabled)
    print("Auto Bonds " .. (autoBondsEnabled and "مفعل" or "معطل"))
end)

-- وظيفة زر الإغلاق
closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- وظيفة السحب
local dragging = false
local dragStart = nil
local startPos = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- حركة الفتح
mainFrame.Size = UDim2.new(0, 0, 0, 0)
local openTween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 450, 0, 550)
})
openTween:Play()
