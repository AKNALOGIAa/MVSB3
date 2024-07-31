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
titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 24
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextYAlignment = Enum.TextYAlignment.Center

-- Кнопка свернуть/развернуть
local minimizeButton = Instance.new("TextButton", header)
minimizeButton.Size = UDim2.new(0.1, 0, 0.5, 0)
minimizeButton.Position = UDim2.new(0.9, -10, 0.25, 0)
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.BorderSizePixel = 0
minimizeButton.Font = Enum.Font.SourceSansBold
minimizeButton.TextSize = 24

local isMinimized = false

minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame:TweenSize(UDim2.new(0.6, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5)
        for _, child in ipairs(mainFrame:GetChildren()) do
            if child ~= header then
                child.Visible = false
            end
        end
    else
        mainFrame:TweenSize(UDim2.new(0.6, 0, 0.8, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5)
        for _, child in ipairs(mainFrame:GetChildren()) do
            if child ~= header then
                child.Visible = true
            end
        end
    end
end)

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
            previousContent:TweenPosition(UDim2.new(-1, 0, previousContent.Position.Y.Scale, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true, function()
                previousContent.Visible = false
                previousContent.Position = UDim2.new(1, 0, 0, 0) -- Сброс позиции
            end)
        end
        local targetContent = content:FindFirstChild(sectionName)
        if targetContent then
            targetContent.Position = UDim2.new(1, 0, 0, 0)
            targetContent.Visible = true
            targetContent:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
        end
        -- Обновляем цвет кнопок
        for _, btn in ipairs(sidebar:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            end
        end
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
end

-- Создание кнопок в боковом меню
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
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center

    if name == "Settings" then
        local transparencyLabel = Instance.new("TextLabel", frame)
        transparencyLabel.Text = "Transparency"
        transparencyLabel.Size = UDim2.new(0.5, 0, 0, 30)
        transparencyLabel.Position = UDim2.new(0, 10, 0, 60)
        transparencyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        transparencyLabel.BackgroundTransparency = 1
        transparencyLabel.Font = Enum.Font.SourceSans
        transparencyLabel.TextSize = 18

        local transparencySlider = Instance.new("TextBox", frame)
        transparencySlider.Size = UDim2.new(0.8, 0, 0, 30)
        transparencySlider.Position = UDim2.new(0, 10, 0, 100)
        transparencySlider.Text = "20"
        transparencySlider.TextColor3 = Color3.fromRGB(255, 255, 255)
        transparencySlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        transparencySlider.BorderSizePixel = 0
        transparencySlider.Font = Enum.Font.SourceSans
        transparencySlider.TextSize = 18
        transparencySlider.TextStrokeTransparency = 0.8
        transparencySlider.TextWrapped = true
        transparencySlider.FocusLost:Connect(function()
            local value = tonumber(transparencySlider.Text)
            if value then
                mainFrame.BackgroundTransparency = math.clamp(value / 100, 0,
