require 'net/http'

class UlyssesParser
  attr_accessor :raw_text, :chapter, :file_path

  def initialize(chapter)
    @chapter_name = chapter[:name]
    @chapter_number = chapter[:number]
    @domain = "faculty.georgetown.edu"
    @file_path = build_file_path
    @raw_text = fetch_raw_text
    @chapter = create_chapter
  end

  def create_chapter
    chapter = Chapter.where(name: @chapter_name)
    if chapter.empty?
      new_chapter = { name: @chapter_name, number: @chapter_number }
      chapter = Chapter.create(new_chapter)
    end
    chapter
  end

  def parse_chapter_text
    # if chapter 15 deal with <* page *> first
    @raw_text = strip_text
    split = @raw_text.split(/(\.|\?|!)/)
    #need to break into sentences now
    #probably need a mass insert fucker
  end

  def strip_text
    @raw_text.gsub!(/\n/, " ").squeeze!(" ")
    text = @raw_text.partition("*")[2].strip
    text.split("*").join.squeeze(" ")
  end

  def fetch_raw_text
    Net::HTTP.get(@domain, @file_path)
  end

  def build_file_path
    number = @chapter_number
    number = "#{number}dr" if @chapter_number == 18
    "/jod/ulysses/ulys#{number}.txt"
  end
end