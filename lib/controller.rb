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
          @template.message_import_success
        else
          @template.message_file_not_found
        end
      end
      input = gets.chomp
      num_entries += 1
    end
  end

end