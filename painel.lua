-- Spam Mobile V1 + Extras | by: <@1348448457303654501>
-- ✅ MINIMALISTA | MENU COMPACTO | BOTÕES ROLAVEIS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local MaterialService = game:GetService("MaterialService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- Resetar versão anterior
if PlayerGui:FindFirstChild("MenuAnG") then
    PlayerGui.MenuAnG:Destroy()
end

-- ⚙️ CONFIGURAÇÕES
local ESTADO_ESP = 0
local ESTADO_ANTILAG = 0
local COR_CINZA = Color3.fromRGB(70, 70, 70)
local COR_VERDE = Color3.new(0, 0.65, 0)
local COR_VERMELHO = Color3.new(0.75, 0, 0)

-- Configurações ESP
local COR_ESP = Color3.new(0.9, 0.9, 0.9)
local TRANSPARENCIA_ESP = 0.75
local TAMANHO_ESP = 2
local Desenhos = {}

-- 📋 LISTA DE ITENS (Os botões 🚀 e 👼 estão NO FINAL, só rolar pra baixo)
local ItensMenu = {
    "🥊 //Mat",
    "🥊 //Render",
    "🥊 //Furar Pneu",
    "🥊 //Kit Repar",
    "🥊 //Lockpick",
    "🥊 //Imobilizar",
    "🚀 AntiLag", -- <-- Rolar pra baixo
    "👼 ESP"     -- <-- Rolar pra baixo
}

-- 🚀 SISTEMA ANTI LAG OTIMIZADO
local function AtivarAntiLag()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Physics.FramerateLimit = 0
    settings().Physics.AllowSleep = true

    Lighting.GlobalShadows = false
    Lighting.FogEnd = 0
    Lighting.Brightness = 0.2
    Lighting.Ambient = Color3.new(0.15, 0.15, 0.15)

    MaterialService:SetBaseMaterial(Enum.Material.Plastic)
    for _, obj in pairs(workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.Plastic
                obj.TextureID = ""
                obj.Reflectance = 0
                obj.CastShadow = false
            end
            if obj:IsA("ParticleEmitter") or obj:IsA("Light") or obj:IsA("Decal") or obj:IsA("Trail") then
                obj:Destroy()
            end
        end)
    end

    SoundService.Volume = 0
end

local function DesativarAntiLag()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level21
    Lighting.GlobalShadows = true
    Lighting.FogEnd = 100000
    Lighting.Brightness = 1
    SoundService.Volume = 1
end

RunService.Heartbeat:Connect(function()
    pcall(function()
        if ESTADO_ANTILAG == 1 then
            AtivarAntiLag()
        elseif ESTADO_ANTILAG == 2 then
            DesativarAntiLag()
        end
    end)
end)

-- 📨 FUNÇÃO DE ENVIAR MENSAGENS
local function EnviarMensagem(msg)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
        else
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
        end
    end)
end

-- 👼 SISTEMA ESP CAMUFLADO
local function CriarMarcacao(jogador)
    if jogador == LocalPlayer or Desenhos[jogador] then return end
    Desenhos[jogador] = { Ponto = Drawing.new("Circle") }
    local d = Desenhos[jogador]
    d.Ponto.Thickness = 1
    d.Ponto.NumSides = 4
    d.Ponto.Filled = true
    d.Ponto.Transparency = TRANSPARENCIA_ESP
end

local function RemoverMarcacao(jogador)
    if Desenhos[jogador] then
        Desenhos[jogador].Ponto:Remove()
        Desenhos[jogador] = nil
    end
end

RunService.RenderStepped:Connect(function()
    if ESTADO_ESP ~= 1 then
        for _, v in pairs(Desenhos) do v.Ponto.Visible = false end
        return
    end
    for jogador, dados in pairs(Desenhos) do
        local char = jogador.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char.Humanoid.Health > 0 then
            local posTela, visivel = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
            if visivel then
                dados.Ponto.Radius = TAMANHO_ESP
                dados.Ponto.Position = Vector2.new(posTela.X, posTela.Y)
                dados.Ponto.Color = COR_ESP
                dados.Ponto.Visible = true
            else
                dados.Ponto.Visible = false
            end
        else
            dados.Ponto.Visible = false
        end
    end
end)

Players.PlayerAdded:Connect(CriarMarcacao)
Players.PlayerRemoving:Connect(RemoverMarcacao)
for _, p in pairs(Players:GetPlayers()) do task.spawn(CriarMarcacao, p) end

-- 📱 INTERFACE - AGORA BEM MENOR E MINIMALISTA
local Gui = Instance.new("ScreenGui")
Gui.Name = "MenuAnG"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

-- TAMANHO REDUZIDO AO MÁXIMO
local Frame = Instance.new("Frame")
Frame.Parent = Gui
Frame.Size = UDim2.new(0, 140, 0, 180) -- Menor tamanho possível
Frame.Position = UDim2.new(0.04, 0, 0.15, 0)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 7)

-- BARRA SUPERIOR
local Topo = Instance.new("Frame")
Topo.Parent = Frame
Topo.Size = UDim2.new(1, 0, 0, 22)
Topo.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Topo.BorderSizePixel = 0
Instance.new("UICorner", Topo).CornerRadius = UDim.new(0, 7)

local Titulo = Instance.new("TextLabel")
Titulo.Parent = Topo
Titulo.Size = UDim2.new(1, -30, 1, 0)
Titulo.Position = UDim2.new(0, 4, 0, 0)
Titulo.BackgroundTransparency = 1
Titulo.Text = "👼 AnG Mobile"
Titulo.TextColor3 = Color3.new(1, 1, 1)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 10
Titulo.TextXAlignment = Enum.TextXAlignment.Left

local BtnMin = Instance.new("TextButton")
BtnMin.Parent = Topo
BtnMin.Size = UDim2.new(0, 16, 0, 16)
BtnMin.Position = UDim2.new(1, -28, 0, 3)
BtnMin.Text = "-"
BtnMin.Font = Enum.Font.GothamBold
BtnMin.TextSize = 10
BtnMin.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
BtnMin.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", BtnMin).CornerRadius = UDim.new(1, 0)

local BtnFechar = Instance.new("TextButton")
BtnFechar.Parent = Topo
BtnFechar.Size = UDim2.new(0, 16, 0, 16)
BtnFechar.Position = UDim2.new(1, -14, 0, 3)
BtnFechar.Text = "X"
BtnFechar.Font = Enum.Font.GothamBold
BtnFechar.TextSize = 9
BtnFechar.BackgroundColor3 = Color3.fromRGB(140, 20, 20)
BtnFechar.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", BtnFechar).CornerRadius = UDim.new(1, 0)

-- ÁREA ROLÁVEL
local Scrool = Instance.new("ScrollingFrame")
Scrool.Parent = Frame
Scrool.Position = UDim2.new(0, 2, 0, 24)
Scrool.Size = UDim2.new(1, -4, 1, -26)
Scrool.BackgroundTransparency = 1
Scrool.BorderSizePixel = 0
Scrool.ScrollBarThickness = 2
Scrool.CanvasSize = UDim2.new(0, 0, 0, #ItensMenu * 22)

local Layout = Instance.new("UIListLayout")
Layout.Parent = Scrool
Layout.Padding = UDim.new(0, 2)

-- 🎛️ CRIAÇÃO DOS BOTÕES
for _, nomeItem in ipairs(ItensMenu) do
    local Botao = Instance.new("TextButton")
    Botao.Parent = Scrool
    Botao.Size = UDim2.new(1, -2, 0, 20)
    Botao.BackgroundColor3 = COR_CINZA -- Começa cinza
    Botao.TextColor3 = Color3.new(1, 1, 1)
    Botao.Font = Enum.Font.Gotham
    Botao.TextSize = 9
    Botao.Text = nomeItem
    Botao.BorderSizePixel = 0
    Instance.new("UICorner", Botao).CornerRadius = UDim.new(0, 3)

    -- LÓGICA ANTI LAG 🚀
    if nomeItem == "🚀 AntiLag" then
        Botao.MouseButton1Click:Connect(function()
            if ESTADO_ANTILAG == 0 then
                ESTADO_ANTILAG = 1
                Botao.BackgroundColor3 = COR_VERDE
            elseif ESTADO_ANTILAG == 1 then
                ESTADO_ANTILAG = 2
                Botao.BackgroundColor3 = COR_VERMELHO
            else
                ESTADO_ANTILAG = (ESTADO_ANTILAG == 2) and 1 or 2
                Botao.BackgroundColor3 = (ESTADO_ANTILAG == 1) and COR_VERDE or COR_VERMELHO
            end
        end)
    -- LÓGICA ESP 👼
    elseif nomeItem == "👼 ESP" then
        Botao.MouseButton1Click:Connect(function()
            if ESTADO_ESP == 0 then
                ESTADO_ESP = 1
                Botao.BackgroundColor3 = COR_VERDE
            elseif ESTADO_ESP == 1 then
                ESTADO_ESP = 2
                Botao.BackgroundColor3 = COR_VERMELHO
            else
                ESTADO_ESP = (ESTADO_ESP == 2) and 1 or 2
                Botao.BackgroundColor3 = (ESTADO_ESP == 1) and COR_VERDE or COR_VERMELHO
            end
        end)
    -- COMANDOS DE CHAT
    else
        Botao.MouseButton1Click:Connect(function() EnviarMensagem(nomeItem) end)
    end
end

-- BOTÃO FLUTUANTE PEQUENO
local BtnFlutuante = Instance.new("TextButton")
BtnFlutuante.Parent = Gui
BtnFlutuante.Size = UDim2.new(0, 28, 0, 28)
BtnFlutuante.Position = UDim2.new(0.04, 0, 0.7, 0)
BtnFlutuante.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
BtnFlutuante.Text = "👼"
BtnFlutuante.TextColor3 = Color3.new(1, 1, 1)
BtnFlutuante.Font = Enum.Font.GothamBold
BtnFlutuante.TextSize = 12
BtnFlutuante.Visible = false
BtnFlutuante.Active = true
BtnFlutuante.Draggable = true
BtnFlutuante.BorderSizePixel = 0
Instance.new("UICorner", BtnFlutuante).CornerRadius = UDim.new(1, 0)

-- AÇÕES DOS BOTÕES DE CONTROLE
BtnMin.MouseButton1Click:Connect(function() Frame.Visible = false BtnFlutuante.Visible = true end)
BtnFlutuante.MouseButton1Click:Connect(function() Frame.Visible = true BtnFlutuante.Visible = false end)
BtnFechar.MouseButton1Click:Connect(function() Gui:Destroy() for _, v in pairs(Desenhos) do RemoverMarcacao(_) end end)