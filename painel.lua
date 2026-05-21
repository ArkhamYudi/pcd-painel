-- By: 〃Yudi | AnG 👼
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Remove menu antigo
if PlayerGui:FindFirstChild("UFCMenu") then PlayerGui.UFCMenu:Destroy() end

-- ✅ Apenas o que você pediu: principais, sem finalizações
local comandos = {
    "〃Soco Direto | AnG 👼",
    "〃Soco Cruzado | AnG 👼",
    "〃Gancho | AnG 👼",
    "〃Uppercut | AnG 👼",
    "〃Chute | AnG 👼",
    "〃Derrubar | AnG 👼",
    "〃Mata Leão | AnG 👼",
    "〃Chave de Braço | AnG 👼",
    "〃Desmaiar | AnG 👼",
    "〃Imobilizar | AnG 👼"
}

-- Função de envio CORRIGIDA e segura
local function enviarMensagem(msg)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
        else
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
        end
    end)
end

-- Interface completa e estável
local gui = Instance.new("ScreenGui")
gui.Name = "UFCMenu"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,310,0,400)
frame.Position = UDim2.new(0.35,0,0.2,0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local top = Instance.new("Frame")
top.Parent = frame
top.Size = UDim2.new(1,0,0,40)
top.BackgroundColor3 = Color3.fromRGB(35,35,35)
top.BorderSizePixel = 0
Instance.new("UICorner", top).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel")
title.Parent = top
title.Size = UDim2.new(1,-80,1,0)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.Text = "👼 〃 UFC | AnG"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

local mini = Instance.new("TextButton")
mini.Parent = top
mini.Size = UDim2.new(0,30,0,30)
mini.Position = UDim2.new(1,-70,0,5)
mini.Text = "-"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 20
mini.BackgroundColor3 = Color3.fromRGB(70,70,70)
mini.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

local close = Instance.new("TextButton")
close.Parent = top
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.BackgroundColor3 = Color3.fromRGB(170,40,40)
close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)

local scroll = Instance.new("ScrollingFrame")
scroll.Parent = frame
scroll.Position = UDim2.new(0,5,0,45)
scroll.Size = UDim2.new(1,-10,1,-50)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 5
scroll.CanvasSize = UDim2.new(0,0,0,#comandos * 45)

local layout = Instance.new("UIListLayout")
layout.Parent = scroll
layout.Padding = UDim.new(0,5)

-- Botões
for _,cmd in ipairs(comandos) do
    local btn = Instance.new("TextButton")
    btn.Parent = scroll
    btn.Size = UDim2.new(1,-5,0,40)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Text = cmd
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    btn.MouseButton1Click:Connect(function() enviarMensagem(cmd) end)
end

-- Botão flutuante
local bola = Instance.new("TextButton")
bola.Parent = gui
bola.Size = UDim2.new(0,60,0,60)
bola.Position = UDim2.new(0.05,0,0.7,0)
bola.BackgroundColor3 = Color3.fromRGB(20,20,20)
bola.Text = "👼"
bola.TextColor3 = Color3.new(1,1,1)
bola.Font = Enum.Font.GothamBold
bola.TextSize = 28
bola.Visible = false
bola.Active = true
bola.Draggable = true
bola.BorderSizePixel = 0
Instance.new("UICorner", bola).CornerRadius = UDim.new(1,0)

mini.MouseButton1Click:Connect(function() frame.Visible=false; bola.Visible=true end)
bola.MouseButton1Click:Connect(function() frame.Visible=true; bola.Visible=false end)
close.MouseButton1Click:Connect(function() gui:Destroy() end)