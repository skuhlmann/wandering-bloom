require 'rails_helper'

describe "Bloom API" do
  it 'sends a tweet friendly message for a time of day' do
    # FactoryGirl.create_list(:message, 10)
    time = "10am"

    get "/api/v1/bloom#{time}"

    json = JSON.parse(response.body)

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right amount of messages are returned
    expect(json['messages'].length).to eq(10)
  end
end