local DataStoreService = game:GetService("DataStoreService")
local moneyStore = DataStoreService:GetDataStore("PlayerMoney")

game.Players.PlayerAdded:Connect(function(player)
    local stats = Instance.new("Folder")
    stats.Name = "leaderstats"
    stats.Parent = player

    local money = Instance.new("IntValue")
    money.Name = "Money"
    money.Value = 0
    money.Parent = stats

    -- Load saved money
    local success, savedMoney = pcall(function()
        return moneyStore:GetAsync(player.UserId)
    end)
    if success and savedMoney then
        money.Value = savedMoney
    end

    -- +1 money per second
    spawn(function()
        while player.Parent do
            wait(1)
            money.Value = money.Value + 1
        end
    end)
end)

game.Players.PlayerRemoving:Connect(function(player)
    local money = player:FindFirstChild("leaderstats"):FindFirstChild("Money")
    if money then
        pcall(function()
            moneyStore:SetAsync(player.UserId, money.Value)
        end)
    end
end)
