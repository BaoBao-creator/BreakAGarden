local mainfarm = workspace:WaitForChild("Farm")
local userfarm = nil
for _, farm in ipairs(mainfarm:GetChildren()) do
  local imp = farm:FindFirstChild("Important")
  local data = imp:FindFirstChild("Data")
  local owner = data:FindFirstChild("Owner")
  if owner.Value == LocalPlayer.Name then
    userfarm = farm
local function shovelplant(name)
  game:GetService("ReplicatedStorage").GameEvents.Remove_Item:FireServer(workspace.Farm.Farm.Important.Plants_Physical.Cauliflower["1"])
end
