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
        if years.count == 2 && years[0].to_i.between?(2007,2012) && years[1].to_i.between?(2007,2012)
          year1 = years[0].to_i
          year2 = years[1].to_i
          player = most_improved_player(year1, year2)
          if player 
            @template.message_most_improved_success(player, year1, year2)
            input = gets.chomp
          end
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
      if input.include?(",")
        params = input.split(",")
        params.each {|p|
          p.chomp!
          p.lstrip!
        }
        if params.count == 2 && params[0].length == 3 && params[1].to_i.between?(2007,2012)
          teamID = params[0]
          year = params[1].to_i
          percentage = team_slugging_percentage(teamID, year)
          if percentage
            @template.message_slugging_percentage_success(percentage, teamID, year)
            input = gets.chomp
          end
        end
      end
    end
  end

  def team_slugging_percentage teamID, year
    stats = BattingStat.where(:year => year, :team => teamID)
    if stats.count > 0
      at_bats = hits = doubles = triples = home_runs = 0
      stats.each do |stat|
        at_bats += stat.at_bats.to_i
        hits += stat.hits.to_i
        doubles += stat.doubles.to_i
        triples += stat.triples.to_i
        home_runs += stat.home_runs.to_i
      end
      slugging_percentage = ((((hits - (doubles + triples + home_runs)) + (2 * doubles) + (3 * triples) + (4 * home_runs)).to_f / at_bats.to_f) * 100).round(2)
      slugging_percentage
    else
      nil
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