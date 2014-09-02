require_relative "batting_stat"

class Player < ActiveRecord::Base

  default_scope { order("player_id ASC") }

  def self.search(search_term = nil)
    Player.where("last_name LIKE ?", "%#{search_term}%").to_a
  end

  def batting_average year
    stat = BattingStat.where(:player_id => player_id, :year => year).first
    if stat
      (stat.hits.to_f / stat.at_bats.to_f).round(3)
    else
      0
    end
  end

  def improvement year1, year2
    av1 = batting_average(year1)
    av2 = batting_average(year2)
    if av1 > 0 && av2 > 0
      (av2 - av1).round(3)
    else
      0
    end
  end
  
end
