require_relative 'helper'
require_relative 'capture_stdout'
require_relative '../views/main'

class TestViewsMain < BaseballTest

    def test_clear_screen
        out = capture_stdout do 
          clear_screen
        end
        assert_equal "\e[H\e[2J\n", out.string
    end

    def test_header_main
        out = capture_stdout do 
          header_main
        end
        assert_equal("\e[34m    __                    __          ____    ______________  ___________\n   / /_  ____ _________  / /_  ____ _/ / /   / ___/_  __/   |/_  __/ ___/\n  / __ \\/ __ `/ ___/ _ \\/ __ \\/ __ `/ / /    \\__ \\ / / / /| | / /  \\__ \\\n / /_/ / /_/ (__  )  __/ /_/ / /_/ / / /    ___/ // / / ___ |/ /  ___/ /\n/_.___/\\__,_/____/\\___/_.___/\\__,_/_/_/_________//_/ /_/  |_/_/  /____/\n                                     /_____/\n=========================================================================\e[0m\n",
        out.string)



        
    end

  

end