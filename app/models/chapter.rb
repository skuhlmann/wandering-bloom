class Chapter < ApplicationRecord
  has_many :sentences

  def self.random
    order("RANDOM()").first
  end
end
