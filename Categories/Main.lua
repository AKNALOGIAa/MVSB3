local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local function createMainSection(content)
    local mainSection = Instance.new("Frame")
    mainSection.Name = "Основные"
    mainSection.Size = UDim2.new(1, 0, 1, 0)
    mainSection.Position = UDim2.new(0, 0, 0, 0)
    mainSection.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    mainSection.Visible = false
    mainSection.BorderSizePixel = 0
    mainSection.Parent = content

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.Text = "Основные"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 24
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.Parent = mainSection

    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Text = "Отображать Vel и Gems над игроками"
    sliderLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
    sliderLabel.Position = UDim2.new(0.1, 0, 0.2, 0)
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Font = Enum.Font.SourceSans
    sliderLabel.TextSize = 18
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.TextYAlignment = Enum.TextYAlignment.Center
    sliderLabel.Parent = mainSection

    local slider = Instance.new("TextButton")
    slider.Text = "Off"
    slider.Size = UDim2.new(0.2, 0, 0.1, 0)
    slider.Position = UDim2.new(0.7, 0, 0.2, 0)
    slider.TextColor3 = Color3.fromRGB(255, 255, 255)
    slider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    slider.BorderSizePixel = 0
    slider.Font = Enum.Font.SourceSansBold
    slider.TextSize = 24
    slider.Parent = mainSection

    -- Логика ползунка
    local function updateDisplay()
        if slider.Text == "Off" then
            slider.Text = "On"
            -- Включить отображение над игроками
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer then
                    local character = player.Character
                    if character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            local velGemsLabel = head:FindFirstChild("VelGemsLabel")
                            if not velGemsLabel then
                                velGemsLabel = Instance.new("BillboardGui")
                                velGemsLabel.Name = "VelGemsLabel"
                                velGemsLabel.Size = UDim2.new(0, 100, 0, 50)
                                velGemsLabel.Adornee = head
                                velGemsLabel.AlwaysOnTop = true
                                velGemsLabel.Parent = head

                                local textLabel = Instance.new("TextLabel")
                                textLabel.Size = UDim2.new(1, 0, 1, 0)
                                textLabel.BackgroundTransparency = 1
                                textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                                textLabel.Font = Enum.Font.SourceSansBold
                                textLabel.TextSize = 14
                                textLabel.TextStrokeTransparency = 0
                                textLabel.Parent = velGemsLabel
                            end
                        end
                    end
                end
            end
        else
            slider.Text = "Off"
            -- Отключить отображение над игроками
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer then
                    local character = player.Character
                    if character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            local velGemsLabel = head:FindFirstChild("VelGemsLabel")
                            if velGemsLabel then
                                velGemsLabel:Destroy()
                            end
                        end
                    end
                end
            end
        end
    end

    slider.MouseButton1Click:Connect(updateDisplay)

    return mainSection
end

return createMainSection
