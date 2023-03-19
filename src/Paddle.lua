Paddle = Class{}

local cases = {
  [0] = 64,  --default paddle
	[1] = 32,  --s paddle
	[2] = 96,  --xl paddle
	[3] = 128,   --xxl paddle
  [17] = 192
}

local sizes = {
  [0] = 2,
  [1] = 1,
  [2] = 3,
  [3] = 4,
  [17] = 17
}


function Paddle:init(skin)
    self.x = VIRTUAL_WIDTH / 2 - 32

    self.y = VIRTUAL_HEIGHT - 32

    self.dx = 0

    self.width = 64
    self.height = 16

    self.skin = skin

    self.size = 2

    self.boss1Killed = true
    self.boss2Killed = true
    self.boss3Killed = false
    self.boss4Killed = false
    self.boss5Killed = false
    self.boss6Killed = false
    self.boss7Killed = false

    self.boss2Skill = false
    self.timer = 0
    self.boss2SkillDuration = 26
    self.boss2SkillSpeed = 0
end

function Paddle:transform(size)
    self.size = sizes[size]
    self.width = cases[size]
end

function Paddle:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.dx = ternary(self.boss1Killed == false, function() return -PADDLE_SPEED end, function() return -PADDLE_SPEED - 90 - self.boss2SkillSpeed end)
    elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.dx = ternary(self.boss1Killed == false, function() return PADDLE_SPEED end, function() return PADDLE_SPEED + 90 + self.boss2SkillSpeed end)
    else
        self.dx = 0
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end

    if self.boss2Killed and self.timer == 0 then
      if love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        self.boss2Skill = true
        self.boss2SkillSpeed = 350
      end
    end

        --coutndown skill2
    if self.boss2Skill then
          self.timer = self.timer + dt
    
          if self.timer > COUNTDOWN_TIME then
              self.timer = self.timer % COUNTDOWN_TIME
              self.boss2SkillDuration = self.boss2SkillDuration - 1
        
          if self.boss2SkillDuration == 0 then
              self.boss2Skill = false
              self.boss2SkillDuration = 26
              self.boss2SkillSpeed = 0
          end
      end
    end

end

function Paddle:render()
  if self.boss2Skill then
    love.graphics.draw(gTextures['main'], gFrames['paddles'][17],
        self.x, self.y)
  else
    love.graphics.draw(gTextures['main'], gFrames['paddles'][self.size + 4 * (self.skin - 1)],
        self.x, self.y)
  end
end