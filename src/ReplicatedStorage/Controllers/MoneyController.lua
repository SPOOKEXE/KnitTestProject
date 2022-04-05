
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Knit = require( ReplicatedStorage.Packages.Knit )

local MoneyController = Knit.CreateController { Name = 'MoneyController' }
local MoneyService = false

function MoneyController:GetMoney()
	return MoneyService:GetMoney()
end

-- On Knit Initialization
function MoneyController:KnitInit()
	print(script.Name, "Init")
	MoneyService = Knit.GetService("MoneyService")
end

-- On Knit Start
function MoneyController:KnitStart()
	print(script.Name, "Start")

	local function ObserveMoney( money : number )
		print("Money: ", money)
	end

	self:GetMoney():andThen(ObserveMoney):andThen(function()
		MoneyService.onMoneyChanged:Connect(ObserveMoney)
	end)

end

return MoneyController
