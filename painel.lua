-- By: 〃Yudi | AnG 👼
-- ✅ ANTI LAG REAL | CORES CINZA→VERDE→VERMELHO | ESP DISCRETO
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

-- Reset anterior
if PlayerGui:FindFirstChild("MenuAnG") then
    PlayerGui.MenuAnG:Destroy()
end

-- ⚙️ CONFIGURAÇÕES
-- Estados: 0 = Cinza/Desligado | 1 = Verde/Ligado | 2 = Vermelho/Desligado
local ESTADO_ESP = 0
local ESTADO_ANTILAG = 0

local COR_CINZA = Color3.fromRGB(80, 80, 80)
local COR_VERDE = Color3.new(0, 0.6, 0)
local COR_VERMELHO = Color3.new(0.7, 0, 0)

-- ESP
local COR_DISCRETA = Color3.new(0.95, 0.95, 0.95)
local TRANSPARENCIA = 0.7
local TAMANHO_MINIMO = 2
local Desenhos = {}

-- ✅ COMANDOS
local comandos = {
    "〃zKill | AnG 👼",
    "〃zRender | AnG 👼",
    "〃zFurar Pneu | AnG 👼",
    "〃zLockpick | AnG 👼",
    "〃zKitRepar | AnG 👼",
    "〃PdPerm | AnG 👼",
    "🚀", -- Anti Lag
    "👼"  -- ESP
}

-- 🚀 SISTEMA DE ANTI LAG REAL (FORTE E COM FUNÇÃO DE DESLIGAR)
RunService.Heartbeat:Connect(function()
    pcall(function()
        if ESTADO_ANTILAG == 1 then -- LIGADO (VERDE)
            -- Qualidade mínima absoluta
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            settings().Rendering.LimitFramerate = 0
            settings().Physics.FramerateLimit = 0
            settings().Physics.AllowSleep = true
            settings().Physics.ThrottleAdjustment = 0

            -- Luzes e sombras desligadas
            Lighting.GlobalShadows = false
            Lighting.ShadowSoftness = 0
            Lighting.FogEnd = 0
            Lighting.FogStart = 0
            Lighting.Brightness = 0.1
            Lighting.Ambient = Color3.new(0.2,0.2,0.2)
            Lighting.OutdoorAmbient = Color3.new(0.2,0.2,0.2)

            -- Remoção total de texturas e materiais
            MaterialService:SetBaseMaterial(Enum.Material.Plastic)
            for _, parte in pairs(workspace:GetDescendants()) do
                if parte:IsA("BasePart") then
                    parte.Material = Enum.Material.Plastic
                    parte.TextureID = ""
                    parte.Reflectance = 0
                    parte.CastShadow = false
                    parte.Locked = true
                end
                -- Destrói tudo que consome desempenho
                if parte:IsA("ParticleEmitter") or parte:IsA("Smoke") or parte:IsA("Fire") or parte:IsA("Sparkles") or parte:IsA("Light") 
                or parte:IsA("Decal") or parte:IsA("Texture") or parte:IsA("Trail") or parte:IsA("Beam") then
                    parte:Destroy()
                end
            end

            -- Silenciar sons
            SoundService.Volume = 0
            SoundService.AmbientReverb = Enum.ReverbType.NoReverb

        elseif ESTADO_ANTILAG == 2 then -- DESLIGADO (VERMELHO) - VOLTA AO NORMAL
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level21
            settings().Rendering.LimitFramerate = 60
            settings().Physics.FramerateLimit = 60
            Lighting.GlobalShadows = true
            Lighting.FogEnd = 100000
            Lighting.Brightness = 1
            SoundService.Volume = 1
        end
    end)
end)

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

-- 👼 SISTEMA DE ESP
local function CriarMarcacao(jogador)
    if jogador == LocalPlayer or Desenhos[jogador] then return end
    Desenhos[jogador] = { Ponto = Drawing.new("Circle") }
    local d = Desenhos[jogador]
    d.Ponto.Thickness = 1
    d.Ponto.NumSides = 4
    d.Ponto.Filled = true
    d.Ponto.Transparency = TRANSPARENCIA
end

local function RemoverMarcacao(jogador)
    if Desenhos[jogador] then
        Desenhos[jogador].Ponto:Remove()
        Desenhos[jogador] = nil
    end
end

-- Atualização ESP
RunService.RenderStepped:Connect(function()
    if ESTADO_ESP ~= 1 then -- Se não estiver VERDE/LIGADO, esconde
        for _, desenho in pairs(Desenhos) do
            desenho.Ponto.Visible = false
        end
        return
    end

    for jogador, desenho in pairs(Desenhos) do
        local char = jogador.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
            local hrp = char.HumanoidRootPart
            local posTela, visivel = Camera:WorldToViewportPoint(hrp.Position)

            if visivel then
                desenho.Ponto.Radius = TAMANHO_MINIMO
                desenho.Ponto.Position = Vector2.new(posTela.X, posTela.Y)
                desenho.Ponto.Color = COR_DISCRETA
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

-- 📱 INTERFACE
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

-- 🎛️ CRIAÇÃO DOS BOTÕES COM CICLO CORRETO
local BotaoAntiLag, BotaoESP

for _, comando in ipairs(comandos) do
    local Btn = Instance.new("TextButton")
    Btn.Parent = Scrool
    Btn.Size = UDim2.new(1, -2, 0, 24)
    Btn.BackgroundColor3 = COR_CINZA -- INICIA CINZA COMO PEDIU
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 10
    Btn.Text = comando
    Btn.BorderSizePixel = 0
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)

    -- BOTÃO ANTI LAG 🚀
    if comando == "🚀" then
        BotaoAntiLag = Btn
        Btn.MouseButton1Click:Connect(function()
            if ESTADO_ANTILAG == 0 then -- CINZA → VERDE
                ESTADO_ANTILAG = 1
                Btn.BackgroundColor3 = COR_VERDE
            elseif ESTADO_ANTILAG == 1 then -- VERDE → VERMELHO
                ESTADO_ANTILAG = 2
                Btn.BackgroundColor3 = COR_VERMELHO
            else -- VERMELHO ↔ VERDE (AGORA ALTERNA SEMPRE)
                ESTADO_ANTILAG = ESTADO_ANTILAG == 2 and 1 or 2
                Btn.BackgroundColor3 = ESTADO_ANTILAG == 1 and COR_VERDE or COR_VERMELHO
            end
        end)
    end

    -- BOTÃO ESP 👼
    if comando == "👼" then
        BotaoESP = Btn
        Btn.MouseButton1Click:Connect(function()
            if ESTADO_ESP == 0 then -- CINZA → VERDE
                ESTADO_ESP = 1
                Btn.BackgroundColor3 = COR_VERDE
            elseif ESTADO_ESP == 1 then -- VERDE → VERMELHO
                ESTADO_ESP = 2
                Btn.BackgroundColor3 = COR_VERMELHO
            else -- VERMELHO ↔ VERDE (AGORA ALTERNA SEMPRE)
                ESTADO_ESP = ESTADO_ESP == 2 and 1 or 2
                Btn.BackgroundColor3 = ESTADO_ESP == 1 and COR_VERDE or COR_VERMELHO
            end
        end)
    end

    -- COMANDOS DE CHAT
    if comando ~= "🚀" and comando ~= "👼" then
        Btn.MouseButton1Click:Connect(function()
            EnviarMensagem(comando)
        end)
    end
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