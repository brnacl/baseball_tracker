require_relative 'helper'
require_relative 'capture_stdout'
require_relative '../lib/template'
require_relative '../lib/controller'

class TestController < BaseballTest

    def setup
        @controller = Controller.new(Template.new)
    end

end