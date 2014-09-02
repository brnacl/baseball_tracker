class BattingStat < ActiveRecord::Base

  default_scope { order("player_id ASC") }

  def self.search(search_term = nil)
    BattingStat.where("player_id LIKE ?", "%#{search_term}%").order("year DESC").to_a
  end

end
