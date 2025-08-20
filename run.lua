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
local middle = userfarm.Important.Center_Point
local petingarden = {}
for _, pet in ipairs(workspace.PetsPhysical:GetChildren()) do
    if pet:GetAttribute("OWNER") == LocalPlayer.Name then
        table.insert(petingarden, pet)
    end
end
local fruits = 
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
    ReplicatedStorage.GameEvents.ActivePetService:FireServer("Feed","{589ef418-a05d-4d33-ba9c-6639bb42dd0c}")
local function sellall()
    ReplicatedStorage.GameEvents.SellAllPets_RE:FireServer()
    ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
end
ReplicatedStorage.GameEvents.PetsService:FireServer("UnequipPet","{589ef418-a05d-4d33-ba9c-6639bb42dd0c}")
ReplicatedStorage.GameEvents.PetsService:FireServer("EquipPet","{589ef418-a05d-4d33-ba9c-6639bb42dd0c}",CFrame.new(36.5112152, 0, -78.5274582, 1, 0, 0, 0, 1, 0, 0, 0, 1))
