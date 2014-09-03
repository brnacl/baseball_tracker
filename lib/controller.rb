require 'csv'

class Controller

  def initialize template
    @template = template
  end

  def get_improved_average
    input = ""
    until input.upcase == "EXIT"
      @template.header_main
      @template.menu_improved_average
      input = gets.chomp
      if input.include?(",")
        years = input.split(",")
        years.each {|y| 
          y.chomp!
          y.lstrip!
        }
        if years.count == 2 && years[0].to_i >= 2007 && years[1].to_i > 2007
          player = most_improved_player(years[0].to_i, years[1].to_i)
          @template.message_most_improved_success(player, years[0], years[1])
          input = gets.chomp
        end
      end
    end
  end

  def most_improved_player year1, year2
    stats = BattingStat.where(:year => year1, :year => year2).where("at_bats >= 200")
    players = []
    stats.each do |stat|
      if !players.any? {|h| h[:player_id] == stat.player_id}
        players << stat.player
      end
    end
    most_improved_player = players.max_by do |player|
      player.improvement year1, year2
    end
    most_improved_player || nil
  end

  def get_slugging_percentage
    input = ""
    until input.upcase == "EXIT"
      @template.header_main
      @template.menu_slugging_percentage
      input = gets.chomp
    end
  end

  def import_csv type
    input = ""
    num_entries = 0
    until input.upcase == "EXIT"
      @template.header_main
      if type == 'players'
        @template.menu_import_players
        @template.header_import_players
      elsif type == 'stats'
        @template.menu_import_stats
        @template.header_import_stats
      end
      if num_entries > 0
        if File.file?(input)
          file_import(input, type)
          @template.message_import_success
        else
          @template.message_file_not_found
        end
      end
      input = gets.chomp
      num_entries += 1
    end
  end

  def file_import path, type
    csv_text = File.read(path)
    csv = CSV.parse(csv_text, :headers => true)
    if type == 'players'
      csv.each do |row|        
        Player.create!(row.to_hash)
        print "."
      end
    elsif type == 'stats'
      csv.each do |row|
        BattingStat.create!(row.to_hash)
        print "."
      end
    end
  end

end