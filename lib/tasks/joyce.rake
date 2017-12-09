require File.expand_path('../../../config/environment', __FILE__)

namespace "joyce" do
  task :upload do
    chapters = [
      { name: "Telemachus", number: 1, hour: "8am" },
      { name: "Nestor", number: 2, hour: "10am" },
      { name: "Proteus", number: 3, hour: "11am" },
      { name: "Calypso", number: 4, hour: "8am" },
      { name: "Lotus Eaters", number: 5, hour: "10am" },
      { name: "Hades", number: 6, hour: "11am" },
      { name: "Aeolus", number: 7, hour: "12pm" },
      { name: "Lestrygonians", number: 8, hour: "1pm" },
      { name: "Scylla and Charybdis", number: 9, hour: "2pm" },
      { name: "Wandering Rocks", number: 10, hour: "3pm" },
      { name: "Sirens", number: 11, hour: "4pm" },
      { name: "Cyclops", number: 12, hour: "5pm" },
      { name: "Nausicaa", number: 13, hour: "8pm" },
      { name: "Oxen of the Sun", number: 14, hour: "10pm" },
      { name: "Circe", number: 15, hour: "12am" },
      { name: "Eumaeus", number: 16, hour: "1am" },
      { name: "Ithaca", number: 17, hour: "2am" },
      { name: "Penelope", number: 18, hour: "~" }
    ]

    chapters.each do |chapter|
      parser = UlyssesParser.new(chapter)
      parser.parse_chapter_text
    end
  end

  task :delete do
    # Sentence.where(chapter_id: 18).each { |d| d.destroy }
    Sentence.all.each { |d| d.destroy }
  end

  task :clean_up do
    Sentence.where(text: ".").delete_all
    Sentence.where(text: "?").delete_all
    Sentence.where(text: "!").delete_all
    Sentence.where("length(text) < 3").delete_all
    last_sentence = Sentence.last
    next_last = Sentence.find((last_sentence.id - 1))
    last_sentence.text = "#{next_last.text} #{last_sentence.text.split(".")[0]}"
    next_last.destroy
    last_sentence.save!
  end
end