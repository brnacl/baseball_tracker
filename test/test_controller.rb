require_relative 'helper'
require_relative 'capture_stdout'
require_relative '../lib/template'
require_relative '../lib/controller'

class TestController < BaseballTest

  def setup
    @controller = Controller.new(Template.new)
  end

  def test_import_players_saves_to_database
    @controller.file_import "test/data-test-players.csv", "players"
    num_players = Player.count
    assert_operator num_players, :>, 0
  end

  def test_import_stats
    @controller.file_import "test/data-test-stats.csv", "stats"
    num_stats = BattingStat.count
    assert_operator num_stats, :>, 0
  end

  def test_imported_players_have_id
    @controller.file_import "test/data-test-players.csv", "players"
    players = Player.all
    refute_nil players[0].id, "Player id shouldn't be nil"
  end

  def test_imported_batting_stats_have_id
    @controller.file_import "test/data-test-stats.csv", "stats"
    stats = BattingStat.all
    refute_nil stats[0].id, "Batting Stat id shouldn't be nil"
  end
  
end