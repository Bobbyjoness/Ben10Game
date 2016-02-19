--play state 
local Play = {}

local sti = require "libs.STI"
local bump = require "bump.bump"

local Player = require "classes.player"
local cols
local player
local GRAVITY = 9.8
local map
local world


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
            break
        end
    end

    -- Remove unneeded object layer
    map:removeLayer("Spawn")

    player = Player(playerSpawn.x, playerSpawn.y, 32, 32, 0, 0, 200, 200, 100, world)
    player:setAcceleration(nil,GRAVITY*player.mass)
    player:setFriction(map.properties.friction)

	world:add(player, player.x, player.y, player.w, player.h)

end

function Play:enter( previous, ... ) -- run every time the state is entered

end

function Play:update(dt)
	map:update(dt)
	player:update(dt)

	if love.keyboard.isDown("d") then
		player:setAcceleration(100)
		player:setDirection(1)
	elseif love.keyboard.isDown("a") then
		player:setAcceleration(-100)
		player:setDirection(-1)
	end

end

function Play:draw()
	love.graphics.setColor(255,255,255)
	map:setDrawRange(0, 0, 800, 600)
	map:draw()
	love.graphics.rectangle( "fill",player.x,player.y,player.w,player.h )
	love.graphics.setColor(255, 255, 0, 255)
	love.graphics.setFont(love.graphics.newFont(12))
	love.graphics.print(love.timer.getFPS())
end

function Play:keypressed(key)
	if key == "space" and player.grounded then
		player:setVelocity(nil,-2000)
		player.grounded = false
	end
end

function Play:keyreleased(key)
	player:setAcceleration(0)
end

function Play:mousereleased(x,y, mouse_btn)
end

return Play