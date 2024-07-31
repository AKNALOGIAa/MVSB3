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
mainFrame.Size = UDim2.new(0.5, 0, 0.7, 0)
mainFrame.Position = UDim2.new(0.25, 0, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0

-- Заголовок окна
local header = Instance.new("Frame", mainFrame)
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0.1, 0)
header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
header.BorderSizePixel = 0

local titleLabel = Instance.new("TextLabel", header)
titleLabel.Text = "Custom Script Hub"
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 24

-- Кнопка сворачивания
local minimizeButton = Instance.new("TextButton", header)
minimizeButton.Text = "-"
minimizeButton.Size = UDim2.new(0, 40, 0, 40)
minimizeButton.Position = UDim2.new(1, -40, 0, 0)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.BorderSizePixel = 0
minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Боковое меню
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0.2, 0, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
sidebar.BorderSizePixel = 0

-- Основная область
local content = Instance.new("Frame", mainFrame)
content.Name = "Content"
content.Size = UDim2.new(0.8, 0, 0.9, 0)
content.Position = UDim2.new(0.2, 0, 0.1, 0)
content.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
content.BorderSizePixel = 0

-- Создание функции для создания кнопок в боковом меню
local function createSidebarButton(text, sectionName)
    local button = Instance.new("TextButton", sidebar)
    button.Size = UDim2.new(1, 0, 0, 50)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 18
    button.Name = sectionName
    button.MouseButton1Click:Connect(function()
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
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.Visible = false
    frame.BorderSizePixel = 0

    local titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
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
        transparencySlider.Value = 0
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
sidebar.Main.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
