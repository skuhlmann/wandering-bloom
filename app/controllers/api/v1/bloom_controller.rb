class Api::V1::BloomController < ApplicationController
  respond_to :json

  def show
    hour = hour_map[params[:time]]
    @chapter = Chapter.where(hour: hour).sample
    @sentence = @chapter.sentences.random_chunk(1).first

    respond_with :api, @sentence
  end

  private

  def hour_map
    {
      "1am" => "1am",
      "2am" => "2am",
      "3am" => "~",
      "4am" => "~",
      "5am" => "~",
      "6am" => "~",
      "7am" => "~",
      "8am" => "8am",
      "9am" => "8am",
      "10am" => "10am",
      "11am" => "11am",
      "12pm" => "12pm",
      "1pm" => "1pm",
      "2pm" => "2pm",
      "3pm" => "3pm",
      "4pm" => "4pm",
      "5pm" => "5pm",
      "6pm" => "5pm",
      "7pm" => "5pm",
      "8pm" => "8pm",
      "9pm" => "9pm",
      "10pm" => "10pm",
      "11pm" => "10pm",
      "12am" => "12am"
     }
  end
end
