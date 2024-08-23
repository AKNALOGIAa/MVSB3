-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local CyclesButton = Instance.new("TextButton")
local ScriptButton = Instance.new("TextButton")
local CyclesFrame = Instance.new("Frame")
local StartLoopButton = Instance.new("TextButton")
local StopLoopButton = Instance.new("TextButton")
local SpeedSlider = Instance.new("TextBox")
local ScriptFrame = Instance.new("Frame")
local ScriptBox = Instance.new("TextBox")
local ExecuteButton = Instance.new("TextButton")

-- Настройка свойств объектов
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Active = true
MainFrame.Draggable = true

TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TitleBar.Size = UDim2.new(1, 0, 0, 30)

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TitleLabel.Size = UDim2.new(1, -30, 1, 0)
TitleLabel.Font = Enum.Font.SourceSans
TitleLabel.Text = "Roblox Executor"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18

CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18

CyclesButton.Name = "CyclesButton"
CyclesButton.Parent = MainFrame
CyclesButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CyclesButton.Size = UDim2.new(0.5, 0, 0, 30)
CyclesButton.Position = UDim2.new(0, 0, 0, 30)
CyclesButton.Font = Enum.Font.SourceSans
CyclesButton.Text = "Циклы"
CyclesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CyclesButton.TextSize = 18

ScriptButton.Name = "ScriptButton"
ScriptButton.Parent = MainFrame
ScriptButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ScriptButton.Size = UDim2.new(0.5, 0, 0, 30)
ScriptButton.Position = UDim2.new(0.5, 0, 0, 30)
ScriptButton.Font = Enum.Font.SourceSans
ScriptButton.Text = "Скрипт"
ScriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptButton.TextSize = 18

CyclesFrame.Name = "CyclesFrame"
CyclesFrame.Parent = MainFrame
CyclesFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CyclesFrame.Size = UDim2.new(1, 0, 1, -60)
CyclesFrame.Position = UDim2.new(0, 0, 0, 60)
CyclesFrame.Visible = false

StartLoopButton.Name = "StartLoopButton"
StartLoopButton.Parent = CyclesFrame
StartLoopButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
StartLoopButton.Size = UDim2.new(0.5, -5, 0, 30)
StartLoopButton.Position = UDim2.new(0, 0, 0, 0)
StartLoopButton.Font = Enum.Font.SourceSans
StartLoopButton.Text = "Начать Цикл"
StartLoopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartLoopButton.TextSize = 18

StopLoopButton.Name = "StopLoopButton"
StopLoopButton.Parent = CyclesFrame
StopLoopButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
StopLoopButton.Size = UDim2.new(0.5, -5, 0, 30)
StopLoopButton.Position = UDim2.new(0.5, 5, 0, 0)
StopLoopButton.Font = Enum.Font.SourceSans
StopLoopButton.Text = "Остановить Цикл"
StopLoopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopLoopButton.TextSize = 18

SpeedSlider.Name = "SpeedSlider"
SpeedSlider.Parent = CyclesFrame
SpeedSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedSlider.Size = UDim2.new(1, 0, 0, 30)
SpeedSlider.Position = UDim2.new(0, 0, 0, 40)
SpeedSlider.Font = Enum.Font.SourceSans
SpeedSlider.PlaceholderText = "Введите скорость (в секундах)"
SpeedSlider.Text = ""
SpeedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedSlider.TextSize = 18

ScriptFrame.Name = "ScriptFrame"
ScriptFrame.Parent = MainFrame
ScriptFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ScriptFrame.Size = UDim2.new(1, 0, 1, -60)
ScriptFrame.Position = UDim2.new(0, 0, 0, 60)
ScriptFrame.Visible = true

ScriptBox.Name = "ScriptBox"
ScriptBox.Parent = ScriptFrame
ScriptBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ScriptBox.Size = UDim2.new(1, 0, 0.8, 0)
ScriptBox.Font = Enum.Font.SourceSans
ScriptBox.PlaceholderText = "Введите ваш скрипт здесь..."
ScriptBox.Text = ""
ScriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptBox.TextSize = 18
ScriptBox.TextWrapped = true
ScriptBox.TextXAlignment = Enum.TextXAlignment.Left
ScriptBox.TextYAlignment = Enum.TextYAlignment.Top

ExecuteButton.Name = "ExecuteButton"
ExecuteButton.Parent = ScriptFrame
ExecuteButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ExecuteButton.Size = UDim2.new(1, 0, 0.2, -10)
ExecuteButton.Position = UDim2.new(0, 0, 0.8, 10)
ExecuteButton.Font = Enum.Font.SourceSans
ExecuteButton.Text = "Выполнить"
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextSize = 18

-- Логика кнопок
local loopRunning = false
local loopSpeed = 1 -- По умолчанию 1 секунда

StartLoopButton.MouseButton1Click:Connect(function()
    loopRunning = true
    local speed = tonumber(SpeedSlider.Text)
    if speed and speed > 0 then
        loopSpeed = speed
    end
    while loopRunning do
        -- Ваш цикл здесь
        wait(loopSpeed)
    end
end)

StopLoopButton.MouseButton1Click:Connect(function()
    loopRunning = false
end)

ExecuteButton.MouseButton1Click:Connect(function()
    local scriptText = ScriptBox.Text
    loadstring(scriptText)()
end)

CyclesButton.MouseButton1Click:Connect(function()
    CyclesFrame.Visible = true
    ScriptFrame.Visible = false
end)

ScriptButton.MouseButton1Click:Connect(function()
    CyclesFrame.Visible = false
    ScriptFrame.Visible = true
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
