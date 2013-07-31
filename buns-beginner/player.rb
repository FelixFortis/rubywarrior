class Player
  def initialize
    @health = 20
  end

  def play_turn(warrior)
    @buns = warrior

    if danger_close?
      bang_im_out
    elsif under_attack?
      if badly_injured?
        @buns.walk!(:backward)
      else
        @buns.walk!
      end
    elsif injured?
      @buns.rest!
    elsif captive_close?
      play_da_hero
    else
      @buns.walk!
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

  def health_update
    @health = @buns.health
  end
end
