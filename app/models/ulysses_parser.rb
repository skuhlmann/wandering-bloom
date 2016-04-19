require 'net/http'

class UlyssesParser
  attr_accessor :raw_text

  def initialize(chapter)
    @chapter_name = chapter[:name]
    @chapter_number = chapter[:number]
    @domain = "faculty.georgetown.edu"
    @file_path = build_file_path
    @raw_text = fetch_raw_text
  end

  def parse_chapter

  end

  private

  def fetch_raw_text
    Net::HTTP.get(@domain, @file_path)
  end

  def build_file_path
    "/jod/ulysses/ulys#{@chapter_number}.txt"
  end
end