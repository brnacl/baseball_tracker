require 'artii'

class Template

  def clear_screen
    puts "\e[H\e[2J"
  end

  def exit_message
    "Type #{red('EXIT')} to go back"
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
    menu << exit_message
    menu << "\n\n"
    menu << green("Enter Year Range Between 2007 & 2012 (#{purple('2007, 2012')}#{green('):')}")
    puts menu
  end

  def menu_slugging_percentage
    menu = "\nGET SLUGGING PERCENTAGE > "
    menu << exit_message
    menu << "\n\n"
    menu << green("Enter TeamID and Year (#{purple('OAK, 2007')}#{green('):')}")
    puts menu
  end

  def menu_import_players
    menu = "\nIMPORT PLAYERS > "
    menu << exit_message
    menu << "\n\n"
    puts menu
  end

  def menu_import_stats
    menu = "\nIMPORT BATTING STATS > "
    menu << exit_message
    menu << "\n\n"
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
    message = yellow("FILE IMPORTED SUCCESSFULLY!\n")
    message << exit_message
    puts message
  end

  def message_most_improved_success player, year1, year2
    puts green("PLAYER FOUND!\n")
    puts "\s\s\sName: #{player.first_name} #{player.last_name}"
    puts "\s\s\s#{year1} Average: #{player.batting_average(year1.to_i)}"
    puts "\s\s\s#{year2} Average: #{player.batting_average(year2.to_i)}"
    puts "\s\s\sImprovement: #{player.improvement(year1.to_i, year2.to_i)}\n\n"
    puts exit_message
  end

  def message_slugging_percentage_success percentage, teamID, year
    puts green("SLUGGING PERCENTAGE CALCULATED!\n")
    puts "\s\s\sTeam ID: #{teamID}"
    puts "\s\s\s#{year} Percentage: #{percentage}%\n\n"
    puts exit_message
  end

end