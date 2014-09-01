class CreateBattingStats < ActiveRecord::Migration
  def change
    create_table :batting_stats do |t|
      t.string :player_id
      t.integer :year
      t.string :league
      t.string :team
      t.integer :games
      t.integer :at_bats
      t.integer :runs_scored
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :home_runs
      t.integer :runs_batted_in
      t.integer :stolen_bases
      t.integer :caught_stealing
    end
  end
end