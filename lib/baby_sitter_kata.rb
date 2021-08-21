require 'time'
require 'date'

def shift(start_shift, in_bed_time, end_shift)
  time_and_pay = {start: nil, bed_time: nil, end: nil, pay: 0}
  begin
    start_time = Time.parse(start_shift)
    bed_time = Time.parse(in_bed_time)
    end_time = Time.parse(end_shift)
  rescue ArgumentError
     time_and_pay[:error] = "Please check your start time, bedtime, and end time. Invalid date time format was entered."
     return time_and_pay
  end
  time_and_pay[:start] = start_time
  time_and_pay[:bed_time] = bed_time
  time_and_pay[:end] = end_time
  if start_time.hour <= 16
    time_and_pay[:error] = "Please check your start time #{start_time.hour} and end time #{end_time.hour} cannot be earlier than 17 or leave later than 4"
  elsif Date.parse("#{start_time}") == Date.parse("#{end_time}")
    time_and_pay[:pay] = calculate_hourly_rate(start_time, bed_time, end_time)
  elsif end_time.hour > 4
    time_and_pay[:error] = "Please check your start time #{start_time.hour} and end time #{end_time.hour} cannot be earlier than 17 or leave later than 4"
  else
   time_and_pay[:pay] = calculate_hourly_rate(start_time, bed_time, end_time)
  end
 time_and_pay
end

def calculate_hourly_rate(start_shift, in_bed_time, end_shift)
  total_amount = 0
  midnight = Time.parse((Date.parse("#{start_shift}") + 1).to_s)
  start_time = start_shift
  bed_time = in_bed_time
  end_time = end_shift
  total_amount = (((in_bed_time - start_shift) / 3600) * 12)
  if end_shift > midnight
    total_amount += (((midnight - bed_time) / 3600) * 8)
    total_amount += (((end_shift - midnight) / 3600) * 16)
  else
   total_amount += (((end_shift - bed_time) / 3600) * 8)
  end
  total_amount = total_amount.round(0)
  return total_amount
end

