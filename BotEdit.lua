HumanDied = false
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
if v:IsA("BasePart") then 
game:GetService("RunService").Heartbeat:connect(function()
v.Velocity = Vector3.new(0,-30,0)
sethiddenproperty(game.Players.LocalPlayer,"MaximumSimulationRadius",math.huge)
sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",999999999)
end)
end
end

local plr = game.Players.LocalPlayer
local char = game.Players.LocalPlayer.Character
local ct = {}
local srv = game:GetService('RunService')
local te = table.insert
local m = plr:GetMouse()
char.Archivable = true

local bot = char:Clone()
bot.Name = 'NexoBot'
bot.Parent = workspace

function pos(part, parent, p)
Instance.new("Attachment",part)
Instance.new("AlignPosition",part)
Instance.new("Attachment",parent)
part.Attachment.Name = part.Name
parent.Attachment.Name = part.Name
part.AlignPosition.Attachment0 = part[part.Name]
part.AlignPosition.Attachment1 = parent[part.Name]
parent[part.Name].Position = p or Vector3.new()
part.AlignPosition.MaxForce = 999999999*10
part.AlignPosition.MaxVelocity = math.huge
part.AlignPosition.ReactionForceEnabled = false
part.AlignPosition.Responsiveness = math.huge
part.AlignPosition.RigidityEnabled = false
end

function create(part, parent, p, r)
Instance.new("Attachment",part)
Instance.new("AlignPosition",part)
Instance.new("AlignOrientation",part)
Instance.new("Attachment",parent)
part.Attachment.Name = part.Name
parent.Attachment.Name = part.Name
part.AlignPosition.Attachment0 = part[part.Name]
part.AlignOrientation.Attachment0 = part[part.Name]
part.AlignPosition.Attachment1 = parent[part.Name]
part.AlignOrientation.Attachment1 = parent[part.Name]
parent[part.Name].Position = p or Vector3.new()
part[part.Name].Orientation = r or Vector3.new()
part.AlignPosition.MaxForce = 999999999
part.AlignPosition.MaxVelocity = math.huge
part.AlignPosition.ReactionForceEnabled = false
part.AlignPosition.Responsiveness = math.huge
part.AlignOrientation.Responsiveness = math.huge
part.AlignPosition.RigidityEnabled = false
part.AlignOrientation.MaxTorque = 999999999
end

for i,v in next, char:GetDescendants() do
if v:IsA('Accessory') then
v.Handle:BreakJoints()
create(v.Handle,bot:FindFirstChild(v.Name).Handle)
end
end

local hats = {
LA = bot['Pink Hair'].Handle,
RA = bot['Kate Hair'].Handle,
LL = bot['Pal Hair'].Handle,
RL = bot['LavanderHair'].Handle,
T = bot['SeeMonkey'].Handle,
}

for i,v in next, hats do
v.AccessoryWeld.C1 = CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
v.AccessoryWeld.C0 = CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
end

hats.LA.AccessoryWeld.Part1 = bot['Left Arm']
hats.RA.AccessoryWeld.Part1 = bot['Right Arm']
hats.RL.AccessoryWeld.Part1 = bot['Right Leg']
hats.LL.AccessoryWeld.Part1 = bot['Left Leg']
hats.T.AccessoryWeld.Part1 = bot['Torso']

for i,v in pairs(bot:GetDescendants()) do
if v:IsA('BasePart') or v:IsA('Decal') then
v.Transparency = 1
end
end

for i,v in next, char:GetDescendants() do
if v:IsA('BasePart') then
te(ct,srv.Stepped:Connect(function()
v.CanCollide = false
end))
end
end

for i,v in next, bot:GetDescendants() do
if v:IsA('BasePart') then
te(ct,srv.Stepped:Connect(function()
v.CanCollide = false
end))
end
end

for i,v in next, bot:GetDescendants() do
if v:IsA('BasePart') then
te(ct,srv.RenderStepped:Connect(function()
v.CanCollide = false
end))
end
end

function rmesh(HatName)
for _,mesh in next, char[HatName]:GetDescendants() do
if mesh:IsA("Mesh") or mesh:IsA("SpecialMesh") then
mesh:Remove()
end
end
end

rmesh('LavanderHair')
rmesh('Pal Hair')
rmesh('Pink Hair')
rmesh('Kate Hair')
rmesh('SeeMonkey')

plr.Character = bot
workspace.CurrentCamera.CameraSubject = bot

local m = plr:GetMouse()
if flinge then
flingo=false
flingclick=true
if flingclick then
te(ct,m.Button1Down:Connect(function()
flingo=true
end))

te(ct,m.Button1Up:Connect(function()
flingo=false
end))
end

te(ct,srv.RenderStepped:Connect(function()
if flingo then
bot.Fling.CFrame = CFrame.new(m.Hit.p)*CFrame.new(0,1.5,0)
elseif not flingo then
bot.Fling.CFrame = bot['HumanoidRootPart'].CFrame*CFrame.new(0,0,0)
end
end))

gobr=Instance.new('Part',bot)
gobr.Size = Vector3.new(1,1,1)
gobr.CFrame = bot.HumanoidRootPart.CFrame
gobr.CanCollide = false
gobr.Transparency = 1
gobr.Anchored = true
gobr.Name = 'Fling'

pos(char.HumanoidRootPart,gobr)
fling = Instance.new('BodyAngularVelocity')
fling.Parent = char.HumanoidRootPart
fling.AngularVelocity = Vector3.new(1000*10,0,1000*10)
fling.MaxTorque = Vector3.new(5000*10,0,5000*10)

char['Left Arm']:Destroy()
char['Right Arm']:Destroy()
char['Left Leg']:Destroy()
char['Right Leg']:Destroy()
else
char.Torso.Anchored = true
end

te(ct,bot.Humanoid.Died:Connect(function()
for i,v in next, ct do v:Disconnect() end
plr.Character = char
char:BreakJoints()
coroutine.wrap(function()
while true do
srv.RenderStepped:wait()
HumanDied = true
if workspace:FindFirstChild(bot.Name) then
bot:Destroy()
else
break
end
end
end)()
end))

--char.Torso.Anchored = true
bot.Animate.Disabled = true
