io.stdout:setvbuf("no")
love.graphics.setDefaultFilter("nearest", "nearest")

local rs = require "lib.resolution_solution"

input = require("lib.baton").new({
	controls = {
		left = { 'key:left', 'key:a', 'axis:leftx-', 'button:dpleft' },
		right = { 'key:right', 'key:d', 'axis:leftx+', 'button:dpright' },
		up = { 'key:up', 'key:w', 'axis:lefty-', 'button:dpup' },
		down = { 'key:down', 'key:s', 'axis:lefty+', 'button:dpdown' },
		action = { 'key:a', 'key:space', 'button:a' },
	},
	joystick = love.joystick.getJoysticks()[1],
})

Class = require "lib.classic"
Object = require "hedge2d.Object"

local Player = require "hedge2d.Player"

local pl = Player()

function love.load()
	rs.conf({ game_width = 320, game_height = 224, scale_mode = 3 })
end

function love.update(dt)
	input:update()
	pl:update()
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
