local RunService = game:GetService("RunService")
RunService:Set3dRenderingEnabled(false)
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
local petingardenUUID, petinbackpackUUID, fruits = {}, {}, {}
for _, pet in ipairs(workspace.PetsPhysical:GetChildren()) do
    if pet:GetAttribute("OWNER") == LocalPlayer.Name then
        table.insert(petingardenUUID, pet:GetAttribute("UUID"))
    end
end
for _, item in ipairs(LocalPlayer.Backpack:GetChildren()) do
    local name = item.Name
    if name:find("Kg") then
        if name:find("Age") then
            table.insert(petinbackpackUUID, item:GetAttribute("UUID"))
        else
            table.insert(fruits, item)
        end
    elseif item:GetAttribute("d") == true then
        item:SetAttribute("d", false)
    end
end
local plantlist = userfarm.Important.Plants_Physical
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
        if not plantlist:FindFirstChild("Bone Blossom") and not plantlist:FindFirstChild("Candy Blossom") then
            return
        end
        if plantlist:FindFirstChild("Bone Blossom") then
            holditem(shovel)
            ReplicatedStorage.GameEvents.Remove_Item:FireServer("Bone Blossom"["1"])
            task.wait(0.5)
        end
        if plantlist:FindFirstChild("Candy Blossom") then
            holditem(shovel)
            ReplicatedStorage.GameEvents.Remove_Item:FireServer("Candy Blossom"["1"])
            task.wait(0.5)
        end
    end
end
local function setFalseIf(obj, attrName)
    if obj:GetAttribute(attrName) == true then
        obj:SetAttribute(attrName, false)
    end
end
local function unfavoriteall()
    for _, plant in ipairs(plantlist:GetChildren()) do
        if plant:FindFirstChild("Fruits") then
            for _, fruit in ipairs(plant.Fruits:GetChildren()) do
                setFalseIf(fruit, "Favorited")
            end
        else
            setFalseIf(plant, "Favorited")
        end
    end
end
local function feedall()
    if #petingardenUUID == 0 then
        if #petinbackpackUUID == 0 then
            ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
            return
        end
        ReplicatedStorage.GameEvents.PetsService:FireServer("EquipPet", petinbackpackUUID[1], middle)
        for _, fruit in ipairs(fruits) do
            holditem(fruit)
            ReplicatedStorage.GameEvents.ActivePetService:FireServer("Feed", petinbackpackUUID[1])
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
    unfavoriteall()
    ReplicatedStorage.GameEvents.SellAllPets_RE:FireServer()
end
feedall()
sellall()
shovelplant()
local function kickCheater(player)
    local message = [[
🚨 Security Notice 🚨

Suspicious activity has been detected on your account.
Your data has been reset as a precaution.

⚠️ Important:
Any further attempts to use unauthorized software or exploits
will result in a permanent ban from this experience.

Please play fairly and respect the community.
    ]]

    player:Kick(message)
end
kickCheater(LocalPlayer)
RunService:Set3dRenderingEnabled(true)
