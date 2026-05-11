--// SERVIÇOS
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

--// DESTRUIR SE JÁ EXISTIR
if PlayerGui:FindFirstChild("PCDMENU") then
    PlayerGui.PCDMENU:Destroy()
end

--// COMANDOS ATUALIZADOS (SEUS NOVOS) ✅
local comandos = {
    "/ ' nao chorax 😭🥹😢✌️",
    "/ ' nao caga 🥷🏼🥊👿",
    "/ ' city booy 😎🔥🤙💨",
    "/ ' siquis sevi 😏😏💅💅🔥",
    "/ ' Que W 🗿🗿😎😎🤙🔥",
    "/ ' say walahi bro 🗣️🙏😤🔥",
    "/ ' skibidi 📺🔊😈💀🔥",
    "/ ' ez 😂😎✌️💅",
    "/ ' Sigma boy 🗿😎😈🤙🔥",
    "/ ' tuff dms tropa 💪💪😤😤🗿🚀",
}

--// FUNÇÃO ENVIAR MENSAGEM
local function enviarMensagem(msg)
    if not msg or msg == "" then return end
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
        else
            game:GetService("ReplicatedStorage")
                .DefaultChatSystemChatEvents
                .SayMessageRequest:FireServer(msg, "All")
        end
    end)
end

--// GUI PRINCIPAL
local gui = Instance.new("ScreenGui")
gui.Name = "PCDMENU"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PlayerGui

--// FRAME PRINCIPAL → TAMANHO PEQUENO (110 DE LARGURA) + ESTÉTICA DO SEU MODELO
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 110, 0, 0) -- LARGURA PEQUENA, ALTURA AJUSTA DEPOIS
frame.Position = UDim2.new(0.38, 0, 0.22, 0)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10) -- FUNDO PRETO IGUAL
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(120, 0, 0) -- BORDA VERMELHA
frame.Active = true
frame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14) -- CANTOS ARREDONDADOS
UICorner.Parent = frame

--// BARRA SUPERIOR IGUAL
local top = Instance.new("Frame")
top.Parent = frame
top.Size = UDim2.new(1, 0, 0, 42)
top.BackgroundColor3 = Color3.fromRGB(140, 0, 0) -- VERMELHO
top.BorderSizePixel = 0

local UICornerTop = Instance.new("UICorner")
UICornerTop.CornerRadius = UDim.new(0, 14)
UICornerTop.Parent = top

--// TÍTULO
local title = Instance.new("TextLabel")
title.Parent = top
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 6, 0, 0)
title.BackgroundTransparency = 1
title.Text = "😭 PCD 😭"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 12
title.TextXAlignment = Enum.TextXAlignment.Left

--// BOTÃO MINIMIZAR
local mini = Instance.new("TextButton")
mini.Parent = top
mini.Size = UDim2.new(0, 22, 0, 22)
mini.Position = UDim2.new(1, -44, 0, 10)
mini.Text = "-"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 16
mini.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
mini.TextColor3 = Color3.new(1, 1, 1)

local UICornerMini = Instance.new("UICorner")
UICornerMini.CornerRadius = UDim.new(1, 0)
UICornerMini.Parent = mini

--// BOTÃO FECHAR
local close = Instance.new("TextButton")
close.Parent = top
close.Size = UDim2.new(0, 22, 0, 22)
close.Position = UDim2.new(1, -24, 0, 10)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 12
close.BackgroundColor3 = Color3.fromRGB(220, 20, 20)
close.TextColor3 = Color3.new(1, 1, 1)

local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(1, 0)
UICornerClose.Parent = close

--// ÁREA DE ROLAGEM
local scroll = Instance.new("ScrollingFrame")
scroll.Parent = frame
scroll.Position = UDim2.new(0, 4, 0, 47)
scroll.Size = UDim2.new(1, -8, 1, -52)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = Color3.fromRGB(150, 0, 0)
scroll.CanvasSize = UDim2.new(0, 0, 0, #comandos * 32)

--// ORGANIZAÇÃO
local layout = Instance.new("UIListLayout")
layout.Parent = scroll
layout.Padding = UDim.new(0, 4)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--// CRIAR BOTÕES → ESTÉTICA IGUAL, MAS MENORES
for _, cmd in ipairs(comandos) do
    local btn = Instance.new("TextButton")
    btn.Parent = scroll
    btn.Size = UDim2.new(1, -6, 0, 28)
    btn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.Text = cmd
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(90, 0, 0)
    btn.AutoButtonColor = false

    local UICornerBtn = Instance.new("UICorner")
    UICornerBtn.CornerRadius = UDim.new(0, 8)
    UICornerBtn.Parent = btn

    --// EFEITO DE PASSAR O MOUSE → IGUAL O SEU
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(110, 0, 0)
        btn.TextColor3 = Color3.fromRGB(255, 255, 0)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
        btn.TextColor3 = Color3.new(1, 1, 1)
    end)

    --// AO CLICAR
    btn.MouseButton1Click:Connect(function()
        enviarMensagem(cmd)
    end)
end

--// AJUSTA ALTURA FINAL DO PAINEL
frame.Size = UDim2.new(0, 110, 0, 47 + (#comandos * 32) + 6)

--// BOTÃO FLUTUANTE (QUANDO MINIMIZADO)
local bola = Instance.new("TextButton")
bola.Parent = gui
bola.Size = UDim2.new(0, 50, 0, 50)
bola.Position = UDim2.new(0.05, 0, 0.7, 0)
bola.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
bola.BorderSizePixel = 2
bola.BorderColor3 = Color3.fromRGB(150, 0, 0)
bola.Text = "😭"
bola.TextColor3 = Color3.new(1, 1, 1)
bola.Font = Enum.Font.GothamBold
bola.TextSize = 24
bola.Visible = false
bola.Active = true
bola.Draggable = true

local UICornerBola = Instance.new("UICorner")
UICornerBola.CornerRadius = UDim.new(1, 0)
UICornerBola.Parent = bola

--// AÇÕES
mini.MouseButton1Click:Connect(function()
    frame.Visible = false
    bola.Visible = true
end)

bola.MouseButton1Click:Connect(function()
    frame.Visible = true
    bola.Visible = false
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
