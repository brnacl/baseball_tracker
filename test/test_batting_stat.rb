require_relative 'helper'

class TestBattingStat < BaseballTest

  def test_count_when_no_batting_stats
    assert_equal 0, BattingStat.count
  end

  def test_count_of_multiple_batting_stats
    BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    BattingStat.create(player_id: "abreubo01", year: 2008, league: "AL", team: "NYA", games: 156, at_bats: 609, runs_scored: 100, hits: 180, doubles: 39, triples: 4, home_runs: 20, runs_batted_in: 100, stolen_bases: 22, caught_stealing: 11)
    BattingStat.create(player_id: "abreubo01", year: 2007, league: "AL", team: "NYA", games: 158, at_bats: 605, runs_scored: 123, hits: 171, doubles: 40, triples: 5, home_runs: 16, runs_batted_in: 101, stolen_bases: 25, caught_stealing: 8)
    assert_equal 3, BattingStat.count
  end

  def test_hash
    batting_stat = BattingStat.new(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    assert_equal("abreubo01", batting_stat.player_id)
    assert_equal(2009, batting_stat.year)
    assert_equal("AL", batting_stat.league)
    assert_equal("LAA", batting_stat.team)
    assert_equal(152, batting_stat.games)
    assert_equal(563, batting_stat.at_bats)
    assert_equal(96, batting_stat.runs_scored)
    assert_equal(165, batting_stat.hits)
    assert_equal(29, batting_stat.doubles)
    assert_equal(3, batting_stat.triples)
    assert_equal(15, batting_stat.home_runs)
    assert_equal(103, batting_stat.runs_batted_in)
    assert_equal(30, batting_stat.stolen_bases)
    assert_equal(8, batting_stat.caught_stealing)
  end

  def test_batting_stat_all_returns_array
    BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    BattingStat.create(player_id: "abreubo01", year: 2008, league: "AL", team: "NYA", games: 156, at_bats: 609, runs_scored: 100, hits: 180, doubles: 39, triples: 4, home_runs: 20, runs_batted_in: 100, stolen_bases: 22, caught_stealing: 11)
    BattingStat.create(player_id: "abreubo01", year: 2007, league: "AL", team: "NYA", games: 158, at_bats: 605, runs_scored: 123, hits: 171, doubles: 40, triples: 5, home_runs: 16, runs_batted_in: 101, stolen_bases: 25, caught_stealing: 8)
    num_batting_stats = BattingStat.count
    assert_equal(3,num_batting_stats)
  end

  def test_update_doesnt_insert_new_row
    batting_stat = BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    batting_stats_before = BattingStat.count
    batting_stat.update(year: 2010)
    batting_stats_after = BattingStat.count
    assert_equal batting_stats_before, batting_stats_after
  end

  def test_update_saves_to_the_database
    batting_stat = BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    id = batting_stat.id
    batting_stat.update(year: 2010)
    updated_batting_stat = BattingStat.find(id)
    expected = ["abreubo01", 2010, "AL", "LAA", 152, 563, 96, 165, 29, 3, 15, 103, 30, 8]
    actual = [updated_batting_stat.player_id, updated_batting_stat.year, updated_batting_stat.league, updated_batting_stat.team, updated_batting_stat.games, updated_batting_stat.at_bats, updated_batting_stat.runs_scored, updated_batting_stat.hits, updated_batting_stat.doubles, updated_batting_stat.triples, updated_batting_stat.home_runs, updated_batting_stat.runs_batted_in, updated_batting_stat.stolen_bases, updated_batting_stat.caught_stealing]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    batting_stat = BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    batting_stat.update(year: 2010)
    expected = ["abreubo01", 2010, "AL", "LAA", 152, 563, 96, 165, 29, 3, 15, 103, 30, 8]
    actual = [batting_stat.player_id, batting_stat.year, batting_stat.league, batting_stat.team, batting_stat.games, batting_stat.at_bats, batting_stat.runs_scored, batting_stat.hits, batting_stat.doubles, batting_stat.triples, batting_stat.home_runs, batting_stat.runs_batted_in, batting_stat.stolen_bases, batting_stat.caught_stealing]
    assert_equal expected, actual
  end

  def test_saved_batting_stats_are_saved
    batting_stat = BattingStat.new(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    batting_stats_before = BattingStat.count
    batting_stat.save
    batting_stats_after = BattingStat.count
    assert_equal batting_stats_before + 1, batting_stats_after
  end

  def test_save_creates_an_id
    batting_stat = BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    refute_nil batting_stat.id, "BattingStat id shouldn't be nil"
  end

  def test_find_returns_the_row_as_batting_stat_object
    batting_stat = BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    found = BattingStat.find(batting_stat.id)
    assert_equal batting_stat, found
  end

  def test_search_returns_batting_stat_objects
    BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    BattingStat.create(player_id: "abreubo01", year: 2008, league: "AL", team: "NYA", games: 156, at_bats: 609, runs_scored: 100, hits: 180, doubles: 39, triples: 4, home_runs: 20, runs_batted_in: 100, stolen_bases: 22, caught_stealing: 11)
    BattingStat.create(player_id: "abreubo01", year: 2007, league: "AL", team: "NYA", games: 158, at_bats: 605, runs_scored: 123, hits: 171, doubles: 40, triples: 5, home_runs: 16, runs_batted_in: 101, stolen_bases: 25, caught_stealing: 8)
    results = BattingStat.search("abreubo01")
    assert results.all?{ |result| result.is_a? BattingStat }, "Not all results were BattingStats"
  end

  def test_search_returns_empty_array_if_no_results
    BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    BattingStat.create(player_id: "abreubo01", year: 2008, league: "AL", team: "NYA", games: 156, at_bats: 609, runs_scored: 100, hits: 180, doubles: 39, triples: 4, home_runs: 20, runs_batted_in: 100, stolen_bases: 22, caught_stealing: 11)
    BattingStat.create(player_id: "abreubo01", year: 2007, league: "AL", team: "NYA", games: 158, at_bats: 605, runs_scored: 123, hits: 171, doubles: 40, triples: 5, home_runs: 16, runs_batted_in: 101, stolen_bases: 25, caught_stealing: 8)
    results = BattingStat.search("xyzxyz111")
    assert_equal [], results
  end

  def test_all_returns_all_batting_stats_by_year_descending
    BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    BattingStat.create(player_id: "abreubo01", year: 2008, league: "AL", team: "NYA", games: 156, at_bats: 609, runs_scored: 100, hits: 180, doubles: 39, triples: 4, home_runs: 20, runs_batted_in: 100, stolen_bases: 22, caught_stealing: 11)
    BattingStat.create(player_id: "abreubo01", year: 2007, league: "AL", team: "NYA", games: 158, at_bats: 605, runs_scored: 123, hits: 171, doubles: 40, triples: 5, home_runs: 16, runs_batted_in: 101, stolen_bases: 25, caught_stealing: 8)
    results = BattingStat.all
    expected = [ "2009: abreubo01","2008: abreubo01","2007: abreubo01"]
    actual = results.map{ |batting_stat| batting_stat.year.to_s + ": " + batting_stat.player_id }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_batting_stats
    results = BattingStat.all
    assert_equal [], results
  end

  def test_equality_on_same_object
    batting_stat = BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    assert batting_stat == batting_stat
  end

  def test_equality_with_different_class
    batting_stat = BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    refute batting_stat == "BattingStat"
  end

  def test_equality_with_different_batting_stat
    batting_stat1 = BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    batting_stat2 = BattingStat.create(player_id: "abreubo01", year: 2008, league: "AL", team: "NYA", games: 156, at_bats: 609, runs_scored: 100, hits: 180, doubles: 39, triples: 4, home_runs: 20, runs_batted_in: 100, stolen_bases: 22, caught_stealing: 11)
    refute batting_stat1 == batting_stat2
  end

  def test_equality_with_same_batting_stat_different_object_id
    batting_stat1 = BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    batting_stat2 = BattingStat.find(batting_stat1.id)
    assert batting_stat1 == batting_stat2
  end

  def test_player_is_a_player
    player1 = Player.create(player_id: "abreubo01", birth_year: 1974, first_name: "Bobby", last_name: "Abreu")
    batting_stat = BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    assert_equal true, batting_stat.player.is_a?(Player)
  end

  def test_player_returns_nil_if_not_found
    batting_stat = BattingStat.create(player_id: "abreubo01", year: 2009, league: "AL", team: "LAA", games: 152, at_bats: 563, runs_scored: 96, hits: 165, doubles: 29, triples: 3, home_runs: 15, runs_batted_in: 103, stolen_bases: 30, caught_stealing: 8)
    assert_equal nil, batting_stat.player
  end

end