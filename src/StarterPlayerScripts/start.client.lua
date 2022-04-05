local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local ReplicatedStorage = game:GetService('ReplicatedStorage')
for _, ModuleScript in ipairs( ReplicatedStorage.Controllers:GetChildren() ) do
	if ModuleScript:IsA('ModuleScript') and ModuleScript.Name:match("Controller$") then
		require(ModuleScript)
	end
end

Knit.Start():andThen(function()
	print("Knit Started")
end):catch(warn)