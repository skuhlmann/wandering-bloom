require 'rails_helper'

RSpec.describe UlyssesParser, :type => :model do
  it "can get a raw ulysses chapter" do
    chapter = { name: "Telemachus", number: 1 }
    parser = UlyssesParser.new(chapter)
    raw_text = parser.raw_text

    expect(raw_text.is_a?(String)).to eq(true)
  end

  xit "can parse a chapter into sentences" do
    parser = UlyssesParser.new(22)
    parser.raw_text = "
      8
      * Pineapple rock, lemon platt, butter scotch. A sugarsticky girl
      shovelling scoopfuls of creams for a christian brother. Some school treat."
    parser.parse_chapter

    senteces = Sentence.all
    expect(enteces.count).to eq(3)
  end
end