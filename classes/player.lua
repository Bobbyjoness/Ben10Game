--Player Class

--3rd party libs
local Class = require('hump.class')

local Player = Class{}

function Player:init(x, y, w, h, maxVelX, maxVelY, mass, world)
	self.name    = "Player" 
	self.x       = x
	self.y       = y
	self.w       = w
	self.h       = h
	self.xAccel  = 0
	self.yAccel  = 0
	self.maxVelX = maxVelX
	self.maxVelY = maxVelY
	self.mass    = mass
	self.world   = world

	self.xvel = 0
	self.yvel = 0
	self.direction = 1
	self.grounded = false
	self.friction = 0

	self.dead = false

	world:add(self, self.x, self.y, self.w, self.h)
end

function Player:setHealth(amount, max)
	local oldMax      = self.healthMax or 100
	self.healthMax    = max or self.healthMax or 100
	self.healthAmount = amount or (self.healthAmount and (self.healthAmount/oldMax)*self.healthMax) or 100
	if self.healthAmount < 0 then
		self.healthAmount = 0
	end
end

function Player:getHealthStats()
	if self.healthMax then
		return self.healthAmount,self.healthMax
	else
		error("Health was not initialized for : " .. self.name)
	end
end

function Player:applyDamage(amount)
	local healthAmount = self:getHealthStats()
	self:setHealth(healthAmount - amount)
end

function Player:checkHealth()
	local healthAmount = self:getHealthStats()
	print(healthAmount)
	if healthAmount <= 0 then 
		print('apple')
		self:die() 
		self:setHealth(0)
	end
end

function Player:die()
	print("dead")
	self.dead = true
end

function Player:checkDead()
	return self.dead
end

function Player:update(dt)
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
	self.grounded = false
	for i,v in ipairs (cols) do
		if cols[i].normal.y == -1 then
			self.yvel = 0
			self.grounded = true
		elseif cols[i].normal.y == 1 then
			self.yvel = -self.yvel/4
		end
		if v.other.name then
			self:applyDamage(10)
		end
	end

	self:checkHealth()
end

function Player:draw()
	love.graphics.setColor(127,127,0)
	love.graphics.rectangle( "fill",self.x,self.y,self.w,self.h )
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

function Player:setFriction( frictionConstant )
	self.friction = frictionConstant
end

return Player
