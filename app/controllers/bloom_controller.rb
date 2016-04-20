class BloomController < ApplicationController
  def index
    @time = Time.now
    @chapter = Chapter.random
    @sentence = @chapter.sentences.random_chunk(1).first
  end
end
