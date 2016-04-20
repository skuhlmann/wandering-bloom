class Sentence < ApplicationRecord
  belongs_to :chapter

  def self.random_chunk(number)
    offset(starting_row).limit(number).reverse
  end

  private

  def self.starting_row
    records = Sentence.count
    (1..records).to_a.sample
  end
end
