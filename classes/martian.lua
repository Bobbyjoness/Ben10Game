--Martian Class

--3rd party libs
local Class = require('hump.class')

local Martian = Class{}

function Martian:init(x, y, world)--we dont need as many things that the player class does.
	self.name    = "martian" 
	
	self.x       = x
	self.y       = y
	self.w       = 32
	self.h       = 50
	self.xAccel  = 0
	self.yAccel  = 0
	self.maxVelX = 140
	self.maxVelY = 400
	self.mass    = 40
	self.world   = world

	self.xvel = 0
	self.yvel = 0
	self.direction = 1
	self.grounded = false
	self.friction = 0

	self.dead = false
	self.world:add(self, self.x, self.y, self.w, self.h)
end

function Martian:update(dt)
	self:AI()
	self:checkHealth(dt)
	self:attackUpdate(dt)
	self.xvel = self.xvel + self.xAccel*dt
	self.yvel = self.yvel + self.yAccel*dt
	if self.grounded then
		self.xvel = self.xvel - self.mass*self.friction*self.direction*dt
	end

	if self.direction == 1 then
		if self.xvel > self.maxVelX then self.xvel = self.maxVelX end
		if self.xvel < 0 then self.xvel = 0 end
	elseif self.direction == -1 then
		if self.xvel < -self.maxVelX then self.xvel = -self.maxVelX end
		if self.xvel > 0 then self.xvel = 0 end
	else
		error("Direction needs to 1 or -1. Direction is: " .. self.direction)
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
	self:attack()
end

function Martian:draw()
	love.graphics.setColor(255,0,0)
	love.graphics.rectangle( "fill",self.x,self.y,self.w,self.h )
	love.graphics.print(self.healthAmount .. "/" .. self.healthMax, self.x, self.y - 20)
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
		if v.name == "Player" and self.grounded then
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

function Martian:setHealth(amount, max)
	local oldMax      = self.healthMax or 100
	self.healthMax    = max or self.healthMax or 100
	self.healthAmount = amount or (self.healthAmount and (self.healthAmount/oldMax)*self.healthMax) or 100
	if self.healthAmount < 0 then
		self.healthAmount = 0
	end
end

function Martian:getHealthStats()
	if self.healthMax then
		return self.healthAmount,self.healthMax
	else
		error("Health was not initialized for : " .. self.name)
	end
end

function Martian:applyDamage(amount)
	local healthAmount = self:getHealthStats()
	self:setHealth(healthAmount - amount)
end

function Martian:checkHealth()
	local healthAmount = self:getHealthStats()
	if healthAmount <= 0 then 
		self:die() 
		self:setHealth(0)
	end
end

function Martian:die()
	self.dead = true
end

function Martian:checkDead()
	return self.dead
end

function Martian:setMeleeAttack(range, damage, speed)
	self.attackRange = range or 100
	self.attackDamage = damage or 5
	self.attackSpeed  = speed or 1
	self.attackTimer  = 0
end

function Martian:attack()
	if self.attackTimer <= 0 then

		self.attackTimer = self.attackSpeed
		local items, len 
		if self.direction == -1 then
			items, len = self.world:queryRect((self.x + self.w/2) - self.attackRange, self.y, self.attackRange, self.h)
		elseif self.direction == 1 then
			items, len = self.world:queryRect((self.x + self.w/2), self.y, self.attackRange, self.h)
		end
		for i,v in ipairs(items) do
			if v.name == "Player" then
				v:attacked(self.attackDamage)	
			end
		end
	end	
end

function Martian:attackUpdate(dt)
	if self.attackTimer > 0 then
		self.attackTimer = self.attackTimer - dt
	elseif self.attackTimer == nil then
		error("This attack was not initialized for: " .. self.name)	
	end
end

function Martian:attacked(damage)
	self:setVelocity(-150*self.direction*damage, -100*damage)
	self.grounded = false
	self:applyDamage(damage)
end


return Martian
