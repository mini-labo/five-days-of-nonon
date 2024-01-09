require 'time'

def iso8601_to_unix_timestamp_milliseconds(iso_datetime_string)
  datetime_object = Time.parse(iso_datetime_string)
  datetime_object.to_i
  unix_timestamp_milliseconds = (datetime_object.to_f * 1000).to_i
end

def get_pulse_seed_value_from_nist(timestamp)
  url = URI('https://beacon.nist.gov/beacon/2.0/pulse/time/' + timestamp.to_s)
  response = Net::HTTP.get(url)
  data = JSON.parse(response)

  random_value = data['pulse']['outputValue']
  random_value.to_i(16)
end

def get_number_in_range(min, max, randomness_seed)
  range_size = max - min + 1
  min + (randomness_seed % range_size)
end

def select_winner(entrants, closing_timestamp)
  begin
    timestamp = iso8601_to_unix_timestamp_milliseconds(closing_timestamp)
    seed = get_pulse_seed_value_from_nist(timestamp)
    min = 0
    max = entrants.length - 1

    shuffled_entrants = entrants.shuffle(random: Random.new(seed))

    random_number_in_range = get_number_in_range(min, max, seed)
    return shuffled_entrants[random_number_in_range]
  rescue => e
    puts e.message
  end
end
