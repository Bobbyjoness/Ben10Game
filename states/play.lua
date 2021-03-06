--play state 
local Play = {}

--3rd Party Libraries
local sti    = require "libs.STI"
local bump   = require "bump.bump"
local Camera = require "hump.camera"
local GS     = require "hump.gamestate"
local camera = Camera()

--My code
local Player      = require "classes.player"
local Martian     = require "classes.martian"
local bigDude     = require "classes.bigDude"
local savageBrute = require "classes.savageBrute"
local LoseOverlay = require "states.loseOverlay"
local player
local map
local world
local enemies = {}

function Play:init() -- run only once

    -- Set Physics Meter
	world = bump.newWorld(64)
	-- Load map
	map = sti("maps/map1.lua", { "bump" })
	
	map:bump_init(world)

    -- Get player spawn object
    local playerSpawn
    for k, object in pairs(map.objects) do
        if object.name == "PlayerSpawn" then
            playerSpawn = object
        elseif object.name == "Martian" then
        	local martian = Martian(object.x, object.y, world)
        	martian:setAcceleration(nil,map.properties.GRAVITY*martian.mass)
   			martian:setFriction(map.properties.friction)
   			martian:setHealth(20,20)
   			martian:setMeleeAttack(32,5,.5)
   			table.insert(enemies,martian)
   		elseif object.name == "savageBrute" then
        	local savageBrute = savageBrute(object.x, object.y, world)
        	savageBrute:setAcceleration(nil,map.properties.GRAVITY*savageBrute.mass)
   			savageBrute:setFriction(map.properties.friction)
   			savageBrute:setHealth(10,10)
   			savageBrute:setMeleeAttack(7,.1,.5)
   			table.insert(enemies,savageBrute)
   		elseif object.name == "bigDude" then
        	local bigDude = bigDude(object.x, object.y, world)
        	bigDude:setAcceleration(nil,map.properties.GRAVITY*bigDude.mass)
   			bigDude:setFriction(map.properties.friction)
   			bigDude:setHealth(45,45)
   			bigDude:setMeleeAttack(64,15,1)
   			table.insert(enemies,bigDude)
        end
    end

    -- Remove unneeded object layer
    map:removeLayer("Spawn")

    player = Player(playerSpawn.x, playerSpawn.y, 32, 32, 300, 400, 100, world)
    player:setAcceleration(nil,map.properties.GRAVITY*player.mass)
    player:setFriction(map.properties.friction)
    player:setHealth()
    player:setMeleeAttack(32,5,.45)
end

function Play:enter( previous, ... ) -- run every time the state is entered

end

function Play:update(dt)
	map:update(dt)
	player:update(dt)
	if player:checkDead() then
		GS.push(LoseOverlay)
	end

	for i=#enemies,1,-1 do
		local enemy = enemies[i]
		enemy:update(dt)
		if enemy:checkDead() then
			world:remove(enemy)
			table.remove(enemies, i)
		end
	end	

	if love.keyboard.isDown("d") then
		player:setAcceleration(300)
		player:setDirection(1)
	elseif love.keyboard.isDown("a") then
		player:setAcceleration(-300)
		player:setDirection(-1)
	end

	camera:lockX(math.floor(player.x))
end

function Play:draw()
	--this will tell how many enemies are left
	love.graphics.setColor(1,1,1)
	if #enemies == 1 then
		love.graphics.print("There is only "..#enemies.."\nenemy left", 700, 25) 
	else
		love.graphics.print("There are "..#enemies.."\nenemies left", 700, 25) --to show how many enemies are left
	end

	local w, h = love.graphics.getDimensions( )
	love.graphics.setColor(1, 1, 1)
	map:draw(w/2-player.x, h/2 - player.y)
	map:bump_draw(world, w/2-player.x, h/2 - player.y)
	
	

	love.graphics.push()
		love.graphics.translate(w/2-player.x, h/2 - player.y)
		player:draw()
		for i,v in ipairs(enemies) do
			v:draw()
		end
	love.graphics.pop()

	local healthAmount, healthMax = player:getHealthStats()
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", 19, 19, healthMax+1, 22)
	love.graphics.setColor(.15, 1, .15)
	love.graphics.rectangle("fill", 20, 20, healthAmount, 20)
	love.graphics.setColor(1, 1, 0, 1)
	love.graphics.setFont(love.graphics.newFont(12))
	love.graphics.print(love.timer.getFPS())
end

function Play:keypressed(key)
	if key == "space" and player.grounded then
		player:setVelocity(nil,-3000)	
	end
	if key == "q" then
		player:attack()
	end
end

function Play:keyreleased(key)
	player:setAcceleration(0)
end

function Play:mousereleased(x,y, mouse_btn)
end

return Play