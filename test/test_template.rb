require_relative 'helper'
require_relative 'capture_stdout'
require_relative '../lib/template'

class TestTemplate < BaseballTest

    def setup
        @template = Template.new
    end

    def test_clear_screen
        out = capture_stdout do 
          @template.clear_screen
        end
        assert_in_output out.string, "\e[H\e[2J\n"
    end

    def test_header_main_clears_screen_and_inserts_line_break
        out = capture_stdout do 
          @template.header_main
        end
        assert_in_output out.string, "=====================================", "\e[H\e[2J"
    end

    def test_main_menu_includes_quit
        out = capture_stdout do
          @template.menu_main
        end
        assert_in_output out.string, "MAIN MENU", "Quit"
    end

    def test_main_menu
        out = capture_stdout do
          @template.menu_main
        end
        assert_in_output out.string, "MAIN MENU", "Get Most Improved Batting Average", "Get Team Slugging Percentage", "Import Player Data", "Import Batting Stats"
    end

    def test_improved_average_menu
        out = capture_stdout do
          @template.menu_improved_average
        end
        assert_in_output out.string, "GET MOST IMPROVED AVERAGE", "EXIT"
    end

    def test_slugging_percentage_menu
        out = capture_stdout do
          @template.menu_slugging_percentage
        end
        assert_in_output out.string, "GET SLUGGING PERCENTAGE", "EXIT"
    end

    def test_import_players_menu
        out = capture_stdout do
          @template.menu_import_players
        end
        assert_in_output out.string, "IMPORT PLAYERS", "EXIT"
    end

    def test_import_batting_stats_menu
        out = capture_stdout do
          @template.menu_import_stats
        end
        assert_in_output out.string, "IMPORT BATTING STATS", "EXIT"
    end

    def test_import_players_header
        out = capture_stdout do
          @template.header_import_players
        end
        assert_in_output out.string, "player_id, birth_year, first_name, last_name", "Enter the full path to the file"
    end

    def test_import_stats_header
        out = capture_stdout do
          @template.header_import_stats
        end
        assert_in_output out.string, "player_id, year, league, team, games, at_bats, runs_scored, hits, doubles, triples, home_runs, runs_batted_in, stolen_bases, caught_stealing", "Enter the full path to the file"
    end

    def test_message_file_not_found
        out = capture_stdout do
          @template.message_file_not_found
        end
        assert_in_output out.string, "FILE NOT FOUND"
    end

    def test_message_import_success
        out = capture_stdout do
          @template.message_import_success
        end
        assert_in_output out.string, "FILE IMPORTED SUCCESSFULLY", "EXIT"
    end

    def test_message_most_improved_success
        player = Player.create(player_id: "abreubo01", birth_year: 1974, first_name: "Bobby", last_name: "Abreu")
        out = capture_stdout do
          @template.message_most_improved_success(player, "2007", "2008")
        end
        assert_in_output out.string, "PLAYER FOUND!", "Name", "Average", "Improvement", "EXIT"
    end

    def test_message_slugging_percentage_success
        percentage = 60.45
        out = capture_stdout do
          @template.message_slugging_percentage_success(percentage, "OAK", 2007)
        end
        assert_in_output out.string, "SLUGGING PERCENTAGE CALCULATED!", "Percentage", "Team ID", "EXIT"
    end

    def test_message_triple_crown_winners
        winner_al = Player.create(player_id: "abreubo01", birth_year: 1974, first_name: "Bobby", last_name: "Abreu")
        winner_nl = Player.create(player_id: "abreubo01", birth_year: 1974, first_name: "Bobby", last_name: "Abreu")
        out = capture_stdout do
          @template.message_triple_crown_winners(2007, winner_al, winner_nl)
        end
        assert_in_output out.string, "TRIPLE CROWN WINNERS", "American League", "National League", "EXIT"
    end

end