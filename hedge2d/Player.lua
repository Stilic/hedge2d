local Player = Object:extend()

Player.pushRadius = 10

function Player:new()
	Player.super.new(self)

	self.widthRadius, self.heightRadius = 9, 19
	self.hitboxWidthRadius, self.hitboxHeightRadius = 8, self.heightRadius - 3

	self.jumpForce = 6.5
end

return Player
