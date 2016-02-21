--libs
local Gamestate = require 'hump.gamestate'

--mycode
local playState = require 'states.play'

function love.load()
	Gamestate.switch(playState)
	Gamestate.registerEvents()
end

function love.update()

end

function love.draw()

end