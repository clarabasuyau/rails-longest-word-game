require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(10)
  end

  def score
    @words = params[:words]
    @letters = params[:letters]
    @include = included?(@words.upcase, @letters)
    @english_word = english_word?(@words)
  end

  private

  def included?(words, letters)
    words.chars.all? { |letter| words.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
