-- By: 〃Yudi | AnG 👼
-- ✅ VERSÃO FINAL | MINIMALISTA | SÓ 👼 | ROXO
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- Reset menu antigo
if PlayerGui:FindFirstChild("MenuAnG") then
    PlayerGui.MenuAnG:Destroy()
end

-- Configurações
local SISTEMA_ATIVO = true
local COR_ROXA = Color3.new(0.7, 0, 1) -- Cor única
local Desenhos = {}

-- ✅ LISTA DE COMANDOS (sem finalizar, só o necessário)
local comandos = {
    "〃zKill | AnG 👼",
    "〃zRender | AnG 👼",
    "〃zFurar Pneu | AnG 👼",
    "〃zLockpick | AnG 👼",
    "〃zKitRepar | AnG 👼",
    "〃Imobilizar + Segurar | AnG 👼",
    "👼" -- SÓ O ANJO, SEM NADA MAIS
}

-- Função de enviar mensagem
local function enviarMensagem(msg)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
        else
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
        end
    end)
end

-- Sistema de marcação (APENAS CÍRCULO ROXO)
local function CriarMarcação(jogador)
    if jogador == LocalPlayer or Desenhos[jogador] then return end

    Desenhos[jogador] = {
        Nome = Drawing.new("Text"),
        Circulo = Drawing.new("Circle")
    }

    local d = Desenhos[jogador]
    d.Nome.Size = 12
    d.Nome.Center = true
    d.Nome.Outline = true
    d.Nome.OutlineColor = Color3.new(0,0,0)

    d.Circulo.Thickness = 2
    d.Circulo.NumSides = 32 -- Círculo perfeito
end

local function RemoverMarcação(jogador)
    if Desenhos[jogador] then
        Desenhos[jogador].Nome:Remove()
        Desenhos[jogador].Circulo:Remove()
        Desenhos[jogador] = nil
    end
end

-- Atualização em tempo real
RunService.RenderStepped:Connect(function()
    if not SISTEMA_ATIVO then
        for _,d in pairs(Desenhos) do
            d.Nome.Visible = false
            d.Circulo.Visible = false
        end
        return
    end

    for jogador, desenho in pairs(Desenhos) do
        local char = jogador.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
            local hrp = char.HumanoidRootPart
            local posTela, visivel = Camera:WorldToViewportPoint(hrp.Position)

            if visivel and char.Humanoid.Health > 0 then
                -- Círculo roxo ao redor
                local raio = 30 / posTela.Z * 70
                desenho.Circulo.Radius = raio
                desenho.Circulo.Position = Vector2.new(posTela.X, posTela.Y)
                desenho.Circulo.Color = COR_ROXA
                desenho.Circulo.Visible = true

                -- Nome em cima
                desenho.Nome.Text = jogador.Name
                desenho.Nome.Position = Vector2.new(posTela.X, posTela.Y - raio - 8)
                desenho.Nome.Color = COR_ROXA
                desenho.Nome.Visible = true
            else
                desenho.Nome.Visible = false
                desenho.Circulo.Visible = false
            end
        else
            desenho.Nome.Visible = false
            desenho.Circulo.Visible = false
        end
    end
end)

Players.PlayerAdded:Connect(CriarMarcação)
Players.PlayerRemoving:Connect(RemoverMarcação)
for _,p in pairs(Players:GetPlayers()) do task.spawn(CriarMarcação, p) end

-- 📱 INTERFACE SUPER PEQUENA (MINIMALISTA)
local gui = Instance.new("ScreenGui")
gui.Name = "MenuAnG"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 170, 0, 230) -- TAMANHO MÍNIMO
frame.Position = UDim2.new(0.05,0,0.2,0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)

local top = Instance.new("Frame")
top.Parent = frame
top.Size = UDim2.new(1,0,0,28)
top.BackgroundColor3 = Color3.fromRGB(35,35,35)
top.BorderSizePixel = 0
Instance.new("UICorner", top).CornerRadius = UDim.new(0,10)

local title = Instance.new("TextLabel")
title.Parent = top
title.Size = UDim2.new(1,-40,1,0)
title.Position = UDim2.new(0,5,0,0)
title.BackgroundTransparency = 1
title.Text = "👼 MenuAnG"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextXAlignment = Enum.TextXAlignment.Left

local mini = Instance.new("TextButton")
mini.Parent = top
mini.Size = UDim2.new(0,20,0,20)
mini.Position = UDim2.new(1,-42,0,4)
mini.Text = "-"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 12
mini.BackgroundColor3 = Color3.fromRGB(70,70,70)
mini.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

local close = Instance.new("TextButton")
close.Parent = top
close.Size = UDim2.new(0,20,0,20)
close.Position = UDim2.new(1,-21,0,4)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 11
close.BackgroundColor3 = Color3.fromRGB(170,40,40)
close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)

local scroll = Instance.new("ScrollingFrame")
scroll.Parent = frame
scroll.Position = UDim2.new(0,2,0,30)
scroll.Size = UDim2.new(1,-4,1,-32)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 2
scroll.CanvasSize = UDim2.new(0,0,0,#comandos * 26)

local layout = Instance.new("UIListLayout")
layout.Parent = scroll
layout.Padding = UDim.new(0,2)

-- 🎛️ BOTÕES
local botaoAnjo

for i, cmd in ipairs(comandos) do
    local btn = Instance.new("TextButton")
    btn.Parent = scroll
    btn.Size = UDim2.new(1,-2,0,24)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 10
    btn.Text = cmd
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,4)

    -- Botão especial do anjo
    if cmd == "👼" then
        botaoAnjo = btn
        btn.BackgroundColor3 = Color3.new(0, 0.6, 0) -- Começa verde
    end

    btn.MouseButton1Click:Connect(function()
        if cmd == "👼" then
            -- Liga/Desliga só mudando cor
            SISTEMA_ATIVO = not SISTEMA_ATIVO
            btn.BackgroundColor3 = SISTEMA_ATIVO and Color3.new(0, 0.6, 0) or Color3.new(0.6, 0, 0)
        else
            enviarMensagem(cmd)
        end
    end)
end

-- Botão flutuante pequeno
local bola = Instance.new("TextButton")
bola.Parent = gui
bola.Size = UDim2.new(0,34,0,34)
bola.Position = UDim2.new(0.05,0,0.75,0)
bola.BackgroundColor3 = Color3.fromRGB(20,20,20)
bola.Text = "👼"
bola.TextColor3 = Color3.new(1,1,1)
bola.Font = Enum.Font.GothamBold
bola.TextSize = 15
bola.Visible = false
bola.Active = true
bola.Draggable = true
bola.BorderSizePixel = 0
Instance.new("UICorner", bola).CornerRadius = UDim.new(1,0)

mini.MouseButton1Click:Connect(function() frame.Visible=false; bola.Visible=true end)
bola.MouseButton1Click:Connect(function() frame.Visible=true; bola.Visible=false end)
close.MouseButton1Click:Connect(function() gui:Destroy(); for _,d in pairs(Desenhos) do RemoverMarcação(_) end end)