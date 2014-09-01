class Player < ActiveRecord::Base

  default_scope { order("player_id ASC") }

  def self.search(search_term = nil)
    Player.where("last_name LIKE ?", "%#{search_term}%").to_a
  end

end
