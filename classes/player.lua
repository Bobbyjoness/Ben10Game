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
	end

	self:checkHealth()
	self:attackUpdate(dt)
end

local function bounceLerp(min, max, lowT, highT ) --yeah I know weird name.
	return min + (max - min)*math.abs(math.sin(math.pi*lowT/highT))^2
end

function Player:draw()
	love.graphics.setColor(127,127,0)
	love.graphics.rectangle( "fill",self.x,self.y,self.w,self.h )
	if self.attackTimer > 0 then 
		local normalizeTime = (self.attackTimer/self.attackSpeed)*2
		local offset = bounceLerp(0, self.attackRange, (2*self.attackTimer)/self.attackSpeed, 2)
		love.graphics.setColor(255,0,0)
		love.graphics.circle("fill", (self.x + self.w/2) + offset*self.direction, self.y+self.h/4, 10 )
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

function Player:setFriction( frictionConstant )
	self.friction = frictionConstant
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
	if healthAmount <= 0 then 
		self:die() 
		self:setHealth(0)
	end
end

function Player:die()
	self.dead = true
end

function Player:checkDead()
	return self.dead
end

function Player:setMeleeAttack(range, damage, speed)
	self.attackRange = range or 15
	self.attackDamage = damage or 5
	self.attackSpeed  = speed or 1
	self.attackTimer  = 0
end

function Player:attack()
	if self.attackTimer <= 0 then
		self.attackTimer = self.attackSpeed
		local items, len
		if self.direction == -1 then
			items, len = self.world:queryRect((self.x + self.w/2) - self.attackRange, self.y, self.attackRange, self.h)
		elseif self.direction == 1 then
			items, len = self.world:queryRect((self.x + self.w/2), self.y, self.attackRange, self.h)
		end
		for i,v in ipairs(items) do
			if v.healthAmount and not (v.name == self.name) then
				v:attacked(self.attackDamage)	
			end
		end
	end	
end

function Player:attackUpdate(dt)
	if self.attackTimer > 0 then
		self.attackTimer = self.attackTimer - dt
	elseif self.attackTimer == nil then
		error("This attack was not initialized for: " .. self.name)	
	end
end

function Player:attacked(damage)
	self:applyDamage(self.attackDamage)
end

return Player
