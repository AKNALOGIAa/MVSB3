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
titleLabel.Text = "Script Hub v1.2"
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
minimizeButton.Text = "_"
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

-- Контейнер для списка профилей игроков
local profileList = Instance.new("ScrollingFrame")
profileList.Name = "ProfileList"
profileList.Size = UDim2.new(1, 0, 1, -50)
profileList.Position = UDim2.new(0, 0, 0, 50)
profileList.CanvasSize = UDim2.new(0, 0, 0, 0)
profileList.ScrollBarThickness = 8
profileList.BackgroundTransparency = 1
profileList.Parent = content:FindFirstChild("PlayerProfile")

-- Контейнер для списка трейдов
local tradeList = Instance.new("ScrollingFrame")
tradeList.Name = "TradeList"
tradeList.Size = UDim2.new(1, 0, 1, -50)
tradeList.Position = UDim2.new(0, 0, 0, 50)
tradeList.CanvasSize = UDim2.new(0, 0, 0, 0)
tradeList.ScrollBarThickness = 8
tradeList.BackgroundTransparency = 1
tradeList.Parent = content:FindFirstChild("Trades")

-- Функция для создания и отображения инвентаря игрока
local function createInventory()
    local inventoryFrame = Instance.new("Frame")
    inventoryFrame.Name = "InventoryFrame"
    inventoryFrame.Size = UDim2.new(1, 0, 1, 0)
    inventoryFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    inventoryFrame.BorderSizePixel = 0
    inventoryFrame.Parent = content:FindFirstChild("PlayerProfile")

    local uiGridLayout = Instance.new("UIGridLayout")
    uiGridLayout.CellSize = UDim2.new(0.3, 0, 0.3, 0)
    uiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiGridLayout.Padding = UDim2.new(0.02, 0, 0.02, 0)
    uiGridLayout.Parent = inventoryFrame

    local items = player.Backpack:GetChildren()
    local itemIndex = 0

    for _, item in ipairs(items) do
        if item:IsA("Tool") then
            local itemFrame = Instance.new("Frame")
            itemFrame.Size = UDim2.new(1, 0, 0.3, 0)
            itemFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            itemFrame.BorderSizePixel = 0
            itemFrame.Parent = inventoryFrame

            local itemLabel = Instance.new("TextLabel")
            itemLabel.Text = item.Name
            itemLabel.Size = UDim2.new(1, 0, 1, 0)
            itemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            itemLabel.BackgroundTransparency = 1
            itemLabel.Font = Enum.Font.SourceSans
            itemLabel.TextSize = 16
            itemLabel.TextXAlignment = Enum.TextXAlignment.Left
            itemLabel.TextYAlignment = Enum.TextYAlignment.Center
            itemLabel.Parent = itemFrame

            itemIndex = itemIndex + 1
        end
    end

    -- Обновление списка инвентаря
    inventoryFrame.Size = UDim2.new(1, 0, 1, 0)
end

-- Функция для создания и отображения информации о трейде
local function createTrade(tradeName, index)
    local trade = replicatedStorage:WaitForChild("Trades"):WaitForChild(tradeName)

    local tradeFrame = Instance.new("Frame")
    tradeFrame.Name = tradeName
    tradeFrame.Size = UDim2.new(1, 0, 0, 100)
    tradeFrame.Position = UDim2.new(0, 0, 0, index * 105)
    tradeFrame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    tradeFrame.BorderSizePixel = 0
    tradeFrame.Parent = tradeList

    local tradeHeader = Instance.new("Frame")
    tradeHeader.Name = "TradeHeader"
    tradeHeader.Size = UDim2.new(1, 0, 0, 30)
    tradeHeader.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tradeHeader.BorderSizePixel = 0
    tradeHeader.Parent = tradeFrame

    local tradeTitle = Instance.new("TextLabel")
    tradeTitle.Text = "Trade with: " .. trade:WaitForChild("OtherPlayer").Value
    tradeTitle.Size = UDim2.new(0.9, 0, 1, 0)
    tradeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    tradeTitle.BackgroundTransparency = 1
    tradeTitle.Font = Enum.Font.SourceSansBold
    tradeTitle.TextSize = 18
    tradeTitle.TextXAlignment = Enum.TextXAlignment.Left
    tradeTitle.TextYAlignment = Enum.TextYAlignment.Center
    tradeTitle.Parent = tradeHeader

    local tradeItems = Instance.new("Frame")
    tradeItems.Name = "TradeItems"
    tradeItems.Size = UDim2.new(1, 0, 0, 70)
    tradeItems.Position = UDim2.new(0, 0, 0, 30)
    tradeItems.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tradeItems.BorderSizePixel = 0
    tradeItems.Parent = tradeFrame

    local uiGridLayout = Instance.new("UIGridLayout")
    uiGridLayout.CellSize = UDim2.new(0.3, 0, 0.3, 0)
    uiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiGridLayout.Padding = UDim2.new(0.02, 0, 0.02, 0)
    uiGridLayout.Parent = tradeItems

    -- Отображение предметов в трейде
    local items = {}
    for i = 1, 10 do
        local item = trade:FindFirstChild("Item" .. i)
        if item then
            local itemName = item:WaitForChild("Value").Value
            local itemCount = item:WaitForChild("Count").Value
            if items[itemName] then
                items[itemName] = items[itemName] + itemCount
            else
                items[itemName] = itemCount
            end
        end
    end

    local itemIndex = 0
    for itemName, itemCount in pairs(items) do
        local itemFrame = Instance.new("Frame")
        itemFrame.Size = UDim2.new(1, 0, 0.3, 0)
        itemFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        itemFrame.BorderSizePixel = 0
        itemFrame.Parent = tradeItems

        local itemLabel = Instance.new("TextLabel")
        itemLabel.Text = itemName .. ": " .. itemCount
        itemLabel.Size = UDim2.new(1, 0, 1, 0)
        itemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        itemLabel.BackgroundTransparency = 1
        itemLabel.Font = Enum.Font.SourceSans
        itemLabel.TextSize = 16
        itemLabel.TextXAlignment = Enum.TextXAlignment.Left
        itemLabel.TextYAlignment = Enum.TextYAlignment.Center
        itemLabel.Parent = itemFrame

        itemIndex = itemIndex + 1
    end

    -- Обновление списка трейдов
    tradeList.CanvasSize = UDim2.new(0, 0, 0, (index + 1) * 105)
end

-- Функция обновления информации о трейдах
local function updateTrades()
    local index = 0
    tradeList:ClearAllChildren()
    
    -- Обновление трейдов
    local trades = replicatedStorage:WaitForChild("Trades"):GetChildren()
    local processedTrades = {}
    
    for _, trade in pairs(trades) do
        if trade:IsA("Folder") then
            local otherPlayer = trade:WaitForChild("OtherPlayer").Value
            if not processedTrades[otherPlayer] then
                createTrade(trade.Name, index)
                index = index + 1
                processedTrades[otherPlayer] = true
            end
        end
    end
end

-- Обновление информации о профилях и инвентаре
local function updatePlayerProfile()
    -- Обновление списка профилей
    profileList:ClearAllChildren()
    -- Здесь добавьте код для создания и отображения профилей игроков
end

-- Обновление информации о трейдах
local function updateTradesList()
    while true do
        updateTrades()
        wait(15)
    end
end

-- Запуск обновления информации
createInventory()
updatePlayerProfile()
spawn(updateTradesList)
