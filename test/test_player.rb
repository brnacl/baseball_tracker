require_relative 'helper'

class TestPlayer < BaseballTest

  def test_count_when_no_players
    assert_equal 0, Player.count
  end

  def test_count_of_multiple_players
    Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    Player.create(player_id: "aaronto01", birth_year: 1939, first_name: "Tommie", last_name: "Aaron")
    Player.create(player_id: "aasedo01", birth_year: 1954, first_name: "Don", last_name: "Aase")
    assert_equal 3, Player.count
  end

  def test_hash
    player = Player.new(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    assert_equal("aaronha01", player.player_id)
    assert_equal(1934, player.birth_year)
    assert_equal("Hank", player.first_name)
    assert_equal("Aaron", player.last_name)
  end

  def test_player_all_returns_array
    Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    Player.create(player_id: "aaronto01", birth_year: 1939, first_name: "Tommie", last_name: "Aaron")
    Player.create(player_id: "aasedo01", birth_year: 1954, first_name: "Don", last_name: "Aase")
    num_players = Player.count
    assert_equal(3,num_players)
  end

  def test_update_doesnt_insert_new_row
    player = Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    players_before = Player.count
    player.update(first_name: "Bill")
    players_after = Player.count
    assert_equal players_before, players_after
  end

  def test_update_saves_to_the_database
    player = Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    id = player.id
    player.update(first_name: "Bill")
    updated_player = Player.find(id)
    expected = ["aaronha01", 1934, "Bill", "Aaron" ]
    actual = [updated_player.player_id, updated_player.birth_year, updated_player.first_name, updated_player.last_name]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    player = Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    player.update(first_name: "Bill")
    expected = ["aaronha01", 1934, "Bill", "Aaron" ]
    actual = [player.player_id, player.birth_year, player.first_name, player.last_name]
    assert_equal expected, actual
  end

  def test_saved_players_are_saved
    player = Player.new(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    players_before = Player.count
    player.save
    players_after = Player.count
    assert_equal players_before + 1, players_after
  end

  def test_save_creates_an_id
    player = Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    refute_nil player.id, "Player id shouldn't be nil"
  end

  def test_find_returns_the_row_as_player_object
    player = Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    found = Player.find(player.id)
    assert_equal player, found
  end

  def test_search_returns_player_objects
    Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    Player.create(player_id: "aaronto01", birth_year: 1939, first_name: "Tommie", last_name: "Aaron")
    Player.create(player_id: "aasedo01", birth_year: 1954, first_name: "Don", last_name: "Aase")
    results = Player.search("Aaron")
    assert results.all?{ |result| result.is_a? Player }, "Not all results were Players"
  end

  def test_search_returns_empty_array_if_no_results
    Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    Player.create(player_id: "aaronto01", birth_year: 1939, first_name: "Tommie", last_name: "Aaron")
    Player.create(player_id: "aasedo01", birth_year: 1954, first_name: "Don", last_name: "Aase")
    results = Player.search("Jenkins")
    assert_equal [], results
  end

  def test_all_returns_all_players_in_alphabetical_order
    Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    Player.create(player_id: "aaronto01", birth_year: 1939, first_name: "Tommie", last_name: "Aaron")
    Player.create(player_id: "aasedo01", birth_year: 1954, first_name: "Don", last_name: "Aase")
    results = Player.all
    expected = [ "Hank Aaron","Tommie Aaron","Don Aase"]
    actual = results.map{ |player| player.first_name + " " + player.last_name }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_players
    results = Player.all
    assert_equal [], results
  end

  def test_equality_on_same_object
    player = Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    assert player == player
  end

  def test_equality_with_different_class
    player = Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    refute player == "Player"
  end

  def test_equality_with_different_player
    player1 = Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    player2 = Player.create(player_id: "aaronto01", birth_year: 1939, first_name: "Tommie", last_name: "Aaron")
    refute player1 == player2
  end

  def test_equality_with_same_player_different_object_id
    player1 = Player.create(player_id: "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron")
    player2 = Player.find(player1.id)
    assert player1 == player2
  end

end