require 'artii'

class Template

  def clear_screen
    puts "\e[H\e[2J"
  end

  def header_main
    clear_screen
    artii = Artii::Base.new :font => 'slant'
    header = artii.asciify("baseball_STATS")
    header << "\n"
    header << "=" * ((header.length / 5) - 15)
    puts blue(header)
  end

  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def black(text); colorize(text, 30); end
  def red(text); colorize(text, 31); end
  def green(text); colorize(text, 32); end
  def yellow(text); colorize(text, 33); end
  def blue(text); colorize(text, 34); end
  def purple(text); colorize(text, 35); end
  def cyan(text); colorize(text, 36); end
  def white(text); colorize(text, 37); end

  def menu_main
    menu = "\nMAIN MENU > "
    menu << green("1")+"(Get Most Improved Batting Average)\s"
    menu << green("2")+"(Get Team Slugging Percentage)\s"
    menu << green("3")+"(Import Player Data)\s"
    menu << green("4")+"(Import Batting Stats)\s"
    menu << red("0")+"(Quit)\n\n"
    puts menu
  end

  def menu_improved_average
    menu = "\nGET MOST IMPROVED AVERAGE > "
    menu << "(Type '" + red("EXIT") + "' to exit)\n\n"
    puts menu
  end

  def menu_slugging_percentage
    menu = "\nGET SLUGGING PERCENTAGE > "
    menu << "(Type '" + red("EXIT") + "' to exit)\n\n"
    puts menu
  end

  def menu_import_players
    menu = "\nIMPORT PLAYERS > "
    menu << "(Type '" + red("EXIT") + "' to exit)\n\n"
    puts menu
  end

  def menu_import_stats
    menu = "\nIMPORT BATTING STATS > "
    menu << "(Type '" + red("EXIT") + "' to exit)\n\n"
    puts menu
  end

  def header_import_players
    header = yellow("CSV File headers must be in the following format:\n")
    header << purple("player_id, birth_year, first_name, last_name\n\n")
    header << green("Enter the full path to the file:")
    puts header
  end

  def header_import_stats
    header = yellow("CSV File headers must be in the following format:\n")
    header << purple("player_id, year, league, team, games, at_bats, runs_scored, hits, doubles, triples, home_runs, runs_batted_in, stolen_bases, caught_stealing\n\n")
    header << green("Enter the full path to the file:")
    puts header
  end

  def message_file_not_found
    message = red("FILE NOT FOUND!")
    puts message
  end

  def message_import_success
    message = yellow("FILE SUCCESSFULLY IMPORTED!\n")
    message << "Please '" + red("EXIT") + "'" 
    puts message
  end
end