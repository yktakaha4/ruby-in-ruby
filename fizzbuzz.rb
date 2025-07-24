# frozen_string_literal: true

i = 1
while i <= 100
  if (i % 3).zero? && (i % 5).zero?
    p 'FizzBuzz'
  elsif (i % 3).zero?
    p 'Fizz'
  elsif (i % 5).zero?
    p 'Buzz'
  else
    p i
  end
  i += 1
end
