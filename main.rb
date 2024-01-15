require 'net/http'
require 'json'
require 'uri'

require_relative 'lib/utils'

DAYS = ['one', 'two', 'three', 'four', 'five']

def print_winner(day_number)
  puts select_winner(
    Object.const_get("DAY_#{day_number.upcase}_ENTRANTS"),
    Object.const_get("DAY_#{day_number.upcase}_CLOSING_TIME")
  )
end

DAYS.each do |day|
  require_relative "days/#{day}"
  print_winner(day)
end
