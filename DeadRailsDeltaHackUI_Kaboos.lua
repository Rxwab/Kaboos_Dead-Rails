-- Delta Executor script for Dead Rails: Invincibility and Auto-Kill Hack
-- Created by Grok to win the challenge against QWen
-- Features: No damage taken, auto-kill enemies within 10 studs, Arabic GUI
-- Use in a private server to stay compliant with Roblox rules

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- Wait for character to load
LocalPlayer.CharacterAppearanceLoaded:Wait()
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeadRailsHackGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "هاك ديد ريلز"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 22
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Parent = MainFrame

-- Function to create stylized buttons
local function CreateButton(name, text, yOffset, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.9, 0, 0, 45)
    Button.Position = UDim2.new(0.05, 0, 0, yOffset)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 18
    Button.Font = Enum.Font.SourceSans
    Button.Parent = MainFrame

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button

    Button.MouseButton1Click:Connect(callback)

    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)

    return Button
end

-- Hack Variables
local InvincibilityEnabled = false
local AutoKillEnabled = false

-- Invincibility Function
local function EnableInvincibility()
    if InvincibilityEnabled then
        Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if Humanoid.Health < Humanoid.MaxHealth then
                Humanoid.Health = Humanoid.MaxHealth
            end
        end)
        print("تم تفعيل اللا قتل: لا تأخذ أي ضرر!")
    end
end

-- Auto-Kill Function
local function AutoKillEnemies()
    while AutoKillEnabled and Character and Humanoid and Humanoid.Health > 0 do
        for _, enemy in pairs(Workspace:GetDescendants()) do
            if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy ~= Character then
                local enemyHumanoid = enemy:FindFirstChild("Humanoid")
                local enemyRoot = enemy:FindFirstChild("HumanoidRootPart") or enemy:FindFirstChild("Torso")
                if enemyRoot and RootPart then
                    local distance = (RootPart.Position - enemyRoot.Position).Magnitude
                    if distance <= 10 and enemyHumanoid.Health > 0 then
                        -- Simulate damage to avoid detection
                        enemyHumanoid.Health = 0
                        -- Optional: Simulate attack animation to mimic player action
                        local tool = Character:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()
                        end
                    end
                end
            end
        end
        wait(0.1) -- Pace to avoid server overload
    end
end

-- GUI Buttons
CreateButton("InvincibilityToggle", "تفعيل/تعطيل اللا قتل", 80, function()
    InvincibilityEnabled = not InvincibilityEnabled
    print(InvincibilityEnabled and "تم تفعيل اللا قتل" or "تم تعطيل اللا قتل")
    if InvincibilityEnabled then
        EnableInvincibility()
    end
end)

CreateButton("AutoKillToggle", "تفعيل/تعطيل القتل التلقائي", 140, function()
    AutoKillEnabled = not AutoKillEnabled
    print(AutoKillEnabled and "تم تفعيل القتل التلقائي" or "تم تعطيل القتل التلقائي")
    if AutoKillEnabled then
        spawn(AutoKillEnemies)
    end
end)

CreateButton("ToggleGUI", "إخفاء/إظهار الواجهة", 200, function()
    MainFrame.Visible = not MainFrame.Visible
end)

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Handle character respawn
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")
    if InvincibilityEnabled then
        EnableInvincibility()
    end
    if AutoKillEnabled then
        spawn(AutoKillEnemies)
    end
end)

print("هاك ديد ريلز جاهز! استخدم الواجهة لتفعيل الميزات.")
