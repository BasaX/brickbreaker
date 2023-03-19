BossState = Class{__includes = BaseState}

local bosses = {
  [1] = function() self.paddle.boss1Killed = true end,
  [2] = function() self.paddle.boss2Killed = true end,
  [3] = function() self.paddle.boss3Killed = true end,
  [4] = function() self.paddle.boss4Killed = true end,
  [5] = function() self.paddle.boss5Killed = true end,
  [6] = function() self.paddle.boss6Killed = true end,
  [7] = function() self.paddle.boss7Killed = true end,
}

function BossState:enter(params)
  self.paddle = params.paddle
  self.bricks = params.bossMap
  self.health = params.health
  self.score = params.score
  self.highScores = params.highScores
  self.ball = params.ball
  self.level = params.level
  self.powerup = params.powerup
  self.powerup2 = params.powerup2
  self.powerup3 = params.powerup3
  self.powerupKey = params.powerupKey
  self.boss = params.boss

  self.boss.dx = math.random(-200, 200)
  self.boss.dy = math.random(-50, -60)

  self.ball2 = params.ball2
  self.ball3 = params.ball3

  self.ball.dx = math.random(-200, 200)
  self.ball.dy = math.random(-50, -60)

  self.ball2.dx = math.random(-200, 200)
  self.ball2.dy = math.random(-50, -60)

  self.ball3.dx = math.random(-200, 200)
  self.ball3.dy = math.random(-50, -60)

  self.powerup.dx = 0
  self.powerup.dy = math.random(-50, -60)

  self.powerup.skin = math.random(2, 5)
  self.powerup.x = math.random(0, VIRTUAL_WIDTH - 16)
  self.powerup.y = -20

  self.powerup2.dx = 0
  self.powerup2.dy = math.random(-50, -60)

  self.powerup2.skin = math.random(2, 5)
  self.powerup2.x = math.random(0, VIRTUAL_WIDTH - 16)
  self.powerup2.y = -20
  self.powerup2.isVisible = false

  self.powerup3.dx = 0
  self.powerup3.dy = math.random(-50, -60)

  self.powerup3.skin = math.random(2, 5)
  self.powerup3.x = math.random(0, VIRTUAL_WIDTH - 16)
  self.powerup3.y = -20
  self.powerup3.isVisible = false

  self.powerupKey.dx = 0
  self.powerupKey.dy = math.random(-50, -60)

  self.powerupKey.skin = 7
  self.powerupKey.x = math.random(0, VIRTUAL_WIDTH - 16)
  self.powerupKey.y = -20
  self.powerupKey.isVisible = false
  self.powerupKey.duration = 999

  self.timer = 0
  self.powerupDrop = math.random(10, 30)

  self.timer2 = 0
  self.powerup2Drop = math.random(10, 30)

  self.timer3 = 0
  self.powerup3Drop = math.random(10, 30)

  gSounds['music']:stop()
  gSounds['boss-theme-2']:play()
  gSounds['boss-theme-2']:setLooping(true)
end


function BossState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    self.paddle:update(dt)

    if self.ball.isActive and self.ball.isVisible then
      self.ball:update(dt)
    end

    if self.ball2.isActive and self.ball2.isVisible then
      self.ball2:update(dt)
    end

    if self.ball3.isActive and self.ball3.isVisible then
      self.ball3:update(dt)
    end

    self.boss:update(dt)


    if self.powerup.isVisible then
        self.powerup:update(dt)
    end  
        -- powerup
    if self.powerup:collides(self.paddle) then
            self.powerup.y = 0
            self.powerup.dy = 0
            self.powerup.x = 10
            self.powerup.dx = 0
            self.powerup.isActive = true

            if self.powerup.skin == 1 then
              self.paddle:transform(1)
            end

            if self.powerup.skin == 2 then
              self.paddle:transform(2)
            end

            if self.powerup.skin == 3 then
              self.paddle:transform(3)
            end

            if self.powerup.skin == 4 then
              self.ball2.isActive = true
              self.ball2.isVisible = true
              self.ball3.isActive = true
              self.ball3.isVisible = true
            end

            if self.powerup.skin == 5 then
              self.health = self.health + 1
            end

            if self.powerup.skin == 6 then
              if self.health > 1 then
                self.health = self.health - 1
              end
            end


            gSounds['recover']:play()
        
    end

    if self.powerup2.isVisible then
      self.powerup2:update(dt)
    end
      -- powerup
    if self.powerup2:collides(self.paddle) then
          self.powerup2.y = 0
          self.powerup2.dy = 0
          self.powerup2.x = 10
          self.powerup2.dx = 0
          self.powerup2.isActive = true

          if self.powerup2.skin == 1 then
            self.paddle:transform(1)
          end

          if self.powerup2.skin == 2 then
            self.paddle:transform(2)
          end

          if self.powerup2.skin == 3 then
            self.paddle:transform(3)
          end

          if self.powerup2.skin == 4 then
            self.ball2.isActive = true
            self.ball2.isVisible = true
            self.ball3.isActive = true
            self.ball3.isVisible = true
          end

          if self.powerup2.skin == 5 then
            self.health = self.health + 1
          end

          if self.powerup2.skin == 6 then
            if self.health > 1 then
              self.health = self.health - 1
            end
          end


          gSounds['recover']:play()
    end
    

    if self.powerup3.isVisible then
      self.powerup3:update(dt)
    end
      -- powerup
    if self.powerup3:collides(self.paddle) then
          self.powerup3.y = 0
          self.powerup3.dy = 0
          self.powerup3.x = 10
          self.powerup3.dx = 0
          self.powerup3.isActive = true

          if self.powerup3.skin == 1 then
            self.paddle:transform(1)
          end

          if self.powerup3.skin == 2 then
            self.paddle:transform(2)
          end

          if self.powerup3.skin == 3 then
            self.paddle:transform(3)
          end

          if self.powerup3.skin == 4 then
            self.ball2.isActive = true
            self.ball2.isVisible = true
            self.ball3.isActive = true
            self.ball3.isVisible = true
          end

          if self.powerup2.skin == 5 then
            self.health = self.health + 1
          end

          if self.powerup2.skin == 6 then
            if self.health > 1 then
              self.health = self.health - 1
            end
          end


          gSounds['recover']:play()
    end
    


    if self.powerupKey.isVisible then
      self.powerupKey:update(dt)
    end

      if self.powerupKey:collides(self.paddle) then
          self.powerupKey.y = 0
          self.powerupKey.dy = 0
          self.powerupKey.x = 26
          self.powerupKey.dx = 0
          self.powerupKey.isActive = true

          gSounds['recover']:play()
      end
    

    --aca reseteo los efectos del powerup
    if not self.powerup.isActive and not self.powerup2.isActive and not self.powerup3.isActive then
      self.paddle:transform(0)
    end


    if self.ball.isVisible and self.ball.isActive and self.ball:collides(self.paddle) then
      self.ball.y = self.paddle.y - 8
      self.ball.dy = -self.ball.dy

      if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
          self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
      
      elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
          self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
      end

      gSounds['paddle-hit']:play()
    end

    if self.ball2.isVisible and self.ball2.isActive and self.ball2:collides(self.paddle) then
      self.ball2.y = self.paddle.y - 8
      self.ball2.dy = -self.ball2.dy

      if self.ball2.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
          self.ball2.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball2.x))
      
      elseif self.ball2.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
          self.ball2.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball2.x))
      end

      gSounds['paddle-hit']:play()
    end

    if self.ball2.isVisible and self.ball3.isActive and self.ball3:collides(self.paddle) then
      self.ball3.y = self.paddle.y - 8
      self.ball3.dy = -self.ball3.dy

      if self.ball3.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
          self.ball3.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball3.x))
      
      elseif self.ball3.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
          self.ball3.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball3.x))
      end

      gSounds['paddle-hit']:play()
    end

    for k, brick in pairs(self.bricks) do

      if brick.inPlay and self.ball:collides(brick) then

          if brick.isSpecial and self.powerupKey.isActive then
            brick.isSpecial = false
          end

          if brick.isSpecial then
            self.score = self.score
          else
            self.score = self.score + (brick.tier * 200 + brick.color * 25)
          end
           
          if brick.isSpecial then
            brick:hitSpecial()
            self.powerupKey.isVisible = true
          else
            brick:hit()
          end

          if self.ball.x + 2 < brick.x and self.ball.dx > 0 then
                
            self.ball.dx = -self.ball.dx
            self.ball.x = brick.x - 8
        
          elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then
              
              self.ball.dx = -self.ball.dx
              self.ball.x = brick.x + 32
          
          elseif self.ball.y < brick.y then
              
              self.ball.dy = -self.ball.dy * 1.01
              self.ball.y = brick.y - 8
          
          else
              
              self.ball.dy = -self.ball.dy * 1.01
              self.ball.y = brick.y + 16
          end

          if math.abs(self.ball.dy) < 150 then
            self.ball.dy = self.ball.dy * 1.04
          end

          break
      end

      if brick.inPlay and self.ball2:collides(brick) then

        if brick.isSpecial and self.powerupKey.isActive then
          brick.isSpecial = false
        end

        if brick.isSpecial then
          self.score = self.score
        else
          self.score = self.score + (brick.tier * 200 + brick.color * 25)
        end
         
        if brick.isSpecial then
          brick:hitSpecial()
          self.powerupKey.isVisible = true
        else
          brick:hit()
        end


        if self.ball2.x + 2 < brick.x and self.ball2.dx > 0 then
              
          self.ball2.dx = -self.ball2.dx
          self.ball2.x = brick.x - 8
      
        elseif self.ball2.x + 6 > brick.x + brick.width and self.ball2.dx < 0 then
            
            self.ball2.dx = -self.ball2.dx
            self.ball2.x = brick.x + 32
        
        elseif self.ball2.y < brick.y then
            
            self.ball2.dy = -self.ball2.dy * 1.02
            self.ball2.y = brick.y - 8
        
        else
            
            self.ball2.dy = -self.ball2.dy * 1.02
            self.ball2.y = brick.y + 16
        end

        if math.abs(self.ball2.dy) < 150 then
          self.ball2.dy = self.ball2.dy * 1.08
        end

      end

      if brick.inPlay and self.ball3:collides(brick) then

          if brick.isSpecial and self.powerupKey.isActive then
            brick.isSpecial = false
          end

          if brick.isSpecial then
            self.score = self.score
          else
            self.score = self.score + (brick.tier * 200 + brick.color * 25)
          end
           
          if brick.isSpecial then
            brick:hitSpecial()
            self.powerupKey.isVisible = true
          else
            brick:hit()
          end


        if self.ball3.x + 2 < brick.x and self.ball3.dx > 0 then
              
          self.ball3.dx = -self.ball3.dx
          self.ball3.x = brick.x - 8
      
        elseif self.ball3.x + 6 > brick.x + brick.width and self.ball3.dx < 0 then
            
            self.ball3.dx = -self.ball3.dx
            self.ball3.x = brick.x + 32
        
        elseif self.ball3.y < brick.y then
            
            self.ball3.dy = -self.ball3.dy * 1.02
            self.ball3.y = brick.y - 8
        
        else
            
            self.ball3.dy = -self.ball3.dy * 1.02
            self.ball3.y = brick.y + 16
        end

        if math.abs(self.ball3.dy) < 150 then
          self.ball3.dy = self.ball3.dy * 1.08
        end

      end
    end

    --chequeo colisiones con el boss
    if self.boss.inPlay and self.ball:collides(self.boss) then

        self.boss:hit()

        if self:checkVictory() then
          gSounds['victory']:play()

          gStateMachine:change('victory', {
              level = self.level,
              paddle = self.paddle,
              health = self.health,
              score = self.score + 8000,
              highScores = self.highScores,
              ball = self.ball
          })
        end


        if self.ball.x + 2 < self.boss.x and self.ball.dx > 0 then
            
          self.ball.dx = -self.ball.dx * (ternary(self.boss.bossState == 1, function() return 1.1 end, function() return 1.3 end))
          self.ball.x = self.boss.x - 8
      
        elseif self.ball.x + 6 > self.boss.x + self.boss.width and self.ball.dx < 0 then
            
            self.ball.dx = -self.ball.dx * (ternary(self.boss.bossState == 1, function() return 1.1 end, function() return 1.3 end))
            self.ball.x = self.boss.x + 64
        
        elseif self.ball.y < self.boss.y then
            
            self.ball.dy = -self.ball.dy * (ternary(self.boss.bossState == 1, function() return 1.1 end, function() return 1.3 end))
            self.ball.y = self.boss.y - 8
        
        else
            
            self.ball.dy = -self.ball.dy * (ternary(self.boss.bossState == 1, function() return 1.1 end, function() return 1.3 end))
            self.ball.y = ternary(self.boss.bossState == 1, function() return self.boss.y + 18 end, function() return self.boss.y + 66 end)
        end

        if math.abs(self.ball.dy) < 150 then
          self.ball.dy = self.ball.dy * 1.08
        end
    end

    if self.boss.inPlay and self.ball2:collides(self.boss) then

      self.boss:hit()

      if self:checkVictory() then
        gSounds['victory']:play()

        gStateMachine:change('victory', {
            level = self.level,
            paddle = self.paddle,
            health = self.health,
            score = self.score + 8000,
            highScores = self.highScores,
            ball = self.ball
        })
      end


      if self.ball2.x + 2 < self.boss.x and self.ball2.dx > 0 then
            
        self.ball2.dx = -self.ball2.dx * (ternary(self.boss.bossState == 1, function() return 1.1 end, function() return 1.3 end))
        self.ball2.x = self.boss.x - 8
    
      elseif self.ball2.x + 6 > self.boss.x + self.boss.width and self.ball2.dx < 0 then
          
          self.ball2.dx = -self.ball2.dx * (ternary(self.boss.bossState == 1, function() return 1.1 end, function() return 1.3 end))
          self.ball2.x = self.boss.x + 64
      
      elseif self.ball2.y < self.boss.y then
          
          self.ball2.dy = -self.ball2.dy * (ternary(self.boss.bossState == 1, function() return 1.1 end, function() return 1.3 end))
          self.ball2.y = self.boss.y - 8
      
      else
          
          self.ball2.dy = -self.ball2.dy * (ternary(self.boss.bossState == 1, function() return 1.1 end, function() return 1.3 end))
          self.ball2.y = ternary(self.boss.bossState == 1, function() return self.boss.y + 18 end, function() return self.boss.y + 66 end)
      end

      if math.abs(self.ball2.dy) < 150 then
        self.ball2.dy = self.ball2.dy * 1.08
      end

  end

  if self.boss.inPlay and self.ball3:collides(self.boss) then

    self.boss:hit()

    if self:checkVictory() then
      gSounds['victory']:play()

      local option = self.level / 3
      local func = bosses[option]
      if func then
        func()
      end

      gStateMachine:change('victory', {
          level = self.level,
          paddle = self.paddle,
          health = self.health,
          score = self.score + 8000,
          highScores = self.highScores,
          ball = self.ball
      })
    end


    if self.ball3.x + 2 < self.boss.x and self.ball3.dx > 0 then
          
      self.ball3.dx = -self.ball3.dx * (ternary(self.boss.bossState == 1, function() return 1.1 end, function() return 1.3 end))
      self.ball3.x = self.boss.x - 8
  
    elseif self.ball3.x + 6 > self.boss.x + self.boss.width and self.ball3.dx < 0 then
        
        self.ball3.dx = -self.ball3.dx * (ternary(self.boss.bossState == 1, function() return 1.1 end, function() return 1.3 end))
        self.ball3.x = self.boss.x + 64
    
    elseif self.ball3.y < self.boss.y then
        
        self.ball3.dy = -self.ball3.dy * (ternary(self.boss.bossState == 1, function() return 1.1 end, function() return 1.3 end))
        self.ball3.y = self.boss.y - 8
    
    else
        
        self.ball3.dy = -self.ball3.dy * (ternary(self.boss.bossState == 1, function() return 1.1 end, function() return 1.3 end))
        self.ball3.y = ternary(self.boss.bossState == 1, function() return self.boss.y + 18 end, function() return self.boss.y + 66 end)
    end

    if math.abs(self.ball3.dy) < 150 then
      self.ball3.dy = self.ball3.dy * 1.08
    end

end

    if self.ball.y >= VIRTUAL_HEIGHT then
      self.ball.isActive = true
      if self.ball2.isActive == false and self.ball3.isActive == false then
        self.health = self.health - 1
        gSounds['hurt']:play()

        if self.health == 0 then
            gStateMachine:change('game-over', {
                score = self.score,
                highScores = self.highScores
            })
        else
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bossMap = self.bricks,
                health = self.health,
                score = self.score,
                highScores = self.highScores,
                level = self.level,
                boss = self.boss
            })
        end
      end
    end

    if self.ball2.y >= VIRTUAL_HEIGHT then
        self.ball2.isActive = true
        if self.ball.isActive == false and self.ball3.isActive == false then
          self.health = self.health - 1
          gSounds['hurt']:play()

          if self.health == 0 then
              gStateMachine:change('game-over', {
                  score = self.score,
                  highScores = self.highScores
              })
          else
              gStateMachine:change('serve', {
                  paddle = self.paddle,
                  bossMap = self.bricks,
                  health = self.health,
                  score = self.score,
                  highScores = self.highScores,
                  level = self.level,
                  boss = self.boss
              })
          end
        end
    end

    if self.ball3.y >= VIRTUAL_HEIGHT then
      self.ball3.isActive = true
      if self.ball2.isActive == false and self.ball.isActive == false then
        self.health = self.health - 1
        gSounds['hurt']:play()

        if self.health == 0 then
            gStateMachine:change('game-over', {
                score = self.score,
                highScores = self.highScores
            })
        else
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bossMap = self.bricks,
                health = self.health,
                score = self.score,
                highScores = self.highScores,
                level = self.level,
                boss = self.boss
            })
        end
      end
    end

    -- particles
    for k, brick in pairs(self.bricks) do
      brick:update(dt)
    end


    if not self.powerup.isVisible then
      self.timer = self.timer + dt

      if self.timer > COUNTDOWN_TIME then
          self.timer = self.timer % COUNTDOWN_TIME
          self.powerupDrop = self.powerupDrop - 1
    
          if self.powerupDrop == 0 then
              self.powerup.isVisible = true
          end
      end
    end
    
    if not self.powerup2.isVisible and self.powerupDrop == 0 and self.powerup.isVisible == false and self.powerup.isActive == false then
      self.timer2 = self.timer2 + dt

      if self.timer2 > COUNTDOWN_TIME then
          self.timer2 = self.timer2 % COUNTDOWN_TIME
          self.powerup2Drop = self.powerup2Drop - 1
    
          if self.powerup2Drop == 0 then
              self.powerup2.isVisible = true
          end
      end
    end
    
    if not self.powerup3.isVisible and self.powerup2Drop == 0 and self.powerup2.isVisible == false and self.powerup2.isActive == false then
      self.timer3 = self.timer3 + dt

      if self.timer3 > COUNTDOWN_TIME then
          self.timer3 = self.timer3 % COUNTDOWN_TIME
          self.powerup3Drop = self.powerup3Drop - 1
    
          if self.powerup3Drop == 0 then
              self.powerup3.isVisible = true
          end
      end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end



function BossState:render()

    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    for k, brick in pairs(self.bricks) do
      brick:renderParticles()
    end

    self.paddle:render()
    self.ball:render()
    self.powerup:render()
    self.powerup2:render()
    self.powerup3:render()
    self.powerupKey:render()

    self.boss:render()

    self.ball2:render()
    self.ball3:render()

    renderScore(self.score)
    renderHealth(self.health)

    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end


function BossState:checkVictory()
  if self.boss.inPlay then
      return false
  end 

  return true
end