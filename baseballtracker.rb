#!/usr/bin/env ruby

require_relative 'lib/environment'

Dir["lib/*.rb"].each {|file| require_relative file }
Dir["views/*.rb"].each {|file| require_relative file }
Dir["models/*.rb"].each {|file| require_relative file }

Environment.environment = "production"
Environment.connect_to_database

command = ""
until command == 0
  header_main
  menu_main
  command = gets.to_i
  case command
  when 1
    header_main
    menu_improved_average
  when 2
    header_main
    menu_slugging_percentage
  when 3
    input = ""
    until input.upcase == "CANCEL"
      header_main
      menu_import_players
      input = gets.chomp  
    end
  when 4
    input = ""
    until input == "cancel"
      header_main
      menu_import_stats
    end
  end
end
clear_screen