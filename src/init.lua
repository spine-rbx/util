local Util = {}

function Util.Make(Class, Props: { [string]: any }?, Children: { Instance }?)
	local Object = Instance.new(Class)

	if type(Props) == "table" then
		for i, v in pairs(Props) do
			Object[i] = v
		end
	end

	if type(Children) == "table" then
		for _, v in ipairs(Children) do
			v.Parent = Object
		end
	end

	return Object
end

function Util.Each(Parent: Instance, ChildAdded: (Child: Instance) -> ()?, ChildRemoved: (Child: Instance) -> ()?)
	local Connections = {}

	if ChildAdded then
		Connections.ChildAdded = Parent.ChildAdded:Connect(ChildAdded)

		for _, v in ipairs(Parent:GetChildren()) do
			task.spawn(ChildAdded, v)
		end
	end

	if ChildRemoved then
		Connections.ChildRemoved = Parent.ChildRemoved:Connect(ChildRemoved)
	end

	Connections.Disconnect = function()
		for _, v in pairs(Connections) do
			v:Disconnect()
		end
	end

	return Connections
end

return Util
