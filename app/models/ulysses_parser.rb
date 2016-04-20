class UlyssesParser
  attr_accessor :raw_text, :chapter, :file_path

  def initialize(chapter)
    @chapter_name = chapter[:name]
    @chapter_number = chapter[:number]
    @chapter_hour = chapter[:hour]
    @domain = "faculty.georgetown.edu"
    @file_path = build_file_path
    @raw_text = fetch_raw_text
    @chapter = create_chapter
  end

  def create_chapter
    chapter = Chapter.where(name: @chapter_name)[0]
    if chapter.nil?
      new_chapter = {
        name: @chapter_name,
        number: @chapter_number,
        hour: @chapter_hour
      }
      chapter = Chapter.create(new_chapter)
    end
    chapter
  end

  def parse_chapter_text
    parsed_text = strip_text

    if @chapter_number == 18
      words = parsed_text.join.split(" ")
      parsed_text = words.each_slice(18).map { |p| p.join(' ') }
      parsed_text.each do |text|
        insert_sentence(text)
      end
    else
      parsed_text.each_with_index do |chunk, index|
        unless sentence_end?(chunk) || parsed_text[index + 1].nil?
          sentence = chunk + parsed_text[index + 1]
          text = sentence.strip.squeeze(" ")
          if @chapter_number == 15 && text.start_with?(")")
            text = text.gsub(")", "")
          end
          insert_sentence(text)
        end
      end
    end
  end

  def insert_sentence(text)
    text.encode!("UTF-8", invalid: :replace, undef: :replace, replace: '')
    Sentence.create(text: text, chapter_id: @chapter.id)
  end

  def remove_titles(parsed_text)
    parsed_text.reject do |text|
      !sentence_end?(text) && text == text.upcase
    end
  end

  def sentence_end?(text)
    text == "." || text == "?" || text == "!"
  end

  def strip_text
    @raw_text = sub_unwanted_chracters
    @raw_text = @raw_text.partition("*")[2].strip
    @raw_text.split(/(\.|\?|!)/)
  end

  def sub_unwanted_chracters
    if @chapter_number == 15 || @chapter_number == 7
      @raw_text = @raw_text.gsub("<*page*>", "")
    end
    @raw_text.gsub("\n", " ").gsub("\f", " ").gsub("--", "")
  end

  def fetch_raw_text
    text = Net::HTTP.get(@domain, @file_path)
  end

  def build_file_path
    number = @chapter_number
    number = "#{number}dr" if @chapter_number == 18
    "/jod/ulysses/ulys#{number}.txt"
  end
end