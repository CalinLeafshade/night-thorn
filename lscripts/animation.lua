
Animation = Class("Animation")

function Animation:initialize(view,loop)
	self.frameCount = ags.Game.GetFrameCountForLoop(view,loop)
	self.frames = {}
	for i=0,self.frameCount - 1 do
		local vf = ags.Game.GetViewFrame(view,loop,i)
		self.frames[i + 1] = { id = vf.Graphic, flipped = vf.Flipped }
	end
	self.speed = 8
	self:reset()
end

function Animation:reset()
	self.frame = 1
	self.frameCounter = self.speed
end

function Animation:advance()
	self.frame = self.frame + 1
	if self.frame > self.frameCount then
		self.frame = 1
	end
end

function Animation:update()
	self.frameCounter = self.frameCounter - 1
	if self.frameCounter <= 0 then
		self.frameCounter = self.speed
		self:advance()
	end
end

function Animation:draw(x,y)
	lags.graphics.draw(self.frames[self.frame].id,x,y,0,1,self.frames[self.frame].flipped)
end