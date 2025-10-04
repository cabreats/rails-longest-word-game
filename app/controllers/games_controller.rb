class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split

    if !valid_in_grid?(@word, @letters)
      @result = "❌ The word can’t be built out of the original grid."
    elsif !english_word?(@word)
      @result = "The word is valid according to the grid, but is not a valid English word ❌"
    else
      @result = "#{@word} is valid"
    end

    private

    def valid_in_grid?(word, letters)
      word.chars.all? do |char|
        word.count(char) <= letters.count(char)
      end
    end


    def english_word?(word)
      url = "https://dictionary.lewagon.com/:#{word.downcase}"
      response = URI.open(url).read
      json = JSON.parse(response)
      json['found']
    end
  end
end
