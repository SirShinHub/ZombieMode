local ESPNUM = true -- Toggle for displaying chest distances

function updateESP()
  local player = game.Players.LocalPlayer

  -- Loop through egg nodes
  for i, v in pairs(game:GetService("Workspace").Interactions.Interactions.Eggs.ActiveNodes:GetChildren()) do
    local modelName = v.Name
    local color = Color3.fromRGB(255, 0, 0) -- Change color for eggs

    if not v:FindFirstChild("gui") then
      -- Create ESP label for new eggs
      local gui = Instance.new("BillboardGui", v)
      gui.Name = "gui"
      gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
      gui.Active = true
      gui.AlwaysOnTop = true
      gui.LightInfluence = 1.000
      gui.Size = UDim2.new(0, 150, 0, 100)

      local esp = Instance.new("TextLabel", gui)
      esp.Name = "esp"
      esp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      esp.BackgroundTransparency = 1.000
      esp.Position = UDim2.new(0.0860000029, 0, 0.123000003, 0)
      esp.Size = UDim2.new(0, 100, 0, 100)
      esp.Font = Enum.Font.FredokaOne
      esp.Text = modelName
      esp.TextScaled = false
      esp.TextSize = 15.000
      esp.TextStrokeTransparency = 0.000
      esp.TextWrapped = false
      esp.TextColor3 = color
    else
      -- Update existing ESP labels with distance
      local distance = (v.Position - player.Character.HumanoidRootPart.Position).Magnitude
      v.gui.esp.Text = modelName .. "\n[ " .. math.floor(distance) .. " studs ]"
    end
  end

  -- Loop through chest nodes (optional)
  if ESPNUM then
    for i, v in pairs(game:GetService("Workspace").Interactions.Nodes.Treasure:GetChildren()) do
      if tonumber(v.Name) ~= nil then
        local modelName = "Empty"
        local color = Color3.fromRGB(236, 0, 255)

        for _, model in pairs(v:GetChildren()) do
          if model:IsA("Model") and (model.Name == "BronzeChest" or model.Name == "SilverChest" or model.Name == "GoldChest") then
            modelName = model.Name
            if modelName == "BronzeChest" then
              color = Color3.fromRGB(218, 113, 41)
            elseif modelName == "SilverChest" then
              color = Color3.fromRGB(0, 247, 255)
            elseif modelName == "GoldChest" then
              color = Color3.fromRGB(250, 201, 0)
            end

            -- Check if the chest is opened
            if model:FindFirstChild("HumanoidRootPart") and model.HumanoidRootPart.Dead.Value then
                modelName = "Opened"
                color = Color3.fromRGB(255, 0, 0)
              end
              break
            end
          end
    
          -- Create ESP label for new chests
          if not v:FindFirstChild("gui") then
            local gui = Instance.new("BillboardGui", v)
            gui.Name = "gui"
            gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            gui.Active = true
            gui.AlwaysOnTop = true
            gui.LightInfluence = 1.000
            gui.Size = UDim2.new(0, 150, 0, 100)
    
            local esp = Instance.new("TextLabel", gui)
            esp.Name = "esp"
            esp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            esp.BackgroundTransparency = 1.000
            esp.Position = UDim2.new(0.0860000029, 0, 0.123000003, 0)
            esp.Size = UDim2.new(0, 100, 0, 100)
            esp.Font = Enum.Font.FredokaOne
            esp.Text = modelName
            esp.TextScaled = false
            esp.TextSize = 15.000
            esp.TextStrokeTransparency = 0.000
            esp.TextWrapped = false
            esp.TextColor3 = color
          else
            -- Update existing ESP labels with distance
            local distance = (v.Position - player.Character.HumanoidRootPart.Position).Magnitude
            v.gui.esp.Text = modelName .. "\n[ " .. math.floor(distance) .. " studs ]"
          end
        end
      end
    
      -- Destroy any existing ESP labels for chests that are no longer present
      else
        for i,v in pairs(game:GetService("Workspace").Interactions.Nodes.Treasure:GetChildren()) do
          if v:FindFirstChild("gui") then
            v:FindFirstChild("gui"):Destroy()
          end
        end
      end
    end
    
    local RunService = game:GetService("RunService")
    RunService.RenderStepped:Connect(updateESP)
