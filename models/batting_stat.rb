class BattingStat < ActiveRecord::Base

  default_scope { order("player_id ASC") }

  def self.search(search_term = nil)
    BattingStat.where("player_id LIKE ?", "%#{search_term}%").to_a
  end

  def player
    Player.where(:player_id => player_id).first || nil
  end

end
