class Player

  def play_turn(warrior)
    @warrior = warrior
    if danger_close?
      bang_him_out
    elsif hurt? && !taking_damage?
      heal
    elsif captive_close?
      hero_time
    else
      move_forward
    end
    @health = @warrior.health
  end

###################################################################################

  def danger_close?
    @warrior.feel.enemy?
  end

  def bang_him_out
    @warrior.attack!
  end

  def hurt?
    @warrior.health < 20
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

  def captive_close?
    @warrior.feel.captive?
  end

  def hero_time
    @warrior.rescue!
  end
end
