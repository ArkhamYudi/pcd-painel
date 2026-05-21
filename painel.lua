-- By: 〃Yudi | AnG 👼
-- ✅ FUNCIONAL | MOBILE | 👼 SYSTEM
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

-- Configurações Sistema 👼
local SISTEMA_ATIVO = true
local SISTEMA_COR = Color3.new(1, 1, 0)
local Desenhos = {}

-- ✅ COMANDOS
local comandos = {
    "〃zKill | AnG 👼",
    "〃zRender | AnG 👼",
    "〃zFurar Pneu | AnG 👼",
    "〃zLockpick | AnG 👼",
    "〃zKitRepar | AnG 👼",
    "〃zFinalizar | AnG 👼",
    "〃Imobilizar + Segurar | AnG 👼",
    "〃👼 SISTEMA: LIGADO 🟢",
    "〃🎨 Cor Vermelha | AnG 👼",
    "〃🎨 Cor Verde | AnG 👼",
    "〃🎨 Cor Azul | AnG 👼",
    "〃🎨 Cor Roxa | AnG 👼"
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

-- Sistema de rastreamento 👼
local function CriarSistema(jogador)
    if jogador == LocalPlayer or Desenhos[jogador] then return end

    Desenhos[jogador] = {
        Nome = Drawing.new("Text"),
        Caixa = Drawing.new("Square"),
        Linha = Drawing.new("Line")
    }

    local d = Desenhos[jogador]
    d.Nome.Size = 14
    d.Nome.Center = true
    d.Nome.Outline = true
    d.Nome.OutlineColor = Color3.new(0,0,0)

    d.Caixa.Thickness = 2
    d.Caixa.Filled = false

    d.Linha.Thickness = 2
end

local function RemoverSistema(jogador)
    if Desenhos[jogador] then
        for _,obj in pairs(Desenhos[jogador]) do obj:Remove() end
        Desenhos[jogador] = nil
    end
end

-- Atualização
RunService.RenderStepped:Connect(function()
    if not SISTEMA_ATIVO then
        for _,d in pairs(Desenhos) do
            d.Nome.Visible = false
            d.Caixa.Visible = false
            d.Linha.Visible = false
        end
        return
    end

    for jogador, desenho in pairs(Desenhos) do
        local char = jogador.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
            local hrp = char.HumanoidRootPart
            local dist = math.floor((hrp.Position - Camera.CFrame.Position).Magnitude)
            local posTela, visivel = Camera:WorldToViewportPoint(hrp.Position)

            if visivel and char.Humanoid.Health > 0 then
                -- Caixa
                local tam = Vector2.new(22, 35) * (1 / posTela.Z) * 90
                desenho.Caixa.Size = tam
                desenho.Caixa.Position = Vector2.new(posTela.X - tam.X/2, posTela.Y - tam.Y/2)
                desenho.Caixa.Color = SISTEMA_COR
                desenho.Caixa.Visible = true

                -- Linha
                desenho.Linha.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                desenho.Linha.To = Vector2.new(posTela.X, posTela.Y)
                desenho.Linha.Color = SISTEMA_COR
                desenho.Linha.Visible = true

                -- Nome
                desenho.Nome.Text = jogador.Name.." ["..dist.."m]"
                desenho.Nome.Position = Vector2.new(posTela.X, posTela.Y - tam.Y - 10)
                desenho.Nome.Color = SISTEMA_COR
                desenho.Nome.Visible = true
            else
                desenho.Nome.Visible = false
                desenho.Caixa.Visible = false
                desenho.Linha.Visible = false
            end
        else
            desenho.Nome.Visible = false
            desenho.Caixa.Visible = false
            desenho.Linha.Visible = false
        end
    end
end)

Players.PlayerAdded:Connect(CriarSistema)
Players.PlayerRemoving:Connect(RemoverSistema)
for _,p in pairs(Players:GetPlayers()) do task.spawn(CriarSistema, p) end

-- 📱 INTERFACE MOBILE
local gui = Instance.new("ScreenGui")
gui.Name = "MenuAnG"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 250, 0, 340)
frame.Position = UDim2.new(0.1,0,0.15,0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local top = Instance.new("Frame")
top.Parent = frame
top.Size = UDim2.new(1,0,0,38)
top.BackgroundColor3 = Color3.fromRGB(35,35,35)
top.BorderSizePixel = 0
Instance.new("UICorner", top).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel")
title.Parent = top
title.Size = UDim2.new(1,-70,1,0)
title.Position = UDim2.new(0,8,0,0)
title.BackgroundTransparency = 1
title.Text = "👼 MenuAnG"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

local mini = Instance.new("TextButton")
mini.Parent = top
mini.Size = UDim2.new(0,28,0,28)
mini.Position = UDim2.new(1,-60,0,5)
mini.Text = "-"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 18
mini.BackgroundColor3 = Color3.fromRGB(70,70,70)
mini.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

local close = Instance.new("TextButton")
close.Parent = top
close.Size = UDim2.new(0,28,0,28)
close.Position = UDim2.new(1,-30,0,5)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.BackgroundColor3 = Color3.fromRGB(170,40,40)
close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)

local scroll = Instance.new("ScrollingFrame")
scroll.Parent = frame
scroll.Position = UDim2.new(0,4,0,42)
scroll.Size = UDim2.new(1,-8,1,-46)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.CanvasSize = UDim2.new(0,0,0,#comandos * 38)

local layout = Instance.new("UIListLayout")
layout.Parent = scroll
layout.Padding = UDim.new(0,4)

-- 🎛️ BOTÕES
local botaoSistema

for i, cmd in ipairs(comandos) do
    local btn = Instance.new("TextButton")
    btn.Parent = scroll
    btn.Size = UDim2.new(1,-4,0,34)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.Text = cmd
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    if cmd:find("👼 SISTEMA") then
        botaoSistema = btn
        btn.BackgroundColor3 = Color3.new(0, 0.6, 0)
    end

    btn.MouseButton1Click:Connect(function()
        if cmd:find("👼 SISTEMA") then
            SISTEMA_ATIVO = not SISTEMA_ATIVO
            if SISTEMA_ATIVO then
                btn.Text = "〃👼 SISTEMA: LIGADO 🟢"
                btn.BackgroundColor3 = Color3.new(0, 0.6, 0)
            else
                btn.Text = "〃👼 SISTEMA: DESLIGADO 🔴"
                btn.BackgroundColor3 = Color3.new(0.6, 0, 0)
            end
        elseif cmd == "〃🎨 Cor Vermelha | AnG 👼" then
            SISTEMA_COR = Color3.new(1,0,0)
        elseif cmd == "〃🎨 Cor Verde | AnG 👼" then
            SISTEMA_COR = Color3.new(0,1,0)
        elseif cmd == "〃🎨 Cor Azul | AnG 👼" then
            SISTEMA_COR = Color3.new(0,0.5,1)
        elseif cmd == "〃🎨 Cor Roxa | AnG 👼" then
            SISTEMA_COR = Color3.new(0.7,0,1)
        else
            enviarMensagem(cmd)
        end
    end)
end

-- Botão flutuante
local bola = Instance.new("TextButton")
bola.Parent = gui
bola.Size = UDim2.new(0,48,0,48)
bola.Position = UDim2.new(0.05,0,0.75,0)
bola.BackgroundColor3 = Color3.fromRGB(20,20,20)
bola.Text = "👼"
bola.TextColor3 = Color3.new(1,1,1)
bola.Font = Enum.Font.GothamBold
bola.TextSize = 22
bola.Visible = false
bola.Active = true
bola.Draggable = true
bola.BorderSizePixel = 0
Instance.new("UICorner", bola).CornerRadius = UDim.new(1,0)

mini.MouseButton1Click:Connect(function() frame.Visible=false; bola.Visible=true end)
bola.MouseButton1Click:Connect(function() frame.Visible=true; bola.Visible=false end)
close.MouseButton1Click:Connect(function() gui:Destroy(); for _,d in pairs(Desenhos) do RemoverSistema(_) end end)