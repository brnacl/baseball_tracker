require 'minitest/autorun'
require_relative '../lib/environment'

class BaseballTest < MiniTest::Unit::TestCase
  def setup
    Environment.environment = "test"
    Environment.connect_to_database
  end

  def teardown
    Player.destroy_all
    BattingStat.destroy_all
  end

  def assert_command_output expected, command
    actual = `#{command} --environment test`.strip
    assert_equal expected, actual
  end

  def assert_in_output output, *args
    missing_content = []
    args.each do |argument|
      unless output.include?(argument)
        missing_content << argument
      end
    end
    assert missing_content.empty?, "Output didn't include #{missing_content.join(", ")}:\n #{output}"
  end

  def assert_not_in_output output, *args
    args.each do |argument|
      assert !output.include?(argument), "Output shouldn't include #{argument}: #{output}"
    end
  end
end
