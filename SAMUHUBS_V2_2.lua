-- SAMUHUBS V2.2 | Interface para Roblox Studio
-- Coloque como LocalScript em StarterPlayerScripts ou StarterGui.
-- Os toggles de Farm são apenas controles visuais: não automatizam ações no Blox Fruits.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local colors = {
    purple = Color3.fromRGB(151, 83, 255),
    blue = Color3.fromRGB(45, 185, 255),
    cyan = Color3.fromRGB(105, 230, 255),
    dark = Color3.fromRGB(10, 13, 25),
    panel = Color3.fromRGB(18, 25, 43),
    row = Color3.fromRGB(27, 38, 61),
    white = Color3.fromRGB(240, 247, 255),
    muted = Color3.fromRGB(155, 177, 205),
    off = Color3.fromRGB(65, 77, 99),
}

local lowEffects = false
local states = {}

local gui = Instance.new("ScreenGui")
gui.Name = "SAMUHUBS"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local function round(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
    return c
end

local function outline(obj, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness
    s.Transparency = transparency or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = obj
    return s
end

local function addGradient(obj, first, second, rotation)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, first),
        ColorSequenceKeypoint.new(1, second),
    })
    g.Rotation = rotation or 0
    g.Parent = obj
    return g
end

local function dragify(handle, target)
    local dragging = false
    local startPos
    local startInput

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startInput = input.Position
            startPos = target.Position
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - startInput
            target.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- Botão flutuante
local mini = Instance.new("TextButton")
mini.Name = "FloatingSH"
mini.Size = UDim2.fromOffset(58, 58)
mini.Position = UDim2.new(0, 25, 0.5, -29)
mini.BackgroundColor3 = colors.purple
mini.Text = "SH"
mini.TextColor3 = colors.white
mini.TextSize = 21
mini.Font = Enum.Font.GothamBlack
mini.AutoButtonColor = true
mini.Parent = gui
round(mini, 20)
outline(mini, colors.cyan, 2.5)
addGradient(mini, colors.blue, colors.purple, 45)
dragify(mini, mini)

-- Janela principal
local main = Instance.new("Frame")
main.Name = "MainWindow"
main.Size = UDim2.fromOffset(590, 435)
main.Position = UDim2.new(0.5, -295, 0.5, -217)
main.BackgroundColor3 = colors.dark
main.Visible = false
main.Parent = gui
round(main, 20)
local mainStroke = outline(main, colors.cyan, 2.5)

local scale = Instance.new("UIScale")
scale.Scale = 1
scale.Parent = main

-- Cabeçalho
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 58)
header.BackgroundColor3 = colors.panel
header.Parent = main
round(header, 18)
addGradient(header, Color3.fromRGB(26, 39, 70), Color3.fromRGB(37, 25, 65), 0)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -75, 1, 0)
title.Position = UDim2.fromOffset(17, 0)
title.BackgroundTransparency = 1
title.Text = "✦  SAMUHUBS  |  BLOX FRUITS"
title.TextColor3 = colors.white
title.Font = Enum.Font.GothamBlack
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local titleAccent = Instance.new("Frame")
titleAccent.Size = UDim2.new(0, 4, 0, 28)
titleAccent.Position = UDim2.fromOffset(8, 15)
titleAccent.BackgroundColor3 = colors.cyan
titleAccent.Parent = header
round(titleAccent, 4)

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(34, 34)
close.Position = UDim2.new(1, -45, 0, 12)
close.BackgroundColor3 = Color3.fromRGB(80, 42, 73)
close.Text = "×"
close.TextColor3 = colors.white
close.TextSize = 23
close.Font = Enum.Font.GothamBold
close.Parent = header
round(close, 11)
outline(close, colors.purple, 1)
dragify(header, main)

-- Barra lateral
local sidebar = Instance.new("ScrollingFrame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.fromOffset(10, 68)
sidebar.Size = UDim2.new(0, 158, 1, -78)
sidebar.BackgroundColor3 = colors.panel
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 4
sidebar.ScrollBarImageColor3 = colors.blue
sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
sidebar.Parent = main
round(sidebar, 15)
outline(sidebar, Color3.fromRGB(48, 92, 135), 1)

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 7)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

local sidePadding = Instance.new("UIPadding")
sidePadding.PaddingTop = UDim.new(0, 10)
sidePadding.PaddingBottom = UDim.new(0, 10)
sidePadding.PaddingLeft = UDim.new(0, 8)
sidePadding.PaddingRight = UDim.new(0, 8)
sidePadding.Parent = sidebar

-- Área de conteúdo
local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.Position = UDim2.fromOffset(178, 68)
content.Size = UDim2.new(1, -188, 1, -78)
content.BackgroundColor3 = colors.panel
content.BorderSizePixel = 0
content.ScrollBarThickness = 5
content.ScrollBarImageColor3 = colors.cyan
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.Parent = main
round(content, 15)
outline(content, Color3.fromRGB(48, 92, 135), 1)

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 9)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = content

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 12)
padding.PaddingLeft = UDim.new(0, 12)
padding.PaddingRight = UDim.new(0, 12)
padding.PaddingBottom = UDim.new(0, 12)
padding.Parent = content

-- Categorias: a nova aba Farm contém as três opções pedidas.
local categories = {
    "Main", "Farm", "Farming", "Teleport", "Combat",
    "Fruits", "Raids", "Weapons", "Settings", "Miscellaneous",
}

local categoryItems = {
    Main = {"Bem-vindo ao SAMUHUBS", "Interface para Blox Fruits", "Versão 2.2"},
    Farm = {"Farm Chest", "Farm Boss", "Farm Material"},
    Farming = {"Auto Farm Level", "Auto Mastery", "Auto Money", "Auto Berry"},
    Teleport = {"Teleport Menu", "Fruit Tracker"},
    Combat = {"Auto Kill Player", "Auto Bounty", "Auto Buso Haki", "Auto Observation Haki"},
    Fruits = {"Auto Spin", "Auto Fruit Finder"},
    Raids = {"Auto Raid", "Auto Factory", "Auto Sea Beast"},
    Weapons = {"Auto CDK", "Auto TTK", "Auto Mini Yoru"},
    Miscellaneous = {"Informações da interface"},
}

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("GuiObject") and child ~= contentLayout and child ~= padding then
            child:Destroy()
        end
    end
end

local function addTitle(text, color)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -5, 0, 34)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or colors.cyan
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = content
    return label
end

local function addInfo(text)
    local box = Instance.new("TextLabel")
    box.Size = UDim2.new(1, -5, 0, 58)
    box.BackgroundColor3 = colors.row
    box.Text = text
    box.TextColor3 = colors.muted
    box.TextSize = 11
    box.Font = Enum.Font.Gotham
    box.TextWrapped = true
    box.TextXAlignment = Enum.TextXAlignment.Left
    box.Parent = content
    round(box, 11)
    local p = Instance.new("UIPadding")
    p.PaddingLeft = UDim.new(0, 11)
    p.PaddingRight = UDim.new(0, 11)
    p.Parent = box
end

local function addToggle(name)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -5, 0, 48)
    row.BackgroundColor3 = colors.row
    row.Parent = content
    round(row, 13)
    outline(row, Color3.fromRGB(45, 83, 119), 1, 0.35)

    local label = Instance.new("TextLabel")
    label.Position = UDim2.fromOffset(12, 0)
    label.Size = UDim2.new(1, -78, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = colors.white
    label.TextSize = 12
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.Parent = row

    local switch = Instance.new("TextButton")
    switch.Size = UDim2.fromOffset(42, 23)
    switch.Position = UDim2.new(1, -53, 0.5, -11)
    switch.BackgroundColor3 = colors.off
    switch.Text = ""
    switch.Parent = row
    round(switch, 20)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.fromOffset(17, 17)
    dot.Position = UDim2.fromOffset(3, 3)
    dot.BackgroundColor3 = colors.white
    dot.Parent = switch
    round(dot, 20)

    states[name] = false
    switch.MouseButton1Click:Connect(function()
        states[name] = not states[name]
        local enabled = states[name]
        local switchColor = enabled and colors.blue or colors.off
        local dotPosition = enabled and UDim2.fromOffset(22, 3) or UDim2.fromOffset(3, 3)

        if name == "Modo leve da interface" then
            lowEffects = enabled
        end

        if lowEffects then
            switch.BackgroundColor3 = switchColor
            dot.Position = dotPosition
        else
            TweenService:Create(switch, TweenInfo.new(0.16), {BackgroundColor3 = switchColor}):Play()
            TweenService:Create(dot, TweenInfo.new(0.16), {Position = dotPosition}):Play()
        end
    end)
end

local function showCategory(category)
    clearContent()
    addTitle(string.upper(category))

    if category == "Settings" then
        addTitle("TAMANHO DA INTERFACE")
        local sizes = {
            {"PEQUENO - 80%", 0.8},
            {"NORMAL - 100%", 1},
            {"GRANDE - 115%", 1.15},
        }
        for _, data in ipairs(sizes) do
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, -5, 0, 40)
            b.BackgroundColor3 = Color3.fromRGB(39, 75, 112)
            b.Text = data[1]
            b.TextColor3 = colors.white
            b.Font = Enum.Font.GothamBold
            b.TextSize = 12
            b.Parent = content
            round(b, 12)
            outline(b, colors.blue, 1)
            b.MouseButton1Click:Connect(function()
                scale.Scale = data[2]
            end)
        end
        addTitle("DESEMPENHO")
        addToggle("Modo leve da interface")
        addInfo("O modo leve reduz animações desta interface. Ele não altera os gráficos nem garante aumento de FPS no jogo.")
        return
    end

    if category == "Farm" then
        addInfo("Opções de interface para Farm. Os controles abaixo ainda não executam automação no jogo.")
    elseif category == "Miscellaneous" then
        addInfo("SAMUHUBS V2.2 — interface visual. Use recursos autorizados pelo criador da experiência.")
    end

    for _, name in ipairs(categoryItems[category] or {}) do
        if category == "Main" or category == "Miscellaneous" then
            addTitle(name, colors.white)
        else
            addToggle(name)
        end
    end

    if category == "Farm" then
        addInfo("Farm Chest, Farm Boss e Farm Material estão adicionados como opções visuais. A lógica de jogo precisa ser implementada pelo desenvolvedor da experiência no Roblox Studio.")
    end
end

-- Botões de categoria
local selectedButton
for index, category in ipairs(categories) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 39)
    button.BackgroundColor3 = Color3.fromRGB(29, 43, 67)
    button.Text = category
    button.TextColor3 = colors.white
    button.TextSize = 12
    button.Font = Enum.Font.GothamBold
    button.TextTruncate = Enum.TextTruncate.AtEnd
    button.LayoutOrder = index
    button.Parent = sidebar
    round(button, 11)
    outline(button, Color3.fromRGB(49, 93, 137), 1, 0.4)

    button.MouseButton1Click:Connect(function()
        if selectedButton then
            selectedButton.BackgroundColor3 = Color3.fromRGB(29, 43, 67)
        end
        selectedButton = button
        button.BackgroundColor3 = Color3.fromRGB(48, 104, 157)
        showCategory(category)
    end)
end

-- Abrir / fechar
mini.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
    if main.Visible then
        showCategory("Main")
    end
end)

close.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- Pulso discreto na borda neon
if not lowEffects then
    task.spawn(function()
        while gui.Parent do
            TweenService:Create(mainStroke, TweenInfo.new(1.2), {Transparency = 0.15}):Play()
            task.wait(1.2)
            if not gui.Parent then break end
            TweenService:Create(mainStroke, TweenInfo.new(1.2), {Transparency = 0.45}):Play()
            task.wait(1.2)
        end
    end)
end

showCategory("Main")
print("SAMUHUBS V2.2 LOADED!")
