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

  def test_most_improved_returns_nil_if_no_stats
    player = @controller.most_improved_player(2007,2009)
    assert_equal nil, player
  end

  def test_most_improved_returns_player
    BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    BattingStat.create(player_id: "abreubo01", year: 2008, league: "AL", team: "NYA", games: 156, at_bats: 609, runs_scored: 100, hits: 180, doubles: 39, triples: 4, home_runs: 20, runs_batted_in: 100, stolen_bases: 22, caught_stealing: 11)
    Player.create(player_id: "abreubo01", birth_year: 1974, first_name: "Bobby", last_name: "Abreu")
    player = @controller.most_improved_player(2008,2009)
    assert_equal true, player.is_a?(Player)
  end

  def test_most_improved_returns_nil_if_no_stats
    player = @controller.most_improved_player(2007,2009)
    assert_equal nil, player
  end

  def test_most_improved_returns_player
    BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    BattingStat.create(player_id: "abreubo01", year: 2008, league: "AL", team: "NYA", games: 156, at_bats: 609, runs_scored: 100, hits: 180, doubles: 39, triples: 4, home_runs: 20, runs_batted_in: 100, stolen_bases: 22, caught_stealing: 11)
    Player.create(player_id: "abreubo01", birth_year: 1974, first_name: "Bobby", last_name: "Abreu")
    player = @controller.most_improved_player(2008,2009)
    assert_equal true, player.is_a?(Player)
  end

  def test_team_slugging_percentage_returns_nil_if_no_stats
    percentage = @controller.team_slugging_percentage("OAK",2008)
    assert_equal nil, percentage
  end

  def test_team_slugging_percentage_returns_float
    BattingStat.create(player_id: "abreubo01", year: 2008, league: "AL", team: "NYA", games: 156, at_bats: 609, runs_scored: 100, hits: 180, doubles: 39, triples: 4, home_runs: 20, runs_batted_in: 100, stolen_bases: 22, caught_stealing: 11)
    BattingStat.create(player_id: "abreubo01", year: 2008, league: "AL", team: "NYA", games: 156, at_bats: 609, runs_scored: 100, hits: 180, doubles: 39, triples: 4, home_runs: 20, runs_batted_in: 100, stolen_bases: 22, caught_stealing: 11)
    BattingStat.create(player_id: "abreubo01", year: 2008, league: "AL", team: "NYA", games: 156, at_bats: 609, runs_scored: 100, hits: 180, doubles: 39, triples: 4, home_runs: 20, runs_batted_in: 100, stolen_bases: 22, caught_stealing: 11)
    percentage = @controller.team_slugging_percentage("NYA",2008)
    assert_equal true, percentage.is_a?(Float)
  end

  def test_team_slugging_percentage_returns_nil_if_no_winner
    BattingStat.create(player_id: "abreubo01", year: 2012, league: "AL", team: "LAA", games: 10, at_bats: 100, runs_scored: 10, hits: 180, doubles: 39, triples: 4, home_runs: 0, runs_batted_in: 0, stolen_bases: 22, caught_stealing: 11)
    BattingStat.create(player_id: "abreuto01", year: 2012, league: "AL", team: "KCA", games: 10, at_bats: 100, runs_scored: 0, hits: 0, doubles: 39, triples: 4, home_runs: 20, runs_batted_in: 0, stolen_bases: 22, caught_stealing: 11)
    BattingStat.create(player_id: "allenbr01", year: 2012, league: "AL", team: "TBA", games: 10, at_bats: 100, runs_scored: 0, hits: 0, doubles: 39, triples: 4, home_runs: 0, runs_batted_in: 20, stolen_bases: 22, caught_stealing: 11)
    Player.create(player_id: "abreubo01", birth_year: 1974, first_name: "Bobby", last_name: "Abreu")
    Player.create(player_id: "abreuto01", birth_year: 1984, first_name: "Tony", last_name: "Abreu")
    Player.create(player_id: "allenbr01", birth_year: 1986, first_name: "Brandon", last_name: "Allen")
    winner = @controller.triple_crown_winner(2012,"AL")
    assert_equal nil, winner
  end
    
end