--Martian Class

--3rd party libs
local Class = require('hump.class')

local Martian = Class{}

function Martian:init(x, y, world)--we dont need as many things that the player class does.
	self.x       = x
	self.y       = y
	self.w       = 32
	self.h       = 50
	self.xAccel  = 0
	self.yAccel  = 0
	self.maxVelX = 100
	self.maxVelY = 400
	self.mass    = 40
	self.world   = world

	self.xvel = 0
	self.yvel = 0
	self.direction = 1
	self.grounded = false
	self.friction = 0

	self.world:add(self, self.x, self.y, self.w, self.h)
end

function Martian:update(dt)
	self:AI()
	self.xvel = self.xvel + self.xAccel*dt
	self.yvel = self.yvel + self.yAccel*dt

	if self.grounded then
		self.xvel = self.xvel - self.mass*self.friction*self.direction*dt
	end

	if self.direction == 1 then
		if self.xvel > self.maxVelX then self.xvel = self.maxVelX end
		if self.xvel < 0 then self.xvel = 0 end
	else
		if self.xvel < -self.maxVelX then self.xvel = -self.maxVelX end
		if self.xvel > 0 then self.xvel = 0 end
	end	

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

function Martian:draw()
	love.graphics.setColor(255,0,0)
	love.graphics.rectangle( "fill",self.x,self.y,self.w,self.h )
end

function Martian:setAcceleration(x, y)
	self.xAccel = x or self.xAccel
	self.yAccel = y or self.yAccel
end

function Martian:addAcceleration(x, y)
	self.xAccel = self.xAccel + (x or 0)
	self.yAccel = self.yAccel + (y or 0)
end

function Martian:setVelocity(x, y)
	self.xvel = x or self.xvel
	self.yvel = y or self.yvel
end

function Martian:setDirection(direction)
	self.direction = direction
end

function Martian:setFriction( frictionConstant )
	self.friction = frictionConstant
end

function Martian:AI()
	local items, len = self.world:queryRect(self.x-100, self.y-100, 200 + self.w, 200 + self.h) --query the world for a player. (so we can kill him(que the evil laugh))
	self:setAcceleration(0)
	for i,v in ipairs(items) do
		if v.name == "Player" then
			if v.x < self.x then
				self:setAcceleration(-500)
				self:setDirection(-1)
			elseif v.x > self.x + self.w then
				self:setAcceleration(500)
				self:setDirection(1)
			end
			break		
		end
	end
end

return Martian
