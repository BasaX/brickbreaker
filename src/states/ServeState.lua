ServeState = Class{__includes = BaseState}

function ServeState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.highScores = params.highScores
    self.level = params.level
    self.boss = params.boss
    self.bossMap = params.bossMap

    self.ball = Ball()
    self.ball.skin = math.random(7)
    self.ball.isVisible = true
    self.ball.isActive = true

    self.ball2 = Ball()
    self.ball2.skin = math.random(7)

    self.ball3 = Ball()
    self.ball3.skin = math.random(7)

    self.powerup = PowerUp()

    self.powerup2 = PowerUp()

    self.powerup3 = PowerUp()

    self.powerupKey = PowerUp()
end

function ServeState:update(dt)

    self.paddle:update(dt)
    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball.y = self.paddle.y - 8

    self.ball2.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball2.y = self.paddle.y - 8

    self.ball3.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball3.y = self.paddle.y - 8

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
      if self.level % 3 == 0 then
        gStateMachine:change('boss', {
          paddle = self.paddle,
          bossMap = self.bossMap,
          health = self.health,
          score = self.score,
          highScores = self.highScores,
          ball = self.ball,
          level = self.level,
          powerup = self.powerup,
          ball2 = self.ball2,
          ball3 = self.ball3,
          powerup2 = self.powerup2,
          powerup3 = self.powerup3,
          powerupKey = self.powerupKey,
          boss = self.boss
      })
      else
        gStateMachine:change('play', {
            paddle = self.paddle,
            bricks = self.bricks,
            health = self.health,
            score = self.score,
            highScores = self.highScores,
            ball = self.ball,
            level = self.level,
            powerup = self.powerup,
            ball2 = self.ball2,
            ball3 = self.ball3,
            powerup2 = self.powerup2,
            powerup3 = self.powerup3,
            powerupKey = self.powerupKey
        })
      end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function ServeState:render()
    self.paddle:render()
    self.ball:render()
    self.powerup:render()
    self.powerup2:render()
    self.powerup3:render()
    self.powerupKey:render()

    if (self.level % 3 == 0) then
      self.boss:render()
    end

    self.ball2:render()
    self.ball3:render()

    if not (self.level % 3 == 0) then
      for k, brick in pairs(self.bricks) do
        brick:render()
      end
    end 

    if (self.level % 3 == 0) then
      for k, brick in pairs(self.bossMap) do
        brick:render()
      end
    end

    renderScore(self.score)
    renderHealth(self.health)

    if (self.level % 3 == 0) then
      love.graphics.setFont(gFonts['large'])
      love.graphics.printf('An Ancient awoke!!', 0, VIRTUAL_HEIGHT / 5,
          VIRTUAL_WIDTH, 'center')  
    end

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Level ' .. tostring(self.level), 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to serve!', 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')
end