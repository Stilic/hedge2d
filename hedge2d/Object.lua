local Object = Class:extend()

function Object:new()
	self.x, self.y = 0, 0

	self.widthRadius, self.heightRadius = 0, 0
	self.hitboxWidthRadius, self.hitboxHeightRadius = 0, 0
end

function Object:getWidth()
	return self.widthRadius * 2 + 1
end

function Object:getHeight()
	return self.heightRadius * 2 + 1
end

function Object:getHitboxWidth()
	return self.hitboxWidthRadius * 2 + 1
end

function Object:getHitboxHeight()
	return self.hitboxHeightRadius * 2 + 1
end

function Object:topLeftSensor()
	return self.x - self:getWidth(), self.y - self:getHeight()
end

function Object:topRightSensor()
	return self.x + self:getWidth(), self.y - self:getHeight()
end

function Object:leftSensor()
	return self.x - self:getWidth(), self.y
end

function Object:rightSensor()
	return self.x + self:getWidth(), self.y
end

function Object:bottomLeftSensor()
	return self.x - self:getWidth(), self.y + self:getHeight()
end

function Object:bottomRightSensor()
	return self.x + self:getWidth(), self.y + self:getHeight()
end

function Object:draw()
	local r, g, b, a = love.graphics.getColor()

	love.graphics.setColor(0.5, 0.7, 0.2, 0.5)

	love.graphics.rectangle("fill", self.x, self.y, self:getWidth(), self:getHeight())

	love.graphics.setColor(r, g, b, a)
end

return Object
