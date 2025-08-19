local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character
local humanoid = character:WaitForChild("Humanoid")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local mainfarm = workspace:WaitForChild("Farm")
local userfarm
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
for _, farm in ipairs(mainfarm:GetChildren()) do
    if farm.Important.Data.Owner.Value == LocalPlayer.Name then
        userfarm = farm
        break
    end
end
local function countPlants(plantlist)
    local result = {}
    for _, plant in ipairs(plantlist) do
        if result[plant] then
            result[plant] += 1
        else
            result[plant] = 1
        end
    end
    return result
end
while plantlist:FindFirstChildWhichIsA("Instance") do
    local plantlist = userfarm.Important.Plants_Physical:GetChildren()
    for name, count in pairs(countPlants(plantlist)) do
        for i = count, 1, -1 do
            ReplicatedStorage.GameEvents.Remove_Item:FireServer(name["1"])
        
holditem(shovel)

for _, plant in ipairs(plantlist) do 
    
    task.wait(0.05)
end
