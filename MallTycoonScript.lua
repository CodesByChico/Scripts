--// Variables \\--
local work = game:GetService("Workspace")
local ps = game:GetService("Players")
local lp = ps.LocalPlayer
local tycoon_name = "Tycoon"..lp.Name
local config

--/Gui\--
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Double Trouble Team - Mall Tycoon", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

--[[
Name = <string> - The name of the UI.
HidePremium = <bool> - Whether or not the user details shows Premium status or not.
SaveConfig = <bool> - Toggles the config saving in the UI.
ConfigFolder = <string> - The name of the folder where the configs are saved.
IntroEnabled = <bool> - Whether or not to show the intro animation.
IntroText = <string> - Text to show in the intro animation.
IntroIcon = <string> - URL to the image you want to use in the intro animation.
Icon = <string> - URL to the image you want displayed on the window.
CloseCallback = <function> - Function to execute when the window is closed.
]]

local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "https://create.roblox.com/store/asset/6318683148/Dog?keyword=Dog&pageNumber=1&pagePosition=10",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Autofarm"
})

--[[
Name = <string> - The name of the section.
]]

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]
Tab:AddToggle({
	Name = "Auto Collect Cash",
	Default = false,
	Callback = function(Value)
			auto_collect_cash = Value
	end,
	Enabled = true
	})

	Tab:AddToggle({
	Name = "Auto Build Mall",
	Default = false,
	Callback = function(Value)
			auto_build_mall = Value
	end,
	Enabled = true    
})

Tab:AddToggle({
	Name = "Auto Pick A Store",
	Default = false,
	Callback = function(Value)
		uto_select_store = Value
	end,
	Enabled = true 
})

Tab:AddToggle({
	Name = "Auto Pick Set",
	Default = false,
	Callback = function(Value)
		auto_select_setpeice = Value
	end,
	Enabled = true    
})

Tab:AddToggle({
	Name = "Auto Rebirth",
	Default = false,
	Callback = function(Value)
				auto_rebirth = Value
	end,
	Enabled = false   
})

local Tab = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Made with love by"
})
Tab:AddLabel("HpLowers (Chico)")
Tab:AddLabel("Zfake(Ztugas)")

Tab:AddButton({
	Name = "added thi to be a random ahhh button",
	Callback = function()
      		local clipboard = require("clipboard")

local function copyToClipboard()
    clipboard.set(url)
end

local siteUrl = "https://www.nyan.cat/"
copyToClipboard(siteUrl)
	end
})

--// Presets \\--
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
	vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	wait(1)
	vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

spawn(function()
	pcall(function()
		while wait(1) do
			for i,v in pairs(work[tycoon_name]:GetDescendants()) do
				if v:IsA("Model") and v.Name == "Gamepasses" then
					v:Destroy()
				end
			end
		end
	end)
end)

wait(1)

--// Configurations \\--
config = {
	func = {
		fb1 = function(button)
			for i,signal in next, getconnections(button.MouseButton1Click) do
				signal:Fire()
			end
			for i,signal in next, getconnections(button.MouseButton1Down) do
				signal:Fire()
			end
			for i,signal in next, getconnections(button.Activated) do
				signal:Fire()
			end
		end,
		collect_cash = function()
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer("RequestCollectCash")
		end,
		pick_store = function()
			if lp.PlayerGui.Interface.PickStore.PickStore.Background.Visible then
				local Rarity = {"Legendary", "Epic", "Rare", "Common"}
				local Green = lp.PlayerGui.Interface.PickStore.PickStore.Background.SpeechBubble.GreenMini.RateTextLabel
				local Red = lp.PlayerGui.Interface.PickStore.PickStore.Background.SpeechBubble.RedMini.RateTextLabel
				local PickedType = false
				local Built = false
				for _,Rare in pairs(Rarity) do
					if not PickedType then
						for _,v in pairs(lp.PlayerGui.Interface.PickStore:GetDescendants()) do
							pcall(function()
								if v:IsA("ImageButton") and v.Name == "SelectButton" and v.Parent:FindFirstChild("StoreType") and v.Parent.Name == Rare then
									if string.match(Green.Text, v.Parent.StoreType.Text) then
										PickedType = v.Parent.StoreType.Text
									end
								end
							end)
						end
					end
				end
				for _,Rare in pairs(Rarity) do
					for _,v in pairs(lp.PlayerGui.Interface.PickStore:GetDescendants()) do
						pcall(function()
							if PickedType then
								if v:IsA("ImageButton") and v.Name == "SelectButton" and v.Parent.StoreType.Text == PickedType and v.Parent.Name == Rare then
									print("Green", PickedType, Rare)
									Built = true
									config.func.fb1(v)
								end
							else
								if v:IsA("ImageButton") and v.Name == "SelectButton" and v.Parent.Name == Rare and not string.match(Red.Text, v.Parent.StoreType.Text) then
									if Rare == "Common" and not Built and not string.match(Green.Text, " any ") then
										for _,leg in pairs(lp.PlayerGui.Interface.PickStore:GetDescendants()) do
											pcall(function()
												if leg.Name == "InventoryButton" and leg.Parent.Name == "StoreButton" and not Built then
													print("Legendary", leg.Parent.StoreTitle.Text)
													Built = true
													config.func.fb1(leg)
												end
											end)
										end
									end
									if not Built then
										print("Random", Rare)
										Built = true
										config.func.fb1(v)
									end
								end
							end
						end)
					end
				end
				if not Built then
					for _,v in pairs(lp.PlayerGui.Interface.PickStore:GetDescendants()) do
						pcall(function()
							if v.Name == "InventoryButton" and v.Parent.Name == "StoreButton" and not Built then
								print("Legendary", v.Parent.StoreTitle.Text)
								Built = true
								config.func.fb1(v)
							end
						end)
					end
				end
				if not Built then
					for _,Rare in pairs(Rarity) do
						for _,v in pairs(lp.PlayerGui.Interface.PickStore:GetDescendants()) do
							pcall(function()
								if v:IsA("ImageButton") and v.Name == "SelectButton" and v.Parent.Name == Rare then
									print("Red", Rare)
									Built = true
									config.func.fb1(v)
								end
							end)
						end
					end
				end
			end
		end,
		pick_setpiece = function()
			if lp.PlayerGui.Interface.PickSetPiece.PickSetPiece.Background.Visible then
				for _,v in pairs(lp.PlayerGui.Interface.PickSetPiece:GetDescendants()) do
					pcall(function()
						if v:IsA("ImageButton") and v.Name == "SelectButton" and v.Parent.Name == "Option2" and v.Parent.parent.Visible then
							print(v.Parent.StoreTitle.Text)
							config.func.fb1(v)
						end
					end)
				end
			end
		end,
		buy_all = function()
			for _,v in pairs(work[tycoon_name]:GetDescendants()) do
				pcall(function()
					if v:IsA("TouchTransmitter") and v.Name == "TouchInterest" and v.Parent.Name == "Button" and v.Parent.Parent.Name ~= "RespawnButton" and v.Parent.Parent.Name ~= "ButtonCollect" then
						local Cash = lp.leaderstats.Cash
						local Cost = v.Parent.Parent.ButtonCost
						wait(.1)
						if Cash.Value >= Cost.Value then
							game:GetService("ReplicatedStorage").RemoteEvent:FireServer("ButtonTriggeredLocally", v.Parent.Parent, v.Parent.Parent.ButtonData)
							wait()
						end
					end
				end)
			end
			config.func.pick_store()
		end,
		rebirth = function()
			pcall(function()
				local F13 = work[tycoon_name]:FindFirstChild("Floor13")
				if F13 then
					local Con = F13:FindFirstChild("Contents")
					if Con then
						local Trophy = Con:FindFirstChild("Trophy")
						if Trophy then
							game:GetService("ReplicatedStorage").RemoteEvent:FireServer("RequestUnlockStores")
							wait(.5)
							game:GetService("ReplicatedStorage").RemoteEvent:FireServer("RequestRebirth")
						end
					end
				end
			end)
		end,
	}
}

--// Collect Cash \\--
spawn(function()
	while wait(1) do
		if auto_collect_cash then
			config.func.collect_cash()
		end
	end
end)

--// Auto Pick Set Piece \\--
spawn(function()
	while wait(1) do
		if auto_select_setpeice then
			config.func.pick_setpiece()
		end
	end
end)

--// Auto Pick Store \\--
spawn(function()
	while wait(1) do
		if auto_select_store then
			config.func.pick_store()
		end
	end
end)

--// Auto Buy \\--
spawn(function()
	while wait(1) do 
		if auto_build_mall then
			config.func.buy_all()
		end
	end
end)

--// Auto Rebirth \\--
spawn(function()
	while wait(1) do
		if auto_rebirth then
			config.func.rebirth()
		end
	end
end)

OrionLib:Init()
