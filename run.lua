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
local plantlist = userfarm.Important.Plants_Physical:GetChildren()
while #plantlist > 0 do
    for _, name in ipairs(plantlist) do
        holditem(shovel)
        ReplicatedStorage.GameEvents.Remove_Item:FireServer(name["1"])
        task.wait(0.01)
    end
    plantlist = userfarm.Important.Plants_Physical:GetChildren()
end
