local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

--// DESTRUIR SE JÁ EXISTIR
if PlayerGui:FindFirstChild("PCDMENU") then
    PlayerGui.PCDMENU:Destroy()
end

--// COMANDOS ATUALIZADOS 😭🤣✅
local comandos = {
    "/ ' nao chorax 😭🥹🥹😢✌️",
    "/ ' nao caga 🥷🏼🥷🏼🥊👿",
    "/ ' city booy 🚬😎🔥🤙",
    "/ ' e o pix? 💸💸😤😡🚫",
    "/ ' mals ae 😬🙏🙏💀💀",
    "/ ' say walahi bro 🗣️🗣️🙏🙏😤🔥",
    "/ ' skibidi 📺📺🔊🔊😈💀🔥",
    "/ ' ez 😂😂😎✌️💅💅",
    "/ ' Sigma boy 🗿🗿😎😈🔥🤙",
    "/ ' tuff dms tropa 💪💪😤😤🔥🚫",
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

--// FRAME PRINCIPAL
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 320, 0, 420)
frame.Position = UDim2.new(0.35, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(120, 0, 0)
frame.Active = true
frame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = frame

--// BARRA SUPERIOR
local top = Instance.new("Frame")
top.Parent = frame
top.Size = UDim2.new(1, 0, 0, 42)
top.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
top.BorderSizePixel = 0

local UICornerTop = Instance.new("UICorner")
UICornerTop.CornerRadius = UDim.new(0, 14)
UICornerTop.Parent = top

--// TÍTULO
local title = Instance.new("TextLabel")
title.Parent = top
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "😭 PCDMENU 😭"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 19
title.TextXAlignment = Enum.TextXAlignment.Left

--// BOTÃO MINIMIZAR
local mini = Instance.new("TextButton")
mini.Parent = top
mini.Size = UDim2.new(0, 32, 0, 32)
mini.Position = UDim2.new(1, -72, 0, 5)
mini.Text = "-"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 22
mini.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
mini.TextColor3 = Color3.new(1, 1, 1)

local UICornerMini = Instance.new("UICorner")
UICornerMini.CornerRadius = UDim.new(1, 0)
UICornerMini.Parent = mini

--// BOTÃO FECHAR
local close = Instance.new("TextButton")
close.Parent = top
close.Size = UDim2.new(0, 32, 0, 32)
close.Position = UDim2.new(1, -37, 0, 5)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 17
close.BackgroundColor3 = Color3.fromRGB(220, 20, 20)
close.TextColor3 = Color3.new(1, 1, 1)

local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(1, 0)
UICornerClose.Parent = close

--// ÁREA DE ROLAGEM
local scroll = Instance.new("ScrollingFrame")
scroll.Parent = frame
scroll.Position = UDim2.new(0, 6, 0, 47)
scroll.Size = UDim2.new(1, -12, 1, -52)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 5
scroll.ScrollBarImageColor3 = Color3.fromRGB(150, 0, 0)
scroll.CanvasSize = UDim2.new(0, 0, 0, #comandos * 46)

--// ORGANIZAÇÃO DOS BOTÕES
local layout = Instance.new("UIListLayout")
layout.Parent = scroll
layout.Padding = UDim.new(0, 6)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--// CRIAR BOTÕES DE COMANDO
for _, cmd in ipairs(comandos) do
    local btn = Instance.new("TextButton")
    btn.Parent = scroll
    btn.Size = UDim2.new(1, -8, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Text = cmd
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(90, 0, 0)
    btn.AutoButtonColor = false

    local UICornerBtn = Instance.new("UICorner")
    UICornerBtn.CornerRadius = UDim.new(0, 10)
    UICornerBtn.Parent = btn

    --// EFEITO DE PASSAR O MOUSE
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

--// BOTÃO FLUTUANTE (QUANDO MINIMIZADO)
local bola = Instance.new("TextButton")
bola.Parent = gui
bola.Size = UDim2.new(0, 65, 0, 65)
bola.Position = UDim2.new(0.05, 0, 0.7, 0)
bola.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
bola.BorderSizePixel = 2
bola.BorderColor3 = Color3.fromRGB(150, 0, 0)
bola.Text = "😭"
bola.TextColor3 = Color3.new(1, 1, 1)
bola.Font = Enum.Font.GothamBold
bola.TextSize = 32
bola.Visible = false
bola.Active = true
bola.Draggable = true

local UICornerBola = Instance.new("UICorner")
UICornerBola.CornerRadius = UDim.new(1, 0)
UICornerBola.Parent = bola

--// AÇÕES DOS BOTÕES
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
