local function sign(number)
	if number > 0 then
		return 1
	elseif number < 0 then
		return -1
	else
		return 0
	end
end

local Player = Object:extend()

Player.pushRadius = 10

function Player:new()
	Player.super.new(self)

	self.widthRadius, self.heightRadius = 9, 19
	self.hitboxWidthRadius, self.hitboxHeightRadius = 8, self.heightRadius - 3

	self.xSpeed, self.ySpeed = 0, 0
	self.groundSpeed, self.groundAngle = 0, 0
	self.slopeFactor = 0.125

	self.grounded = true
	self.controlLockTimer = 0 -- prevents the player's input from adjusting the speed while grounded

	self.jumpForce = 6.5
end

function Player:update(dt)
	local topSpeed = 6
	if self.grounded then
		self.groundSpeed = self.groundSpeed - self.slopeFactor * math.sin(self.groundAngle)

		-- PLAYER INPUT
		local acceleration, deceleration = 0.046875, 0.5
		local leftInput, rightInput = false, false

		if self.controlLockTimer ~= 0 then
			leftInput, rightInput = input:down("left"), input:down("right")
			if leftInput then
				if self.groundSpeed > 0 then
					self.groundSpeed = self.groundSpeed - deceleration
					if self.groundSpeed <= 0 then
						self.groundSpeed = -0.5
					end
				elseif self.groundSpeed > -topSpeed then
					self.groundSpeed = self.groundSpeed - acceleration
					if self.groundSpeed <= -topSpeed then
						self.groundSpeed = -topSpeed
					end
				end
			elseif rightInput then
				if self.groundSpeed < 0 then
					self.groundSpeed = self.groundSpeed + deceleration
					if self.groundSpeed >= 0 then
						self.groundSpeed = 0.5
					end
				elseif self.groundSpeed < topSpeed then
					self.groundSpeed = self.groundSpeed + acceleration
					if self.groundSpeed >= topSpeed then
						self.groundSpeed = topSpeed
					end
				end
			end
		end

		if not leftInput and not rightInput then
			self.groundSpeed = self.groundSpeed -
				math.min(math.abs(self.groundSpeed), acceleration) * sign(self.groundSpeed)
		end
		--

		self.xSpeed = self.groundSpeed * math.cos(self.groundAngle)
		self.ySpeed = self.groundSpeed * -math.sin(self.groundAngle)
		self.x = self.x + self.xSpeed
		self.y = self.y + self.ySpeed

		if self.controlLockTimer == 0 then
			if math.abs(self.groundSpeed) < 2.5 and ((self.groundAngle >= 293 and self.groundAngle <= 326) or (self.groundAngle >= 35 and self.groundAngle <= 69)) then
				self.controlLockTimer = 30

				if self.groundAngle <= 293 and self.groundAngle >= 69 then
					self.grounded = false
				elseif self.groundAngle < 180 then
					self.groundAngle = self.groundAngle - 0.5
				else
					self.groundAngle = self.groundAngle + 0.5
				end
			end
		else
			self.controlLockTimer = self.controlLockTimer - 1
		end
	else
		local airAcceleration, gravityForce = 0.09375, 0.21875

		if input:down("left") then
			self.xSpeed = self.xSpeed - airAcceleration
			if self.groundSpeed <= -topSpeed then
				self.groundSpeed = -topSpeed
			end
		elseif input:down("right") then
			self.xSpeed = self.xSpeed + airAcceleration
			if self.groundSpeed >= topSpeed then
				self.groundSpeed = topSpeed
			end
		end

		if self.ySpeed < 0 and self.ySpeed > -4 then
			self.xSpeed = self.xSpeed - (self.xSpeed / 0.125) / 256
		end

		self.x = self.x + self.xSpeed
		self.y = self.y + self.ySpeed

		self.ySpeed = self.ySpeed + gravityForce
		if self.ySpeed > 16 then
			self.ySpeed = 16
		end

		-- TODO: Check underwater for reduced gravity

		if self.groundAngle ~= 0 then
			self.groundAngle = self.groundAngle + 2.8125
		end
	end
end

return Player
