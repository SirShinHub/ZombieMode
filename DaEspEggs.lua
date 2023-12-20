local RunService = game:GetService("RunService")

local ESPNUM = true

local function updateESP()
    local success, error = pcall(function()
        if ESPNUM then
            local player = game.Players.LocalPlayer

            for i,v in pairs(game:GetService("Workspace").Interactions.Nodes.Eggs.ActiveNodes:GetChildren()) do
                for j,k in pairs(v:GetChildren()) do
                    if k.Name == "EggModel" then
                        local modelPrimaryPart = k.PrimaryPart
                        if not k:FindFirstChild("gui") and modelPrimaryPart then
                            local gui = Instance.new("BillboardGui", k)
                            gui.Name = "gui"
                            gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            gui.Active = true
                            gui.AlwaysOnTop = true
                            gui.LightInfluence = 1.000
                            gui.Size = UDim2.new(0, 120, 0, 100)
                            
                            local esp = Instance.new("TextLabel", gui)
                            esp.Name = "esp"
                            esp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            esp.BackgroundTransparency = 1.000
                            esp.Position = UDim2.new(0.0860000029, 0, 0.123000003, 0)
                            esp.Size = UDim2.new(0, 100, 0, 100)
                            esp.Font = Enum.Font.FredokaOne
                            esp.TextScaled = false
                            esp.TextSize = 15.000
                            esp.TextStrokeTransparency = 0.000
                            esp.TextWrapped = false
                            esp.TextColor3 = Color3.fromRGB(255, 255, 50)
                            
                            esp.Text = "Eggs" -- ตั้งชื่อของ Label เป็น "Eggs"
                        elseif modelPrimaryPart then
                            local distance = (modelPrimaryPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                            if k:FindFirstChild("gui") and k.gui:FindFirstChild("esp") then
                                k.gui.esp.Text = "Eggs\n[ " .. math.floor(distance) .." studs ]" -- แสดงชื่อและระยะทางใน Label
                            end
                        end
                    end
                end
            end
        else
            for i,v in pairs(game:GetService("Workspace").Interactions.Nodes.Eggs.ActiveNodes:GetChildren()) do
                if v:FindFirstChild("gui") then
                    v:FindFirstChild("gui"):Destroy()
                end
            end
        end
    end)

    if not success then
        warn("Error occurred: ", error)
    end
end

RunService.RenderStepped:Connect(updateESP)
