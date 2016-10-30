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
	camera:attach()
	love.graphics.setColor(255, 255, 255)
	map:setDrawRange(player.x - 800, 0, player.x + 800, player.y + 600)
	map:draw()
	map:bump_draw(world)
	player:draw()
	for i,v in ipairs(enemies) do
		v:draw()
	end
	camera:detach()

	local healthAmount, healthMax = player:getHealthStats()
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", 19, 19, healthMax+1, 22)
	love.graphics.setColor(50, 255, 50)
	love.graphics.rectangle("fill", 20, 20, healthAmount, 20)
	love.graphics.setColor(255, 255, 0, 255)
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