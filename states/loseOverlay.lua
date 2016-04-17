local Lose = {}
local font
function Lose:enter(PreviousState)
    self.previousState = PreviousState
end

function Lose:init()
	font = love.graphics.newFont(30)
end

function Lose:update(dt)

end

function Lose:draw()
	self.previousState:draw()
	love.graphics.setColor(0, 0, 0, 127)
	love.graphics.rectangle("fill", 0, 0, 800, 600)
	love.graphics.setFont(font)
	love.graphics.setColor(255, 255, 255)
	love.graphics.print("You Died :P")

end

return Lose