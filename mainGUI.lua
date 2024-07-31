local player = game:GetService("Players").LocalPlayer
local playerGui = player:FindFirstChildOfClass("PlayerGui")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")

-- Удаление старого GUI, если существует
if playerGui:FindFirstChild("CustomUI") then
    playerGui.CustomUI:Destroy()
end

-- Создание нового GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomUI"
screenGui.Parent = playerGui

-- Окно GUI
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0.6, 0, 0.8, 0)
mainFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Заголовок окна
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0.1, 0)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
header.BorderSizePixel = 0
header.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Akanlogia MMSB3 script v1.2"
titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 24
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextYAlignment = Enum.TextYAlignment.Center
titleLabel.Parent = header

-- Кнопка свернуть/развернуть
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0.1, 0, 0.5, 0)
minimizeButton.Position = UDim2.new(0.9, -10, 0.25, 0)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.BorderSizePixel = 0
minimizeButton.Font = Enum.Font.SourceSansBold
minimizeButton.TextSize = 24
minimizeButton.Parent = header

local restoreButton = Instance.new("TextButton")
restoreButton.Size = UDim2.new(0.1, 0, 0.1, 0)
restoreButton.Position = UDim2.new(0, 0, 0, 0)
restoreButton.Text = "Restore"
restoreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
restoreButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
restoreButton.BorderSizePixel = 0
restoreButton.Font = Enum.Font.SourceSansBold
restoreButton.TextSize = 24
restoreButton.Parent = screenGui
restoreButton.Visible = false

local isMinimized = false

minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame.Visible = false
        restoreButton.Visible = true
    else
        mainFrame.Visible = true
        restoreButton.Visible = false
    end
end)

restoreButton.MouseButton1Click:Connect(function()
    isMinimized = false
    mainFrame.Visible = true
    restoreButton.Visible = false
end)

-- Перетаскивание окна
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

userInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Боковое меню
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0.2, 0, 0.9, 0)
sidebar.Position = UDim2.new(0, 0, 0.1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

-- Основная область
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(0.8, 0, 0.9, 0)
content.Position = UDim2.new(0.2, 0, 0.1, 0)
content.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
content.BorderSizePixel = 0
content.Parent = mainFrame

-- Размер и отступы кнопок
local buttonHeight = 40
local buttonSpacing = 10

-- Функция для создания кнопок в боковом меню
local function createSidebarButton(text, sectionName, index)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, buttonHeight)
    button.Position = UDim2.new(0, 0, 0, index * (buttonHeight + buttonSpacing))
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.BorderSizePixel = 0
    button.Name = sectionName
    button.Parent = sidebar
    
    button.MouseButton1Click:Connect(function()
        -- Скрытие всех разделов
        for _, child in ipairs(content:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = false
            end
        end
        -- Отображение выбранного раздела
        local targetContent = content:FindFirstChild(sectionName)
        if targetContent then
            targetContent.Visible = true
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

-- Функция для создания раздела
local function createSection(name)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.Visible = false
    frame.BorderSizePixel = 0
    frame.Parent = content

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.Text = name
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 24
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.Parent = frame
end

-- Создание кнопок и разделов
local categories = {
    {name = "Основные", section = "Main"},
    {name = "Профиль Игроков", section = "PlayerProfile"},
    {name = "Трейды", section = "Trades"},
    {name = "Настройки", section = "Settings"}
}

for index, category in ipairs(categories) do
    createSidebarButton(category.name, category.section, index)
    createSection(category.section)
end

-- Заполнение раздела Профиль Игроков
local profileSection = content:FindFirstChild("PlayerProfile")

local profileTitle = Instance.new("TextLabel")
profileTitle.Size = UDim2.new(1, 0, 0, 40)
profileTitle.Text = "Профиль Игроков"
profileTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
profileTitle.BackgroundTransparency = 1
profileTitle.Font = Enum.Font.SourceSansBold
profileTitle.TextSize = 24
profileTitle.TextXAlignment = Enum.TextXAlignment.Center
profileTitle.TextYAlignment = Enum.TextYAlignment.Center
profileTitle.Parent = profileSection

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Padding = UDim.new(0, 10)
playerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
playerListLayout.Parent = profileSection

local function updatePlayerProfiles()
    -- Очистка старого списка
    for _, child in ipairs(profileSection:GetChildren()) do
        if child:IsA("TextButton") and child.Name ~= "ProfileTitle" then
            child:Destroy()
        end
    end

    -- Создание кнопок для каждого игрока
    for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
        if p ~= player then
            local profileButton = Instance.new("TextButton")
            profileButton.Size = UDim2.new(1, -20, 0, 60)
            profileButton.Position = UDim2.new(0, 10, 0, 10)
            profileButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            profileButton.Text = p.Name
            profileButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            profileButton.Font = Enum.Font.SourceSans
            profileButton.TextSize = 18
            profileButton.BorderSizePixel = 0
            profileButton.Name = p.Name
            profileButton.Parent = profileSection

            profileButton.MouseButton1Click:Connect(function()
                -- Показать информацию о профиле
                local playerInfo = Instance.new("Frame")
                playerInfo.Name = "PlayerInfo"
                playerInfo.Size = UDim2.new(0.5, 0, 0.5, 0)
                playerInfo.Position = UDim2.new(0.25, 0, 0.25, 0)
                playerInfo.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                playerInfo.BorderSizePixel = 0
                playerInfo.Parent = screenGui

                local closeButton = Instance.new("TextButton")
                closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
                closeButton.Position = UDim2.new(0.9, 0, 0, 0)
                closeButton.Text = "X"
                closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
                closeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                closeButton.BorderSizePixel = 0
                closeButton.Font = Enum.Font.SourceSansBold
                closeButton.TextSize = 24
                closeButton.Parent = playerInfo

                closeButton.MouseButton1Click:Connect(function()
                    playerInfo:Destroy()
                end)

                local playerName = Instance.new("TextLabel")
                playerName.Size = UDim2.new(1, 0, 0.3, 0)
                playerName.Text = "Имя: " .. p.Name
                playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
                playerName.BackgroundTransparency = 1
                playerName.Font = Enum.Font.SourceSansBold
                playerName.TextSize = 24
                playerName.TextXAlignment = Enum.TextXAlignment.Center
                playerName.TextYAlignment = Enum.TextYAlignment.Center
                playerName.Parent = playerInfo

                -- Информация о инвентаре
                local inventoryTitle = Instance.new("TextLabel")
                inventoryTitle.Size = UDim2.new(1, 0, 0, 40)
                inventoryTitle.Text = "Инвентарь:"
                inventoryTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                inventoryTitle.BackgroundTransparency = 1
                inventoryTitle.Font = Enum.Font.SourceSansBold
                inventoryTitle.TextSize = 24
                inventoryTitle.TextXAlignment = Enum.TextXAlignment.Left
                inventoryTitle.TextYAlignment = Enum.TextYAlignment.Top
                inventoryTitle.Position = UDim2.new(0, 0, 0.3, 0)
                inventoryTitle.Parent = playerInfo

                local inventoryFrame = Instance.new("Frame")
                inventoryFrame.Size = UDim2.new(1, -20, 0.6, -50)
                inventoryFrame.Position = UDim2.new(0, 10, 0.4, 0)
                inventoryFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                inventoryFrame.BorderSizePixel = 0
                inventoryFrame.Parent = playerInfo

                local inventoryListLayout = Instance.new("UIGridLayout")
                inventoryListLayout.CellSize = UDim2.new(0.3, 0, 0.3, 0)
                inventoryListLayout.CellPadding = UDim2.new(0.05, 0, 0.05, 0)
                inventoryListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                inventoryListLayout.Parent = inventoryFrame

                local function updateInventory()
                    -- Очистка старого инвентаря
                    for _, child in ipairs(inventoryFrame:GetChildren()) do
                        if child:IsA("ImageButton") then
                            child:Destroy()
                        end
                    end

                    -- Создание и отображение предметов
                    for _, item in ipairs(p.Backpack:GetChildren()) do
                        local itemButton = Instance.new("ImageButton")
                        itemButton.Size = UDim2.new(1, 0, 1, 0)
                        itemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        itemButton.Image = "rbxassetid://" .. item.TextureID
                        itemButton.BorderSizePixel = 0
                        itemButton.Parent = inventoryFrame
                    end
                end

                updateInventory()
            end)
        end
    end
end

updatePlayerProfiles()

-- Заполнение раздела Трейды
local tradesSection = content:FindFirstChild("Trades")

local tradesTitle = Instance.new("TextLabel")
tradesTitle.Size = UDim2.new(1, 0, 0, 40)
tradesTitle.Text = "Трейды"
tradesTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
tradesTitle.BackgroundTransparency = 1
tradesTitle.Font = Enum.Font.SourceSansBold
tradesTitle.TextSize = 24
tradesTitle.TextXAlignment = Enum.TextXAlignment.Center
tradesTitle.TextYAlignment = Enum.TextYAlignment.Center
tradesTitle.Parent = tradesSection

local tradesListLayout = Instance.new("UIListLayout")
tradesListLayout.Padding = UDim.new(0, 10)
tradesListLayout.SortOrder = Enum.SortOrder.LayoutOrder
tradesListLayout.Parent = tradesSection

local function updateTrades()
    -- Очистка старых трейдов
    for _, child in ipairs(tradesSection:GetChildren()) do
        if child:IsA("TextButton") and child.Name ~= "TradesTitle" then
            child:Destroy()
        end
    end

    -- Создание кнопок для трейдов
    local trades = {} -- Здесь должен быть список трейдов
    for _, trade in ipairs(trades) do
        if trade.Player1 ~= player and trade.Player2 ~= player then
            local tradeButton = Instance.new("TextButton")
            tradeButton.Size = UDim2.new(1, -20, 0, 60)
            tradeButton.Position = UDim2.new(0, 10, 0, 10)
            tradeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            tradeButton.Text = "Трейд с " .. trade.Player1.Name .. " и " .. trade.Player2.Name
            tradeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            tradeButton.Font = Enum.Font.SourceSans
            tradeButton.TextSize = 18
            tradeButton.BorderSizePixel = 0
            tradeButton.Name = "Trade_" .. trade.ID
            tradeButton.Parent = tradesSection

            tradeButton.MouseButton1Click:Connect(function()
                -- Показать информацию о трейде
                local tradeInfo = Instance.new("Frame")
                tradeInfo.Name = "TradeInfo"
                tradeInfo.Size = UDim2.new(0.5, 0, 0.5, 0)
                tradeInfo.Position = UDim2.new(0.25, 0, 0.25, 0)
                tradeInfo.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                tradeInfo.BorderSizePixel = 0
                tradeInfo.Parent = screenGui

                local closeButton = Instance.new("TextButton")
                closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
                closeButton.Position = UDim2.new(0.9, 0, 0, 0)
                closeButton.Text = "X"
                closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
                closeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                closeButton.BorderSizePixel = 0
                closeButton.Font = Enum.Font.SourceSansBold
                closeButton.TextSize = 24
                closeButton.Parent = tradeInfo

                closeButton.MouseButton1Click:Connect(function()
                    tradeInfo:Destroy()
                end)

                local tradeDetails = Instance.new("TextLabel")
                tradeDetails.Size = UDim2.new(1, 0, 0.3, 0)
                tradeDetails.Text = "Трейд между " .. trade.Player1.Name .. " и " .. trade.Player2.Name
                tradeDetails.TextColor3 = Color3.fromRGB(255, 255, 255)
                tradeDetails.BackgroundTransparency = 1
                tradeDetails.Font = Enum.Font.SourceSansBold
                tradeDetails.TextSize = 24
                tradeDetails.TextXAlignment = Enum.TextXAlignment.Center
                tradeDetails.TextYAlignment = Enum.TextYAlignment.Center
                tradeDetails.Parent = tradeInfo

                -- Информация о предметах
                local itemsTitle = Instance.new("TextLabel")
                itemsTitle.Size = UDim2.new(1, 0, 0, 40)
                itemsTitle.Text = "Предметы:"
                itemsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                itemsTitle.BackgroundTransparency = 1
                itemsTitle.Font = Enum.Font.SourceSansBold
                itemsTitle.TextSize = 24
                itemsTitle.TextXAlignment = Enum.TextXAlignment.Left
                itemsTitle.TextYAlignment = Enum.TextYAlignment.Top
                itemsTitle.Position = UDim2.new(0, 0, 0.3, 0)
                itemsTitle.Parent = tradeInfo

                local itemsFrame = Instance.new("Frame")
                itemsFrame.Size = UDim2.new(1, -20, 0.6, -50)
                itemsFrame.Position = UDim2.new(0, 10, 0.4, 0)
                itemsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                itemsFrame.BorderSizePixel = 0
                itemsFrame.Parent = tradeInfo

                local itemsListLayout = Instance.new("UIGridLayout")
                itemsListLayout.CellSize = UDim2.new(0.3, 0, 0.3, 0)
                itemsListLayout.CellPadding = UDim2.new(0.05, 0, 0.05, 0)
                itemsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                itemsListLayout.Parent = itemsFrame

                local function updateItems()
                    -- Очистка старых предметов
                    for _, child in ipairs(itemsFrame:GetChildren()) do
                        if child:IsA("ImageButton") then
                            child:Destroy()
                        end
                    end

                    -- Создание и отображение предметов
                    for _, item in ipairs(trade.Items) do
                        local itemButton = Instance.new("ImageButton")
                        itemButton.Size = UDim2.new(1, 0, 1, 0)
                        itemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        itemButton.Image = "rbxassetid://" .. item.TextureID
                        itemButton.BorderSizePixel = 0
                        itemButton.Parent = itemsFrame
                    end
                end

                updateItems()
            end)
        end
    end
end

updateTrades()
