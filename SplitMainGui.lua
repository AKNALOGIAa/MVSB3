local player = game:GetService("Players").LocalPlayer
local playerGui = player:FindFirstChildOfClass("PlayerGui")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local savedPlayerName = "AKNALOGIAaura"
---Циклы
local RunService = game:GetService("RunService")
local tradeInterval = 2
local updateInterval = 15
local lastTradeProcessTime = tick()
local lastUpdateProfilesTime = tick()
---

local MountsColor = {
    Orange = {"VoidErebusMount", "VoidGaliardMount", "DarkUnicornMount", "DarkCrab", "ShadowCrab",},
    Purple = {"ErebusMount", "GaliardMount", "IcewhalMount", "OwlMount", "SandTerrorMount", "SeaSerpentMount"}
}
local ogCosmeticItems = {"NecromancerCloak", "ShadowTuxedo", "VoidArmor", "FlamingGarment", "CyberEnforcer", "GoldenKimono"} -- Список предметов для категории OG Cosmetic


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
titleLabel.Text = "AKNALOGIA MMSB3 script v1.4.8Beta"
titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 24
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextYAlignment = Enum.TextYAlignment.Center
titleLabel.Parent = header

------------- Кнопка свернуть/развернуть--------------
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
----------------------------------------------------------

------------------- Перетаскивание окна-------------------
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
----------------------------------------------------------

---------------------- Боковое меню-----------------------
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
----------------------------------------------------------

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
----------------------------------------------------------

--------------- Создание кнопок и разделов----------------
local categories = {
    {name = "Основные", section = "Main"},
    {name = "Профиль Игроков", section = "PlayerProfile"},
    {name = "Трейды", section = "Trades"},
    {name = "Вещи", section = "Items"},
    {name = "Настройки", section = "Settings"}
}

for index, category in ipairs(categories) do
    createSidebarButton(category.name, category.section, index)
    createSection(category.section)
end
----------------------------------------------------------
-------------------Получение наград гильдии---------------
local mainCategorySection = content:FindFirstChild("Main")

if mainCategorySection then
    print("Раздел 'Основные Для гильдии' найден")

    -- Создаем кнопку для сбора наград в гильдии
    local guildRewardButton = Instance.new("TextButton")
    guildRewardButton.Size = UDim2.new(1, 0, 0, 50)  -- Размер кнопки
    guildRewardButton.Position = UDim2.new(0, 0, 0, 100)  -- Позиция кнопки под основной
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
            game:GetService("ReplicatedStorage").Systems.Guilds.GetRewards:InvokeServer()
            for i = 1, 9 do
                local args = {
                    [1] = i
                }
                game:GetService("ReplicatedStorage").Systems.Guilds.ClaimGuildReward:FireServer(unpack(args))
            end
            local auraPackArgs = {
                [1] = "Floor6AuraPack",
                [2] = 3,
                [3] = true
            }
            game:GetService("ReplicatedStorage").Systems.PremiumShop.PurchaseAuraPack:FireServer(unpack(auraPackArgs))
            -- Меняем цвет кнопки на зеленый
            guildRewardButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            isCollected = true
        end
    end)
end
----------------------------------------------------------

----------- Функция для создания кнопки покупки----------
-----------Получаем основную категорию для вещей---------
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspaceDrops = game:GetService("Workspace").Drops
local itemsSection = content:FindFirstChild("Items")

local ogCosmeticColor = Color3.new(1, 0, 1) -- Розовый цвет для OG косметики

local categories = {"Все", "Маунты", "Оружие", "Броня", "OG Косметика"}

if itemsSection then
    -- Создаем ScrollingFrame для возможности прокрутки
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, 0, 0.9, 0) -- Сместим вниз, чтобы освободить место для кнопок
    scrollingFrame.Position = UDim2.new(0, 0, 0, 0)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollingFrame.ScrollBarThickness = 12
    scrollingFrame.Parent = itemsSection

    -- Добавляем кнопки для категорий
    local buttonsFrame = Instance.new("Frame")
    buttonsFrame.Size = UDim2.new(1, 0, 0.1, 0)
    buttonsFrame.Position = UDim2.new(0, 0, 0.9, 0)
    buttonsFrame.BackgroundTransparency = 1
    buttonsFrame.Parent = itemsSection

    local function createCategoryButtons()
        for i, category in ipairs(categories) do
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0.2, 0, 1, 0) -- 0.2 для 5 кнопок
            button.Position = UDim2.new((i - 1) * 0.2, 0, 0, 0)
            button.Text = category
            button.TextColor3 = Color3.new(1, 1, 1)
            button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            button.Parent = buttonsFrame

            button.MouseButton1Click:Connect(function()
                updateItems(category)
            end)
        end
    end

    local function updateItems(selectedCategory)
        local drops = replicatedStorage:FindFirstChild("Drops")
        
        if drops then
            local items = drops:GetChildren()
            
            -- Очистка старых предметов
            for _, child in pairs(scrollingFrame:GetChildren()) do
                if child:IsA("TextLabel") or child:IsA("TextButton") then
                    child:Destroy()
                end
            end
            
            local columns = 3
            local spacing = 10
            local itemWidth = (scrollingFrame.AbsoluteSize.X - spacing * (columns - 1)) / columns
            local itemHeight = 50
            local row = 0
            local col = 0

            for i, item in ipairs(items) do
                -- Фильтр по категориям
                local itemCategory = item:GetAttribute("Category") -- допустим, у предмета есть атрибут "Category"
                if selectedCategory == "Все" or itemCategory == selectedCategory or (selectedCategory == "OG Косметика" and table.find(ogCosmeticItems, item.Name)) then
                    local itemDisplay = Instance.new("TextLabel")
                    itemDisplay.Size = UDim2.new(0, itemWidth, 0, itemHeight)
                    itemDisplay.Position = UDim2.new(0, col * (itemWidth + spacing), 0, row * (itemHeight * 2 + spacing))
                    itemDisplay.Text = item.Name
                    itemDisplay.TextColor3 = Color3.new(1, 1, 1)
                    itemDisplay.BackgroundTransparency = 1

                    -- Проверяем цвет для маунтов
                    for color, mountNames in pairs(MountsColor) do
                        if table.find(mountNames, item.Name) then
                            itemDisplay.BackgroundColor3 = color == "Orange" and Color3.new(1, 0.5, 0) or Color3.new(0.5, 0, 1)
                        end
                    end

                    -- Проверяем OG косметику
                    if table.find(ogCosmeticItems, item.Name) then
                        itemDisplay.BackgroundColor3 = ogCosmeticColor
                    end

                    itemDisplay.Parent = scrollingFrame

                    local buyButton = Instance.new("TextButton")
                    buyButton.Size = UDim2.new(0, itemWidth, 0, itemHeight)
                    buyButton.Position = UDim2.new(0, col * (itemWidth + spacing), 0, row * (itemHeight * 2 + spacing) + itemHeight + spacing)
                    buyButton.Text = "Купить"
                    buyButton.TextColor3 = Color3.new(1, 1, 1)
                    buyButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
                    buyButton.Parent = scrollingFrame

                    buyButton.MouseButton1Click:Connect(function()
                        local player = players.LocalPlayer
                        local character = player.Character or player.CharacterAdded:Wait()
                    
                        -- Находим объект в Workspace
                        local dropItem = workspaceDrops:FindFirstChild(item.Name)
                        if dropItem then
                            -- Сохраняем исходные позиции всех частей предмета
                            local originalPositions = {}
                            for _, part in pairs(dropItem:GetChildren()) do
                                if part:IsA("MeshPart") or part:IsA("Part") then
                                    originalPositions[part] = part.CFrame
                                end
                            end
                    
                            -- Телепортируем все MeshPart и Part объекты к персонажу
                            for part, originalPosition in pairs(originalPositions) do
                                part.CFrame = character:GetPrimaryPartCFrame() * CFrame.new(0, 0, 2) -- Позиционируем перед персонажем (можно изменить смещение)
                            end
                            wait(0.1)

                            -- После телепортации отправляем нажатие клавиши "E"
                            local VirtualInputManager = game:GetService('VirtualInputManager')
                            VirtualInputManager:SendKeyEvent(true, "E", false, game)
                            wait(0.1)
                    
                            -- Возвращаем все части предмета в их исходные позиции
                            for part, originalPosition in pairs(originalPositions) do
                                part.CFrame = originalPosition
                            end
                        end
                    end)
                    
                    

                    col = col + 1
                    if col >= columns then
                        col = 0
                        row = row + 1
                    end
                end
            end

            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, (row + 1) * (itemHeight * 2 + spacing))
        else
            warn("Drops не найдены в ReplicatedStorage")
        end
    end

    createCategoryButtons()
    updateItems("Все") -- Отображаем все предметы по умолчанию

    -- Подписываемся на изменения в Drops
    replicatedStorage.Drops.ChildAdded:Connect(function()
        updateItems("Все")
    end)
    replicatedStorage.Drops.ChildRemoved:Connect(function()
        updateItems("Все")
    end)
else
    warn("itemsSection категория не найдена в content")
end





----------------------------------------------------------

---------------------Деньги над головой-------------------
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Создаем кнопку для основного скрипта
local mainScriptButton = Instance.new("TextButton")
mainScriptButton.Size = UDim2.new(1, 0, 0, 50)
mainScriptButton.Position = UDim2.new(0, 0, 0, 50)
mainScriptButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainScriptButton.Text = "Загрузить срипт показа Денег"
mainScriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mainScriptButton.Font = Enum.Font.SourceSans
mainScriptButton.TextSize = 18
mainScriptButton.BorderSizePixel = 0
mainScriptButton.ZIndex = 2
mainScriptButton.Parent = mainCategorySection

-- Переменная для отслеживания состояния скрипта
local scriptEnabled = false

-- Функция для форматирования числа с разделителями для тысяч
local function formatNumber(number)
    local formatted = tostring(number)
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then
            break
        end
    end
    return formatted
end

-- Функция для создания и обновления информации над головой игрока
local function createInfoTag(player)
    -- Создание BillboardGui
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.Adornee = player.Character:WaitForChild("Head")
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = player.Character:WaitForChild("Head")

    -- Текстовое поле для Vel
    local velText = Instance.new("TextLabel")
    velText.Size = UDim2.new(1, 0, 0.5, 0)
    velText.TextColor3 = Color3.new(1, 0.843, 0) -- Золотой цвет
    velText.BackgroundTransparency = 1
    velText.Font = Enum.Font.SourceSansBold
    velText.TextScaled = false
    velText.TextSize = 14 -- Фиксированный размер текста
    velText.Parent = billboardGui

    -- Текстовое поле для Gems
    local gemsText = Instance.new("TextLabel")
    gemsText.Size = UDim2.new(1, 0, 0.5, 0)
    gemsText.Position = UDim2.new(0, 0, 0.5, 0)
    gemsText.TextColor3 = Color3.new(0, 0, 1) -- Синий цвет
    gemsText.BackgroundTransparency = 1
    gemsText.Font = Enum.Font.SourceSansBold
    gemsText.TextScaled = false
    gemsText.TextSize = 14 -- Фиксированный размер текста
    gemsText.Parent = billboardGui

    -- Функция для обновления текста
    local function updateText()
        local profile = ReplicatedStorage:FindFirstChild("Profiles"):FindFirstChild(player.Name)
        if profile then
            local velValue = profile:FindFirstChild("Vel")
            local gemsValue = profile:FindFirstChild("Gems")

            if velValue and gemsValue then
                velText.Text = "Vel: " .. formatNumber(velValue.Value)
                gemsText.Text = "Gems: " .. formatNumber(gemsValue.Value)
            end
        end
    end

    -- Подписка на изменения значений
    local profile = ReplicatedStorage:FindFirstChild("Profiles"):FindFirstChild(player.Name)
    if profile then
        local velValue = profile:FindFirstChild("Vel")
        local gemsValue = profile:FindFirstChild("Gems")

        if velValue then
            velValue:GetPropertyChangedSignal("Value"):Connect(updateText)
        end

        if gemsValue then
            gemsValue:GetPropertyChangedSignal("Value"):Connect(updateText)
        end
    end

    -- Первоначальное обновление текста
    updateText()
end

-- Функция для включения скрипта
local function enableScript()
    -- Подписка на событие появления игрока
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            -- Ожидание загрузки головы игрока
            character:WaitForChild("Head")
            createInfoTag(player)
        end)
    end)

    -- Добавление тегов для уже присутствующих игроков
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Head") then
            createInfoTag(player)
        end
    end
end

-- Функция для отключения скрипта
local function disableScript()
    -- Отключение всех созданных BillboardGui
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            for _, child in pairs(head:GetChildren()) do
                if child:IsA("BillboardGui") then
                    child:Destroy()
                end
            end
        end
    end
end

-- Обработчик нажатия на кнопку
mainScriptButton.MouseButton1Click:Connect(function()
    scriptEnabled = not scriptEnabled
    if scriptEnabled then
        mainScriptButton.Text = "Скрыть деньги над головой"
        enableScript()
    else
        mainScriptButton.Text = "Отобразить деньги над головой"
        disableScript()
    end
end)

---------------------------------------------------------

---------------------АвтоТрейд---------------------------

-- Создание постоянной надписи
local AutoTradeLabel = Instance.new("TextLabel")
AutoTradeLabel.Size = UDim2.new(0.5, 0, 0, 50)
AutoTradeLabel.Position = UDim2.new(0, 0, 0, 150)
AutoTradeLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
AutoTradeLabel.Text = "Авто трейд с игроком:"
AutoTradeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoTradeLabel.Font = Enum.Font.SourceSans
AutoTradeLabel.TextSize = 18
AutoTradeLabel.BorderSizePixel = 0
AutoTradeLabel.ZIndex = 2
AutoTradeLabel.Parent = mainCategorySection

-- Создание TextBox для ввода имени игрока
local PlayerNameInput = Instance.new("TextBox")
PlayerNameInput.Size = UDim2.new(0.5, 0, 0, 50)
PlayerNameInput.Position = UDim2.new(0.5, 0, 0, 150)
PlayerNameInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PlayerNameInput.PlaceholderText = "Введите имя игрока"
PlayerNameInput.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
PlayerNameInput.Text = ""
PlayerNameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerNameInput.Font = Enum.Font.SourceSans
PlayerNameInput.TextSize = 18
PlayerNameInput.BorderSizePixel = 0
PlayerNameInput.ZIndex = 2
PlayerNameInput.Parent = mainCategorySection

-- Создание кнопки TradeScriptButton
local TradeScriptButton = Instance.new("TextButton")
TradeScriptButton.Size = UDim2.new(1, 0, 0, 50)
TradeScriptButton.Position = UDim2.new(0, 0, 0, 200)
TradeScriptButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TradeScriptButton.Text = "АвтоТрейд"
TradeScriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TradeScriptButton.Font = Enum.Font.SourceSans
TradeScriptButton.TextSize = 18
TradeScriptButton.BorderSizePixel = 0
TradeScriptButton.ZIndex = 2
TradeScriptButton.Parent = mainCategorySection

-- Объединенная функция для отправки запроса на трейд, ожидания и добавления предметов
local function handleTrade()
    local playerName = PlayerNameInput.Text
    if playerName == "" then
        playerName = savedPlayerName
    end

    local player = game:GetService("Players"):FindFirstChild(playerName)
    if not player then
        warn("Игрок с именем " .. playerName .. " не найден")
        return
    end

    local args = {
        [1] = player
    }
    game:GetService("ReplicatedStorage").Systems.Trading.TradeRequest:FireServer(unpack(args))

    local trades = replicatedStorage:WaitForChild("Trades")
    local trade = trades:WaitForChild(playerName)

    -- Ждем, пока OtherPlayer.Value станет равным нашему имени
    local function waitForOtherPlayer()
        repeat
            wait(1)
        until trade.OtherPlayer.Value == game.Players.LocalPlayer.Name
        
        -- Добавление фиксированных предметов
        local currentPlayerName = game.Players.LocalPlayer.Name

        local function addItem(itemName, amount)
            local item = replicatedStorage.Profiles[currentPlayerName].Inventory:FindFirstChild(itemName)
            if item then
                local itemArgs = {
                    [1] = item,
                    [2] = amount
                }
                game:GetService("ReplicatedStorage").Systems.Trading.AddItem:FireServer(unpack(itemArgs))
            else
                warn("Предмет " .. itemName .. " не найден в инвентаре " .. currentPlayerName)
            end
        end

        addItem("UpgradeCrystalLegendary", 50)
        addItem("UpgradeCrystalEpic", 40)
        addItem("EnchantingStone", 10)
        addItem("RoyalGuardian", 1)

        -- Функция добавления предметов с аурой
        local function findAndAddAuras()
            local playerInventory = replicatedStorage.Profiles[currentPlayerName].Inventory
            local itemname = "Aura"
            
            for i, v in next, playerInventory:GetChildren() do
                if v.Name:find(itemname) then
                    local args = {
                        [1] = v,
                        [2] = 1
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Systems"):WaitForChild("Trading"):WaitForChild("AddItem"):FireServer(unpack(args))
                end
            end
        end

        -- Вызов функции добавления предметов с аурой
        findAndAddAuras()
        -- Блокировка трейда
        local lockArgs = {
  
            [1] = true
        }
        game:GetService("ReplicatedStorage").Systems.Trading.LockTrade:FireServer(unpack(lockArgs))

        -- Ждем, пока Lock.Value другого игрока станет равным true
        local function waitForOtherPlayerLock()
            local otherPlayerLock = trade:WaitForChild("Lock")
            repeat
                wait(2)
            until otherPlayerLock.Value == true
            
            -- Готовность трейда
            local readyArgs = {
                [1] = true
            }
            game:GetService("ReplicatedStorage").Systems.Trading.ReadyTrade:FireServer(unpack(readyArgs))
        end

        waitForOtherPlayerLock()
    end

    waitForOtherPlayer()
end

-- Подключение функции к кнопке
TradeScriptButton.MouseButton1Click:Connect(handleTrade)


---------------------------------------------------------

---------------------Настройки---------------------------
-- Создаем контейнер для всех элементов
local SettingCategorySevtion = content:FindFirstChild("Settings")

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, 0, 0, 50)
Container.Position = UDim2.new(0, 0, 0, 0)
Container.BackgroundTransparency = 1
Container.Parent = SettingCategorySevtion

-- Создаем текст слева
local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(0.4, 0, 1, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "Имя игрока по умолчанию:"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.TextSize = 18
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.Parent = Container

-- Создаем текстовое поле посередине
local PlayerNameInput = Instance.new("TextBox")
PlayerNameInput.Size = UDim2.new(0.4, 0, 1, 0)
PlayerNameInput.Position = UDim2.new(0.4, 0, 0, 0)
PlayerNameInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PlayerNameInput.Text = "AKNALOGIA11" -- начальное значение
PlayerNameInput.TextColor3 = Color3.fromRGB(211, 211, 211) -- светло-бледный цвет
PlayerNameInput.Font = Enum.Font.SourceSans
PlayerNameInput.TextSize = 18
PlayerNameInput.BorderSizePixel = 0
PlayerNameInput.Parent = Container

-- Создаем кнопку "Изменить" справа
local ChangeButton = Instance.new("TextButton")
ChangeButton.Size = UDim2.new(0.2, 0, 1, 0)
ChangeButton.Position = UDim2.new(0.8, 0, 0, 0)
ChangeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ChangeButton.Text = "Изменить"
ChangeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ChangeButton.Font = Enum.Font.SourceSans
ChangeButton.TextSize = 18
ChangeButton.BorderSizePixel = 0
ChangeButton.Parent = Container

-- Функция для сохранения имени игрока в локальную переменную
local function SavePlayerName(newName)
    savedPlayerName = newName
end

-- Функция для загрузки имени игрока в текстовое поле
local function LoadPlayerName()
    PlayerNameInput.Text = savedPlayerName
end

-- Привязываем функцию к кнопке
ChangeButton.MouseButton1Click:Connect(function()
    SavePlayerName(PlayerNameInput.Text)
end)

-- Загружаем сохраненное имя при старте
LoadPlayerName()
------------------АвтоТрейд----------------------
-- Создаем новый контейнер для переключателя
local AutoTradeContainer = Instance.new("Frame")
AutoTradeContainer.Size = UDim2.new(1, 0, 0, 50)
AutoTradeContainer.Position = UDim2.new(0, 0, 0, 60)
AutoTradeContainer.BackgroundTransparency = 1
AutoTradeContainer.Parent = SettingCategorySevtion

-- Создаем текст "Включить прием АвтоТрейд" слева
local AutoTradeLabel = Instance.new("TextLabel")
AutoTradeLabel.Size = UDim2.new(0.7, 0, 1, 0)
AutoTradeLabel.Position = UDim2.new(0, 0, 0, 0)
AutoTradeLabel.BackgroundTransparency = 1
AutoTradeLabel.Text = "Включить прием АвтоТрейд:"
AutoTradeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoTradeLabel.Font = Enum.Font.SourceSans
AutoTradeLabel.TextSize = 18
AutoTradeLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoTradeLabel.Parent = AutoTradeContainer

-- Создаем переключатель "Вкл/Выкл" справа
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.3, 0, 1, 0)
ToggleButton.Position = UDim2.new(0.7, 0, 0, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleButton.Text = "Выкл"
ToggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.TextSize = 18
ToggleButton.BorderSizePixel = 0
ToggleButton.Parent = AutoTradeContainer

-- Логика переключателя
local autoTradeEnabled = false
local tradeCoroutine -- Переменная для хранения корутины

-- Функция для автоматического принятия и обработки трейдов
local function autoAcceptAndProcessTrades()
    while autoTradeEnabled do
        wait(5) -- Ждать 5 секунду
        print("testTrade")

        local players = game:GetService("Players")
        local tradingSystem = game:GetService("ReplicatedStorage").Systems.Trading
        
        -- Принятие трейда от каждого игрока на сервере
        for _, player in pairs(players:GetPlayers()) do
            local args = { [1] = player }
            local success, err = pcall(function()
                tradingSystem.AcceptInvite:FireServer(unpack(args))
            end)

            if success then
                local tradeInstance = game:GetService("ReplicatedStorage").Trades:FindFirstChild(player.Name)
                if tradeInstance then
                    local lockValue = tradeInstance:FindFirstChild("Lock")
                    local readyValue = tradeInstance:FindFirstChild("Ready")
                    
                    -- Пытаемся заблокировать трейд
                    while lockValue and not lockValue.Value do
                        success, err = pcall(function()
                            tradingSystem.LockTrade:FireServer(true)
                        end)
                        wait(0.3)
                    end

                    -- Пытаемся подтвердить готовность трейда
                    while readyValue and not readyValue.Value do
                        success, err = pcall(function()
                            tradingSystem.ReadyTrade:FireServer(true)
                        end)
                        wait(0.3)
                    end
                end
            else
                warn("Ошибка при принятии трейда от игрока " .. player.Name .. ": " .. tostring(err))
            end
        end
    end
end

-- Обработчик нажатия на кнопку
ToggleButton.MouseButton1Click:Connect(function()
    autoTradeEnabled = not autoTradeEnabled
    if autoTradeEnabled then
        ToggleButton.Text = "Вкл"
        ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 0)
        -- Запускаем корутину
        tradeCoroutine = coroutine.create(autoAcceptAndProcessTrades)
        coroutine.resume(tradeCoroutine)
    else
        ToggleButton.Text = "Выкл"
        ToggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
        -- Останавливаем корутину
        if tradeCoroutine and coroutine.status(tradeCoroutine) == "suspended" then
            coroutine.close(tradeCoroutine)
        end
    end
end)

-- Создаем интерфейс для загрузки дополнительного списка
local WebhookContainer = Instance.new("Frame")
WebhookContainer.Size = UDim2.new(1, 0, 0, 50)
WebhookContainer.Position = UDim2.new(0, 0, 0, 110)
WebhookContainer.BackgroundTransparency = 1
WebhookContainer.Parent = SettingCategorySevtion

-- Создаем текст "Webhook Player Name" слева
local WebhookLabel = Instance.new("TextLabel")
WebhookLabel.Size = UDim2.new(0.3, 0, 1, 0)
WebhookLabel.Position = UDim2.new(0, 0, 0, 0)
WebhookLabel.BackgroundTransparency = 1
WebhookLabel.Text = "Webhook Player Name:"
WebhookLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WebhookLabel.Font = Enum.Font.SourceSans
WebhookLabel.TextSize = 18
WebhookLabel.TextXAlignment = Enum.TextXAlignment.Left
WebhookLabel.Parent = WebhookContainer

-- Создаем поле для ввода URL
local UrlInput = Instance.new("TextBox")
UrlInput.Size = UDim2.new(0.5, 0, 1, 0)
UrlInput.Position = UDim2.new(0.3, 0, 0, 0)
UrlInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
UrlInput.TextColor3 = Color3.fromRGB(255, 255, 255)
UrlInput.Font = Enum.Font.SourceSans
UrlInput.TextSize = 18
UrlInput.PlaceholderText = "Введите URL"
UrlInput.Parent = WebhookContainer

-- Создаем кнопку "Загрузить"
local LoadButton = Instance.new("TextButton")
LoadButton.Size = UDim2.new(0.2, 0, 1, 0)
LoadButton.Position = UDim2.new(0.8, 0, 0, 0)
LoadButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
LoadButton.Text = "Загрузить"
LoadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadButton.Font = Enum.Font.SourceSans
LoadButton.TextSize = 18
LoadButton.BorderSizePixel = 0
LoadButton.Parent = WebhookContainer

-- Переменная для хранения списка
local TrueNick = {}

-- Функция для загрузки списка из URL
local function loadListFromUrl(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success then
        TrueNick = result
    else
        warn("Ошибка загрузки списка: " .. tostring(result))
    end
end

-- Логика кнопки "Загрузить"
LoadButton.MouseButton1Click:Connect(function()
    local url = UrlInput.Text
    if url and url ~= "" then
        loadListFromUrl(url)
        print("Список загружен:", TrueNick)
    else
        warn("URL не указан или пуст")
    end
end)


---------------------------------------------------------

--------- Контейнер для списка профилей игроков----------
-- Создание и настройка профиля списка
local profileList = Instance.new("ScrollingFrame")
profileList.Name = "ProfileList"
profileList.Size = UDim2.new(1, 0, 1, -50)
profileList.Position = UDim2.new(0, 0, 0, 50)
profileList.CanvasSize = UDim2.new(0, 0, 0, 0)  -- CanvasSize обновляется динамически
profileList.ScrollBarThickness = 8
profileList.BackgroundTransparency = 1
profileList.Parent = content:FindFirstChild("PlayerProfile")

-- Флаг для управления обновлением
local isUpdating = true

-- Кнопка для остановки/возобновления обновления
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleUpdateButton"
toggleButton.Size = UDim2.new(0, 100, 0, 50)
toggleButton.Position = UDim2.new(1, -110, 0, 0)  -- Справа от списка
toggleButton.Text = "Stop Updates"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.BorderSizePixel = 0
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.Parent = content:FindFirstChild("PlayerProfile")

toggleButton.MouseButton1Click:Connect(function()
    isUpdating = not isUpdating
    toggleButton.Text = isUpdating and "Stop Updates" or "Start Updates"
end)

-- Форматирование чисел
local function formatNumber(num)
    local formatted = tostring(num)
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then
            break
        end
    end
    return formatted
end

-- Цвета аур
local auraColors = {
    Orange = {"InfernoAura", "GalaxyAura","CloudBurstAura", "LightningAura", "SynthwaveAura", "CursedAura", "ElectricAura", "PrismaticAura", }, 
    Purple = {"SeaBubblesAura", "PixelAura", "UnicornSwirlAura", "BurstAura", "ToxicAura", "StarstreamAura", "EnchantedAura", "SandstormAura", "SunrayAura", "DataStreamAura", "StardustAura", "CyberAura","BubbleAura", "NanoSwarmAura", "RainbowAura", "WhirlwindAura", "OasisAura", "ErrorAura"},
    LightBlue = {"FishyAura", "LeafAura", "PinkButterflyAura", "SparkleAura", "PoisonAura", "CactusAura", "FlowerAura", "BlueButterflyAura", "SnowAura", "EmberAura", "StarAura", "TreasureAura",}
}

local MountsPriority = {
    Orange = 1,
    Purple = 2,
    Default = 3
}

local function getAuraColor(name)
    for color, names in pairs(auraColors) do
        for _, auraName in ipairs(names) do
            if auraName == name then
                if color == "Orange" then
                    return Color3.fromRGB(255, 165, 0), 1
                elseif color == "Purple" then
                    return Color3.fromRGB(160, 32, 240), 2
                elseif color == "LightBlue" then
                    return Color3.fromRGB(173, 216, 230), 3
                end
            end
        end
    end
    return Color3.fromRGB(255, 255, 255), 4 -- Цвет по умолчанию и наименьший приоритет
end

-- Создание профиля игрока
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
    velLabel.Name = "VelLabel"
    velLabel.Text = "Vel: " .. formatNumber(vel)
    velLabel.Size = UDim2.new(0.3, 0, 1, 0)
    velLabel.Position = UDim2.new(0.4, 0, 0, 0)
    velLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    velLabel.BackgroundTransparency = 1
    velLabel.Font = Enum.Font.SourceSans
    velLabel.TextSize = 18
    velLabel.TextXAlignment = Enum.TextXAlignment.Left
    velLabel.TextYAlignment = Enum.TextYAlignment.Center
    velLabel.Parent = playerFrame

    local gemsLabel = Instance.new("TextLabel")
    gemsLabel.Name = "GemsLabel"
    gemsLabel.Text = "Gems: " .. formatNumber(gems)
    gemsLabel.Size = UDim2.new(0.3, 0, 1, 0)
    gemsLabel.Position = UDim2.new(0.7, 0, 0, 0)
    gemsLabel.TextColor3 = Color3.fromRGB(0, 0, 255)
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
    expandedFrame.Name = "ExpandedFrame"
    expandedFrame.Size = UDim2.new(1, 0, 0, 230)
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

    local function createFilterButton(name, position, parent)
        local button = Instance.new("TextButton")
        button.Name = name .. "Button"
        button.Size = UDim2.new(0.2, -10, 0, 30)
        button.Position = UDim2.new(position, 5, 0, 35)
        button.Text = name
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.BorderSizePixel = 0
        button.Font = Enum.Font.SourceSans
        button.TextSize = 18
        button.Parent = parent
        return button
    end

    local allButton = createFilterButton("All", 0, expandedFrame)
    local auraButton = createFilterButton("Aura", 0.2, expandedFrame)
    local mountButton = createFilterButton("Mount", 0.4, expandedFrame)
    local weaponArmorButton = createFilterButton("Weapon/Armor", 0.6, expandedFrame)
    local ogCosmeticButton = createFilterButton("OG Cosmetic", 0.8, expandedFrame)

    local inventoryScrollingFrame = Instance.new("ScrollingFrame")
    inventoryScrollingFrame.Size = UDim2.new(1, 0, 1, -70)
    inventoryScrollingFrame.Position = UDim2.new(0, 0, 0, 70)
    inventoryScrollingFrame.BackgroundTransparency = 1
    inventoryScrollingFrame.ScrollBarThickness = 8
    inventoryScrollingFrame.Parent = expandedFrame

    local itemsListFrame = Instance.new("Frame")
    itemsListFrame.Size = UDim2.new(1, 0, 1, 0)
    itemsListFrame.BackgroundTransparency = 1
    itemsListFrame.Parent = inventoryScrollingFrame

    local function updateInventoryItems(filter)
        local inventory = profile:WaitForChild("Inventory")
        local items = {}
    
        for _, item in pairs(inventory:GetChildren()) do
            local itemName = item.Name
            local itemCount = 1
    
            local countObject = item:FindFirstChild("Count")
            if countObject then
                itemCount = countObject.Value
            end
    
            if items[itemName] then
                items[itemName] = items[itemName] + itemCount
            else
                items[itemName] = itemCount
            end
        end
    
        local itemList = {}
        for name, count in pairs(items) do
            table.insert(itemList, {name = name, count = count})
        end
    
        -- Сортировка предметов
        table.sort(itemList, function(a, b)
            return a.name < b.name
        end)
    
        itemsListFrame:ClearAllChildren()
        local yOffset = 0
    
        for _, item in ipairs(itemList) do
            local displayItem = false
            local displayText = item.name .. " :" .. item.count
            local itemLabel = Instance.new("TextLabel")
            itemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    
            if filter == "All" then
                displayItem = true
            elseif filter == "Aura" and string.find(item.name, "Aura") then
                itemLabel.TextColor3, _ = getAuraColor(item.name)
                displayItem = true
            elseif filter == "Mount" and string.find(item.name, "Mount") then
                displayItem = true
                itemLabel.TextColor3 = getMountColor(item.name)
            elseif filter == "Weapon/Armor" then
                local enchantObject = item:FindFirstChild("Enchant")
                local legendEnchantObject = item:FindFirstChild("LegendEnchant")
                local upgradeObject = item:FindFirstChild("Upgrade")
    
                -- Проверка и обновление текста, если объекты существуют
                if upgradeObject then
                    displayText = displayText .. " +" .. upgradeObject.Value
                    if upgradeObject.Value == 10 then
                        local upgradeLabel = Instance.new("TextLabel")
                        upgradeLabel.Text = "+" .. upgradeObject.Value
                        upgradeLabel.TextColor3 = Color3.fromRGB(224, 50, 50) -- Светло-красный для upgradeObject = 10
                        upgradeLabel.Parent = itemLabel
                    end
                end
    
                -- Проверка Enchant и LegendEnchant
                if enchantObject and enchantObject.Value >= 1 and enchantObject.Value <= 9 then
                    displayItem = true
                    local enchantValue = enchantObject.Value
                    displayText = displayText .. " " .. (enchantValue == 1 and "MVP" or (enchantValue == 2 and "ATK" or (enchantValue == 3 and "HPR" or (enchantValue == 4 and "MHP" or (enchantValue == 5 and "CRI" or (enchantValue == 6 and "SPR" or (enchantValue == 7 and "CRD" or (enchantValue == 8 and "BUR" or "STA"))))))))
                end
    
                if legendEnchantObject and legendEnchantObject.Value >= 1 and legendEnchantObject.Value <= 9 then
                    itemLabel.TextColor3 = Color3.fromRGB(255, 140, 0) -- Оранжевый для предметов с LegendEnchant
                    displayItem = true
                    local legendEnchantValue = legendEnchantObject.Value
                    displayText = displayText .. "/" .. (legendEnchantValue == 1 and "MVP" or (legendEnchantValue == 2 and "ATK" or (legendEnchantValue == 3 and "HPR" or (legendEnchantValue == 4 and "MHP" or (legendEnchantValue == 5 and "CRI" or (legendEnchantValue == 6 and "SPR" or (legendEnchantValue == 7 and "CRDI" or (legendEnchantValue == 8 and "BUR" or "STA"))))))))
                end
    
                -- Установка цвета для специфичных меток
                local colorMapping = {
                    ATK = Color3.fromRGB(255, 165, 0), -- Оранжевый
                    SPR = Color3.fromRGB(0, 0, 255), -- Голубой
                    CRI = Color3.fromRGB(255, 0, 0), -- Красный
                    CRD = Color3.fromRGB(255, 0, 0), -- Красный
                    MHP = Color3.fromRGB(0, 128, 0), -- Зеленый
                    HPR = Color3.fromRGB(144, 238, 144), -- Светло-зеленый
                    BUR = Color3.fromRGB(255, 140, 0), -- Темно-оранжевый
                    STA = Color3.fromRGB(0, 0, 128), -- Синий
                    SPD = Color3.fromRGB(173, 216, 230) -- Бледно-голубой
                }
    
                for key, color in pairs(colorMapping) do
                    if string.find(displayText, key) then
                        local label = Instance.new("TextLabel")
                        label.Text = key
                        label.TextColor3 = color
                        label.Parent = itemLabel
                    end
                end
            elseif filter == "OG Cosmetic" and table.find(ogCosmeticItems, item.name) then
                itemLabel.TextColor3 = Color3.fromRGB(255, 0, 255) -- Розовый цвет для OG Cosmetic
                displayItem = true
            end
    
            -- Если предмет соответствует условиям, выводим его
            if displayItem then
                itemLabel.Text = displayText
                itemLabel.Size = UDim2.new(1, -10, 0, 30)
                itemLabel.Position = UDim2.new(0, 5, 0, yOffset)
                itemLabel.BackgroundTransparency = 1
                itemLabel.Font = Enum.Font.SourceSans
                itemLabel.TextSize = 16
                itemLabel.TextXAlignment = Enum.TextXAlignment.Left
                itemLabel.TextYAlignment = Enum.TextYAlignment.Top
                itemLabel.Parent = itemsListFrame
                yOffset = yOffset + 30
                print(displayText)
            end
        end
    
        itemsListFrame.Size = UDim2.new(1, 0, 0, yOffset)
        inventoryScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
    end
    

    allButton.MouseButton1Click:Connect(function() updateInventoryItems("All") end)
    auraButton.MouseButton1Click:Connect(function() updateInventoryItems("Aura") end)
    mountButton.MouseButton1Click:Connect(function() updateInventoryItems("Mount") end)
    weaponArmorButton.MouseButton1Click:Connect(function() updateInventoryItems("Weapon/Armor") end)
    ogCosmeticButton.MouseButton1Click:Connect(function() updateInventoryItems("OG Cosmetic") end)

    expandButton.MouseButton1Click:Connect(function()
        expandedFrame.Visible = not expandedFrame.Visible
        expandButton.Text = expandedFrame.Visible and "-" or "+"
        if expandedFrame.Visible then
            updateInventoryItems("All")
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

-- Функция обновления профилей игроков
local function updatePlayerProfiles()
    if not isUpdating then
        return
    end
    
    local players = game:GetService("Players"):GetPlayers()
    local playerProfiles = {}
    local expandedPlayers = {}

    for _, frame in ipairs(profileList:GetChildren()) do
        if frame:IsA("Frame") then
            local expandedFrame = frame:FindFirstChild("ExpandedFrame")
            if expandedFrame and expandedFrame.Visible then
                table.insert(expandedPlayers, frame.Name)
            end
        end
    end

    profileList:ClearAllChildren()

    for _, player in ipairs(players) do
        local profile = replicatedStorage:WaitForChild("Profiles"):WaitForChild(player.Name)
        table.insert(playerProfiles, {
            name = player.Name,
            vel = profile:WaitForChild("Vel").Value,
            gems = profile:WaitForChild("Gems").Value
        })
    end

    table.sort(playerProfiles, function(a, b) return a.vel > b.vel end)

    profileList.CanvasSize = UDim2.new(0, 0, 0, #players * 55)

    for i, profile in ipairs(playerProfiles) do
        local playerName = profile.name
        createPlayerProfile(playerName, i - 1)
    end

    for _, playerName in ipairs(expandedPlayers) do
        local playerFrame = profileList:FindFirstChild(playerName)
        if playerFrame then
            local expandButton = playerFrame:FindFirstChild("ExpandButton")
            if expandButton then
                expandButton:MouseButton1Click()
            end
        end
    end
end

updatePlayerProfiles()

replicatedStorage.Profiles.ChildAdded:Connect(updatePlayerProfiles)
replicatedStorage.Profiles.ChildRemoved:Connect(updatePlayerProfiles)

for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
    local profile = replicatedStorage:WaitForChild("Profiles"):WaitForChild(player.Name)
    profile.Vel.Changed:Connect(updatePlayerProfiles)
    profile.Gems.Changed:Connect(updatePlayerProfiles)
end

game:GetService("Players").PlayerAdded:Connect(updatePlayerProfiles)
game:GetService("Players").PlayerRemoving:Connect(updatePlayerProfiles)
    
---------------------------------------------------------


--------------- Контейнер для списка трейдов-------------

local profileList = Instance.new("ScrollingFrame")
profileList.Name = "Trades"
profileList.Size = UDim2.new(1, 0, 1, -50)
profileList.Position = UDim2.new(0, 0, 0, 50)
profileList.CanvasSize = UDim2.new(0, 0, 0, 0)  -- CanvasSize обновляется динамически
profileList.ScrollBarThickness = 8
profileList.BackgroundTransparency = 1
profileList.Parent = content:FindFirstChild("Trades")

local tradesFolder = game:GetService("ReplicatedStorage").Trades
local itemHeight = 120  -- Высота карточки для размещения предметов и информации
local yPosition = 0

local function createTradeCard(trade)
    local tradeFrame = Instance.new("Frame")
    tradeFrame.Name = trade.Name
    tradeFrame.Size = UDim2.new(1, 0, 0, itemHeight)
    tradeFrame.Position = UDim2.new(0, 0, 0, yPosition)
    tradeFrame.BackgroundTransparency = 0.3
    tradeFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    tradeFrame.BorderSizePixel = 0
    tradeFrame.Parent = profileList

    -- Имя игрока
    local playerNameLabel = Instance.new("TextLabel")
    playerNameLabel.Size = UDim2.new(0.4, 0, 0.3, 0)
    playerNameLabel.Position = UDim2.new(0, 10, 0, 0)
    playerNameLabel.BackgroundTransparency = 1
    playerNameLabel.Text = trade.Name
    playerNameLabel.TextColor3 = Color3.new(1, 1, 1)
    playerNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    playerNameLabel.Font = Enum.Font.SourceSansBold
    playerNameLabel.TextSize = 18
    playerNameLabel.Parent = tradeFrame

    -- Значение Vel
    local velLabel = Instance.new("TextLabel")
    velLabel.Size = UDim2.new(0.3, -10, 0.3, 0)
    velLabel.Position = UDim2.new(0.4, 0, 0, 0)
    velLabel.BackgroundTransparency = 1
    velLabel.Text = "-"
    velLabel.TextColor3 = Color3.new(1, 1, 0)
    velLabel.TextXAlignment = Enum.TextXAlignment.Right
    velLabel.Font = Enum.Font.SourceSans
    velLabel.TextSize = 18
    velLabel.Parent = tradeFrame

    -- Имя другого игрока (OtherPlayer)
    local otherPlayerLabel = Instance.new("TextLabel")
    otherPlayerLabel.Size = UDim2.new(0.3, -10, 0.3, 0)
    otherPlayerLabel.Position = UDim2.new(0.7, 0, 0, 0)
    otherPlayerLabel.BackgroundTransparency = 1
    otherPlayerLabel.Text = "-"
    otherPlayerLabel.TextColor3 = Color3.new(0.7, 0.7, 1)
    otherPlayerLabel.TextXAlignment = Enum.TextXAlignment.Right
    otherPlayerLabel.Font = Enum.Font.SourceSans
    otherPlayerLabel.TextSize = 18
    otherPlayerLabel.Parent = tradeFrame

    -- Отображение предметов
    local itemsFrame = Instance.new("Frame")
    itemsFrame.Size = UDim2.new(1, -20, 0.7, -10)
    itemsFrame.Position = UDim2.new(0, 10, 0.3, 10)
    itemsFrame.BackgroundTransparency = 1
    itemsFrame.Parent = tradeFrame

    local function updateItems()
        itemsFrame:ClearAllChildren()
    
        -- Определяем позиции для каждой колонки
        local positions = {
            UDim2.new(0, 0, 0, 0),    -- Левая колонка
            UDim2.new(0.33, 0, 0, 0), -- Центральная колонка
            UDim2.new(0.66, 0, 0, 0)  -- Правая колонка
        }
    
        -- Проходим по предметам и размещаем их в нужной колонке
        for i = 1, 10 do
            local itemName = "Item" .. i
            local item = trade:FindFirstChild(itemName)
            if item then
                local itemLabel = Instance.new("TextLabel")
                itemLabel.Size = UDim2.new(0.33, 0, 0, 20)
                itemLabel.Position = positions[math.ceil(i / 4)]
                itemLabel.BackgroundTransparency = 1
                itemLabel.TextXAlignment = Enum.TextXAlignment.Left
                itemLabel.Font = Enum.Font.SourceSans
                itemLabel.TextSize = 16
                itemLabel.TextColor3 = Color3.new(1, 1, 1)
    
                -- Получаем значение и количество предмета
                local itemValue = item:FindFirstChild("Value") and item.Value.Value or "-"
                local itemCount = item:FindFirstChild("Count") and item.Count.Value or 1
                itemLabel.Text = tostring(itemValue) .. ":" .. tostring(itemCount)
    
                -- Размещение в нужной строке и колонке
                itemLabel.Position = UDim2.new(itemLabel.Position.X.Scale, itemLabel.Position.X.Offset, 0, ((i - 1) % 4) * 20)
                itemLabel.Parent = itemsFrame

                -- Обработчики для обновления значений предметов
                if item:FindFirstChild("Value") then
                    item.Value:GetPropertyChangedSignal("Value"):Connect(function()
                        itemLabel.Text = tostring(item.Value.Value) .. ":" .. tostring(itemCount)
                    end)
                end
                if item:FindFirstChild("Count") then
                    item.Count:GetPropertyChangedSignal("Value"):Connect(function()
                        itemLabel.Text = tostring(itemValue) .. ":" .. tostring(item.Count.Value)
                    end)
                end
            end
        end
    end

    -- Ожидание появления Vel и OtherPlayer и обновление значений
    local function updateVelAndOtherPlayer()
        -- Проверка на существование и изменение Vel
        if trade:FindFirstChild("Vel") then
            velLabel.Text = tostring(trade.Vel.Value)
            trade.Vel:GetPropertyChangedSignal("Value"):Connect(function()
                velLabel.Text = tostring(trade.Vel.Value)
            end)
        else
            velLabel.Text = "-"  -- если Vel отсутствует
        end
        
        -- Проверка на существование и изменение OtherPlayer
        if trade:FindFirstChild("OtherPlayer") then
            otherPlayerLabel.Text = tostring(trade.OtherPlayer.Value)
            trade.OtherPlayer:GetPropertyChangedSignal("Value"):Connect(function()
                otherPlayerLabel.Text = tostring(trade.OtherPlayer.Value)
            end)
        else
            otherPlayerLabel.Text = "-"  -- если OtherPlayer отсутствует
        end
    end

    -- Если значения Vel и OtherPlayer существуют, сразу обновляем их, иначе ждем появления
    if trade:FindFirstChild("Vel") and trade:FindFirstChild("OtherPlayer") then
        updateVelAndOtherPlayer()
    else
        trade.ChildAdded:Connect(function(child)
            if child.Name == "Vel" or child.Name == "OtherPlayer" then
                updateVelAndOtherPlayer()
            end
        end)
    end

    -- Динамическое обновление предметов
    updateItems()
    trade.ChildAdded:Connect(updateItems)
    trade.ChildRemoved:Connect(updateItems)

    return tradeFrame
end

local function refreshTradeList()
    -- Очистка списка перед обновлением
    profileList:ClearAllChildren()
    yPosition = 0

    local tradeItems = tradesFolder:GetChildren()
    for _, trade in pairs(tradeItems) do
        local tradeCard = createTradeCard(trade)
        tradeCard.Position = UDim2.new(0, 0, 0, yPosition)
        yPosition = yPosition + itemHeight
    end

    -- Обновляем CanvasSize в зависимости от количества элементов
    profileList.CanvasSize = UDim2.new(0, 0, 0, yPosition)
end

-- Первоначальное создание списка
refreshTradeList()

-- Динамическое обновление списка при изменении трейдов
tradesFolder.ChildAdded:Connect(function()
    refreshTradeList()
end)

tradesFolder.ChildRemoved:Connect(function()
    refreshTradeList()
end)

-- Основной цикл
local function update()
    local currentTime = tick()
    
    -- Обработка трейдов каждые 2 секунды
    if currentTime - lastTradeProcessTime >= tradeInterval then
      --  processTrade()
        lastTradeProcessTime = currentTime
    end
    
    -- Обновление данных каждые 15 секунд
    if currentTime - lastUpdateProfilesTime >= updateInterval then
      --  updatePlayerProfiles()
     --   updateTrades()
        lastUpdateProfilesTime = currentTime
    end
end
-- Используем Heartbeat для запуска функции обновления
RunService.Heartbeat:Connect(update)

--anti afk kick
local vu = cloneref(game:GetService("VirtualUser"))
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)