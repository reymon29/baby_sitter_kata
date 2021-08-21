require 'time'
require 'date'

def shift(start_shift, in_bed_time, end_shift)
  time_and_pay = {start: nil, bed_time: nil, end: nil, pay: 0}
  start_time = Time.parse(start_shift)
  bed_time = Time.parse(in_bed_time)
  end_time = Time.parse(end_shift)
  time_and_pay[:start] = start_time
  time_and_pay[:bed_time] = bed_time
  time_and_pay[:end] = end_time
  time_and_pay[:pay] = calculate_hourly_rate(start_time, bed_time, end_time)
  if start_time.hour <= 16 || end_time.hour >= 4
    return "Please check your start time #{start_time} and your end time #{end_time} cannot be earlier than 17:00:00 or leave earlier than 4:00:00"
  else
    time_and_pay[:pay] = calculate_hourly_rate(start_time, bed_time, end_time)
    return time_and_pay
  end
end

def calculate_hourly_rate(start_shift, in_bed_time, end_shift)
  total_amount = 0
  midnight = (Date.today + 1).to_time
  start_time = start_shift
  bed_time = in_bed_time
  end_time = end_shift
  total_amount = ((in_bed_time - start_shift).to_i * 12)
  if end_shift > midnight
    total_amount += ((midnight - bed_time).to_i * 8)
    total_amount += ((end_shift - midnight).to_i * 16)
  else
    total_amount += ((midnight - bed_time).to_i * 8)
  end
  total_amount = total_amount.round(0)
  return total_amount
end

