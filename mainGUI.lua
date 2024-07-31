local player = game:GetService("Players").LocalPlayer
local playerGui = player:FindFirstChildOfClass("PlayerGui")

-- Удаление старого GUI, если существует
if playerGui:FindFirstChild("CustomUI") then
    playerGui.CustomUI:Destroy()
end

-- Создание нового GUI
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "CustomUI"

-- Боковое меню
local sidebar = Instance.new("Frame", screenGui)
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0.2, 0, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- Основная область
local content = Instance.new("Frame", screenGui)
content.Name = "Content"
content.Size = UDim2.new(0.8, 0, 1, 0)
content.Position = UDim2.new(0.2, 0, 0, 0)
content.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

-- Создание функции для создания кнопок в боковом меню
local function createSidebarButton(text, position, sectionName)
    local button = Instance.new("TextButton", sidebar)
    button.Size = UDim2.new(1, 0, 0, 50)
    button.Position = UDim2.new(0, 0, position, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Name = sectionName
    button.MouseButton1Click:Connect(function()
        for _, child in ipairs(content:GetChildren()) do
            child.Visible = (child.Name == sectionName)
        end
    end)
end

-- Создание кнопок в боковом меню
createSidebarButton("Основные", 0, "Main")
createSidebarButton("Профиль Игроков", 0.1, "PlayerProfile")
createSidebarButton("Трейды", 0.2, "Trades")
createSidebarButton("Настройки", 0.3, "Settings")

-- Функция для создания раздела
local function createSection(name)
    local frame = Instance.new("Frame", content)
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    frame.Visible = false

    -- Добавляем заголовок в раздел
    local titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    titleLabel.Text = name
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 24
    titleLabel.TextStrokeTransparency = 0.8
    titleLabel.TextWrapped = true

    -- Пример функций для раздела
    if name == "Settings" then
        local toggleButton = Instance.new("TextButton", frame)
        toggleButton.Size = UDim2.new(1, -20, 0, 50)
        toggleButton.Position = UDim2.new(0, 10, 0, 60)
        toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        toggleButton.Text = "Toggle Feature"
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.TextSize = 18
        toggleButton.MouseButton1Click:Connect(function()
            print("Settings feature toggled")
        end)
    elseif name == "Main" then
        local mainLabel = Instance.new("TextLabel", frame)
        mainLabel.Size = UDim2.new(1, -20, 0, 50)
        mainLabel.Position = UDim2.new(0, 10, 0, 60)
        mainLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        mainLabel.Text = "Main section content here"
        mainLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        mainLabel.TextSize = 18
    elseif name == "PlayerProfile" then
        local profileLabel = Instance.new("TextLabel", frame)
        profileLabel.Size = UDim2.new(1, -20, 0, 50)
        profileLabel.Position = UDim2.new(0, 10, 0, 60)
        profileLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        profileLabel.Text = "Player Profile content here"
        profileLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        profileLabel.TextSize = 18
    elseif name == "Trades" then
        local tradesLabel = Instance.new("TextLabel", frame)
        tradesLabel.Size = UDim2.new(1, -20, 0, 50)
        tradesLabel.Position = UDim2.new(0, 10, 0, 60)
        tradesLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        tradesLabel.Text = "Trades content here"
        tradesLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        tradesLabel.TextSize = 18
    end
end

-- Создание всех разделов
createSection("Main")
createSection("PlayerProfile")
createSection("Trades")
createSection("Settings")

-- Отображение первого раздела по умолчанию
content.Main.Visible = true
