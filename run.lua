local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mainfarm = workspace:WaitForChild("Farm")
local userfarm = nil
for _, farm in ipairs(mainfarm:GetChildren()) do
  if farm.Important.Data.Owner.Value == LocalPlayer.Name then
    userfarm = farm
    break
  end
end
local function shovelplant(name)
  game:GetService("ReplicatedStorage").GameEvents.Remove_Item:FireServer(workspace.Farm.Farm.Important.Plants_Physical.Cauliflower["1"])
end
