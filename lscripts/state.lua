
--state

State = Class("State")

function State:initialize()
	self.opaque = true
end

function State:onFocus() end
function State:onBlur() end
function State:draw() end
function State:update() end
