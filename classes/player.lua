--Player Class

--3rd party libs
local Class = require('hump.class')

local Player = Class{}

function Player:init(x, y, w, h, xAccel, yAccel, maxVelX, maxVelY, mass, world)
	self.x       = x
	self.y       = y
	self.w       = w
	self.h       = h
	self.xAccel  = xAccel
	self.yAccel  = yAccel
	self.maxVelX = maxVelX
	self.maxVelY = maxVelY
	self.mass    = mass
	self.world   = world

	self.xvel = 0
	self.yvel = 0
	self.direction = 1
	self.grounded = false
end

function Player:update(dt)
	self.xvel = self.xvel + self.direction*self.xAccel*dt
	self.yvel = self.yvel + self.yAccel*dt

	if self.xvel > self.maxVelX then self.xvel = self.maxVelX end
	if self.xvel < 0 then self.xvel = 0 end
	if self.yvel > self.maxVelY then self.yvel = self.maxVelY end
	if self.yvel < -self.maxVelY then self.yvel = -self.maxVelY end

	self.x = self.x + self.xvel*dt
	self.y = self.y + self.yvel*dt

	self.x, self.y, cols = self.world:move( self, self.x, self.y )

	for i,v in ipairs (cols) do
		if cols[i].normal.y == -1 then
			self.yvel = 0
			self.grounded = true
		elseif cols[i].normal.y == 1 then
			self.yvel = -self.yvel/4
		end
	end

end

function Player:setAcceleration(x, y)
	self.xAccel = x or self.xAccel
	self.yAccel = y or self.yAccel
end

function Player:addAcceleration(x, y)
	self.xAccel = self.xAccel + (x or 0)
	self.yAccel = self.yAccel + (y or 0)
end

function Player:setVelocity(x, y)
	self.xvel = x or self.xvel
	self.yvel = y or self.yvel
end

function Player:setDirection(direction)
	self.direction = direction
end

return Player
