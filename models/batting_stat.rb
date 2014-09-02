class BattingStat < ActiveRecord::Base

  default_scope { order("player_id ASC") }

  def self.search(search_term = nil)
    BattingStat.where("player_id LIKE ?", "%#{search_term}%").to_a
  end

  def self.most_improved year1, year2
    stats = BattingStat.where(:year => year1, :year => year2).where("at_bats >= 200")
    
    players = []
    
    stats.each do |stat|
      if !players.any? {|h| h[:player_id] == stat.player_id}
        players << stat.player
      end
    end

    most_improved_player = players.max_by do |player|
      player.improvement year1, year2
    end
    most_improved_player
  
  end

  def player
    Player.where(:player_id => player_id).first
  end

end
