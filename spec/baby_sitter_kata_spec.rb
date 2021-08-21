require "baby_sitter_kata"

describe "Baby Sitter program" do

  it "Did the baby sitter clock in?" do
    response = shift("2021-08-21 17:00:00 -0400", "2021-08-21 20:00:00 -0400", "2021-08-22 01:00:00 -0400")
    expect(response[:start]).to be_truthy
  end

  it "Does the child have a bed time?" do
    response = shift("2021-08-21 17:00:00 -0400", "2021-08-21 21:00:00 -0400", "2021-08-22 01:00:00 -0400")
    expect(response[:bed_time]).to be_truthy
  end

  it "Did the baby sitter clock out?" do
    response = shift("2021-08-21 17:00:00 -0400", "2021-08-21 21:00:00 -0400", "2021-08-22 01:00:00 -0400")
    expect(response[:end]).to be_truthy
  end

  it "Baby sitter clocked in at 16 early return error?" do
    response = shift("2021-08-21 16:00:00 -0400", "2021-08-21 21:00:00 -0400", "2021-08-22 01:00:00 -0400")
    expect(response[:error]).to eq("Please check your start time 16 and end time 1 cannot be earlier than 17 or leave earlier than 4")
  end

  it "Baby sitter clocked out at 5 early return error?" do
    response = shift("2021-08-21 17:00:00 -0400", "2021-08-21 21:00:00 -0400", "2021-08-22 05:00:00 -0400")
    expect(response[:error]).to eq("Please check your start time 17 and end time 5 cannot be earlier than 17 or leave earlier than 4")
  end

  it "Baby sitter not fill in their start time entry correctly return error?" do
    response = shift("Hello", "2021-08-21 21:00:00 -0400", "2021-08-22 05:00:00 -0400")
    expect(response[:error]).to eq("Please check your start time, bedtime, and end time. Invalid date time format was entered.")
  end

  it "Baby sitter not fill in their bed time entry correctly return error?" do
    response = shift("2021-08-21 17:00:00 -0400", "Hi There", "2021-08-22 05:00:00 -0400")
    expect(response[:error]).to eq("Please check your start time, bedtime, and end time. Invalid date time format was entered.")
  end

  it "Baby sitter not fill in their end time entry correctly return error?" do
    response = shift("2021-08-21 17:00:00 -0400", "2021-08-21 21:00:00 -0400", "Ending")
    expect(response[:error]).to eq("Please check your start time, bedtime, and end time. Invalid date time format was entered.")
  end

  it "Baby sitter calculate hourly wage 17:00:00 to 04:00:00?" do
    response = shift("2021-08-21 17:00:00 -0400", "2021-08-21 21:00:00 -0400", "2021-08-22 04:00:00 -0400")
    expect(response[:pay]).to eq(136)
  end

  it "Baby sitter calculate hourly wage 17:00:00 to 03:30:00?" do
    response = shift("2021-08-21 17:00:00 -0400", "2021-08-21 21:00:00 -0400", "2021-08-22 03:30:00 -0400")
    expect(response[:pay]).to eq(128)
  end

    it "Baby sitter calculate hourly wage 17:00:00 to 03:30:15 rounding?" do
    response = shift("2021-08-21 17:00:00 -0400", "2021-08-21 21:00:00 -0400", "2021-08-22 03:30:15 -0400")
    expect(response[:pay]).to eq(128)
  end
end
