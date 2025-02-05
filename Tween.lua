local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Rayfield Example Window",
    Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
    LoadingTitle = "Prison Life Scipt 1",
    LoadingSubtitle = "By anonymous",
    Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes
 
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
 
    ConfigurationSaving = {
       Enabled = true,
       FolderName = PrisonLife, -- Create a custom folder for your hub/game
       FileName = "Big Hub"
    },
 
    Discord = {
       Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
 
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
       Title = "Prison Life Script Key System😭",
       Subtitle = "Key System",
       Note = "You know the password", -- Use this to tell the user how to get a key
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"mS8QGik1ZaKPHZNUNScFf6AFIB91BjTs"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

 local Tab = Window:CreateTab("Main tab", 240126830) -- Title, Image

 local Button = Tab:CreateButton({
    Name = "Tween to Criminal Base!",
    Callback = function()
    local TweenService = game:GetService("TweenService")
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    
    -- Desativa o movimento do jogador
    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0
    
    -- Defina a posição de destino
    local destino = Vector3.new(-949.362060546875, 93.59180450439453, 2056.14111328125) -- Altere para a posição desejada
    
    -- Configuração do Tween
    local tweenInfo = TweenInfo.new(
        2, -- Tempo de duração
        Enum.EasingStyle.Quad, -- Estilo de animação
        Enum.EasingDirection.Out -- Direção da animação
    )
    
    local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = CFrame.new(destino)})
    
    tween:Play()
    
    tween.Completed:Connect(function()
        -- Reativa o movimento do jogador após o tween
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end)

    end,
 })
