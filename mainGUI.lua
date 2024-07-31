local player = game:GetService("Players").LocalPlayer
local playerGui = player:FindFirstChildOfClass("PlayerGui")
local tweenService = game:GetService("TweenService")

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

-- Сворачивание/разворачивание окна
local isCollapsed = false
local toggleButton = Instance.new("TextButton", sidebar)
toggleButton.Text = ">"
toggleButton.Size = UDim2.new(0, 30, 0, 30)
toggleButton.Position = UDim2.new(1, -30, 0, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)

toggleButton.MouseButton1Click:Connect(function()
    isCollapsed = not isCollapsed
    if isCollapsed then
        toggleButton.Text = "<"
        tweenService:Create(sidebar, TweenInfo.new(0.5), {Size = UDim2.new(0.05, 0, 1, 0)}):Play()
        tweenService:Create(content, TweenInfo.new(0.5), {Position = UDim2.new(0.05, 0, 0, 0), Size = UDim2.new(0.95, 0, 1, 0)}):Play()
    else
        toggleButton.Text = ">"
        tweenService:Create(sidebar, TweenInfo.new(0.5), {Size = UDim2.new(0.2, 0, 1, 0)}):Play()
        tweenService:Create(content, TweenInfo.new(0.5), {Position = UDim2.new(0.2, 0, 0, 0), Size = UDim2.new(0.8, 0, 1, 0)}):Play()
    end
end)

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
        -- Анимация перехода
        for _, child in ipairs(content:GetChildren()) do
            if child.Name == sectionName then
                tweenService:Create(child, TweenInfo.new(0.5), {Position = UDim2.new(0, 0, 0, 0), Transparency = 0}):Play()
                child.Visible = true
            else
                tweenService:Create(child, TweenInfo.new(0.5), {Position = UDim2.new(1, 0, 0, 0), Transparency = 1}):Play()
                wait(0.5) -- Дождаться завершения анимации
                child.Visible = false
            end
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
    frame.Position = UDim2.new(1, 0, 0, 0) -- Начальное положение за экраном
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
        -- Добавляем слайдер для изменения прозрачности
        local transparencyLabel = Instance.new("TextLabel", frame)
        transparencyLabel.Size = UDim2.new(1, -20, 0, 50)
        transparencyLabel.Position = UDim2.new(0, 10, 0, 60)
        transparencyLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        transparencyLabel.Text = "Прозрачность:"
        transparencyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        transparencyLabel.TextSize = 18

        local transparencySlider = Instance.new("TextButton", frame)
        transparencySlider.Size = UDim2.new(1, -20, 0, 50)
        transparencySlider.Position = UDim2.new(0, 10, 0, 120)
        transparencySlider.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        transparencySlider.Text = "Сдвиньте для изменения"
        transparencySlider.TextColor3 = Color3.fromRGB(0, 0, 0)
        transparencySlider.TextSize = 18
        transparencySlider.MouseButton1Down:Connect(function()
            local mouseMoveConnection
            local mouseUpConnection

            mouseMoveConnection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    local newPos = math.clamp(input.Position.X - transparencySlider.AbsolutePosition.X, 0, transparencySlider.AbsoluteSize.X)
                    transparencySlider.Position = UDim2.new(0, newPos, 0, 120)
                    local transparency = newPos / transparencySlider.AbsoluteSize.X
                    frame.BackgroundTransparency = transparency
                    sidebar.BackgroundTransparency = transparency
                    toggleButton.BackgroundTransparency = transparency
                    transparencyLabel.BackgroundTransparency = transparency
                end
            end)

            mouseUpConnection = game:GetService("UserInputService").InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    mouseMoveConnection:Disconnect()
                    mouseUpConnection:Disconnect()
                end
            end)
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
tweenService:Create(content.Main, TweenInfo.new(0.5), {Position = UDim2.new(0, 0, 0, 0), Transparency = 0}):Play()
