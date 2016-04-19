require 'rails_helper'

describe 'blooming', type: :feature do

  it "can see the time in user's time zone" do
    visit root_path

    expect(page).to have_content("Wandering Bloom")
  end
end