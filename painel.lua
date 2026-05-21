-- By: 〃Yudi | AnG 👼
-- ✅ PONTO BRANCO MINÚSCULO | DISCRETO
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- Reset anterior
if PlayerGui:FindFirstChild("MenuAnG") then
    PlayerGui.MenuAnG:Destroy()
end

-- Configurações
local SISTEMA_ATIVO = true
local COR_BRANCA = Color3.new(1, 1, 1) -- Branco
local TAMANHO_PONTO = 2 -- TAMANHO MÍNIMO, SÓ UM PONTO
local Desenhos = {}

-- ✅ COMANDOS
local comandos = {
    "〃zKill | AnG 👼",
    "〃zRender | AnG 👼",
    "〃zFurar Pneu | AnG 👼",
    "〃zLockpick | AnG 👼",
    "〃zKitRepar | AnG 👼",
    "〃Imobilizar + Segurar | AnG 👼",
    "👼" -- Botão só com emoji
}

-- Função enviar mensagem
local function EnviarMensagem(msg)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
        else
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
        end
    end)
end

-- Sistema de marcação → AGORA É SÓ UM PONTO BRANCO PEQUENO
local function CriarMarcacao(jogador)
    if jogador == LocalPlayer or Desenhos[jogador] then return end

    Desenhos[jogador] = {
        Ponto = Drawing.new("Circle") -- Agora é ponto pequeno
    }

    local d = Desenhos[jogador]
    d.Ponto.Thickness = 1
    d.Ponto.NumSides = 16 -- Deixa redondo mas pequeno
end

local function RemoverMarcacao(jogador)
    if Desenhos[jogador] then
        Desenhos[jogador].Ponto:Remove()
        Desenhos[jogador] = nil
    end
end

-- Atualização
RunService.RenderStepped:Connect(function()
    if not SISTEMA_ATIVO then
        for _, desenho in pairs(Desenhos) do
            desenho.Ponto.Visible = false
        end
        return
    end

    for jogador, desenho in pairs(Desenhos) do
        local char = jogador.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
            local hrp = char.HumanoidRootPart
            local posTela, visivel = Camera:WorldToViewportPoint(hrp.Position)

            if visivel and char.Humanoid.Health > 0 then
                -- 🎯 SÓ O PONTO BRANCO MINÚSCULO
                desenho.Ponto.Radius = TAMANHO_PONTO -- Tamanho mínimo
                desenho.Ponto.Position = Vector2.new(posTela.X, posTela.Y)
                desenho.Ponto.Color = COR_BRANCA
                desenho.Ponto.Visible = true
            else
                desenho.Ponto.Visible = false
            end
        else
            desenho.Ponto.Visible = false
        end
    end
end)

Players.PlayerAdded:Connect(CriarMarcacao)
Players.PlayerRemoving:Connect(RemoverMarcacao)
for _, p in pairs(Players:GetPlayers()) do
    task.spawn(CriarMarcacao, p)
end

-- 📱 INTERFACE IGUAL A ANTES
local Gui = Instance.new("ScreenGui")
Gui.Name = "MenuAnG"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Parent = Gui
Frame.Size = UDim2.new(0, 170, 0, 230)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

local Topo = Instance.new("Frame")
Topo.Parent = Frame
Topo.Size = UDim2.new(1, 0, 0, 28)
Topo.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Topo.BorderSizePixel = 0
Instance.new("UICorner", Topo).CornerRadius = UDim.new(0, 10)

local Titulo = Instance.new("TextLabel")
Titulo.Parent = Topo
Titulo.Size = UDim2.new(1, -40, 1, 0)
Titulo.Position = UDim2.new(0, 5, 0, 0)
Titulo.BackgroundTransparency = 1
Titulo.Text = "👼 MenuAnG"
Titulo.TextColor3 = Color3.new(1, 1, 1)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 12
Titulo.TextXAlignment = Enum.TextXAlignment.Left

local BotaoMinimizar = Instance.new("TextButton")
BotaoMinimizar.Parent = Topo
BotaoMinimizar.Size = UDim2.new(0, 20, 0, 20)
BotaoMinimizar.Position = UDim2.new(1, -42, 0, 4)
BotaoMinimizar.Text = "-"
BotaoMinimizar.Font = Enum.Font.GothamBold
BotaoMinimizar.TextSize = 12
BotaoMinimizar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
BotaoMinimizar.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", BotaoMinimizar).CornerRadius = UDim.new(1, 0)

local BotaoFechar = Instance.new("TextButton")
BotaoFechar.Parent = Topo
BotaoFechar.Size = UDim2.new(0, 20, 0, 20)
BotaoFechar.Position = UDim2.new(1, -21, 0, 4)
BotaoFechar.Text = "X"
BotaoFechar.Font = Enum.Font.GothamBold
BotaoFechar.TextSize = 11
BotaoFechar.BackgroundColor3 = Color3.fromRGB(170, 40, 40)
BotaoFechar.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", BotaoFechar).CornerRadius = UDim.new(1, 0)

local Scrool = Instance.new("ScrollingFrame")
Scrool.Parent = Frame
Scrool.Position = UDim2.new(0, 2, 0, 30)
Scrool.Size = UDim2.new(1, -4, 1, -32)
Scrool.BackgroundTransparency = 1
Scrool.BorderSizePixel = 0
Scrool.ScrollBarThickness = 2
Scrool.CanvasSize = UDim2.new(0, 0, 0, #comandos * 26)

local Layout = Instance.new("UIListLayout")
Layout.Parent = Scrool
Layout.Padding = UDim.new(0, 2)

-- 🎛️ BOTÕES
local BotaoAnjo

for _, comando in ipairs(comandos) do
    local Btn = Instance.new("TextButton")
    Btn.Parent = Scrool
    Btn.Size = UDim2.new(1, -2, 0, 24)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 10
    Btn.Text = comando
    Btn.BorderSizePixel = 0
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)

    if comando == "👼" then
        BotaoAnjo = Btn
        Btn.BackgroundColor3 = Color3.new(0, 0.6, 0)
    end

    Btn.MouseButton1Click:Connect(function()
        if comando == "👼" then
            SISTEMA_ATIVO = not SISTEMA_ATIVO
            Btn.BackgroundColor3 = SISTEMA_ATIVO and Color3.new(0, 0.6, 0) or Color3.new(0.6, 0, 0)
        else
            EnviarMensagem(comando)
        end
    end)
end

-- Botão flutuante
local BotaoFlutuante = Instance.new("TextButton")
BotaoFlutuante.Parent = Gui
BotaoFlutuante.Size = UDim2.new(0, 34, 0, 34)
BotaoFlutuante.Position = UDim2.new(0.05, 0, 0.75, 0)
BotaoFlutuante.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
BotaoFlutuante.Text = "👼"
BotaoFlutuante.TextColor3 = Color3.new(1, 1, 1)
BotaoFlutuante.Font = Enum.Font.GothamBold
BotaoFlutuante.TextSize = 15
BotaoFlutuante.Visible = false
BotaoFlutuante.Active = true
BotaoFlutuante.Draggable = true
BotaoFlutuante.BorderSizePixel = 0
Instance.new("UICorner", BotaoFlutuante).CornerRadius = UDim.new(1, 0)

BotaoMinimizar.MouseButton1Click:Connect(function()
    Frame.Visible = false
    BotaoFlutuante.Visible = true
end)

BotaoFlutuante.MouseButton1Click:Connect(function()
    Frame.Visible = true
    BotaoFlutuante.Visible = false
end)

BotaoFechar.MouseButton1Click:Connect(function()
    Gui:Destroy()
    for _, desenho in pairs(Desenhos) do
        RemoverMarcacao(_)
    end
end)