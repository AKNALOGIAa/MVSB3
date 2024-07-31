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
    button.Position = UDim2.new(0, 0, position * 0.1, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Name = sectionName
    button.Visible = true  -- Убедитесь, что кнопка видима
    button.MouseButton1Click:Connect(function()
        for _, child in ipairs(content:GetChildren()) do
            child.Visible = (child.Name == sectionName)
        end
    end)
end

-- Создание кнопок в боковом меню
createSidebarButton("Settings", 0, "Settings")
createSidebarButton("Kill Aura", 0.1, "KillAura")
createSidebarButton("Misc", 0.2, "Misc")
createSidebarButton("Void Tower", 0.3, "VoidTower")
createSidebarButton("Guild", 0.4, "Guild")
createSidebarButton("Target", 0.5, "Target")
createSidebarButton("Teleport", 0.6, "Teleport")
createSidebarButton("Upgrade", 0.7, "Upgrade")
createSidebarButton("Webhook", 0.8, "Webhook")
createSidebarButton("Information", 0.9, "Information")

-- Функция для создания раздела
local function createSection(name)
    local frame = Instance.new("Frame", content)
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    frame.Visible = false
    frame.Padding = UDim.new(0, 10) -- Добавляем отступы для удобства

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
        -- Добавляем кнопку в раздел Settings
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
    elseif name == "KillAura" then
        -- Добавляем кнопку в раздел Kill Aura
        local activateButton = Instance.new("TextButton", frame)
        activateButton.Size = UDim2.new(1, -20, 0, 50)
        activateButton.Position = UDim2.new(0, 10, 0, 60)
        activateButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        activateButton.Text = "Activate Kill Aura"
        activateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        activateButton.TextSize = 18
        activateButton.MouseButton1Click:Connect(function()
            print("Kill Aura activated")
        end)
    elseif name == "Misc" then
        -- Добавляем кнопку в раздел Misc
        local miscButton = Instance.new("TextButton", frame)
        miscButton.Size = UDim2.new(1, -20, 0, 50)
        miscButton.Position = UDim2.new(0, 10, 0, 60)
        miscButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        miscButton.Text = "Misc Option"
        miscButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        miscButton.TextSize = 18
        miscButton.MouseButton1Click:Connect(function()
            print("Misc option selected")
        end)
    elseif name == "VoidTower" then
        -- Добавляем кнопку в раздел Void Tower
        local voidTowerButton = Instance.new("TextButton", frame)
        voidTowerButton.Size = UDim2.new(1, -20, 0, 50)
        voidTowerButton.Position = UDim2.new(0, 10, 0, 60)
        voidTowerButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        voidTowerButton.Text = "Void Tower Feature"
        voidTowerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        voidTowerButton.TextSize = 18
        voidTowerButton.MouseButton1Click:Connect(function()
            print("Void Tower feature selected")
        end)
    elseif name == "Guild" then
        -- Добавляем кнопку в раздел Guild
        local guildButton = Instance.new("TextButton", frame)
        guildButton.Size = UDim2.new(1, -20, 0, 50)
        guildButton.Position = UDim2.new(0, 10, 0, 60)
        guildButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        guildButton.Text = "Guild Option"
        guildButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        guildButton.TextSize = 18
        guildButton.MouseButton1Click:Connect(function()
            print("Guild option selected")
        end)
    elseif name == "Target" then
        -- Добавляем кнопку в раздел Target
        local targetButton = Instance.new("TextButton", frame)
        targetButton.Size = UDim2.new(1, -20, 0, 50)
        targetButton.Position = UDim2.new(0, 10, 0, 60)
        targetButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        targetButton.Text = "Target Feature"
        targetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        targetButton.TextSize = 18
        targetButton.MouseButton1Click:Connect(function()
            print("Target feature selected")
        end)
    elseif name == "Teleport" then
        -- Добавляем кнопку в раздел Teleport
        local teleportButton = Instance.new("TextButton", frame)
        teleportButton.Size = UDim2.new(1, -20, 0, 50)
        teleportButton.Position = UDim2.new(0, 10, 0, 60)
        teleportButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        teleportButton.Text = "Teleport Option"
        teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        teleportButton.TextSize = 18
        teleportButton.MouseButton1Click:Connect(function()
            print("Teleport option selected")
        end)
    elseif name == "Upgrade" then
        -- Добавляем кнопку в раздел Upgrade
        local upgradeButton = Instance.new("TextButton", frame)
        upgradeButton.Size = UDim2.new(1, -20, 0, 50)
        upgradeButton.Position = UDim2.new(0, 10, 0, 60)
        upgradeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        upgradeButton.Text = "Upgrade Feature"
        upgradeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        upgradeButton.TextSize = 18
        upgradeButton.MouseButton1Click:Connect(function()
            print("Upgrade feature selected")
        end)
    elseif name == "Webhook" then
        -- Добавляем кнопку в раздел Webhook
        local webhookButton = Instance.new("TextButton", frame)
        webhookButton.Size = UDim2.new(1, -20, 0, 50)
        webhookButton.Position = UDim2.new(0, 10, 0, 60)
        webhookButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        webhookButton.Text = "Webhook Option"
        webhookButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        webhookButton.TextSize = 18
        webhookButton.MouseButton1Click:Connect(function()
            print("Webhook option selected")
        end)
    elseif name == "Information" then
        -- Добавляем кнопку в раздел Information
        local infoButton = Instance.new("TextButton", frame)
        infoButton.Size = UDim2.new(1, -20, 0, 50)
        infoButton.Position = UDim2.new(0, 10, 0, 60)
        infoButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        infoButton.Text = "Information Option"
        infoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        infoButton.TextSize = 18
        infoButton.MouseButton1Click:Connect(function()
            print("Information option selected")
        end)
    end
end

-- Создание всех разделов
createSection("Settings")
createSection("KillAura")
createSection("Misc")
createSection("VoidTower")
createSection("Guild")
createSection("Target")
createSection("Teleport")
createSection("Upgrade")
createSection("Webhook")
createSection("Information")

-- Отображение первого раздела по умолчанию
content.Settings.Visible = true
