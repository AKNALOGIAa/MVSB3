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
