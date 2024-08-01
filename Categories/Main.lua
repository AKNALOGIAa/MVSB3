local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
    velText.TextScaled = true
    velText.Parent = billboardGui

    -- Текстовое поле для Gems
    local gemsText = Instance.new("TextLabel")
    gemsText.Size = UDim2.new(1, 0, 0.5, 0)
    gemsText.Position = UDim2.new(0, 0, 0.5, 0)
    gemsText.TextColor3 = Color3.new(1, 1, 1) -- Белый цвет
    gemsText.BackgroundTransparency = 1
    gemsText.Font = Enum.Font.SourceSansBold
    gemsText.TextScaled = true
    gemsText.Parent = billboardGui

    -- Функция для обновления текста
    local function updateText()
        local profile = ReplicatedStorage.Profiles:FindFirstChild(player.Name)
        if profile then
            local velValue = profile:FindFirstChild("Vel")
            local gemsValue = profile:FindFirstChild("Gems")

            if velValue and gemsValue then
                velText.Text = "Vel: " .. velValue.Value
                gemsText.Text = "Gems: " .. formatNumber(gemsValue.Value)
            end
        end
    end

    -- Подписка на изменения значений
    local profile = ReplicatedStorage.Profiles:FindFirstChild(player.Name)
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
