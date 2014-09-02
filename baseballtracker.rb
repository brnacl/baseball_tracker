#!/usr/bin/env ruby

require_relative 'lib/environment'

Dir["lib/*.rb"].each {|file| require_relative file }
Dir["views/*.rb"].each {|file| require_relative file }
Dir["models/*.rb"].each {|file| require_relative file }

Environment.environment = "production"
Environment.connect_to_database

command = ""
until command == "0"
  header_main
  menu_main
  command = gets.to_i
end
clear_screen