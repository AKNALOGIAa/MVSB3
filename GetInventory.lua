local playerName = game.Players.LocalPlayer.Name
local inventoryPath = game:GetService("ReplicatedStorage").Profiles[playerName].Inventory:GetChildren()

local itemID = 1
local categorizedItems = {}

local HttpService = game:GetService("HttpService")
local filename = playerName .. "_inventory.txt"

if isfile("sb3AKNA//" .. filename) then
    delfile("sb3AKNA//" .. filename)
end

if not isfolder("sb3AKNA") then
    makefolder("sb3AKNA")
end

local function getSizeValue(size)
    local sizeMap = {50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100}
    return sizeMap[size] or 50
end

local function getSpeedValue(speed)
    local speedMap = {30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40}
    return speedMap[speed] or 30
end

for _, item in ipairs(inventoryPath) do
    local itemName = item.Name
    local itemCategory = ""
    local itemDetails = ""

    -- Категория Mount
    if item:FindFirstChild("Size") or item:FindFirstChild("Speed") then
        itemCategory = "Mount"
        if item:FindFirstChild("Size") then
            itemDetails = itemDetails .. " " .. getSizeValue(item.Size.Value)
        end
        if item:FindFirstChild("Speed") then
            itemDetails = itemDetails .. " " .. getSpeedValue(item.Speed.Value)
        end
    end

    -- Категория Materials
    if item:FindFirstChild("Count") then
        itemCategory = "Materials"
        itemDetails = itemDetails .. " " .. item.Count.Value
    end

    -- Категория Aura
    if string.find(itemName, "Aura") then
        itemCategory = "Aura"
    end

    -- Категория Equipment
    if item:FindFirstChild("Upgrade") or item:FindFirstChild("Enchant") or item:FindFirstChild("LegendEnchant") then
        itemCategory = "Equipment"
        if item:FindFirstChild("Upgrade") then
            itemDetails = itemDetails .. " Upgrade: " .. item.Upgrade.Value
        end
        if item:FindFirstChild("Enchant") then
            local enchantValue = item.Enchant.Value
            local enchantTypes = {"SPD", "ATK", "HPR", "MHP", "CRI", "SRP", "CRD", "BUR", "STA"}
            itemDetails = itemDetails .. " " .. enchantTypes[enchantValue] .. "\\"
        end
        if item:FindFirstChild("LegendEnchant") then
            local legendEnchantValue = item.LegendEnchant.Value
            local legendEnchantTypes = {"SPD", "ATK", "HPR", "MHP", "CRI", "SRP", "CRD", "BUR", "STA"}
            itemDetails = itemDetails .. " " .. legendEnchantTypes[legendEnchantValue]
        end
    end

    -- Категория OG Cosmetic
    local ogCosmeticItems = {"NecromancerCloak", "ShadowTuxedo", "VoidArmor", "FlamingGarment", "CyberEnforcer", "GoldenKimono", "VoidPickaxe", "CrystalFishingRod", "GoldPickaxe", "ToyPickaxe", "ToyFishingRod", "CoralFishingRod"}
    if table.find(ogCosmeticItems, itemName) then
        itemCategory = "OG Cosmetic"
    end

    -- Запись в таблицу
    if itemCategory ~= "" then
        table.insert(categorizedItems, itemID .. " - " .. itemCategory .. ": " .. itemName .. itemDetails)
        itemID = itemID + 1
    end
end

local function Save()
    writefile("sb3AKNA//" .. filename, table.concat(categorizedItems, "\n"))
end

Save()
