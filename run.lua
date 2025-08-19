local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character
local humanoid = character:WaitForChild("Humanoid")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local mainfarm = workspace:WaitForChild("Farm")
local userfarm
for _, farm in ipairs(mainfarm:GetChildren()) do
    if farm.Important.Data.Owner.Value == LocalPlayer.Name then
        userfarm = farm
        break
    end
end
local plantlist = userfarm.Important.Plants_Physical:GetChildren()
local function holditem(tool)
    humanoid:EquipTool(tool)
end
local function find(wl, bl)
    for _, item in ipairs(LocalPlayer.Backpack:GetChildren()) do
        local name = item.Name
        local pass = true
        for _, ww in ipairs(wl) do
            if not name:find(ww) then
                pass = false
                break
            end
        end
        if pass then
            for _, bw in ipairs(bl) do
                if name:find(bw) then
                    pass = false
                    break
                end
            end
        end
        if pass then
            return item
        end
    end
end
local shovel = find({"Shovel"}, {})
local function shovelall()
    while true do
        if #plantlist == 0 then return end
        for _, plant in ipairs(plantlist) do 
            holditem(shovel)
            pcall(function()
                ReplicatedStorage.GameEvents.Remove_Item:FireServer(plant["1"])
            end)()
            task.wait(0.1)
        end
        plantlist = userfarm.Important.Plants_Physical:GetChildren()
    end
end
local function unfavoriteall()
    for _, item in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if item:GetAttribute("d") then
            item:SetAttribute("d", false)
        end
    end
    for _, plant in ipairs(plantlist) do 
        if plant:FindFirstChild("Fruits") ~= nil then 
            for _, fruit in ipairs(plant.Fruits:GetChildren()) do
                if fruit:GetAttribute("Favorited") then
                    fruit:SetAttribute("Favorited", false)
                end
            end
        else
            if plant:GetAttribute("Favorited") then
                plant:SetAttribute("Favorited", false)
            end
        end
    end
end
game:GetService("ReplicatedStorage").GameEvents.SellAllPets_RE:FireServer()
