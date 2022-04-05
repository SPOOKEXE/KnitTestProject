local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local ReplicatedStorage = game:GetService('ReplicatedStorage')
for _, ModuleScript in ipairs( ReplicatedStorage.Controllers:GetChildren() ) do
	if ModuleScript:IsA('ModuleScript') and ModuleScript.Name:match("Controller$") then
		require(ModuleScript)
	end
end

local PerServiceMiddleware = false --[[{
	MoneyService = {
		Inbound = {function(...) print("INBOUND: ", ...) return true end},
		Outbound = {function(...) print("OUTBOUND: ", ...) return true end},
	},
}]]

Knit.Start({
	PerServiceMiddleware = PerServiceMiddleware,
}):andThen(function()
	print("Knit Started")
end):catch(warn)