-- By: 〃Yudi | AnG 👼
-- ✅ MAIS MINIMALISTA | MENU COMPACTO | BOTÕES ROLAVEIS
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

-- ⚙️ CONFIGS
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

-- ✅ COMANDOS (AGORA OS BOTÕES FICAM NO FINAL, SÓ ROLAR PRA BAIXO)
local comandos = {
    "〃zKill | AnG 👼",
    "〃zRender | AnG 👼",
    "〃zFurar Pneu | AnG 👼",
    "〃zLockpick | AnG 👼",
    "〃zKitRepar | AnG 👼",
    "〃Imobilizar + Segurar | AnG 👼",
    "🚀", -- Anti Lag (rolar pra baixo)
    "👼"  -- ESP (rolar pra baixo)
}

-- 🚀 ANTI LAG POTENTE
local function AtivarAntiLag()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.LimitFramerate = 0
    settings().Physics.FramerateLimit = 0
    settings().Physics.AllowSleep = true

    Lighting.GlobalShadows = false
    Lighting.FogEnd = 0
    Lighting.Brightness = 0.1
    Lighting.Ambient = Color3.new(0.2,0.2,0.2)

    MaterialService:SetBaseMaterial(Enum.Material.Plastic)
    for _, obj in pairs(workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.Plastic
                obj.TextureID = ""
                obj.Reflectance = 0
                obj.CastShadow = false
            end
            if obj:IsA("ParticleEmitter") or obj:IsA("Light") or obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("Trail") then
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
        if ESTADO_ANTILAG == 1 then AtivarAntiLag()
        elseif ESTADO_ANTILAG == 2 then DesativarAntiLag() end
    end)
end)

-- 📨 ENVIAR MENSAGEM
local function EnviarMensagem(msg)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
        else
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
        end
    end)
end

-- 👼 ESP DISCRETO
local function CriarMarcacao(jogador)
    if jogador == LocalPlayer or Desenhos[jogador] then return end
    Desenhos[jogador]={Ponto=Drawing.new("Circle")}
    local d=Desenhos[jogador]
    d.Ponto.Thickness=1 d.Ponto.NumSides=4 d.Ponto.Filled=true d.Ponto.Transparency=TRANSPARENCIA
end
local function RemoverMarcacao(jogador) if Desenhos[jogador] then Desenhos[jogador].Ponto:Remove() Desenhos[jogador]=nil end end

RunService.RenderStepped:Connect(function()
    if ESTADO_ESP~=1 then for _,d in pairs(Desenhos)do d.Ponto.Visible=false end return end
    for jogador,d in pairs(Desenhos)do
        local c=jogador.Character
        if c and c:FindFirstChild("HumanoidRootPart") and c.Humanoid.Health>0 then
            local pos,vis=Camera:WorldToViewportPoint(c.HumanoidRootPart.Position)
            if vis then d.Ponto.Radius=TAMANHO_MINIMO d.Ponto.Position=Vector2.new(pos.X,pos.Y) d.Ponto.Color=COR_DISCRETA d.Ponto.Visible=true
            else d.Ponto.Visible=false end
        else d.Ponto.Visible=false end
    end
end)

Players.PlayerAdded:Connect(CriarMarcacao) Players.PlayerRemoving:Connect(RemoverMarcacao)
for _,p in pairs(Players:GetPlayers())do task.spawn(CriarMarcacao,p)end

-- 📱 INTERFACE MAIS MINIMALISTA E MENOR
local Gui=Instance.new("ScreenGui") Gui.Name="MenuAnG" Gui.ResetOnSpawn=false Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling Gui.Parent=PlayerGui

-- TAMANHO REDUZIDO
local Frame=Instance.new("Frame") Frame.Parent=Gui Frame.Size=UDim2.new(0, 150, 0, 200) -- MENOR TAMANHO
Frame.Position=UDim2.new(0.05,0,0.2,0) Frame.BackgroundColor3=Color3.fromRGB(18,18,18) Frame.BorderSizePixel=0 Frame.Active=true Frame.Draggable=true Instance.new("UICorner",Frame).CornerRadius=UDim.new(0,8)

local Topo=Instance.new("Frame") Topo.Parent=Frame Topo.Size=UDim2.new(1,0,0,24) Topo.BackgroundColor3=Color3.fromRGB(30,30,30) Topo.BorderSizePixel=0 Instance.new("UICorner",Topo).CornerRadius=UDim.new(0,8)
local Titulo=Instance.new("TextLabel") Titulo.Parent=Topo Titulo.Size=UDim2.new(1,-35,1,0) Titulo.Position=UDim2.new(0,4,0,0) Titulo.BackgroundTransparency=1 Titulo.Text="👼 AnG" Titulo.TextColor3=Color3.new(1,1,1) Titulo.Font=Enum.Font.GothamBold Titulo.TextSize=11 Titulo.TextXAlignment=Enum.TextXAlignment.Left

local BotaoMinimizar=Instance.new("TextButton") BotaoMinimizar.Parent=Topo BotaoMinimizar.Size=UDim2.new(0,18,0,18) BotaoMinimizar.Position=UDim2.new(1,-32,0,3) BotaoMinimizar.Text="-" BotaoMinimizar.Font=Enum.Font.GothamBold BotaoMinimizar.TextSize=11 BotaoMinimizar.BackgroundColor3=Color3.fromRGB(60,60,60) BotaoMinimizar.TextColor3=Color3.new(1,1,1) Instance.new("UICorner",BotaoMinimizar).CornerRadius=UDim.new(1,0)
local BotaoFechar=Instance.new("TextButton") BotaoFechar.Parent=Topo BotaoFechar.Size=UDim2.new(0,18,0,18) BotaoFechar.Position=UDim2.new(1,-17,0,3) BotaoFechar.Text="X" BotaoFechar.Font=Enum.Font.GothamBold BotaoFechar.TextSize=10 BotaoFechar.BackgroundColor3=Color3.fromRGB(150,30,30) BotaoFechar.TextColor3=Color3.new(1,1,1) Instance.new("UICorner",BotaoFechar).CornerRadius=UDim.new(1,0)

local Scrool=Instance.new("ScrollingFrame") Scrool.Parent=Frame Scrool.Position=UDim2.new(0,2,0,26) Scrool.Size=UDim2.new(1,-4,1,-28) Scrool.BackgroundTransparency=1 Scrool.BorderSizePixel=0 Scrool.ScrollBarThickness=2 Scrool.CanvasSize=UDim2.new(0,0,0,#comandos*24)
local Layout=Instance.new("UIListLayout") Layout.Parent=Scrool Layout.Padding=UDim.new(0,2)

-- 🎛️ BOTÕES
for _,comando in ipairs(comandos)do
    local Btn=Instance.new("TextButton") Btn.Parent=Scrool Btn.Size=UDim2.new(1,-2,0,22) Btn.BackgroundColor3=COR_CINZA Btn.TextColor3=Color3.new(1,1,1) Btn.Font=Enum.Font.Gotham Btn.TextSize=9 Btn.Text=comando Btn.BorderSizePixel=0 Instance.new("UICorner",Btn).CornerRadius=UDim.new(0,3)

    if comando=="🚀"then
        Btn.MouseButton1Click:Connect(function()
            if ESTADO_ANTILAG==0 then ESTADO_ANTILAG=1 Btn.BackgroundColor3=COR_VERDE
            elseif ESTADO_ANTILAG==1 then ESTADO_ANTILAG=2 Btn.BackgroundColor3=COR_VERMELHO
            else ESTADO_ANTILAG=ESTADO_ANTILAG==2 and 1 or 2 Btn.BackgroundColor3=ESTADO_ANTILAG==1 and COR_VERDE or COR_VERMELHO end
        end)
    elseif comando=="👼"then
        Btn.MouseButton1Click:Connect(function()
            if ESTADO_ESP==0 then ESTADO_ESP=1 Btn.BackgroundColor3=COR_VERDE
            elseif ESTADO_ESP==1 then ESTADO_ESP=2 Btn.BackgroundColor3=COR_VERMELHO
            else ESTADO_ESP=ESTADO_ESP==2 and 1 or 2 Btn.BackgroundColor3=ESTADO_ESP==1 and COR_VERDE or COR_VERMELHO end
        end)
    else
        Btn.MouseButton1Click:Connect(function() EnviarMensagem(comando) end)
    end
end

-- BOTÃO FLUTUANTE PEQUENO
local BotaoFlutuante=Instance.new("TextButton") BotaoFlutuante.Parent=Gui BotaoFlutuante.Size=UDim2.new(0,30,0,30) BotaoFlutuante.Position=UDim2.new(0.05,0,0.75,0) BotaoFlutuante.BackgroundColor3=Color3.fromRGB(18,18,18) BotaoFlutuante.Text="👼" BotaoFlutuante.TextColor3=Color3.new(1,1,1) BotaoFlutuante.Font=Enum.Font.GothamBold BotaoFlutuante.TextSize=13 BotaoFlutuante.Visible=false BotaoFlutuante.Active=true BotaoFlutuante.Draggable=true BotaoFlutuante.BorderSizePixel=0 Instance.new("UICorner",BotaoFlutuante).CornerRadius=UDim.new(1,0)

BotaoMinimizar.MouseButton1Click:Connect(function() Frame.Visible=false BotaoFlutuante.Visible=true end)
BotaoFlutuante.MouseButton1Click:Connect(function() Frame.Visible=true BotaoFlutuante.Visible=false end)
BotaoFechar.MouseButton1Click:Connect(function() Gui:Destroy() for _,d in pairs(Desenhos)do RemoverMarcacao(_)end end)