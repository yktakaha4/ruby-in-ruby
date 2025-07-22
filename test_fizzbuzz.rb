require 'minitest/autorun'
require 'open3'

class TestFizzBuzz < Minitest::Test
  def setup
    @script_path = File.join(File.dirname(__FILE__), 'fizzbuzz.rb')
  end

  def test_fizzbuzz_first_15_numbers
    stdout, stderr, status = Open3.capture3("ruby #{@script_path}")

    assert status.success?, "Script should execute successfully"
    assert_empty stderr, "No errors should be output to stderr"

    lines = stdout.strip.split("\n")

    expected_first_15 = [
      "1", "2", "\"Fizz\"", "4", "\"Buzz\"", "\"Fizz\"", "7", "8",
      "\"Fizz\"", "\"Buzz\"", "11", "\"Fizz\"", "13", "14", "\"FizzBuzz\""
    ]

    assert_equal expected_first_15, lines[0, 15], "First 15 numbers should match expected FizzBuzz pattern"
  end

  def test_fizzbuzz_total_output_length
    stdout, _stderr, status = Open3.capture3("ruby #{@script_path}")

    assert status.success?, "Script should execute successfully"

    lines = stdout.strip.split("\n")
    assert_equal 100, lines.length, "Should output exactly 100 lines for numbers 1 to 100"
  end
end
