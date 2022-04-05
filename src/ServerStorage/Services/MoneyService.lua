
local Players = game:GetService('Players')

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Knit = require( ReplicatedStorage.Packages.Knit )

local MoneyService = Knit.CreateService { Name = "MoneyService", Client = { } }
MoneyService._MoneyCache = { }
MoneyService._StartMoney = 50
MoneyService.Client.onMoneyChanged = Knit.CreateSignal()

function MoneyService.Client:GetMoney( LocalPlayer : Player )
	return self.Server:GetMoney( LocalPlayer )
end

function MoneyService:GetMoney( LocalPlayer : Player ) : number
	return self._MoneyCache[LocalPlayer] or self._StartMoney
end

function MoneyService:AddMoney( LocalPlayer : Player, amount : number )
	local newMoney = self:GetMoney( LocalPlayer ) + amount
	if (amount > 0) then
		self._MoneyCache[ LocalPlayer ] = newMoney
		self.Client.onMoneyChanged:Fire( LocalPlayer, newMoney )
	end
end

-- On Knit Initialization
function MoneyService:KnitInit()
	print("MoneyService Init")

	local function PlayerAdded( LocalPlayer )
		self._MoneyCache[ LocalPlayer ] = self._StartMoney
	end
	for _, LocalPlayer in ipairs( Players:GetPlayers() ) do
		task.defer(PlayerAdded, LocalPlayer)
	end
	Players.PlayerAdded:Connect(PlayerAdded)

	Players.PlayerRemoving:Connect(function( LocalPlayer : Player )
		self._MoneyCache[ LocalPlayer ] = nil
	end)

	task.defer(function()
		while true do
			for _, LocalPlayer in ipairs( Players:GetPlayers() ) do
				self:AddMoney( LocalPlayer, Random.new():NextInteger(1, 50) )
			end
			task.wait(1)
		end
	end)

end

-- On Knit Start
function MoneyService:KnitStart()
	print("MoneyService Start")
end

return MoneyService
