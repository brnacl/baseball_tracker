require 'artii'

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

def menu_main
  menu = "\nMAIN MENU > "
  menu << red("0")+"(Quit)\n\n"
  puts menu
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