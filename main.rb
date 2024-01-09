require 'net/http'
require 'json'
require 'uri'

require_relative 'days/one'
require_relative 'lib/utils'

def print_day_one_winner
  puts select_winner(DAY_ONE_ENTRANTS, DAY_ONE_CLOSING_TIME)
end

print_day_one_winner
