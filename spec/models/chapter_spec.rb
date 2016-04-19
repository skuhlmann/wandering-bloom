require 'rails_helper'

RSpec.describe Chapter, :type => :model do
  it "exists" do
    Chapter.create(name: "Circe", hour: "12am", number: 15)
    chappie = Chapter.where(name: "Circe").first

    expect(chappie.hour).to eq("12am")
  end

  it "can be retrived by hour" do
    Chapter.create(name: "Circe", hour: "12am", number: 15)
    chappie = Chapter.where(hour: "12am").first

    expect(chappie.name).to eq("Circe")
  end
end
