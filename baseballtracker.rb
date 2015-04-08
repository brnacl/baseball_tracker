#!/usr/bin/env ruby
require_relative 'lib/environment'

Dir["lib/*.rb"].each {|file| require_relative file }
Dir["views/*.rb"].each {|file| require_relative file }
Dir["models/*.rb"].each {|file| require_relative file }

Environment.environment = "production"
Environment.connect_to_database

#
template = Template.new
controller = Controller.new(template)

command = ""
until command == 0
  template.header_main
  template.menu_main
  command = gets.to_i
  case command
  when 1
    controller.get_improved_average
  when 2
    controller.get_slugging_percentage
  when 3
    controller.get_triple_crown_winners
  when 4
    controller.import_csv "players"
  when 5
    controller.import_csv "stats"
  end
end

template.clear_screen