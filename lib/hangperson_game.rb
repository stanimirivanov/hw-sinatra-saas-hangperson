class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize (new_word)
    @word = new_word
    @guesses = ''
    @wrong_guesses = ''
  end

  attr_accessor :word, :guesses, :wrong_guesses

  def guess (character)
    if character == nil
      raise ArgumentError.new("No nil is allowed")
    elsif character.length == 0
      raise ArgumentError.new("No Empty character is allowed")
    elsif character !~ /[[:alpha:]]/
      raise ArgumentError.new("No Non-Letter character is allowed")
    end

    character = character.downcase

    if @word.include? character
      if @guesses.include? character
        return false
      else
        @guesses += character
        return true
      end
    else
      if @wrong_guesses.include? character
        return false
      else  
        @wrong_guesses += character
        return true
      end
    end
  end

  def word_with_guesses
    output_string = ''
    @word.split("").each do |char|
      if @guesses.include? char
        output_string += char
      else
        output_string += '-'
      end
    end
    return output_string
  end

  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    end
    @word.split("").each do |char|
      if !@guesses.include? char
        return :play
      end
    end
    return :win
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end