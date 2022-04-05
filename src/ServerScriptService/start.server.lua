
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local ServerStorage = game:GetService("ServerStorage")
for _, ModuleScript in ipairs( ServerStorage.Services:GetChildren() ) do
	if ModuleScript:IsA('ModuleScript') and ModuleScript.Name:match("Service$") then
		require(ModuleScript)
	end
end

Knit.Start():andThen(function()
	print("Knit Started")
end):catch(warn)
