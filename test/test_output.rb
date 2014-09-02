require_relative 'helper'
require_relative 'capture_stdout'
require_relative '../views/main'
require_relative '../views/menus'

class TestOutput < BaseballTest

    def test_clear_screen
        out = capture_stdout do 
          clear_screen
        end
        assert_in_output out.string, "\e[H\e[2J\n"
    end

    def test_header_main_clears_screen_and_inserts_line_break
        out = capture_stdout do 
          header_main
        end
        assert_in_output out.string, "=====================================", "\e[H\e[2J"
    end

    def test_main_menu_includes_quit
        out = capture_stdout do
          menu_main
        end
        assert_in_output out.string, "MAIN MENU", "Quit"
    end

    def test_main_menu
        out = capture_stdout do
          menu_main
        end
        assert_in_output out.string, "MAIN MENU", "Get Most Improved Batting Average", "Get Team Slugging Percentage", "Import Player Data", "Import Batting Stats"
    end

    def test_import_players_menu
        out = capture_stdout do
          menu_import_players
        end
        assert_in_output out.string, "IMPORT PLAYERS", "EXIT"
    end

    def test_import_batting_stats_menu
        out = capture_stdout do
          menu_import_stats
        end
        assert_in_output out.string, "IMPORT BATTING STATS", "EXIT"
    end

end