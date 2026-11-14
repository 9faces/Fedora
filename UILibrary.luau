-- █████▒▓█████ ▓█████▄  ▒█████   ██▀███   ▄▄▄      
-- ▓██   ▒ ▓█   ▀ ▒██▀ ██▌▒██▒  ██▒▓██ ▒ ██▒▒████▄    
-- ▒████ ░ ▒███   ░██   █▌▒██░  ██▒▓██ ░▄█ ▒▒██  ▀█▄  
-- ░▓█▒  ░ ▒▓█  ▄ ░▓█▄   ▌▒██   ██░▒██▀▀█▄  ░██▄▄▄▄██ 
-- ░▒█░    ░▒████▒░▒████▓ ░ ████▓▒░░██▓ ▒██▒ ▓█   ▓██▒
--  ▒ ░    ░░ ▒░ ░ ▒▒▓  ▒ ░ ▒░▒░▒░ ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░
--  ░       ░ ░  ░ ░ ▒  ▒   ░ ▒ ▒░   ░▒ ░ ▒░  ▒   ▒▒ ░
--  ░ ░       ░    ░ ░  ░ ░ ░ ░ ▒    ░░   ░   ░   ▒   
--            ░  ░   ░        ░ ░     ░           ░  ░
--                 ░                                  
--  ▄████▄   ██░ ██ ▓█████ ▄▄▄     ▄▄▄█████▓  ██████  
-- ▒██▀ ▀█  ▓██░ ██▒▓█   ▀▒████▄   ▓  ██▒ ▓▒▒██    ▒  
-- ▒▓█    ▄ ▒██▀▀██░▒███  ▒██  ▀█▄ ▒ ▓██░ ▒░░ ▓██▄    
-- ▒▓▓▄ ▄██▒░▓█ ░██ ▒▓█  ▄░██▄▄▄▄██░ ▓██▓ ░   ▒   ██▒ 
-- ▒ ▓███▀ ░░▓█▒░██▓░▒████▒▓█   ▓██▒ ▒██▒ ░ ▒██████▒▒ 
-- ░ ░▒ ▒  ░ ▒ ░░▒░▒░░ ▒░ ░▒▒   ▓▒█░ ▒ ░░   ▒ ▒▓▒ ▒ ░ 
--   ░  ▒    ▒ ░▒░ ░ ░ ░  ░ ▒   ▒▒ ░   ░    ░ ░▒  ░ ░ 
-- ░         ░  ░░ ░   ░    ░   ▒    ░      ░  ░  ░   
-- ░ ░       ░  ░  ░   ░  ░     ░  ░              ░   
-- ░

-- roof dweleleras (do NOT ask)
-- this file is a ui library and i forgot what else to say
-- made with hate

-- services
local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local TweenService     = game:GetService("TweenService")
local TextService      = game:GetService("TextService")

local LocalPlayer = Players.LocalPlayer

local function GetGuiParent()
    local fn = rawget(getfenv(), "gethui")
    if type(fn) == "function" then
        local ok, res = pcall(fn)
        if ok and res then return res end
    end
    return LocalPlayer:WaitForChild("PlayerGui")
end

-- colors palette
local Col = {
    Bg     = Color3.fromRGB(6, 6, 6),
    Panel  = Color3.fromRGB(14, 14, 14),
    Panel2 = Color3.fromRGB(22, 22, 22),
    Panel3 = Color3.fromRGB(30, 30, 30),
    Line   = Color3.fromRGB(48, 48, 48),
    Line2  = Color3.fromRGB(70, 70, 70),
    Accent = Color3.fromRGB(255, 255, 255),
    Text   = Color3.fromRGB(242, 242, 242),
    Sub    = Color3.fromRGB(150, 150, 150),
    Muted  = Color3.fromRGB(100, 100, 100),
    Off    = Color3.fromRGB(38, 38, 38),
    Dark   = Color3.fromRGB(8, 8, 8),
}

-- little gremlin helpers
local function Make(Class, Props, Parent)
    local Obj = Instance.new(Class)
    for K, V in next, Props do
        if K ~= "Parent" then Obj[K] = V end
    end
    if Parent then Obj.Parent = Parent end
    return Obj
end

local function Corner(Obj, R)
    return Make("UICorner", { CornerRadius = UDim.new(0, R or 6) }, Obj)
end

local function Stroke(Obj, C, T, Mode)
    return Make("UIStroke", {
        Color = C or Col.Line,
        Thickness = T or 1,
        ApplyStrokeMode = Mode or Enum.ApplyStrokeMode.Border,
    }, Obj)
end

local function TweenObj(Obj, Info, Props)
    return TweenService:Create(Obj, Info, Props)
end

local function Notify(Title, Desc, Duration)
    Duration = Duration or 5
    local existing = LocalPlayer.PlayerGui:FindFirstChild("FedoraNotify")
    if existing then existing:Destroy() end

    local Ngui = Make("ScreenGui", {
        Name = "FedoraNotify", IgnoreGuiInset = true,
        ResetOnSpawn = false, DisplayOrder = 2000,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    Ngui.Parent = GetGuiParent()

    local Box = Make("Frame", {
        Size = UDim2.fromOffset(320, 0),
        Position = UDim2.new(0, 16, 1, 60),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Col.Panel,
        BorderSizePixel = 0, ClipsDescendants = true,
    }, Ngui)
    Corner(Box, 10)
    Stroke(Box, Col.Line2, 1)

    local Accent = Make("Frame", {
        Size = UDim2.fromOffset(3, 0),
        BackgroundColor3 = Col.Accent, BorderSizePixel = 0,
    }, Box)
    Corner(Accent, 2)

    local LogoBox = Make("Frame", {
        Size = UDim2.fromOffset(36, 36),
        Position = UDim2.fromOffset(14, 14),
        BackgroundColor3 = Col.Panel3, BorderSizePixel = 0,
    }, Box)
    Corner(LogoBox, 8)
    Stroke(LogoBox, Col.Line2, 1)
    Make("ImageLabel", {
        Size = UDim2.fromOffset(26, 26), Position = UDim2.fromOffset(5, 5),
        BackgroundTransparency = 1, Image = "rbxassetid://125023552107789",
        ScaleType = Enum.ScaleType.Fit,
    }, LogoBox)

    Make("TextLabel", {
        Size = UDim2.new(1, -72, 0, 18), Position = UDim2.fromOffset(60, 12),
        BackgroundTransparency = 1, Font = Enum.Font.GothamBold,
        TextSize = 14, TextColor3 = Col.Text,
        TextXAlignment = Enum.TextXAlignment.Left, Text = Title,
    }, Box)
    Make("TextLabel", {
        Size = UDim2.new(1, -72, 0, 30), Position = UDim2.fromOffset(60, 30),
        BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextSize = 11,
        TextColor3 = Col.Sub, TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true, Text = Desc,
    }, Box)

    local Bar = Make("Frame", {
        Size = UDim2.new(1, -28, 0, 2), Position = UDim2.fromOffset(14, 62),
        BackgroundColor3 = Col.Panel3, BorderSizePixel = 0,
    }, Box)
    Corner(Bar, 1)
    local Progress = Make("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Col.Accent, BorderSizePixel = 0,
    }, Bar)
    Corner(Progress, 1)

    TweenObj(Box, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(320, 76), Position = UDim2.new(0, 16, 1, -16),
    }):Play()
    TweenObj(Accent, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(3, 76),
    }):Play()
    TweenObj(Progress, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 1, 0),
    }):Play()

    task.delay(Duration, function()
        TweenObj(Box, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.fromOffset(320, 0), Position = UDim2.new(0, 16, 1, 60),
            BackgroundTransparency = 1,
        }):Play()
        TweenObj(Accent, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.fromOffset(3, 0), BackgroundTransparency = 1,
        }):Play()
        task.delay(0.32, function() if Ngui then Ngui:Destroy() end end)
    end)
end

local function ShowCenterNotify(Title, Desc)
    local existing = LocalPlayer.PlayerGui:FindFirstChild("FedoraCenterNotify")
    if existing then existing:Destroy() end

    local Ngui = Make("ScreenGui", {
        Name = "FedoraCenterNotify", IgnoreGuiInset = true,
        ResetOnSpawn = false, DisplayOrder = 3000,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    Ngui.Parent = GetGuiParent()

    local Box = Make("Frame", {
        Size = UDim2.fromOffset(360, 130),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Col.Panel, BorderSizePixel = 0,
        ClipsDescendants = true,
    }, Ngui)
    Corner(Box, 10)
    Stroke(Box, Col.Line2, 2)

    local Accent = Make("Frame", {
        Size = UDim2.new(1, 0, 0, 4),
        BackgroundColor3 = Col.Accent, BorderSizePixel = 0,
    }, Box)
    Corner(Accent, 2)

    local CloseBtn = Make("TextButton", {
        Size = UDim2.fromOffset(24, 24),
        Position = UDim2.new(1, -32, 0, 12),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderSizePixel = 0,
        Text = "X", Font = Enum.Font.GothamBold, TextSize = 14,
        TextColor3 = Col.Text, AutoButtonColor = false,
    }, Box)
    Corner(CloseBtn, 6)

    local function Close()
        TweenObj(Box, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
        for _, V in pairs(Box:GetDescendants()) do
            if V:IsA("TextLabel") or V:IsA("TextButton") then
                TweenObj(V, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
            end
        end
        task.delay(0.3, function() if Ngui then Ngui:Destroy() end end)
    end
    CloseBtn.MouseButton1Click:Connect(Close)

    Make("TextLabel", {
        Size = UDim2.new(1, -64, 0, 24), Position = UDim2.fromOffset(16, 14),
        BackgroundTransparency = 1, Font = Enum.Font.GothamBold,
        TextSize = 16, TextColor3 = Col.Text,
        TextXAlignment = Enum.TextXAlignment.Left, Text = Title,
    }, Box)
    Make("TextLabel", {
        Size = UDim2.new(1, -32, 0, 60), Position = UDim2.fromOffset(16, 40),
        BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextSize = 13,
        TextColor3 = Col.Sub, TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true, Text = Desc,
    }, Box)

    local Progress = Make("Frame", {
        Size = UDim2.new(1, 0, 0, 4),
        Position = UDim2.new(0, 0, 1, -4),
        BackgroundColor3 = Col.Accent, BorderSizePixel = 0,
    }, Box)
    Corner(Progress, 2)
    TweenObj(Progress, TweenInfo.new(10, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 0, 4),
    }):Play()

    task.delay(10, function()
        if not Ngui then return end
        TweenObj(Box, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
        TweenObj(Accent, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
        TweenObj(Progress, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
        for _, V in pairs(Box:GetDescendants()) do
            if V:IsA("TextLabel") or V:IsA("TextButton") then
                TweenObj(V, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
            end
        end
        task.delay(0.35, function() if Ngui then Ngui:Destroy() end end)
    end)
end

-- the library 
local Lib = {}

function Lib:Window(Title)
    local Win = {}
    local Tabs = {}

    local Gui = Make("ScreenGui", {
        Name = "FedoraUI", IgnoreGuiInset = true, ResetOnSpawn = false,
        DisplayOrder = 1000, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Enabled = false,
    })
    Gui.Parent = GetGuiParent()

    local ToggleBtn = Make("TextButton", {
        Size = UDim2.fromOffset(44, 44), Position = UDim2.fromOffset(16, 16),
        BackgroundColor3 = Col.Panel, BorderSizePixel = 0, AutoButtonColor = false,
        Text = "F", Font = Enum.Font.GothamBold, TextSize = 20,
        TextColor3 = Col.Accent, Visible = false,
    }, Gui)
    Corner(ToggleBtn, 10)
    Stroke(ToggleBtn, Col.Line2, 1)

    -- main window
    local Root = Make("Frame", {
        Name = "Root", Size = UDim2.fromOffset(580, 360),
        Position = UDim2.new(0.5, -290, 0.5, -180),
        BackgroundColor3 = Col.Bg, BorderSizePixel = 0, ClipsDescendants = true,
    }, Gui)
    Corner(Root, 12)
    Stroke(Root, Color3.fromRGB(76, 76, 76), 1)

    -- sidebar where your tab list lives
    local Sidebar = Make("Frame", {
        Name = "Sidebar", Size = UDim2.new(0, 155, 1, 0),
        BackgroundColor3 = Col.Panel, BorderSizePixel = 0,
        ClipsDescendants = true,
    }, Root)
    Corner(Sidebar, 12)
    Make("Frame", {
        Size = UDim2.new(0, 1, 1, -20),
        Position = UDim2.new(1, -1, 0, 10),
        BackgroundColor3 = Col.Line, BorderSizePixel = 0,
    }, Sidebar)

    local Header = Make("Frame", {
        Size = UDim2.new(1, 0, 0, 76),
        BackgroundTransparency = 1, BorderSizePixel = 0,
    }, Sidebar)

    local LogoBox = Make("Frame", {
        Size = UDim2.fromOffset(34, 34), Position = UDim2.fromOffset(12, 16),
        BackgroundColor3 = Col.Panel3, BorderSizePixel = 0,
    }, Header)
    Corner(LogoBox, 8)
    Stroke(LogoBox, Col.Line2, 1)
    Make("ImageLabel", {
        Size = UDim2.fromOffset(22, 22), Position = UDim2.fromOffset(6, 6),
        BackgroundTransparency = 1, Image = "rbxassetid://125023552107789",
        ScaleType = Enum.ScaleType.Fit,
    }, LogoBox)
    Make("TextLabel", {
        Size = UDim2.new(1, -58, 0, 16), Position = UDim2.fromOffset(54, 17),
        BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 13,
        TextColor3 = Col.Text, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd, Text = Title,
    }, Header)
    Make("TextLabel", {
        Size = UDim2.new(1, -58, 0, 14), Position = UDim2.fromOffset(54, 32),
        BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextSize = 10,
        TextColor3 = Col.Muted, TextXAlignment = Enum.TextXAlignment.Left,
        Text = "v1.0.0",
    }, Header)
    Make("Frame", {
        Size = UDim2.new(1, -24, 0, 1), Position = UDim2.fromOffset(12, 64),
        BackgroundColor3 = Col.Line, BorderSizePixel = 0,
    }, Sidebar)

    local TabStrip = Make("ScrollingFrame", {
        Name = "TabStrip", Size = UDim2.new(1, -16, 1, -84),
        Position = UDim2.fromOffset(8, 76), BackgroundTransparency = 1,
        BorderSizePixel = 0, AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 2, ScrollBarImageColor3 = Col.Line2,
        ScrollingDirection = Enum.ScrollingDirection.Y,
    }, Sidebar)
    Make("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, TabStrip)

    -- content area (the right side)
    local Content = Make("Frame", {
        Name = "Content", Size = UDim2.new(1, -155, 1, 0),
        Position = UDim2.fromOffset(155, 0),
        BackgroundTransparency = 1, BorderSizePixel = 0,
    }, Root)
    local Topbar = Make("Frame", {
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundTransparency = 1, BorderSizePixel = 0,
    }, Content)
    local TitleLbl = Make("TextLabel", {
        Size = UDim2.new(1, -120, 1, 0), Position = UDim2.fromOffset(16, 0),
        BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 15,
        TextColor3 = Col.Text, TextXAlignment = Enum.TextXAlignment.Left,
        Text = "Main",
    }, Topbar)
    Make("Frame", {
        Size = UDim2.new(1, -32, 0, 1), Position = UDim2.fromOffset(16, 43),
        BackgroundColor3 = Col.Line, BorderSizePixel = 0,
    }, Topbar)

    local function BarButton(Text, X)
        local B = Make("TextButton", {
            Size = UDim2.fromOffset(26, 26),
            Position = UDim2.new(1, X, 0.5, -13),
            BackgroundColor3 = Col.Panel2, BorderSizePixel = 0,
            AutoButtonColor = false, Font = Enum.Font.GothamBold,
            TextSize = 14, TextColor3 = Col.Text, Text = Text,
        }, Topbar)
        Corner(B, 7)
        Stroke(B, Col.Line, 1)
        return B
    end
    local MinBtn = BarButton("-", -68)
    local CloseBtn = BarButton("X", -36)

    local PageHolder = Make("Frame", {
        Size = UDim2.new(1, 0, 1, -44), Position = UDim2.fromOffset(0, 44),
        BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true,
    }, Content)

    local Dragging, DragStart, StartPos, LastMousePos, LastGoalPos = false, nil, nil, nil, nil
    local DragSpeed = 10
    local function Lerp(A, B, M) return A + (B - A) * M end
    local function UpdateDrag(Dt)
        if not StartPos then return end
        if not Dragging and LastGoalPos then
            Root.Position = UDim2.new(
                StartPos.X.Scale, Lerp(Root.Position.X.Offset, LastGoalPos.X.Offset, Dt * DragSpeed),
                StartPos.Y.Scale, Lerp(Root.Position.Y.Offset, LastGoalPos.Y.Offset, Dt * DragSpeed)
            )
            return
        end
        if not Dragging then return end
        local Delta = LastMousePos - UserInputService:GetMouseLocation()
        local XGoal = StartPos.X.Offset - Delta.X
        local YGoal = StartPos.Y.Offset - Delta.Y
        LastGoalPos = UDim2.new(StartPos.X.Scale, XGoal, StartPos.Y.Scale, YGoal)
        Root.Position = UDim2.new(
            StartPos.X.Scale, Lerp(Root.Position.X.Offset, XGoal, Dt * DragSpeed),
            StartPos.Y.Scale, Lerp(Root.Position.Y.Offset, YGoal, Dt * DragSpeed)
        )
    end
    Topbar.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
            or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = Input.Position
            StartPos = Root.Position
            LastMousePos = UserInputService:GetMouseLocation()
            LastGoalPos = StartPos
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then Dragging = false end
            end)
        end
    end)
    RunService.Heartbeat:Connect(UpdateDrag)

    CloseBtn.MouseButton1Click:Connect(function()
        local OrigPos = Root.Position
        TweenObj(Root, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Size = UDim2.fromOffset(580, 0),
            Position = UDim2.new(OrigPos.X.Scale, OrigPos.X.Offset, OrigPos.Y.Scale, OrigPos.Y.Offset + 180),
            BackgroundTransparency = 1,
        }):Play()
        task.delay(0.32, function()
            Root.Visible = false
            ToggleBtn.Visible = true
            Root.Size = UDim2.fromOffset(580, 360)
            Root.Position = UDim2.new(0.5, -290, 0.5, -180)
            Root.BackgroundTransparency = 0
        end)
    end)

    ToggleBtn.MouseButton1Click:Connect(function()
        Root.Visible = true
        ToggleBtn.Visible = false
        Root.Size = UDim2.fromOffset(580, 0)
        Root.Position = UDim2.new(0.5, -290, 0.5, 0)
        TweenObj(Root, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(580, 360), Position = UDim2.new(0.5, -290, 0.5, -180),
        }):Play()
    end)

    local Minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        Minimized = not Minimized
        MinBtn.Text = Minimized and "+" or "-"
        TweenObj(Root, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = Minimized and UDim2.fromOffset(580, 44) or UDim2.fromOffset(580, 360),
        }):Play()
        TweenObj(Content, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = Minimized and UDim2.fromOffset(0, 0) or UDim2.fromOffset(155, 0),
            Size = Minimized and UDim2.new(1, 0, 1, 0) or UDim2.new(1, -155, 1, 0),
        }):Play()
        Sidebar.Visible = not Minimized
        PageHolder.Visible = not Minimized
    end)

    -- tab select ok
    local function Select(Index)
        for I, T in ipairs(Tabs) do
            local Active = (I == Index)
            TweenObj(T.Btn, TweenInfo.new(0.18), {
                BackgroundColor3 = Active and Col.Accent or Col.Panel2,
            }):Play()
            TweenObj(T.Indicator, TweenInfo.new(0.18), {
                BackgroundColor3 = Active and Col.Dark or Color3.fromRGB(120, 120, 120),
            }):Play()
            if T.Icon then
                TweenObj(T.Icon, TweenInfo.new(0.18), {
                    TextColor3 = Active and Col.Dark or Col.Sub,
                }):Play()
            end
            if T.Lbl then
                TweenObj(T.Lbl, TweenInfo.new(0.18), {
                    TextColor3 = Active and Col.Dark or Col.Sub,
                }):Play()
            end
            T.Page.Visible = Active
        end
        local Current = Tabs[Index]
        if Current then TitleLbl.Text = Current.Name end
    end
    function Win:SelectTab(Index) Select(Index) end

    -- create a new tab
    function Win:Server(Name, IconText)
        local Order = #Tabs + 1
        local Btn = Make("TextButton", {
            Size = UDim2.new(1, 0, 0, 32),
            BackgroundColor3 = Col.Panel2, BorderSizePixel = 0,
            AutoButtonColor = false, Text = "",
            LayoutOrder = Order, ClipsDescendants = true,
        }, TabStrip)
        Corner(Btn, 8)
        local Indicator = Make("Frame", {
            Size = UDim2.fromOffset(3, 14), Position = UDim2.fromOffset(8, 9),
            BackgroundColor3 = Color3.fromRGB(120, 120, 120), BorderSizePixel = 0,
        }, Btn)
        Corner(Indicator, 2)
        local IconLbl
        if IconText then
            IconLbl = Make("TextLabel", {
                Size = UDim2.fromOffset(20, 20), Position = UDim2.fromOffset(20, 6),
                BackgroundTransparency = 1, Font = Enum.Font.GothamBold,
                TextSize = 13, TextColor3 = Col.Sub, Text = IconText,
            }, Btn)
        end
        local NameLbl = Make("TextLabel", {
            Size = UDim2.new(1, -52, 1, 0), Position = UDim2.fromOffset(44, 0),
            BackgroundTransparency = 1, Font = Enum.Font.GothamMedium,
            TextSize = 13, TextColor3 = Col.Sub,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd, Text = Name,
        }, Btn)
        local Page = Make("ScrollingFrame", {
            Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
            BorderSizePixel = 0, ScrollBarThickness = 3,
            ScrollBarImageColor3 = Color3.fromRGB(90, 90, 90),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false, ClipsDescendants = true,
        }, PageHolder)
        local Holder = Make("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1, BorderSizePixel = 0,
        }, Page)
        Make("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder }, Holder)
        Make("UIPadding", {
            PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12),
        }, Holder)

        local Tab = { Page = Page, Btn = Btn, Indicator = Indicator, Icon = IconLbl, Lbl = NameLbl, Name = Name }
        Tabs[Order] = Tab
        Btn.MouseButton1Click:Connect(function() Select(Order) end)

        local SecCount = 0
        function Tab:Section(SecTitle)
            SecCount = SecCount + 1
            local Sec = {}
            local Frame = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = Col.Panel, BorderSizePixel = 0,
                LayoutOrder = SecCount,
            }, Holder)
            Corner(Frame, 10)
            Stroke(Frame, Col.Line, 1)

            local HeaderFrame = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 36),
                BackgroundTransparency = 1, BorderSizePixel = 0,
            }, Frame)
            local Accent = Make("Frame", {
                Size = UDim2.fromOffset(3, 14), Position = UDim2.fromOffset(14, 11),
                BackgroundColor3 = Col.Accent, BorderSizePixel = 0,
            }, HeaderFrame)
            Corner(Accent, 2)
            Make("TextLabel", {
                Size = UDim2.new(1, -46, 1, 0), Position = UDim2.fromOffset(26, 0),
                BackgroundTransparency = 1, Font = Enum.Font.GothamBold,
                TextSize = 13, TextColor3 = Col.Text,
                TextXAlignment = Enum.TextXAlignment.Left, Text = SecTitle,
            }, HeaderFrame)

            local Body = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 0), Position = UDim2.fromOffset(0, 36),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1, BorderSizePixel = 0,
            }, Frame)
            Make("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, Body)
            Make("UIPadding", {
                PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12),
            }, Body)
            Sec.Body = Body
            local ItemCount = 0

            function Sec:Toggle(Text, Default, Callback)
                ItemCount = ItemCount + 1
                local Row = Make("Frame", {
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = Col.Panel2, BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                }, Body)
                Corner(Row, 8)
                Make("TextLabel", {
                    Size = UDim2.new(1, -70, 1, 0), Position = UDim2.fromOffset(12, 0),
                    BackgroundTransparency = 1, Font = Enum.Font.Gotham,
                    TextSize = 13, TextColor3 = Col.Text,
                    TextXAlignment = Enum.TextXAlignment.Left, Text = Text,
                }, Row)
                local Pill = Make("Frame", {
                    Size = UDim2.fromOffset(40, 22),
                    Position = UDim2.new(1, -50, 0.5, -11),
                    BackgroundColor3 = Col.Off, BorderSizePixel = 0,
                }, Row)
                Corner(Pill, 11)
                local Knob = Make("Frame", {
                    Size = UDim2.fromOffset(16, 16), Position = UDim2.fromOffset(3, 3),
                    BackgroundColor3 = Color3.fromRGB(190, 190, 190), BorderSizePixel = 0,
                }, Pill)
                Corner(Knob, 8)

                local State = Default and true or false
                local function Render()
                    TweenObj(Pill, TweenInfo.new(0.18, Enum.EasingStyle.Quart), {
                        BackgroundColor3 = State and Col.Accent or Col.Off,
                    }):Play()
                    TweenObj(Knob, TweenInfo.new(0.18, Enum.EasingStyle.Quart), {
                        Position = State and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3),
                        BackgroundColor3 = State and Col.Dark or Color3.fromRGB(190, 190, 190),
                    }):Play()
                end
                Render()

                local Click = Make("TextButton", {
                    Size = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 1, Text = "",
                }, Row)
                Click.MouseButton1Click:Connect(function()
                    State = not State
                    Render()
                    if Callback then pcall(Callback, State) end
                end)

                return {
                    Set = function(V)
                        State = V and true or false
                        Render()
                        if Callback then pcall(Callback, State) end
                    end,
                    Get = function() return State end,
                }
            end

            function Sec:Slider(Text, Min, Max, Default, Callback)
                ItemCount = ItemCount + 1
                local Row = Make("Frame", {
                    Size = UDim2.new(1, 0, 0, 50),
                    BackgroundColor3 = Col.Panel2, BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                }, Body)
                Corner(Row, 8)
                Make("TextLabel", {
                    Size = UDim2.new(1, -90, 0, 22), Position = UDim2.fromOffset(12, 5),
                    BackgroundTransparency = 1, Font = Enum.Font.Gotham,
                    TextSize = 13, TextColor3 = Col.Text,
                    TextXAlignment = Enum.TextXAlignment.Left, Text = Text,
                }, Row)
                local ValLbl = Make("TextLabel", {
                    Size = UDim2.fromOffset(80, 22), Position = UDim2.new(1, -92, 0, 5),
                    BackgroundTransparency = 1, Font = Enum.Font.GothamMedium,
                    TextSize = 12, TextColor3 = Col.Sub,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Text = tostring(Default),
                }, Row)
                local Track = Make("Frame", {
                    Size = UDim2.new(1, -24, 0, 6), Position = UDim2.fromOffset(12, 32),
                    BackgroundColor3 = Color3.fromRGB(44, 44, 44), BorderSizePixel = 0,
                }, Row)
                Corner(Track, 3)
                local Fill = Make("Frame", {
                    Size = UDim2.new(0, 0, 1, 0),
                    BackgroundColor3 = Col.Accent, BorderSizePixel = 0,
                }, Track)
                Corner(Fill, 3)
                local Knob = Make("Frame", {
                    Size = UDim2.fromOffset(14, 14),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    BackgroundColor3 = Col.Accent, BorderSizePixel = 0,
                }, Track)
                Corner(Knob, 7)
                Stroke(Knob, Col.Bg, 2)

                local Value = Default
                local function Set(V, Fire)
                    V = math.clamp(V, Min, Max)
                    Value = V
                    local A = (Max > Min) and ((V - Min) / (Max - Min)) or 0
                    Fill.Size = UDim2.new(A, 0, 1, 0)
                    Knob.Position = UDim2.new(A, 0, 0.5, 0)
                    ValLbl.Text = tostring(math.floor(V + 0.5))
                    if Fire and Callback then pcall(Callback, V) end
                end
                Set(Default, false)

                local Drag = false
                local function Update(Input)
                    local Rel = (Input.Position.X - Track.AbsolutePosition.X) / math.max(1, Track.AbsoluteSize.X)
                    Set(Min + (Max - Min) * math.clamp(Rel, 0, 1), false)
                end
                for _, Obj in next, { Track, Fill, Knob } do
                    Obj.InputBegan:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1
                            or Input.UserInputType == Enum.UserInputType.Touch then
                            Drag = true
                            Update(Input)
                        end
                    end)
                end
                UserInputService.InputChanged:Connect(function(Input)
                    if not Drag then return end
                    if Input.UserInputType ~= Enum.UserInputType.MouseMovement
                        and Input.UserInputType ~= Enum.UserInputType.Touch then return end
                    Update(Input)
                end)
                UserInputService.InputEnded:Connect(function(Input)
                    if Input.UserInputType ~= Enum.UserInputType.MouseButton1
                        and Input.UserInputType ~= Enum.UserInputType.Touch then return end
                    if Drag then
                        Drag = false
                        Set(Value, true)
                    end
                end)

                return {
                    Set = function(V) Set(V, false) end,
                    Get = function() return Value end,
                }
            end

            function Sec:Label(Text)
                ItemCount = ItemCount + 1
                Make("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 20),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1, Font = Enum.Font.Gotham,
                    TextSize = 12, TextColor3 = Col.Sub,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true, Text = Text,
                    LayoutOrder = ItemCount,
                }, Body)
            end

            -- card (fancy avatar thing)
            function Sec:Card(ImageId, User, Desc)
                ItemCount = ItemCount + 1
                local Card = Make("Frame", {
                    Size = UDim2.new(1, 0, 0, 90),
                    BackgroundColor3 = Col.Panel2, BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                }, Body)
                Corner(Card, 10)
                Stroke(Card, Col.Line, 1)
                local ImgBox = Make("Frame", {
                    Size = UDim2.fromOffset(66, 66), Position = UDim2.fromOffset(12, 12),
                    BackgroundColor3 = Col.Panel3, BorderSizePixel = 0,
                    ClipsDescendants = true,
                }, Card)
                if ImageId then
                    Corner(ImgBox, 10)
                    Stroke(ImgBox, Col.Line2, 1)
                    Make("ImageLabel", {
                        Size = UDim2.fromScale(1, 1),
                        BackgroundTransparency = 1,
                        Image = "rbxassetid://" .. tostring(ImageId),
                        ScaleType = Enum.ScaleType.Crop,
                    }, ImgBox)
                else
                    ImgBox.BackgroundTransparency = 1
                    ImgBox.Visible = false
                end
                local TextXOffset = ImageId and 88 or 12
                Make("TextLabel", {
                    Size = UDim2.new(1, -TextXOffset - 12, 0, 20),
                    Position = UDim2.fromOffset(TextXOffset, 12),
                    BackgroundTransparency = 1, Font = Enum.Font.GothamBold,
                    TextSize = 14, TextColor3 = Col.Text,
                    TextXAlignment = Enum.TextXAlignment.Left, Text = User,
                }, Card)
                Make("TextLabel", {
                    Size = UDim2.new(1, -TextXOffset - 12, 0, 52),
                    Position = UDim2.fromOffset(TextXOffset, 32),
                    BackgroundTransparency = 1, Font = Enum.Font.Gotham,
                    TextSize = 11, TextColor3 = Col.Sub,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextWrapped = true, Text = Desc,
                }, Card)
                return Card
            end

            function Sec:TextBox(Placeholder, Default, Callback)
                ItemCount = ItemCount + 1
                local Row = Make("Frame", {
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = Col.Panel2, BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                }, Body)
                Corner(Row, 8)
                local Box = Make("TextBox", {
                    Size = UDim2.new(1, -24, 1, -8), Position = UDim2.fromOffset(12, 4),
                    BackgroundTransparency = 1, Font = Enum.Font.Gotham,
                    TextSize = 13, TextColor3 = Col.Text,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    PlaceholderText = Placeholder, PlaceholderColor3 = Col.Muted,
                    Text = Default or "",
                }, Row)
                Box.FocusLost:Connect(function()
                    if Callback then pcall(Callback, Box.Text) end
                end)
                return Box
            end

            function Sec:Button(Text, Callback)
                ItemCount = ItemCount + 1
                local Row = Make("Frame", {
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = Col.Panel2, BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                }, Body)
                Corner(Row, 8)
                local Btn = Make("TextButton", {
                    Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
                    Text = Text, Font = Enum.Font.GothamBold, TextSize = 13,
                    TextColor3 = Col.Text, TextXAlignment = Enum.TextXAlignment.Center,
                }, Row)
                Btn.MouseButton1Click:Connect(function()
                    if Callback then pcall(Callback) end
                end)
                return Btn
            end

            function Sec:Row()
                ItemCount = ItemCount + 1
                local Row = Make("Frame", {
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundTransparency = 1, LayoutOrder = ItemCount,
                }, Body)
                Make("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                }, Row)
                return Row
            end

            function Sec:InlineButton(ParentRow, Text, Callback)
                local Btn = Make("TextButton", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Col.Panel2, BorderSizePixel = 0,
                    AutoButtonColor = false, Font = Enum.Font.GothamBold,
                    TextSize = 12, TextColor3 = Col.Text, Text = Text,
                }, ParentRow)
                Corner(Btn, 8)
                Btn.MouseButton1Click:Connect(function()
                    if Callback then pcall(Callback) end
                end)
                return Btn
            end

            function Sec:InlineButtonFixed(ParentRow, Text, Width, Callback)
                local Btn = Make("TextButton", {
                    Size = UDim2.new(0, Width, 1, 0),
                    BackgroundColor3 = Col.Panel2, BorderSizePixel = 0,
                    AutoButtonColor = false, Font = Enum.Font.GothamBold,
                    TextSize = 12, TextColor3 = Col.Text, Text = Text,
                }, ParentRow)
                Corner(Btn, 8)
                Btn.MouseButton1Click:Connect(function()
                    if Callback then pcall(Callback) end
                end)
                return Btn
            end

            -- divider
            function Sec:Divider()
                ItemCount = ItemCount + 1
                Make("Frame", {
                    Size = UDim2.new(1, 0, 0, 1),
                    BackgroundColor3 = Col.Line, BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                }, Body)
            end

            -- space (just empty space, like my brain)
            function Sec:Space(Height)
                ItemCount = ItemCount + 1
                Make("Frame", {
                    Size = UDim2.new(1, 0, 0, Height or 8),
                    BackgroundTransparency = 1, LayoutOrder = ItemCount,
                }, Body)
            end

            -- dropdown (basic but works)
            function Sec:Dropdown(Text, Options, Default, Callback)
                ItemCount = ItemCount + 1
                local Selected = Default or (Options and Options[1]) or ""
                local Open = false
                local Row = Make("Frame", {
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = Col.Panel2, BorderSizePixel = 0,
                    LayoutOrder = ItemCount, ClipsDescendants = true,
                }, Body)
                Corner(Row, 8)
                Make("UIListLayout", {
                    Padding = UDim.new(0, 2),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                }, Row)

                local Top = Make("TextButton", {
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundTransparency = 1, Text = "",
                    AutoButtonColor = false, LayoutOrder = 1,
                }, Row)
                Make("TextLabel", {
                    Size = UDim2.new(1, -40, 1, 0), Position = UDim2.fromOffset(12, 0),
                    BackgroundTransparency = 1, Font = Enum.Font.Gotham,
                    TextSize = 13, TextColor3 = Col.Text,
                    TextXAlignment = Enum.TextXAlignment.Left, Text = Text,
                }, Top)
                local ValLbl = Make("TextLabel", {
                    Size = UDim2.new(0, 100, 1, 0),
                    Position = UDim2.new(1, -32, 0, 0),
                    BackgroundTransparency = 1, Font = Enum.Font.GothamBold,
                    TextSize = 12, TextColor3 = Col.Sub,
                    TextXAlignment = Enum.TextXAlignment.Right, Text = Selected,
                }, Top)
                local Arrow = Make("TextLabel", {
                    Size = UDim2.fromOffset(24, 24),
                    Position = UDim2.new(1, -26, 0.5, -12),
                    BackgroundTransparency = 1, Font = Enum.Font.GothamBold,
                    TextSize = 14, TextColor3 = Col.Sub,
                    Text = "v",
                }, Top)

                local List = Make("Frame", {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1, BorderSizePixel = 0,
                    LayoutOrder = 2,
                }, Row)
                Make("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }, List)

                for i, Opt in ipairs(Options or {}) do
                    local OptBtn = Make("TextButton", {
                        Size = UDim2.new(1, -12, 0, 28),
                        Position = UDim2.fromOffset(6, 0),
                        BackgroundColor3 = Col.Panel3, BorderSizePixel = 0,
                        AutoButtonColor = false, Font = Enum.Font.Gotham,
                        TextSize = 12, TextColor3 = Col.Sub,
                        Text = tostring(Opt), LayoutOrder = i,
                    }, List)
                    Corner(OptBtn, 6)
                    OptBtn.MouseButton1Click:Connect(function()
                        Selected = Opt
                        ValLbl.Text = tostring(Opt)
                        Open = false
                        Row.Size = UDim2.new(1, 0, 0, 34)
                        Arrow.Text = "v"
                        if Callback then pcall(Callback, Opt) end
                    end)
                end

                Top.MouseButton1Click:Connect(function()
                    Open = not Open
                    if Open then
                        Row.Size = UDim2.new(1, 0, 0, 34 + #Options * 30 + 4)
                        Arrow.Text = "^"
                    else
                        Row.Size = UDim2.new(1, 0, 0, 34)
                        Arrow.Text = "v"
                    end
                end)

                return {
                    Get = function() return Selected end,
                    Set = function(V)
                        Selected = V
                        ValLbl.Text = tostring(V)
                        if Callback then pcall(Callback, V) end
                    end,
                }
            end

            -- Create: build whatever the hell you want in here
            -- callback gets a parent frame, do whatever idc
            function Sec:Create(Callback)
                ItemCount = ItemCount + 1
                local Container = Make("Frame", {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1, BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                }, Body)
                if Callback then
                    pcall(Callback, Container)
                end
                return Container
            end

            return Sec
        end

        return Tab
    end

    function Win:GetGui() return Gui end
    function Win:Toggle(Visible)
        if Visible == nil then
            Root.Visible = not Root.Visible
            ToggleBtn.Visible = not Root.Visible
        else
            Root.Visible = Visible
            ToggleBtn.Visible = not Visible
        end
    end
    function Win:SetTitle(Text)
        for _, v in ipairs(Header:GetChildren()) do
            if v:IsA("TextLabel") and v.TextSize == 13 then
                v.Text = Text
                break
            end
        end
    end
    function Win:Destroy()
        Gui:Destroy()
    end

    return Win
end

return Lib
