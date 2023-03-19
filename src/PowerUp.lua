PowerUp = Class{}

function PowerUp:init(skin)
    self.width = 16
    self.height = 16

    self.dy = 0
    self.dx = 0

    self.skin = skin

    self.duration = 18
    self.timer = 0

    self.isActive = false
    self.isVisible = false
end

function PowerUp:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    return true
end


function PowerUp:update(dt)
    self.x = self.x
    self.y = self.y - self.dy * dt

    --Colisión con piso
    if self.y >= VIRTUAL_HEIGHT then
      if self.duration > 900 then
        self.x = math.random(0, VIRTUAL_WIDTH - 16)
        self.y = -20
      else
        self.isVisible = false
        self.isActive = false
      end
    end

    --coutndown powerup
    if self.isActive then
      self.timer = self.timer + dt

      if self.timer > COUNTDOWN_TIME then
          self.timer = self.timer % COUNTDOWN_TIME
          self.duration = self.duration - 1
    
          if self.duration == 0 then
              self.isActive = false
              self.isVisible = false
          end
      end
    end
end

function PowerUp:render()
  if self.isVisible == true then
    love.graphics.draw(gTextures['main'], gFrames['powerups'][self.skin],
        self.x, self.y)
  end
end