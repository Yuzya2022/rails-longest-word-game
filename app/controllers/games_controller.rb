require 'open-uri'
require 'json'

class GamesController < ApplicationController
   def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
   end

   def score
     @word = params[:member]
     @letters = params[:letters].split('')
     @result = nil
     if !english?(@word.upcase)
      @result = "the given word is not an english word"
    elsif !match_grid?(@word.upcase, @letters)
      @result = "the given word is not in the grid"
    else
      @result ="Well done"
    end
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    answer = URI.open(url).read
    response = JSON.parse(answer)
    response["found"]
  end

  def match_grid?(word, letters)
    return false if letters.nil?
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
