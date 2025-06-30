module DiceRollable
  extend ActiveSupport::Concern

  def roll_dice(dice_type, count = 1, modifier = 0)
    sides = dice_type.to_i
    rolls = Array.new(count) { rand(1..sides) }
    total = rolls.sum + modifier

    self.roll_data = {
      dice: "#{count}d#{sides}",
      modifier: modifier,
      rolls: rolls,
      total: total,
      details: build_roll_details(rolls, modifier)
    }

    self.content = build_roll_content(count, sides, modifier)
    self
  end

  private

  def build_roll_details(rolls, modifier)
    details = rolls.join(" + ")
    if modifier != 0
      operator = modifier > 0 ? " + " : " - "
      details += "#{operator}#{modifier.abs}"
    end
    details
  end

  def build_roll_content(count, sides, modifier)
    content = "#{player.name} rolled #{count}d#{sides}"
    content += " + #{modifier}" if modifier > 0
    content += " - #{modifier.abs}" if modifier < 0
    content
  end
end
