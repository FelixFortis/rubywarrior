class Player
  def initialize
    @health = 20
    @walls = 0
  end

  def play_turn(warrior)
    @buns = warrior

    if danger_close?
      bang_im_out
    elsif under_attack?
      if badly_injured?
        retreat
      else
        advance
      end
    elsif injured?
      heal_up
    elsif captive_close?
      play_da_hero
    elsif @walls == 0
      retreat
      walls
    else
      advance
    end

    health_update
  end

  #ACTIONS

  def danger_close?
    @buns.feel.enemy? || @buns.feel(:right).enemy? || @buns.feel(:left).enemy? || @buns.feel(:backward).enemy?
  end

  def under_attack?
    @health > @buns.health
  end

  def bang_im_out
    if @buns.feel.enemy?
      @buns.attack!
    elsif @buns.feel(:right).enemy?
      @buns.attack!(:right)
    elsif @buns.feel(:left).enemy?
      @buns.attack!(:left)
    elsif @buns.feel(:backward).enemy?
      @buns.attack!(:backward)
    end
  end

  def captive_close?
    @buns.feel.captive? || @buns.feel(:right).captive? || @buns.feel(:left).captive? || @buns.feel(:backward).captive?
  end

  def play_da_hero
    if @buns.feel.captive?
      @buns.rescue!
    elsif @buns.feel(:right).captive?
      @buns.rescue!(:right)
    elsif @buns.feel(:left).captive?
      @buns.rescue!(:left)
    elsif @buns.feel(:backward).captive?
      @buns.rescue!(:backward)
    end
  end

  def injured?
    @buns.health < 20
  end

  def badly_injured?
    @buns.health < 12
  end

  def advance
    @buns.walk!
  end

  def retreat
    @buns.walk!(:backward)
  end

  def walls
    if @buns.feel(:backward).wall?
      @walls = @walls + 1
    end
  end

  def heal_up
    @buns.rest!
  end

  def health_update
    @health = @buns.health
  end
end
