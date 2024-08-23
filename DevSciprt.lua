-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local CyclesButton = Instance.new("TextButton")
local ScriptButton = Instance.new("TextButton")
local DEXButton = Instance.new("TextButton")
local CyclesFrame = Instance.new("Frame")
local AddLoopButton = Instance.new("TextButton")
local ScriptFrame = Instance.new("Frame")
local AddScriptButton = Instance.new("TextButton")
local DEXFrame = Instance.new("Frame")
local DEXScrollFrame = Instance.new("ScrollingFrame")
local DEXContent = Instance.new("TextLabel")

-- Настройка свойств объектов
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BackgroundTransparency = 0.3

TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.Active = true
TitleBar.Draggable = true -- Чтобы перетаскивать за заголовок

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TitleLabel.Size = UDim2.new(1, -90, 1, 0)
TitleLabel.Font = Enum.Font.SourceSans
TitleLabel.Text = "Roblox Executor"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
MinimizeButton.Font = Enum.Font.SourceSans
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18

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
CyclesButton.Size = UDim2.new(0.33, 0, 0, 30)
CyclesButton.Position = UDim2.new(0, 0, 0, 30)
CyclesButton.Font = Enum.Font.SourceSans
CyclesButton.Text = "Циклы"
CyclesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CyclesButton.TextSize = 18

ScriptButton.Name = "ScriptButton"
ScriptButton.Parent = MainFrame
ScriptButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ScriptButton.Size = UDim2.new(0.33, 0, 0, 30)
ScriptButton.Position = UDim2.new(0.33, 0, 0, 30)
ScriptButton.Font = Enum.Font.SourceSans
ScriptButton.Text = "Скрипт"
ScriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptButton.TextSize = 18

DEXButton.Name = "DEXButton"
DEXButton.Parent = MainFrame
DEXButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
DEXButton.Size = UDim2.new(0.33, 0, 0, 30)
DEXButton.Position = UDim2.new(0.66, 0, 0, 30)
DEXButton.Font = Enum.Font.SourceSans
DEXButton.Text = "DEX"
DEXButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DEXButton.TextSize = 18

CyclesFrame.Name = "CyclesFrame"
CyclesFrame.Parent = MainFrame
CyclesFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CyclesFrame.Size = UDim2.new(1, 0, 1, -60)
CyclesFrame.Position = UDim2.new(0, 0, 0, 60)
CyclesFrame.Visible = false

AddLoopButton.Name = "AddLoopButton"
AddLoopButton.Parent = CyclesFrame
AddLoopButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AddLoopButton.Size = UDim2.new(1, 0, 0, 30)
AddLoopButton.Position = UDim2.new(0, 0, 0, 0)
AddLoopButton.Font = Enum.Font.SourceSans
AddLoopButton.Text = "Добавить Цикл"
AddLoopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AddLoopButton.TextSize = 18

ScriptFrame.Name = "ScriptFrame"
ScriptFrame.Parent = MainFrame
ScriptFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ScriptFrame.Size = UDim2.new(1, 0, 1, -60)
ScriptFrame.Position = UDim2.new(0, 0, 0, 60)
ScriptFrame.Visible = true

AddScriptButton.Name = "AddScriptButton"
AddScriptButton.Parent = ScriptFrame
AddScriptButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AddScriptButton.Size = UDim2.new(1, 0, 0, 30)
AddScriptButton.Position = UDim2.new(0, 0, 0, 0)
AddScriptButton.Font = Enum.Font.SourceSans
AddScriptButton.Text = "Добавить Скрипт"
AddScriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AddScriptButton.TextSize = 18

DEXFrame.Name = "DEXFrame"
DEXFrame.Parent = MainFrame
DEXFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DEXFrame.Size = UDim2.new(1, 0, 1, -60)
DEXFrame.Position = UDim2.new(0, 0, 0, 60)
DEXFrame.Visible = false

DEXScrollFrame.Name = "DEXScrollFrame"
DEXScrollFrame.Parent = DEXFrame
DEXScrollFrame.Size = UDim2.new(1, 0, 1, 0)
DEXScrollFrame.CanvasSize = UDim2.new(0, 0, 5, 0)
DEXScrollFrame.ScrollBarThickness = 8

DEXContent.Name = "DEXContent"
DEXContent.Parent = DEXScrollFrame
DEXContent.Size = UDim2.new(1, 0, 0, 60)
DEXContent.TextColor3 = Color3.fromRGB(255, 255, 255)
DEXContent.TextSize = 18
DEXContent.TextWrapped = true
DEXContent.Text = ""

-- Логика кнопок
local loopRunning = false
local loops = {}

local function createLoop()
	local loopFrame = Instance.new("Frame")
	local loopInput = Instance.new("TextBox")
	local startLoopButton = Instance.new("TextButton")
	local stopLoopButton = Instance.new("TextButton")

	loopFrame.Parent = CyclesFrame
	loopFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	loopFrame.Size = UDim2.new(1, 0, 0, 60)

	loopInput.Parent = loopFrame
	loopInput.Size = UDim2.new(1, 0, 0.5, 0)
	loopInput.PlaceholderText = "Введите команду цикла..."
	loopInput.Text = ""
	loopInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	loopInput.TextSize = 18

	startLoopButton.Parent = loopFrame
	startLoopButton.Size = UDim2.new(0.5, 0, 0.5, 0)
	startLoopButton.Position = UDim2.new(0, 0, 0.5, 0)
	startLoopButton.Text = "Начать"
	startLoopButton.TextColor3 = Color3.fromRGB(255, 255, 255)

	stopLoopButton.Parent = loopFrame
	stopLoopButton.Size = UDim2.new(0.5, 0, 0.5, 0)
	stopLoopButton.Position = UDim2.new(0.5, 0, 0.5, 0)
	stopLoopButton.Text = "Остановить"
	stopLoopButton.TextColor3 = Color3.fromRGB(255, 255, 255)

	local loop = {
		frame = loopFrame,
		input = loopInput,
		startButton = startLoopButton,
		stopButton = stopLoopButton,
		running = false,
		speed = 1
	}

	table.insert(loops, loop)

	startLoopButton.MouseButton1Click:Connect(function()
		if not loop.running then
			loop.running = true
			loop.speed = tonumber(loopInput.Text) or 1
			while loop.running do
				-- Ваш цикл здесь
				wait(loop.speed)
			end
		end
	end)

	stopLoopButton.MouseButton1Click:Connect(function()
		loop.running = false
	end)
end

AddLoopButton.MouseButton1Click:Connect(createLoop)

local scripts = {}

local function createScript()
	local scriptFrame = Instance.new("Frame")
	local scriptInput = Instance.new("TextBox")
	local executeButton = Instance.new("TextButton")

	scriptFrame.Parent = ScriptFrame
	scriptFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	scriptFrame.Size = UDim2.new(1, 0, 0, 60)

	scriptInput.Parent = scriptFrame
	scriptInput.Size = UDim2.new(1, 0, 0.5, 0)
	scriptInput.PlaceholderText = "Введите скрипт..."
	scriptInput.Text = ""
	scriptInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	scriptInput.TextSize = 18

	executeButton.Parent = scriptFrame
	executeButton.Size = UDim2.new(1, 0, 0.5, 0)
	executeButton.Position = UDim2.new(0, 0, 0.5, 0)
	executeButton.Text = "Выполнить"
	executeButton.TextColor3 = Color3.fromRGB(255, 255, 255)

	table.insert(scripts, {frame = scriptFrame, input = scriptInput, button = executeButton})

	executeButton.MouseButton1Click:Connect(function()
		local scriptText = scriptInput.Text
		if scriptText ~= "" then
			-- Выполнение скрипта
			loadstring(scriptText)()
		end
	end)
end

AddScriptButton.MouseButton1Click:Connect(createScript)


-- Функция для отображения содержимого DEX с улучшенным отображением папок
local function displayDEXContents(parent, container, indent)
	indent = indent or 0
	local yPos = 0

	for _, item in pairs(parent:GetChildren()) do
		local isFolder = #item:GetChildren() > 0
		local itemButton = Instance.new("TextButton")
		itemButton.Parent = container
		itemButton.Size = UDim2.new(1, -10, 0, 30)
		itemButton.Position = UDim2.new(0, 5 * indent, 0, yPos)
		itemButton.BackgroundColor3 = isFolder and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(50, 50, 50)
		itemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		itemButton.TextSize = 18
		itemButton.Text = (isFolder and "[+]" or "") .. item.Name
		itemButton.TextXAlignment = Enum.TextXAlignment.Left
		
		yPos = yPos + 30

		if isFolder then
			local expanded = false
			local subContainer = Instance.new("Frame")
			subContainer.Parent = container
			subContainer.Size = UDim2.new(1, 0, 0, 0)
			subContainer.Position = UDim2.new(0, 0, 0, yPos)
			subContainer.BackgroundTransparency = 1

			itemButton.MouseButton1Click:Connect(function()
				expanded = not expanded
				itemButton.Text = (expanded and "[-]" or "[+]") .. item.Name

				if expanded then
					local subHeight = displayDEXContents(item, subContainer, indent + 1)
					subContainer.Size = UDim2.new(1, 0, 0, subHeight)
					yPos = yPos + subHeight
				else
					subContainer:ClearAllChildren()
					subContainer.Size = UDim2.new(1, 0, 0, 0)
					yPos = yPos - subContainer.Size.Y.Offset
				end

				container.CanvasSize = UDim2.new(0, 0, 0, yPos)
			end)
		else
			itemButton.MouseButton1Click:Connect(function()
				print("Открыт файл: " .. item.Name)
			end)
		end
	end

	container.CanvasSize = UDim2.new(0, 0, 0, yPos)
	return yPos
end


-- Добавление логики переключения между вкладками
CyclesButton.MouseButton1Click:Connect(function()
	CyclesFrame.Visible = true
	ScriptFrame.Visible = false
	DEXFrame.Visible = false
end)

ScriptButton.MouseButton1Click:Connect(function()
	CyclesFrame.Visible = false
	ScriptFrame.Visible = true
	DEXFrame.Visible = false
end)

DEXButton.MouseButton1Click:Connect(function()
	CyclesFrame.Visible = false
	ScriptFrame.Visible = false
	DEXFrame.Visible = true
	displayDEXContents(workspace, DEXScrollFrame) -- Показываем содержимое Workspace по умолчанию
end)

-- Закрытие GUI
CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Сворачивание GUI
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		MainFrame.Size = UDim2.new(0, 400, 0, 30)
	else
		MainFrame.Size = UDim2.new(0, 400, 0, 300)
	end
end)
