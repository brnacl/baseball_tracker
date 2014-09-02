def menu_main
  menu = "\nMAIN MENU > "
  menu << green("1")+"(Get Most Improved Batting Average)\s"
  menu << green("2")+"(Get Team Slugging Percentage)\s"
  menu << green("3")+"(Import Player Data)\s"
  menu << green("4")+"(Import Batting Stats)\s"
  menu << red("0")+"(Quit)\n\n"
  puts menu
end

def menu_import_players
  menu = "\nIMPORT PLAYERS > "
  menu << green("Enter Path to CSV File")
  menu << "\s\s(Type '"
  menu << red("CANCEL")
  menu << "' to exit)"
  puts menu
end