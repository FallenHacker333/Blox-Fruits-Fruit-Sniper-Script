-- سكربت أسطوري لتجميع الفواكه في Blox Fruits - مع واجهة تحكم GUI
-- يعمل على Arceus X وExecutors الشبيهة

local SelectedFruits = {
    ["All"] = true, -- اجمع كل الفواكه
    ["Leopard"] = true,
    ["Dragon"] = true,
    ["Dough"] = true,
    ["Light"] = true,
    ["Magma"] = true
}

getgenv().FruitSniperActive = false
local TotalCollected = 0

-- واجهة GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FruitSniperGUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 180)
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Fruit Sniper - Blox Fruits"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.TextScaled = true

local ToggleBtn = Instance.new("TextButton", Frame)
ToggleBtn.Size = UDim2.new(0, 200, 0, 40)
ToggleBtn.Position = UDim2.new(0, 25, 0, 40)
ToggleBtn.Text = "تشغيل التجميع"
ToggleBtn.TextScaled = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ToggleBtn.TextColor3 = Color3.new(1,1,1)

local CollectedLabel = Instance.new("TextLabel", Frame)
CollectedLabel.Size = UDim2.new(1, -20, 0, 30)
CollectedLabel.Position = UDim2.new(0, 10, 0, 130)
CollectedLabel.Text = "الفواكه المجمعة: 0"
CollectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CollectedLabel.BackgroundTransparency = 1
CollectedLabel.TextScaled = true

-- تشغيل/إيقاف
ToggleBtn.MouseButton1Click:Connect(function()
    getgenv().FruitSniperActive = not getgenv().FruitSniperActive
    ToggleBtn.Text = getgenv().FruitSniperActive and "إيقاف التجميع" or "تشغيل التجميع"
    ToggleBtn.BackgroundColor3 = getgenv().FruitSniperActive and Color3.fromRGB(170, 0, 0) or Color3.fromRGB(0, 170, 0)
end)

-- تجميع الفواكه تلقائيًا
spawn(function()
    while true do
        if getgenv().FruitSniperActive then
            for _, fruit in pairs(workspace:GetDescendants()) do
                if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
                    local name = fruit.Name
                    if SelectedFruits["All"] or SelectedFruits[name] then
                        pcall(function()
                            local char = game.Players.LocalPlayer.Character
                            char.HumanoidRootPart.CFrame = fruit.Handle.CFrame + Vector3.new(0, 3, 0)
                            wait(0.2)
                            firetouchinterest(char.HumanoidRootPart, fruit.Handle, 0)
                            firetouchinterest(char.HumanoidRootPart, fruit.Handle, 1)
                            TotalCollected += 1
                            CollectedLabel.Text = "الفواكه المجمعة: " .. TotalCollected
                            game.StarterGui:SetCore("SendNotification", {
                                Title = "تم التقاط فاكهة!";
                                Text = name;
                                Duration = 3;
                            })
                        end)
                    end
                end
            end
        end
        wait(2)
    end
end)
