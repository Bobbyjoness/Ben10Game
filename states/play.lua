--play state 
local Play = {}

--3rd Party Libraries
local sti    = require "libs.STI"
local bump   = require "bump.bump"
local Camera = require "hump.camera"
local camera = Camera()

--My code
local Player  = require "classes.player"
local Martian = require "classes.martian"
local player
local map
local world
local enemies = {}

function Play:init() -- run only once

    -- Set Physics Meter
	world = bump.newWorld(64)
	-- Load map
	map = sti.new("maps/map1.lua", { "bump" })
	
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
   			table.insert(enemies,martian)
        end
    end

    -- Remove unneeded object layer
    map:removeLayer("Spawn")

    player = Player(playerSpawn.x, playerSpawn.y, 32, 32, 150, 400, 100, world)
    player:setAcceleration(nil,map.properties.GRAVITY*player.mass)
    player:setFriction(map.properties.friction)
end

function Play:enter( previous, ... ) -- run every time the state is entered

end

function Play:update(dt)
	map:update(dt)
	player:update(dt)
	for i,v in ipairs(enemies) do
		v:update(dt)
	end

	if love.keyboard.isDown("d") then
		player:setAcceleration(200)
		player:setDirection(1)
	elseif love.keyboard.isDown("a") then
		player:setAcceleration(-200)
		player:setDirection(-1)
	end

	camera:lockX(player.x)

end

function Play:draw()
	camera:attach()
	love.graphics.setColor(255,255,255)
	map:setDrawRange(0, 0, 800, 600)
	map:draw()
	player:draw()
	for i,v in ipairs(enemies) do
		v:draw()
	end
	camera:detach()
	love.graphics.setColor(255, 255, 0, 255)
	love.graphics.setFont(love.graphics.newFont(12))
	love.graphics.print(love.timer.getFPS())
end

function Play:keypressed(key)
	if key == "space" and player.grounded then
		player:setVelocity(nil,-3000)
	end
end

function Play:keyreleased(key)
	player:setAcceleration(0)
end

function Play:mousereleased(x,y, mouse_btn)
end

return Play