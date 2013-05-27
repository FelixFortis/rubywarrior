class Player

  def initialize
    @health = 20
    @bounce = 0
  end

  def play_turn(warrior)
    @warrior = warrior
    if danger_close?
      bang_him_out
    elsif slightly_hurt? && !taking_damage?
      heal
    elsif captive_close?
      hero_time
    elsif archer_issues?
      retreat
    elsif @warrior.feel.wall?
        @warrior.pivot!
    else
      move_forward
    end
    @health = @warrior.health
  end

###################################################################################

  def danger_close?
    @warrior.feel.enemy? || @warrior.feel(:backward).enemy?
  end

  def bang_him_out
    if @warrior.feel.enemy?
      @warrior.attack!
    elsif @warrior.feel(:backward).enemy?
      @warrior.attack!(:backward)
    end
  end

  def slightly_hurt?
    @warrior.health < 20
  end

  def badly_hurt?
    @warrior.health < 12
  end

  def taking_damage?
    @warrior.health < @health
  end

  def heal
    @warrior.rest!
  end

  def move_forward
    @warrior.walk!
  end

  def move_backward
    @warrior.walk!(:backward)
  end

  def captive_close?
    @warrior.feel.captive? || @warrior.feel(:backward).captive?
  end

  def hero_time
    if @warrior.feel.captive?
      @warrior.rescue!
    elsif @warrior.feel(:backward).captive?
      @warrior.rescue!(:backward)
    end
  end

  def archer_issues?
    taking_damage? && !danger_close? && badly_hurt?
  end

  def retreat
    move_backward unless @warrior.feel(:backward).wall?
  end

  def bounce
    if @warrior.feel(:backward).wall?
      @bounce += 1
    end
  end
end
