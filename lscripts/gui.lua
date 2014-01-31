
GUI = Class("GUI")

GUIs = {}

function GUI:initialize(x,y,w,h)
	self.x = x or 0
	self.y = y or 0
	self.width = w or 100
	self.height = h or 100
	GUIs[self] = self
end

function GUI:draw()
	lags.graphics.setColor(16,120,144)
	lags.graphics.rect("fill", self.x,self.y,self.width,self.height)
	lags.graphics.setColor(255,255,255)
	lags.graphics.rect("line", self.x,self.y,self.width,self.height)
	if self.text then
		lags.graphics.printf(self.text, self.x + 5, self.y + 5,self.width - 10, "left")
	end
end

function GUI:destroy()
	GUIs[self] = nil
end