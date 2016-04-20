require 'rails_helper'

RSpec.describe UlyssesParser, :type => :model do
  it "can get a raw ulysses chapter" do
    chapter = { name: "Telemachus", number: 1, hour: "8am" }
    parser = UlyssesParser.new(chapter)
    raw_text = parser.raw_text

    expect(raw_text.is_a?(String)).to eq(true)
  end

  it "builds the correct file path for last chapter" do
    parser = UlyssesParser.new(chapter = { name: "Penelope", number: 18, hour: "8am" })

    expect(parser.file_path).to eq("/jod/ulysses/ulys18dr.txt")
  end

  it "creates a chapter" do
    chapter = { name: "Telemachus", number: 1, hour: "8am"}
    parser = UlyssesParser.new(chapter)

    expect(parser.chapter.name).to eq("Telemachus")
  end

  it "doesn't create duplicate chapters" do
    chapter = { name: "Telemachus", number: 1, hour: "8am" }
    Chapter.create(chapter)
    parser = UlyssesParser.new(chapter)

    results = Chapter.where(name: "Telemachus")

    expect(results.count).to eq(1)
  end

  it "can parse a chapter into sentences" do
    parser = UlyssesParser.new(chapter = { name: "Telemachus", number: 1, hour: "8am" })
    parser.raw_text = "
      8
      * Pineapple rock. lemon platt, butter scotch? A sugarsticky girl
      shovelling scoopfuls of creams for a christian brother! ** Some school treat."
    parser.parse_chapter_text

    sentences = Sentence.all
    expect(sentences.count).to eq(4)
    expect(sentences.first.text).to eq("Pineapple rock.")
  end
end