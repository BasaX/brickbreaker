Boss = Class{}

paletteColors = {
  -- blue
  [1] = {
      ['r'] = 99,
      ['g'] = 155,
      ['b'] = 255
  },
  -- green
  [2] = {
      ['r'] = 106,
      ['g'] = 190,
      ['b'] = 47
  },
  -- red
  [3] = {
      ['r'] = 217,
      ['g'] = 87,
      ['b'] = 99
  },
  -- purple
  [4] = {
      ['r'] = 215,
      ['g'] = 123,
      ['b'] = 186
  },
  -- gold
  [5] = {
      ['r'] = 251,
      ['g'] = 242,
      ['b'] = 54
  }
}


function Boss:init()
    self.tier = 4
    self.color = 1
    
    self.x = 150
    self.y = 28
    self.dx = 0
    self.dy = 0

    self.width = 64
    self.height = ternary(self.bossState == 1, function() return 16 end, function() return 64 end)
    
    self.inPlay = true
    self.bossState = 1
    self.bossSkin = 1

    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64) --particle to emit on hit
    self.psystem:setParticleLifetime(0.5, 1) -- (from, to) seconds
    self.psystem:setLinearAcceleration(-15, 0, 15, 80) --aceleracion en (x1, y1, x2, y2)
    self.psystem:setEmissionArea('normal', 10, 10)
end

function Boss:hit()

  self.psystem:setColors(
    paletteColors[self.color].r / 255,
    paletteColors[self.color].g / 255,
    paletteColors[self.color].b / 255,
    55 * (self.tier + 1) / 255,
    paletteColors[self.color].r / 255,
    paletteColors[self.color].g / 255,
    paletteColors[self.color].b / 255,
    0
  )

  self.psystem:emit(64)
  

  gSounds['boss-hit-2']:stop()
  gSounds['boss-hit-2']:play()

  if self.tier == 2 then 
    self.bossState = 2
  end


  if self.tier > 0 then
      if self.color == 1 then
          self.tier = self.tier - 1
          self.color = 5
      else
          self.color = self.color - 1
      end
  else
      if self.color == 1 then
          self.inPlay = false
      else
          self.color = self.color - 1
      end
  end

  gSounds['boss-hit-1']:stop()
  gSounds['boss-hit-1']:play()

end

-- function Boss:reset()
--     self.tier = 4
--     self.color = 1
    
--     self.x = 150
--     self.y = 28
--     self.dx = 0
--     self.dy = 0
    
--     self.inPlay = true
--     self.bossState = 1
--     self.bossSkin = 3
    
--     self.width = 64
--     self.height = ternary(self.bossState == 1, function() return 16 end, function() return 64 end)
-- end

function Boss:update(dt)
  
  self.height = ternary(self.bossState == 1, function() return 16 end, function() return 64 end)
  self.x = self.x + self.dx * dt

  if self.tier <= 3 then
    self.y = self.y + self.y * dt
  else
    self.y = self.y
  end

    --Colisión con paredes y techo
    if self.x <= 82 then
        self.x = 82
        self.dx = -self.dx
    end

    if self.x >= 352 then
        self.x = 352
        self.dx = -self.dx
    end

    if self.y <= 0 then
      self.y = 0
      self.dy = -self.dy
    end

    if self.y >= 48 then
        self.y = 48
        self.dy = -self.dy
    end 

  self.psystem:update(dt)
end

function Boss:render()
  if self.bossState == 1 then
    love.graphics.draw(gTextures['bossesSprite'], gFrames['bosses'][self.bossSkin], self.x, self.y)
  end

  if self.bossState == 2 then
    love.graphics.draw(gTextures['bossesSprite'], gFrames['bosses'][(self.bossSkin + 1)], self.x, self.y)
  end
end

function Boss:renderParticles()
  love.graphics.draw(self.psystem, self.x + 64, self.y + 16)
end