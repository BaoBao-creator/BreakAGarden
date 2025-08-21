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
local middle = userfarm.Important.Center_Point.CFrame
local petingardenUUID = {}
for _, pet in ipairs(workspace.PetsPhysical:GetChildren()) do
    if pet:GetAttribute("OWNER") == LocalPlayer.Name then
        table.insert(petingardenUUID, pet:GetAttribute("UUID")
    end
end
local petinbackpackUUID = {}
for _, item in ipairs(LocalPlayer.Backpack:GetChildren()) do
    if item.Name:find("Kg") and item.Name:find("Age") then
        table.insert(petinbackpackUUID, item:GetAttribute("UUID")
    end
end
local fruits = {}
for _, item in ipairs(LocalPlayer.Backpack:GetChildren()) do
    if item.Name:find("Kg") and not item.Name:find("Age") then
        table.insert(fruits, item)
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
local function shovelplant()
    while true do
        if plantlist:FindFirstChild("Bone Blossom") == nil and plantlist:FindFirstChild("Candy Blossom") == nil then return end
        if plantlist:FindFirstChild("Bone Blossom") ~= nil then
            holditem(shovel)
            ReplicatedStorage.GameEvents.Remove_Item:FireServer("Bone Blossom"["1"])
            task.wait(0.5)
        end
        if plantlist:FindFirstChild("Candy Blossom") ~= nil then
            holditem(shovel)
            ReplicatedStorage.GameEvents.Remove_Item:FireServer("Candy Blossom"["1"])
            task.wait(0.5)
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
local function feedall()
    if #petingardenUUID == 0 then
        if #peninbackpackUUID == 0 then
            ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
            return
        end
        ReplicatedStorage.GameEvents.PetsService:FireServer("EquipPet", petinbackpackUUID[1], middle)
        for _, fruit in ipairs(fruits) do
            holditem(fruit)
            ReplicatedStorage.GameEvents.ActivePetService:FireServer("Feed", petinbackpackUID[1])
            task.wait(0.05)
        end
    else
        for _, fruit in ipairs(fruits) do
            holditem(fruit)
            ReplicatedStorage.GameEvents.ActivePetService:FireServer("Feed", petingardenUUID[1])
            task.wait(0.05)
        end
    end
end         
local function sellall()
    for _, pet in ipairs(workspace.PetsPhysical:GetChildren()) do
        if pet:GetAttribute("OWNER") == LocalPlayer.Name then
            ReplicatedStorage.GameEvents.PetsService:FireServer("UnequipPet", pet:GetAttribute("UUID"))
        end
    end
    ReplicatedStorage.GameEvents.SellAllPets_RE:FireServer()
end
