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

local mainCategorySection = content:FindFirstChild("Main")

if mainCategorySection then
    print("Раздел 'Основные' найден")

-- Создаем кнопку для сбора наград в гильдии
local guildRewardButton = Instance.new("TextButton")
guildRewardButton.Size = UDim2.new(1, 0, 0, 50)  -- Размер кнопки
guildRewardButton.Position = UDim2.new(0, 0, 0, 50)  -- Позиция кнопки под основной
guildRewardButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Красный цвет, когда не нажата
guildRewardButton.Text = "Сбор наград в гильдии"
guildRewardButton.TextColor3 = Color3.fromRGB(255, 255, 255)
guildRewardButton.Font = Enum.Font.SourceSans
guildRewardButton.TextSize = 18
guildRewardButton.BorderSizePixel = 0
guildRewardButton.ZIndex = 2
guildRewardButton.Parent = mainCategorySection  -- Присоединяем кнопку к разделу "Основные"

-- Флаг, чтобы отслеживать статус нажатия кнопки
local isCollected = false

-- Обработчик нажатия кнопки
guildRewardButton.MouseButton1Click:Connect(function()
    if not isCollected then
        -- Загружаем и выполняем скрипт для сбора наград
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AKNALOGIAa/MVSB3/main/Categories/GuildsRewards.lua"))()

        -- Меняем цвет кнопки на зеленый
        guildRewardButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        isCollected = true
    end
end)

    local mainScriptButton = Instance.new("TextButton")
    mainScriptButton.Size = UDim2.new(1, 0, 0, 50)  -- Увеличил высоту кнопки для лучшей видимости
    mainScriptButton.Position = UDim2.new(0, 0, 0, 0)  -- Позиция кнопки
    mainScriptButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    mainScriptButton.Text = "Load Main Script"
    mainScriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    mainScriptButton.Font = Enum.Font.SourceSans
    mainScriptButton.TextSize = 18
    mainScriptButton.BorderSizePixel = 0
    mainScriptButton.ZIndex = 2  -- Устанавливаем высокий ZIndex
    mainScriptButton.Parent = mainCategorySection  -- Присоединяем кнопку к разделу "Основные"

    local scriptLoaded = false
    local mainScript

    local function unloadScript()
        if mainScript and type(mainScript) == "table" and mainScript.cleanup then
            print("Выполняется очистка скрипта...")
            pcall(mainScript.cleanup)  -- Выполняем функцию очистки скрипта
        end
    end

    local function hideInfoTag(player)
        local head = player.Character and player.Character:FindFirstChild("Head")
        if head then
            local billboardGui = head:FindFirstChildOfClass("BillboardGui")
            if billboardGui then
                billboardGui:Destroy()  -- Удалить BillboardGui
                print("Информация над головой игрока " .. player.Name .. " скрыта.")
            else
                print("BillboardGui не найден для игрока " .. player.Name)
            end
        else
            print("Голова не найдена для игрока " .. player.Name)
        end
    end

    local function getAllPlayers()
        local playersList = {}
        for _, player in ipairs(Players:GetChildren()) do
            if player:IsA("Player") then
                table.insert(playersList, player)
            end
        end
        return playersList
    end

    mainScriptButton.MouseButton1Click:Connect(function()
        print("Кнопка нажата")
        if not scriptLoaded then
            -- Загрузка скрипта
            print("Попытка загрузки скрипта")
            local scriptCode = game:HttpGet("https://raw.githubusercontent.com/AKNALOGIAa/MVSB3/main/Categories/Main.lua")
            local scriptFunc = loadstring(scriptCode)
            if scriptFunc then
                mainScript = scriptFunc()
                scriptLoaded = true
                mainScriptButton.Text = "Unload Main Script"
                print("Скрипт загружен успешно.")
            else
                print("Ошибка загрузки скрипта")
            end
        else
            -- Скрытие тегов
            print("Попытка скрыть теги")
            for _, player in pairs(getAllPlayers()) do
                hideInfoTag(player)
            end

            -- Удаление скрипта
            print("Попытка отгрузки скрипта")
            unloadScript()
            scriptLoaded = false
            mainScriptButton.Text = "Load Main Script"
            mainScript = nil  -- Очистка ссылки на скрипт
            print("Скрипт отгружен и очищен.")
        end
    end)

    print("Кнопка успешно добавлена в раздел 'Основные'")
else
    print("Раздел 'Основные' не найден")
end


-- Контейнер для списка профилей игроков
local profileList = Instance.new("ScrollingFrame")
profileList.Name = "ProfileList"
profileList.Size = UDim2.new(1, 0, 1, -50)
profileList.Position = UDim2.new(0, 0, 0, 50)
profileList.CanvasSize = UDim2.new(0, 0, 0, 0)  -- CanvasSize обновляется динамически
profileList.ScrollBarThickness = 8
profileList.BackgroundTransparency = 1
profileList.Parent = content:FindFirstChild("PlayerProfile")

-- Функция для создания профиля игрока
local function createPlayerProfile(playerName, index)
    local profile = replicatedStorage:WaitForChild("Profiles"):WaitForChild(playerName)
    local vel = profile:WaitForChild("Vel").Value
    local gems = profile:WaitForChild("Gems").Value

    local playerFrame = Instance.new("Frame")
    playerFrame.Name = playerName
    playerFrame.Size = UDim2.new(1, 0, 0, 50)
    playerFrame.Position = UDim2.new(0, 0, 0, index * 55)
    playerFrame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    playerFrame.BorderSizePixel = 0
    playerFrame.Parent = profileList

    local playerNameLabel = Instance.new("TextLabel")
    playerNameLabel.Text = playerName
    playerNameLabel.Size = UDim2.new(0.4, 0, 1, 0)
    playerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    playerNameLabel.BackgroundTransparency = 1
    playerNameLabel.Font = Enum.Font.SourceSansBold
    playerNameLabel.TextSize = 18
    playerNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    playerNameLabel.TextYAlignment = Enum.TextYAlignment.Center
    playerNameLabel.Parent = playerFrame

    local velLabel = Instance.new("TextLabel")
    velLabel.Text = "Vel: " .. vel
    velLabel.Size = UDim2.new(0.3, 0, 1, 0)
    velLabel.Position = UDim2.new(0.4, 0, 0, 0)
    velLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    velLabel.BackgroundTransparency = 1
    velLabel.Font = Enum.Font.SourceSans
    velLabel.TextSize = 18
    velLabel.TextXAlignment = Enum.TextXAlignment.Left
    velLabel.TextYAlignment = Enum.TextYAlignment.Center
    velLabel.Parent = playerFrame

    local gemsLabel = Instance.new("TextLabel")
    gemsLabel.Text = "Gems: " .. gems
    gemsLabel.Size = UDim2.new(0.3, 0, 1, 0)
    gemsLabel.Position = UDim2.new(0.7, 0, 0, 0)
    gemsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    gemsLabel.BackgroundTransparency = 1
    gemsLabel.Font = Enum.Font.SourceSans
    gemsLabel.TextSize = 18
    gemsLabel.TextXAlignment = Enum.TextXAlignment.Left
    gemsLabel.TextYAlignment = Enum.TextYAlignment.Center
    gemsLabel.Parent = playerFrame

    local expandButton = Instance.new("TextButton")
    expandButton.Size = UDim2.new(0.1, 0, 1, 0)
    expandButton.Position = UDim2.new(0.9, 0, 0, 0)
    expandButton.Text = "+"
    expandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    expandButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    expandButton.BorderSizePixel = 0
    expandButton.Font = Enum.Font.SourceSansBold
    expandButton.TextSize = 18
    expandButton.Parent = playerFrame

    local expandedFrame = Instance.new("Frame")
    expandedFrame.Size = UDim2.new(1, 0, 0, 200)
    expandedFrame.Position = UDim2.new(0, 0, 1, 0)
    expandedFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    expandedFrame.BorderSizePixel = 0
    expandedFrame.Visible = false
    expandedFrame.Parent = playerFrame

    local inventoryLabel = Instance.new("TextLabel")
    inventoryLabel.Text = "Inventory:"
    inventoryLabel.Size = UDim2.new(1, 0, 0, 30)
    inventoryLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    inventoryLabel.BackgroundTransparency = 1
    inventoryLabel.Font = Enum.Font.SourceSansBold
    inventoryLabel.TextSize = 18
    inventoryLabel.TextXAlignment = Enum.TextXAlignment.Left
    inventoryLabel.TextYAlignment = Enum.TextYAlignment.Top
    inventoryLabel.Parent = expandedFrame

    -- Создаём ScrollingFrame для списка предметов
    local inventoryScrollingFrame = Instance.new("ScrollingFrame")
    inventoryScrollingFrame.Size = UDim2.new(1, 0, 1, -30)
    inventoryScrollingFrame.Position = UDim2.new(0, 0, 0, 30)
    inventoryScrollingFrame.BackgroundTransparency = 1
    inventoryScrollingFrame.ScrollBarThickness = 8
    inventoryScrollingFrame.Parent = expandedFrame

    -- Добавляем рамку для отображения предметов
    local itemsListFrame = Instance.new("Frame")
    itemsListFrame.Size = UDim2.new(1, 0, 1, 0)
    itemsListFrame.BackgroundTransparency = 1
    itemsListFrame.Parent = inventoryScrollingFrame

    -- Заполняем информацию об инвентаре
 local inventory = profile:WaitForChild("Inventory")
local items = {}

for _, item in pairs(inventory:GetChildren()) do
    local itemName = item.Name
    local itemCount = 1  -- Значение по умолчанию

    -- Проверяем наличие объекта "Count" в предметах
    local countObject = item:FindFirstChild("Count")
    if countObject then
        itemCount = countObject.Value
    end

    -- Проверяем, если предмет уже существует в таблице, увеличиваем его количество
    if items[itemName] then
        items[itemName] = items[itemName] + itemCount
    else
        -- Если предмета ещё нет в таблице, добавляем его с указанным количеством
        items[itemName] = itemCount
    end
end

-- Преобразуем таблицу items в массив для упрощения работы с элементами
local itemList = {}
for name, count in pairs(items) do
    table.insert(itemList, {name = name, count = count})
end

-- Сортируем предметы по имени для удобства
table.sort(itemList, function(a, b) return a.name < b.name end)

-- Обновляем отображение предметов в ScrollingFrame
local yOffset = 0
for _, item in ipairs(itemList) do
    local itemLabel = Instance.new("TextLabel")
    itemLabel.Text = item.name .. ": " .. item.count
    itemLabel.Size = UDim2.new(1, -10, 0, 30)
    itemLabel.Position = UDim2.new(0, 5, 0, yOffset)
    itemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    itemLabel.BackgroundTransparency = 1
    itemLabel.Font = Enum.Font.SourceSans
    itemLabel.TextSize = 16
    itemLabel.TextXAlignment = Enum.TextXAlignment.Left
    itemLabel.TextYAlignment = Enum.TextYAlignment.Top
    itemLabel.Parent = itemsListFrame
    yOffset = yOffset + 30
end

-- Обновляем размеры ScrollingFrame
itemsListFrame.Size = UDim2.new(1, 0, 0, yOffset)
inventoryScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)


    expandButton.MouseButton1Click:Connect(function()
        expandedFrame.Visible = not expandedFrame.Visible
        expandButton.Text = expandedFrame.Visible and "-" or "+"
        if expandedFrame.Visible then
            for _, frame in ipairs(profileList:GetChildren()) do
                if frame:IsA("Frame") and frame ~= playerFrame then
                    frame.Position = frame.Position + UDim2.new(0, 0, 0, expandedFrame.Size.Y.Offset)
                end
            end
            profileList.CanvasSize = UDim2.new(0, 0, 0, profileList.CanvasSize.Y.Offset + expandedFrame.Size.Y.Offset)
        else
            for _, frame in ipairs(profileList:GetChildren()) do
                if frame:IsA("Frame") and frame ~= playerFrame then
                    frame.Position = frame.Position - UDim2.new(0, 0, 0, expandedFrame.Size.Y.Offset)
                end
            end
            profileList.CanvasSize = UDim2.new(0, 0, 0, profileList.CanvasSize.Y.Offset - expandedFrame.Size.Y.Offset)
        end
    end)
end


-- Отображение профилей игроков
local function updatePlayerProfiles()
    profileList:ClearAllChildren()
    local players = game:GetService("Players"):GetPlayers()
    profileList.CanvasSize = UDim2.new(0, 0, 0, #players * 55)  -- Обновляем CanvasSize для прокрутки
    for i, player in ipairs(players) do
        createPlayerProfile(player.Name, i - 1)
    end
end

-- Контейнер для списка трейдов
local tradeList = Instance.new("ScrollingFrame")
tradeList.Name = "TradeList"
tradeList.Size = UDim2.new(1, 0, 1, -50)
tradeList.Position = UDim2.new(0, 0, 0, 50)
tradeList.CanvasSize = UDim2.new(0, 0, 0, 0)  -- CanvasSize обновляется динамически
tradeList.ScrollBarThickness = 8
tradeList.BackgroundTransparency = 1
tradeList.Parent = content:FindFirstChild("Trades")

-- Функция для создания трейда
local function createTrade(tradeName, index)
    local trade = replicatedStorage:WaitForChild("Trades"):WaitForChild(tradeName)
    local otherPlayer = trade:WaitForChild("OtherPlayer").Value
    local vel = trade:WaitForChild("Vel").Value

    local tradeFrame = Instance.new("Frame")
    tradeFrame.Name = tradeName
    tradeFrame.Size = UDim2.new(1, 0, 0, 100)
    tradeFrame.Position = UDim2.new(0, 0, 0, index * 105)
    tradeFrame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    tradeFrame.BorderSizePixel = 0
    tradeFrame.Parent = tradeList

    local tradeNameLabel = Instance.new("TextLabel")
    tradeNameLabel.Text = tradeName
    tradeNameLabel.Size = UDim2.new(0.4, 0, 0, 50)
    tradeNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    tradeNameLabel.BackgroundTransparency = 1
    tradeNameLabel.Font = Enum.Font.SourceSansBold
    tradeNameLabel.TextSize = 18
    tradeNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    tradeNameLabel.TextYAlignment = Enum.TextYAlignment.Center
    tradeNameLabel.Parent = tradeFrame

    local velLabel = Instance.new("TextLabel")
    velLabel.Text = "Vel: " .. vel
    velLabel.Size = UDim2.new(0.3, 0, 0, 50)
    velLabel.Position = UDim2.new(0.4, 0, 0, 0)
    velLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    velLabel.BackgroundTransparency = 1
    velLabel.Font = Enum.Font.SourceSans
    velLabel.TextSize = 18
    velLabel.TextXAlignment = Enum.TextXAlignment.Left
    velLabel.TextYAlignment = Enum.TextYAlignment.Center
    velLabel.Parent = tradeFrame

    local itemsList = Instance.new("TextLabel")
    itemsList.Text = "Items:\n"
    itemsList.Size = UDim2.new(1, 0, 1, -50)
    itemsList.Position = UDim2.new(0, 0, 0, 50)
    itemsList.TextColor3 = Color3.fromRGB(255, 255, 255)
    itemsList.BackgroundTransparency = 1
    itemsList.Font = Enum.Font.SourceSans
    itemsList.TextSize = 16
    itemsList.TextXAlignment = Enum.TextXAlignment.Left
    itemsList.TextYAlignment = Enum.TextYAlignment.Top
    itemsList.TextWrapped = true
    itemsList.Parent = tradeFrame

    local tradeItems = {}
    for i = 1, 10 do
        local item = trade:FindFirstChild("Item" .. i)
        if item then
            local itemName = item.Value
            local itemCount = item:FindFirstChild("Count") and item.Count.Value or 1
            tradeItems[itemName] = itemCount
        end
    end

    local itemsText = ""
    for itemName, itemCount in pairs(tradeItems) do
        itemsText = itemsText .. itemName .. ": " .. itemCount .. "\n"
    end
    itemsList.Text = itemsText
end

-- Обновление списка трейдов
local function updateTrades()
    tradeList:ClearAllChildren()
    local trades = replicatedStorage:WaitForChild("Trades"):GetChildren()
    tradeList.CanvasSize = UDim2.new(0, 0, 0, #trades * 105)  -- Обновляем CanvasSize для прокрутки
    for i, trade in ipairs(trades) do
        if trade:IsA("Folder") then
            local tradeName = trade.Name
            createTrade(tradeName, i - 1)
        end
    end
end

-- Обновление данных каждую секунду
while true do
    updatePlayerProfiles()
    updateTrades()
    wait(15)
end
