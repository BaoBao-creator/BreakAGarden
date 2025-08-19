local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
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
for _, plant in ipairs(plantlist) do
    ReplicatedStorage.GameEvents.Remove_Item:FireServer(plant["1"])
end
