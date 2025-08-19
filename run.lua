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
plants
for _, plant in ipairs(userfarm.Important.Plants_Physical:GetChildren()) do
    for _, model in ipairs(plant:GetChildren()) do
        ReplicatedStorage.GameEvents.Remove_Item:FireServer(model)
        task.wait(0.1)
    end
end
