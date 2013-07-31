class Player
  def initialize
    @health = 20
  end

  def play_turn(warrior)
    @buns = warrior

    if !@buns.feel.empty?
      @buns.attack!
    else
      if under_attack?
        @buns.walk!
      else
        if @buns.health < 20
          @buns.rest!
        else
          @buns.walk!
        end
      end
    end
    @health = @buns.health
  end

  def under_attack?
    @health > @buns.health
  end
end
