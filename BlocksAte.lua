if ScriptExecuted then return end
ScriptExecuted = true
local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local RS = game:GetService("RunService")
    local camera = Workspace.CurrentCamera
    local CurrentCamera = workspace.CurrentCamera
    local worldToViewportPoint = CurrentCamera.worldToViewportPoint
    local mouse = game.Players.LocalPlayer:GetMouse()
    local lp = game.Players.LocalPlayer
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local HttpService = game:GetService("HttpService")
    local VirtualUser = game:GetService("VirtualUser")
    local ChatService = game:GetService("Chat")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local RbxAnalService = game:GetService("RbxAnalyticsService")
    
features = {
    ["SpeedToggle"] = false,
    ["JumpToggle"] = false,
    ["FlyToggle"] = false,
    ["SpeedValue"] = 16,
    ["JumpValue"] = 50,
    ["FlyValue"] = 10,
    ["FlingToggle"] = false,
    ["FloatToggle"] = false,
    ["NoclipToggle"] = false,
    ["InfJumpToggle"] = false,
    ["SpamDecal"] = false,
    ["SpamSign"] = false,
}

if not isfolder("/BlocksAt") then
    makefolder("/BlocksAt")
end
if not isfolder("/BlocksAt/SavedWorlds") then
    makefolder("/BlocksAt/SavedWorlds")
end

local function gplr(String)
    local Found = {}
    local strl = String:lower()
    if strl == "all" then
    for i,v in pairs(game:FindService("Players"):GetPlayers()) do
    table.insert(Found,v)
    end
    elseif strl == "others" then
    for i,v in pairs(game:FindService("Players"):GetPlayers()) do
    if v.Name ~= lp.Name then
    table.insert(Found,v)
    end
    end
    elseif strl == "me" then
    for i,v in pairs(game:FindService("Players"):GetPlayers()) do
    if v.Name == lp.Name then
    table.insert(Found,v)
    end
    end
    else
        for i,v in pairs(game:FindService("Players"):GetPlayers()) do
    if v.Name:lower():sub(1, #String) == String:lower() then
    table.insert(Found,v)
    end
    end
    end
    return Found
    end
    
    local symbols = {"!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "+", "=", "{", "}", "[", "]", ";", ":", "'", "\"", ",", "<", ">", ".", "/", "?", "`", "~"}
    local letters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
    local numbers = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
    
    
    local function generateCode(length)
        local code = ""
        for i = 1, length do
            local randomIndex = math.random(1, 3)
            if randomIndex == 1 then
                code = code .. symbols[math.random(1, #symbols)]
            elseif randomIndex == 2 then
                code = code .. letters[math.random(1, #letters)]
            else
                code = code .. numbers[math.random(1, #numbers)]
            end
        end
        return code
    end

function GetCharacter(Player)
    if Player.Character then
    return Player.Character
    end
    end
    
    function GetRoot(Player)
    if GetCharacter(Player):FindFirstChild("HumanoidRootPart") then
    return GetCharacter(Player).HumanoidRootPart
    end
    end
    
    function TeleportTO(posX,posY,posZ,player,method)
    pcall(function()
        if method == "safe" then
        task.spawn(function()
            for i = 1,30 do
            task.wait()
            GetRoot(lp).Velocity = Vector3.new(0,0,0)
            if player == "pos" then
            GetRoot(lp).CFrame = CFrame.new(posX,posY,posZ)
            else
                GetRoot(lp).CFrame = CFrame.new(GetRoot(player).Position)+Vector3.new(0,2,0)
            end
            end
            end)
        else
            GetRoot(plr).Velocity = Vector3.new(0,0,0)
        if player == "pos" then
        GetRoot(plr).CFrame = CFrame.new(posX,posY,posZ)
        else
            GetRoot(plr).CFrame = CFrame.new(GetRoot(player).Position)+Vector3.new(0,2,0)
        end
        end
        end)
    end

    function Fly()
        local root = lp.Character:WaitForChild("HumanoidRootPart")
        local camera = workspace.CurrentCamera
        local v3none = Vector3.new()
        local v3zero = Vector3.new(0, 0, 0)
        local v3inf = Vector3.new(9e9, 9e9, 9e9)
        
        local controlModule = require(lp.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
        local bv = Instance.new("BodyVelocity")
        bv.Name = velocityHandlerName
        bv.Parent = root
        bv.MaxForce = v3zero
        bv.Velocity = v3zero
        
        local bg = Instance.new("BodyGyro")
        bg.Name = gyroHandlerName
        bg.Parent = root
        bg.MaxTorque = v3inf
        bg.P = 1000
        bg.D = 50
        
        mfly1 = lp.CharacterAdded:Connect(function()
            local bv = Instance.new("BodyVelocity")
            bv.Name = velocityHandlerName
            bv.Parent = root
            bv.MaxForce = v3zero
            bv.Velocity = v3zero
        
            local bg = Instance.new("BodyGyro")
            bg.Name = gyroHandlerName
            bg.Parent = root
            bg.MaxTorque = v3inf
            bg.P = 1000
            bg.D = 50
            end)
        
            mfly2 = RS.RenderStepped:Connect(function()
                root = GetHumPart(lp)
                camera = workspace.CurrentCamera
                if lp.Character:FindFirstChildWhichIsA("Humanoid") and root and root:FindFirstChild(velocityHandlerName) and root:FindFirstChild(gyroHandlerName) then
                    local humanoid = lp.Character:FindFirstChildWhichIsA("Humanoid")
                    local VelocityHandler = root:FindFirstChild(velocityHandlerName)
                    local GyroHandler = root:FindFirstChild(gyroHandlerName)
        
                    VelocityHandler.MaxForce = v3inf
                    GyroHandler.MaxTorque = v3inf
                    humanoid.PlatformStand = true
                    GyroHandler.CFrame = camera.CoordinateFrame
                    VelocityHandler.Velocity = v3none
        
                    local direction = controlModule:GetMoveVector()
                    if direction.X > 0 then
                        VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * ((functionforscript_mm2["FlyValue"])))
                    end
                    if direction.X < 0 then
                        VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * ((functionforscript_mm2["FlyValue"])))
                    end
                    if direction.Z > 0 then
                        VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * ((functionforscript_mm2["FlyValue"])))
                    end
                    if direction.Z < 0 then
                        VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * ((functionforscript_mm2["FlyValue"])))
                    end
                end
            end)
    end
    
    function UnFly()
        lp.Character:WaitForChild("HumanoidRootPart"):FindFirstChild(velocityHandlerName):Destroy()
        lp.Character:WaitForChild("HumanoidRootPart"):FindFirstChild(gyroHandlerName):Destroy()
        lp.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
        if mfly1 then
        mfly1:Disconnect()
        end
        if mfly2 then
        mfly2:Disconnect()
        end
    end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/NecroxisTeam/Files/refs/heads/main/Roblox-UiLibrary-Modifed/Peacock-Modifed/Source.lua", true))()
local main = library:CreateLib({name = "BlocksAte Script 1.0"})

local tabs = {
    ["LocalPlr"] = main:NewTab({name = "Player"}),
    ["Trolling"] = main:NewTab({name = "Trolling"}),
    ["Settings"] = main:NewTab({name = "Player"})
}

Toggle({
        name = "Speed Toggle", 
        default = features["SpeedToggle"],
        callback = function(val)
        features["SpeedToggle"] = val
    end})
    
    tabs.LocalPlr:NewSlider({
    name = "Speed Value",
    default = features["SpeedValue"],
    min = 16,
    max = 250,
    callback = function(Value)
        features["SpeedValue"] = Value
    end})
    
    tabs.LocalPlr:NewToggle({
        name = "Jump Toggle", 
        default = features["JumpToggle"],
        callback = function(val)
        features["JumpToggle"] = val
    end})
    
    tabs.LocalPlr:NewSlider({
    name = "Jump Value",
    default = features["JumpValue"],
    min = 50,
    max = 500,
    callback = function(Value)
        features["JumpValue"] = Value
    end})
    
tabs.LocalPlr:NewToggle({
        name = "Fly", 
        default = functionforscript_mm2["Fly"],
        callback = function(val)
        features["FlyToggle"] = val
        if features["FlyToggle"] then
            Fly()
        else
            UnFly()
        end
    end})
    
    tabs.LocalPlr:NewSlider({
    name = "Fly Speed",
    default = functionforscript_mm2["FlyValue"],
    min = 10,
    max = 200,
    callback = function(Value)
        features["FlyValue"] = Value
    end})
    
    tabs.LocalPlr:NewToggle({
        name = "Fling Toggle", 
        default = features["FlingToggle"],
        callback = function(val)
        features["FlingToggle"] = val
        getgenv().fling = val
        if getgenv().fling then
        local fixpos = GetRoot(lp).Position
        TeleportTO(fixpos.X,fixpos.Y,fixpos.Z,"pos","safe")
        local RVelocity = nil
        repeat
        pcall(function()
            RVelocity = GetRoot(lp).Velocity
            GetRoot(lp).Velocity = Vector3.new(math.random(-150,150),-25000,math.random(-150,150))
            RS.RenderStepped:wait()
            GetRoot(lp).Velocity = RVelocity
            end)
        RS.Heartbeat:wait()
        until not getgenv().fling
        fixpos = nil
        end
        end})

    tabs.LocalPlr:NewToggle({
        name = "Float Toggle", 
        default = features["FloatToggle"],
        callback = function(val)
        features["FloatToggle"] = val
        floattoggle = val
        if floattoggle then
        while wait(0.0001) do
        pcall(function()
            if workspace:FindFirstChild("FloatExploit") then
            workspace.FloatExploit:Destroy()
            end
            local Float = Instance.new("Part", game.Workspace)
            Float.Anchored = true
            Float.Name = "FloatExploit"
            Float.Transparency = 1
            Float.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,-3.1, 0)
            Float.Size = Vector3.new(3,0,3)
            end)
        if not floattoggle then
        if workspace:FindFirstChild("FloatExploit") then
        workspace.FloatExploit:Destroy()
        end
        break
        end
        end
        end
        end})

    tabs.LocalPlr:NewToggle({
        name = "Noclip", 
        default = features["SpeedToggle"],
        callback = function(val)
        features["SpeedToggle"] = val
        Noclip = val
        if Noclip then
        Nclp = RS.Stepped:Connect(function()
            if lp.Character ~= nil then
            for _, child in pairs(lp.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true then
            child.CanCollide = false
            end
            end
            end
            end)
        else
            if Nclp then
        Nclp:Disconnect()
        end
        if lp.Character ~= nil then
        for _, child in pairs(lp.Character:GetDescendants()) do
        if child:IsA("BasePart") and child.CanCollide == true then
        child.CanCollide = true
        end
        end
        end
        end
        end})
        
    tabs.LocalPlr:NewToggle({
        name = "Inf Jump", 
        default = features["InfJToggle"],
        callback = function(val)
        features["InfJToggle"] = val
        if val then
        InfJump = game:GetService("UserInputService").JumpRequest:connect(function()
            if val then
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
            else
                if InfJump then
            InfJump:Disconnect()
            end
            end
            end)
        else
            if InfJump then
        InfJump:Disconnect()
        end
        end
        end})


    
    tabs.Trolling:NewLabel({name = "Its Not Working For Sometimes:/"})
    tabs.Trolling:NewToggle({name = "Spam Sign", default = features["SpamSign"], callback = function(val)
        
    end})
    tabs.Trolling:NewToggle({name = "Spam Decal", default = features["SpamDecal"], callback = function(val)
        
    end})
    tabs.Trolling:NewButton({name = "Grief World", callback = function()
        
    end})
    
    Trolling_SECT:addButton({name = "Delete Everything", callback = function()

    end})
    
    Trolling_SECT:addLabel({name = "      World Copier"})
    
    WorldName = "SavedWorld"
    
    tabs.Trolling:NewButton({name = "Save World", callback = function()
        if not isfile("/BlocksAte/SavedWorlds/"..WorldName.."_World.lua") then
            puth = 'print("testing")'
            writefile("/BlocksAte/SavedWorlds/"..WorldName.."_World.lua", puth)
            print("Successful Saved File!")
        else
            print("File With Same Name Founded!")
        end
    end})
    
    tabs.Trolling:NewButton({name = "Load World", callback = function()
            if isfile("/BlocksAte/SavedWorlds/"..WorldName.."_World.lua") then
            
            local WorldNeed = readfile("/BlocksAte/SavedWorlds/"..WorldName.."_World.lua")
            loadstring(WorldNeed)()
            print("Success Loaded File!")
        else
            print("File Didnt Founded!")
        end
    end})
    
    tabs.Trolling:NewButton({name = "Delete World File", callback = function()
        if isfile("/BlocksAte/SavedWorlds/"..WorldName.."_World.lua") then
            delfile("/BlocksAte/SavedWorlds/"..WorldName.."_World.lua")
            print("Success Deleted File!")
        else
            print("File Didnt Founded!")
        end
    end})
    
while wait(0.1) do
    pcall(function()
        if features["SpeedToggle"] then
            if lp.Character ~= nil and lp.Character.Humanoid ~= nil and lp.Character.Humanoid.Health >= 0 then
                lp.Character.Humanoid.WalkSpeed = features["SpeedValue"]
            end
        else
            if lp.Character ~= nil and lp.Character.Humanoid ~= nil and lp.Character.Humanoid.Health >= 0 then
                lp.Character.Humanoid.WalkSpeed = 16
            end
        end
        if features["JumpToggle"] then
            if lp.Character ~= nil and lp.Character.Humanoid ~= nil and lp.Character.Humanoid.Health >= 0 then
                lp.Character.Humanoid.JumpPower = features["JumpValue"]
            end
        else
            if lp.Character ~= nil and lp.Character.Humanoid ~= nil and lp.Character.Humanoid.Health >= 0 then
                lp.Character.Humanoid.WalkSpeed = 50
            end
        end
    end)
end
