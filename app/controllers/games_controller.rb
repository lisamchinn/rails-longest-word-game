require 'open-uri'
require 'json'

class GamesController < ApplicationController
  include GamesHelper

  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample }
  end

  def score
    # binding.pry
    @word = params[:word]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    info = URI(url).read
    info_parsed = JSON(info)
    if word_in_grid?(@word, @letters) == false
      @message = "Sorry, but #{@word} cannot be made out of the letters #{@letters}"
    elsif info_parsed["found"] == false
      @message = "Sorry, but #{@word} does not seem to be a valid English word..."
    else
      @message = "Congratulations! #{@word} is a valid English word!"
    end
  end
end

# def run_game(attempt, grid, start_time, end_time)
#   # TODO: runs the game and return detailed hash of result
#   url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
#   hash_as_string = URI.open(url).read
#   info_as_hash = JSON.parse(hash_as_string)
#   score = 0
#   if !info_as_hash["found"]
#     message = "not an english word"
#   elsif !word_in_grid?(attempt, grid.join)
#     message = "not in the grid"
#   else # it is found and it is in the grid
#     message = "well done"
#     score = info_as_hash["length"] / (end_time - start_time)
#   end
#   { time: (end_time - start_time), score: score, message: message }
# end
