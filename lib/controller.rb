require 'csv'

class Controller

  def initialize template
    @template = template
  end

  def get_improved_average
    input = ""
    year1 = ""
    year2 = ""
    until input.upcase == "EXIT"
      @template.header_main
      @template.menu_improved_average
      puts "Enter Start Year (Between 2007 & 2012):"
      input = year1 = gets.chomp
      
      puts "Enter End Year (Between 2007 & 2012):"
      input = year2 = gets.chomp
      if year1.to_i > 0 && year2.to_i > 0
        player = BattingStat.most_improved(year1.to_i, year2.to_i)
        @template.most_improved(player, year1, year2)
        input = gets.chomp
      end
      
      
    end
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