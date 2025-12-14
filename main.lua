local players = game:GetService("Players")
local player = players.LocalPlayer
local gui = Instance.new("ScreenGui")
local ts = game:GetService("RunService")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local function loadAnim(id)
	local anim = Instance.new("Animation")
	anim.AnimationId = id
	return humanoid:LoadAnimation(anim)
end

local you = loadAnim("rbxassetid://128853357")

player.Chatted:Connect(function(msg)
	if msg:lower() == "you" then
		you:Play()
	end
end)

gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 600)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.Parent = gui

local uiDragDetector = Instance.new("UIDragDetector")
uiDragDetector.Parent = frame

local AdminAnims = Instance.new("TextButton")
AdminAnims.Parent = frame
AdminAnims.Text = "Admin Anim Pack"
AdminAnims.Size = UDim2.new(1, 0, 0, 50)

local X = Instance.new("TextButton")
X.Parent = frame
X.Text = "X"
X.Size = UDim2.new(0, 50, 0, 50)
X.AnchorPoint = Vector2.new(1, 1)
X.Position = UDim2.new(1, 0, 1, 0)
X.BackgroundColor = BrickColor.Red()
X.TextColor = BrickColor.White()


X.Activated:Connect(function()
	gui:Destroy()
end)

AdminAnims.Activated:Connect(function()
	local Players = game:GetService("Players")
	local ts = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")

	local player = Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local hrp = character:WaitForChild("HumanoidRootPart")

	-- Animation IDs
	local anims = {
		Idle = "rbxassetid://119473916907837",
		Walk = "rbxassetid://89706191899405",
		Run = "rbxassetid://124250212996049"
	}

	local idleTrack = loadAnim(anims.Idle)
	local walkTrack = loadAnim(anims.Walk)
	local runTrack = loadAnim(anims.Run)

	-- Play idle at start
	idleTrack:Play()


	-- Variables
	local normalWalkSpeed = humanoid.WalkSpeed -- baseline

	-- Movement & animation logic
	ts.RenderStepped:Connect(function()
		local speed = hrp.Velocity.Magnitude
		local moveDir = humanoid.MoveDirection.Magnitude

		-- If standing still
		if moveDir <= 0.1 then
			if not idleTrack.IsPlaying then
				walkTrack:Stop()
				runTrack:Stop()
				idleTrack:Play()
			end
			return
		end

		-- Walking vs Running logic
		if speed > normalWalkSpeed + 1 then
			-- Running
			if not runTrack.IsPlaying then
				idleTrack:Stop()
				walkTrack:Stop()
				runTrack:Play()
			end
		else
			-- Walking
			if not walkTrack.IsPlaying then
				idleTrack:Stop()
				runTrack:Stop()
				walkTrack:Play()
			end
		end
	end)
end)

local DoomAnims = Instance.new("TextButton")
DoomAnims.Parent = frame
DoomAnims.Text = "Speedy!"
DoomAnims.Size = UDim2.new(1, 0, 0, 50)
DoomAnims.Position = UDim2.new(0, 0, 0, 50)

DoomAnims.Activated:Connect(function()
	game.Players.LocalPlayer.Character.Humanoid:SetAttribute("BaseSpeed", 100)
end)

local Jump = Instance.new("TextButton")
Jump.Parent = frame
Jump.Text = "Jump in round"
Jump.Size = UDim2.new(1, 0, 0, 50)
Jump.Position = UDim2.new(0, 0, 0, 100)

Jump.Activated:Connect(function()
	local UserInputService = game:GetService("UserInputService")
	local useVel = false

	if not useVel then
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 60
		game.Players.LocalPlayer.Character.Humanoid.JumpHeight = 7.2
		return
	else
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.KeyCode == Enum.KeyCode.Space then
				game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 60, 0)
			end
		end)
	end
end)

local svin = Instance.new("TextButton")
svin.Parent = frame
svin.Text = "saveinstance()"
svin.Size = UDim2.new(1, 0, 0, 50)
svin.Position = UDim2.new(0, 0, 0, 150)

svin.Activated:Connect(function()
	gui:Destroy()
	print("We have destroyed the gui so it does not get put in the saveinstance()")
	saveinstance()
end)

local HeadView = Instance.new("TextButton")
HeadView.Parent = frame
HeadView.Text = "Head CameraSubject"
HeadView.Size = UDim2.new(1, 0, 0, 50)
HeadView.Position = UDim2.new(0, 0, 0, 200)

HeadView.Activated:Connect(function()
	workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Head
end)

local FixView = Instance.new("TextButton")
FixView.Parent = frame
FixView.Text = "Normal CameraSubject"
FixView.Size = UDim2.new(1, 0, 0, 50)
FixView.Position = UDim2.new(0, 0, 0, 250)

FixView.Activated:Connect(function()
	workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
end)

local FakeSlash = Instance.new("TextButton")
FakeSlash.Parent = frame
FakeSlash.Text = "Fake Slash (SHED ONLY)"
FakeSlash.Size = UDim2.new(1, 0, 0, 50)
FakeSlash.Position = UDim2.new(0, 0, 0, 300)

FakeSlash.Activated:Connect(function()
	local uis = game:GetService("UserInputService")
local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
local deb = false

uis.InputBegan:Connect(function(input, gp)
	if gp or deb then return end
	if input.KeyCode == Enum.KeyCode.R then
			deb = true
			local unsheath = Instance.new("Sound")
			unsheath.SoundId = "rbxassetid://12222225"
			unsheath.Volume = 1
			unsheath.Parent = game.Players.LocalPlayer.Character.Sword

			local slash = Instance.new("Sound")
			slash.SoundId = "rbxassetid://12222208"
			slash.Volume = 1
			slash.Parent = game.Players.LocalPlayer.Character.Sword
			local anim = Instance.new("Animation")
			anim.AnimationId = "rbxassetid://116618003477002"
			humanoid:FindFirstChildOfClass("Animator"):LoadAnimation(anim):Play()
   	        game.Players.LocalPlayer.Character.Sword.Transparency = 0
			anim:Destroy()
			unsheath:Play()
			wait(0.5)
			slash:Play()
			wait(1)
			game.Players.LocalPlayer.Character.Sword.Transparency = 1
			deb = false
			wait(2)
			slash:Destroy()
			unsheath:Destroy()
		end
	end)
end)
