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
    elsif danger_ahead?
      boom_headshot
    elsif injured?
      heal_up
    elsif captive_close?
      play_da_hero
    elsif dead_end
      turn_around
    else
      advance
    end

    health_update
  end

  #ACTIONS

  def danger_close?
    @buns.feel.enemy? ||
    @buns.feel(:right).enemy? ||
    @buns.feel(:left).enemy? ||
    @buns.feel(:backward).enemy?
  end

  def danger_ahead?
    ((@buns.look[1].enemy?            && !@buns.look[0].captive?) ||
    (@buns.look(:right)[1].enemy?     && !@buns.look(:right)[0].captive?) ||
    (@buns.look(:left)[1].enemy?      && !@buns.look(:left)[0].captive?) ||
    (@buns.look(:backward)[1].enemy?  && !@buns.look(:backward)[0].captive?)) ||
    ((@buns.look[2].enemy?            && !@buns.look[1].captive?) ||
    (@buns.look(:right)[2].enemy?     && !@buns.look(:right)[1].captive?) ||
    (@buns.look(:left)[2].enemy?      && !@buns.look(:left)[1].captive?) ||
    (@buns.look(:backward)[2].enemy?  && !@buns.look(:backward)[1].captive?))
  end

  def boom_headshot
    @buns.shoot!
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
    @buns.feel.captive? ||
    @buns.feel(:right).captive? ||
    @buns.feel(:left).captive? ||
    @buns.feel(:backward).captive?
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

  def dead_end
    @buns.feel.wall?
  end

  def turn_around
    @buns.pivot!
  end

  def heal_up
    @buns.rest!
  end

  def health_update
    @health = @buns.health
  end
end
