require 'open-uri'
require 'json'

BASE_URL = "https://api-platform.systran.net/translation/text/translate"
API_KEY = "f344bd65-939f-4a5d-be99-c0e46f227389"

class LongestwordsController < ApplicationController
  def game
  @grid = ""
  9.times do
    @grid << ('A'..'Z').to_a.sample
  end
  @grid
  end

  def score
  @word = params[:word]
  @grid = params[:grid]
  @word_letters = @word.upcase.split(//)
  @grid_letters = @grid.upcase.split(//)
  @result = ''
  @word_letters_count = {}
  @grid_letters_count = {}

    # check if the word exists in the English dictionnary
    json = JSON.parse(open("#{BASE_URL}?source=en&target=fr&key=#{API_KEY}&input=#{@word}").read)
    @result = json['outputs'].first['output']
    return nil if @result == @word
    @message = 'not an english word'
    # @message = 'not an english word' if translation.nil?
    @result

    # count the number of occurences of each letter of the word
    @word_letters.each do |char|
      if @word_letters_count.key?(char)
        @word_letters_count[char] += 1 # Incrementation
      else
        @word_letters_count[char] = 1 # Initialisation
      end
    end

    # count the number of occurences of each letter in the initial grid
    @grid_letters.each do |char|
      if @grid_letters_count.key?(char)
        @grid_letters_count[char] += 1 # Incrementation
      else
        @grid_letters_count[char] = 1 # Initialisation
      end
    end

    # determine if all the letters of the word are part of the grid
    @word_letters_count.each do |key, value|
      return false unless @grid_letters_count.key?(key)
      @message = 'not in the grid'
      # @message = 'not in the grid' unless in_the_grid(attempt, grid)
      # équivalent à unless @word_letters_count.key == @grid_letters_count.key
      return false if value > @grid_letters_count[key]
    end
      true

# def get_message(translation, attempt, grid)
#     @message = 'well done'
#     @message = 'not an english word' if translation.nil?
#     @message = 'not in the grid' unless in_the_grid(attempt, grid)
#   @message
# end

  end

#  def hash_chars_occurence(chars)
#   hash = {}
#   chars.each do |char|
#     if hash.key?(char)
#       hash[char] += 1 # Incrementation
#     else
#       hash[char] = 1 # Initialisation
#     end
#   end
#   hash
# end

# def in_the_grid(attempt, grid)
#   attempt_h = hash_chars_occurence(attempt.upcase.chars)
#   grid_h = hash_chars_occurence(grid)
#   attempt_h.each do |key, value|
#     return false unless grid_h.key?(key)
#     return false if value > grid_h[key]
#   end
#   true
# end

# def calculate_score(attempt, time)
#   (attempt.chars.count * 100) / time
# end

# def get_message(translation, attempt, grid)
#   @message = 'well done'
#   @message = 'not an english word' if translation.nil?
#   @message = 'not in the grid' unless in_the_grid(attempt, grid)
#   @message
# end

# def run_game(attempt, grid, start_time, end_time)
#   time = end_time - start_time
#   translation = translate(attempt)
#   score = calculate_score(attempt, time)
#   message = get_message(translation, attempt, grid)
#   score = 0 if message != 'well done'
#   { time: time, translation: translation, score: score, message: message }
# end

end
