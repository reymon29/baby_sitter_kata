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

  it "Baby sitter clocked in at 16:00:00 early error?" do
    response = shift("2021-08-21 16:00:00", "2021-08-21 21:00:00", "2021-08-22 01:00:00")
    expect(response).to eq("Please check your start time 2021-08-21 16:00:00 and your end time 2021-08-22 01:00:00 cannot be earlier than 17:00:00 or leave earlier than 4:00:00")
  end

  # it "Does the baby sitter have a end time?" do
  #   expect().to eq
  # end

  # it "Did the baby sitter clock out early?" do
  #   expect().to eq
  # end

  # it "Did the child go to bed?" do
  #   expect().to eq
  # end


  # it "How much did the baby sitter get paid?" do
  #   expect().to eq
  # end
end
