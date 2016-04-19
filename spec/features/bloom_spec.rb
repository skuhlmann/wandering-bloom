require 'rails_helper'

describe 'blooming', type: :feature do

  it "can see the time in user's time zone" do
    visit root_path

    now = Time.now.strftime("%I:%M %p")

    expect(page).to have_content("Wandering Bloom")
    expect(page).to have_content(now)
  end
end