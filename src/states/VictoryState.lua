VictoryState = Class{__includes = BaseState}

function VictoryState:enter(params)
    self.level = params.level
    self.score = params.score
    self.highScores = params.highScores
    self.paddle = params.paddle
    self.health = params.health
    self.ball = params.ball

    self.boss = Boss()
    
    gSounds['boss-theme-2']:stop()
    gSounds['music']:play()
    gSounds['music']:setLooping(true)
end

function VictoryState:update(dt)
    self.paddle:update(dt)

    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball.y = self.paddle.y - 8

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self.boss.tier = self.level + 1
        self.boss.bossSkin =((self.level + 1) / 3) + gBossCounter,
        gStateMachine:change('serve', {
            level = self.level + 1,
            bricks = LevelMaker.createMap(self.level + 1),
            paddle = self.paddle,
            health = self.health,
            score = self.score,
            highScores = self.highScores,
            boss = self.boss,
            bossMap = LevelMaker.createBossMap()
        })
    end
end

function VictoryState:render()
    self.paddle:render()
    self.ball:render()

    renderHealth(self.health)
    renderScore(self.score)

    if (self.level % 3 == 0) then
      love.graphics.setFont(gFonts['large'])
      love.graphics.printf('The power of this Ancient is yours!!', 0, VIRTUAL_HEIGHT / 8,
          VIRTUAL_WIDTH, 'center')  
    end

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("Level " .. tostring(self.level) .. " complete!",
        0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to serve!', 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')
end