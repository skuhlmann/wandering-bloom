require 'rails_helper'

RSpec.describe Sentence, :type => :model do
  it "exists" do
    chapter = Chapter.create(name: "Circe", hour: "12am", number: 15)
    sentence = Sentence.create(text: "Wait, my love, and I'll be with you.")
    chapter.sentences << sentence
    chappie = Chapter.where(name: "Circe").first

    expect(chappie.sentences.first.text).to eq(sentence.text)
  end
end
