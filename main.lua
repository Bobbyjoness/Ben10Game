local Gamestate = require 'hump.gamestate'

local playState = require 'states.play'

function love.load()
	Gamestate.switch(playState)
	Gamestate.registerEvents()
end

