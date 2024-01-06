local rs = require("lib.resolution_solution")

Class = require "lib.classic"
Object = require "hedge2d.Object"

local Player = require "hedge2d.Player"

local pl = Player()

function love.load()
	rs.conf({ game_width = 320, game_height = 224, scale_mode = 3 })
end

function love.draw()
	rs.push()
	local x, y, w, h = love.graphics.getScissor()
	love.graphics.setScissor(rs.get_game_zone())

	pl:draw()

	love.graphics.setScissor(x, y, w, h)
	rs.pop()
end

function love.resize()
	rs.resize()
end
