-- By: 〃Yudi | AnG 👼
-- ✅ VERSÃO FINAL | 100% FUNCIONAL | MINIMALISTA
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
local COR_ROXA = Color3.new(0.7, 0, 1) -- Cor única
local Desenhos = {}

-- ✅ COMANDOS (sem os que pediu para remover)
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

-- Sistema de marcação (SÓ CÍRCULO ROXO)
local function CriarMarcacao(jogador)
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
    d.Circulo.NumSides = 32
end

local function RemoverMarcacao(jogador)
    if Desenhos[jogador] then
        Desenhos[jogador].Nome:Remove()
        Desenhos[jogador].Circulo:Remove()
        Desenhos[jogador] = nil
    end
end

-- Atualização
RunService.RenderStepped:Connect(function()
    if not SISTEMA_ATIVO then
        for _, desenho in pairs(Desenhos) do
            desenho.Nome.Visible = false
            desenho.Circulo.Visible = false
        end
        return
    end

    for jogador, desenho in pairs(Desenhos) do
        local char = jogador.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
            local hrp = char.HumanoidRootPart
            local posTela, visivel = Camera:WorldToViewportPoint(hrp.Position)

            if visivel and char.Humanoid.Health > 0 then
                -- Círculo roxo
                local raio = 30 / posTela.Z * 70
                desenho.Circulo.Radius = raio
                desenho.Circulo.Position = Vector2.new(posTela.X, posTela.Y)
                desenho.Circulo.Color = COR_ROXA
                desenho.Circulo.Visible = true

                -- Nome
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

Players.PlayerAdded:Connect(CriarMarcacao)
Players.PlayerRemoving:Connect(RemoverMarcacao)
for _, p in pairs(Players:GetPlayers()) do
    task.spawn(CriarMarcacao, p)
end

-- 📱 INTERFACE PEQUENA E LIMPA
local Gui = Instance.new("ScreenGui")
Gui.Name = "MenuAnG"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Parent = Gui
Frame.Size = UDim2.new(0, 170, 0, 230) -- Tamanho mínimo
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

-- 🎛️ CRIAÇÃO DOS BOTÕES
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

    -- Botão especial do anjo
    if comando == "👼" then
        BotaoAnjo = Btn
        Btn.BackgroundColor3 = Color3.new(0, 0.6, 0) -- Começa verde
    end

    Btn.MouseButton1Click:Connect(function()
        if comando == "👼" then
            SISTEMA_ATIVO = not SISTEMA_ATIVO
            -- Muda cor só, sem texto
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

-- Ações dos botões
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