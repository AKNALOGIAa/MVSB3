local player = game:GetService("Players").LocalPlayer
local playerGui = player:FindFirstChildOfClass("PlayerGui")

-- Удаление старого GUI, если существует
if playerGui:FindFirstChild("CustomUI") then
    playerGui.CustomUI:Destroy()
end

-- Создание нового GUI
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "CustomUI"

-- Окно GUI
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0.6, 0, 0.8, 0)
mainFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0

-- Заголовок окна
local header = Instance.new("Frame", mainFrame)
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0.1, 0)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
header.BorderSizePixel = 0

local titleLabel = Instance.new("TextLabel", header)
titleLabel.Text = "Script Hub"
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 24

-- Боковое меню
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0.2, 0, 0.9, 0)
sidebar.Position = UDim2.new(0, 0, 0.1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
sidebar.BorderSizePixel = 0

-- Основная область
local content = Instance.new("Frame", mainFrame)
content.Name = "Content"
content.Size = UDim2.new(0.8, 0, 0.9, 0)
content.Position = UDim2.new(0.2, 0, 0.1, 0)
content.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
content.BorderSizePixel = 0

-- Функция для создания кнопок в боковом меню
local function createSidebarButton(text, sectionName)
    local button = Instance.new("TextButton", sidebar)
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.BorderSizePixel = 0
    button.Name = sectionName
    button.MouseButton1Click:Connect(function()
        -- Анимация перехода
        local previousContent = content:FindFirstChildWhichIsA("Frame")
        if previousContent then
            previousContent:TweenPosition(UDim2.new(1, 0, previousContent.Position.Y.Scale, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.25, true, function()
                previousContent.Visible = false
                frame:TweenPosition(UDim2.new(0, 0, frame.Position.Y.Scale, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
            end)
        end
        -- Отображаем нужный раздел и скрываем остальные
        for _, child in ipairs(content:GetChildren()) do
            child.Visible = (child.Name == sectionName)
        end
        -- Обновляем цвет кнопок
        for _, btn in ipairs(sidebar:GetChildren()) do
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
end

-- Создание кнопок в боковом меню
createSidebarButton("Main", "Main")
createSidebarButton("Player Profile", "PlayerProfile")
createSidebarButton("Trades", "Trades")
createSidebarButton("Settings", "Settings")

-- Функция для создания раздела
local function createSection(name)
    local frame = Instance.new("Frame", content)
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(1, 0, 0, 0)  -- Позиция для анимации
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.Visible = false
    frame.BorderSizePixel = 0

    local titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.Text = name
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 24

    if name == "Settings" then
        local transparencyLabel = Instance.new("TextLabel", frame)
        transparencyLabel.Text = "Transparency"
        transparencyLabel.Size = UDim2.new(0.5, 0, 0, 30)
        transparencyLabel.Position = UDim2.new(0, 10, 0, 60)
        transparencyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        transparencyLabel.BackgroundTransparency = 1
        transparencyLabel.Font = Enum.Font.SourceSans
        transparencyLabel.TextSize = 18

        local transparencySlider = Instance.new("Slider", frame)
        transparencySlider.Size = UDim2.new(0.8, 0, 0, 30)
        transparencySlider.Position = UDim2.new(0, 10, 0, 100)
        transparencySlider.BackgroundTransparency = 1
        transparencySlider.MaxValue = 100
        transparencySlider.MinValue = 0
        transparencySlider.Value = 20
        transparencySlider.Step = 1
        transparencySlider.ValueChanged:Connect(function(value)
            mainFrame.BackgroundTransparency = value / 100
        end)
    end
end

-- Создание всех разделов
createSection("Main")
createSection("PlayerProfile")
createSection("Trades")
createSection("Settings")

-- Отображение первого раздела по умолчанию
content.Main.Visible = true
content.Main.Position = UDim2.new(0, 0, 0, 0)
sidebar.Main.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
