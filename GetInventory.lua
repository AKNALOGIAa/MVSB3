local playerName = game.Players.LocalPlayer.Name
local inventoryPath = game:GetService("ReplicatedStorage").Profiles[playerName].Inventory:GetChildren()

local itemID = 1
local categorizedItems = {}

local HttpService = game:GetService("HttpService")
local filename = playerName .. "_inventory.txt"

if not isfolder("sb3AKNA") then
    makefolder("sb3AKNA")
end

if isfile("sb3AKNA//" .. filename) then
    categorizedItems = HttpService:JSONDecode(readfile("sb3AKNA//" .. filename))
end

for _, item in ipairs(inventoryPath) do
    local itemName = item.Name
    local itemCategory = ""
    local itemDetails = ""

    -- Категория Mount
    if item:FindFirstChild("Size") or item:FindFirstChild("Speed") then
        itemCategory = "Mount"
        if item:FindFirstChild("Size") then
            itemDetails = itemDetails .. " Size.Value = " .. item.Size.Value
        end
        if item:FindFirstChild("Speed") then
            itemDetails = itemDetails .. " Speed.Value = " .. item.Speed.Value
        end
    end

    -- Категория Materials
    if item:FindFirstChild("Count") then
        itemCategory = "Materials"
        itemDetails = itemDetails .. " Count.Value = " .. item.Count.Value
    end

    -- Категория Aura
    if string.find(itemName, "Aura") then
        itemCategory = "Aura"
    end

    -- Категория Экипировка
    if item:FindFirstChild("Upgrade") or item:FindFirstChild("Enchant") or item:FindFirstChild("LegendEnchant") then
        itemCategory = "Экипировка"
        if item:FindFirstChild("Upgrade") then
            itemDetails = itemDetails .. " Upgrade.Value = " .. item.Upgrade.Value
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
    writefile("sb3AKNA//" .. filename, HttpService:JSONEncode(categorizedItems))
end

Save()
