class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  attr_accessor :valid
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @valid = true
  end
  
  def guess char
    raise ArgumentError unless char =~ /[[:alpha:]]/

    if (word =~ /#{char}/i) 
      
      if (guesses =~ /#{char}/i) 
        false 
      else
        guesses << char 
      end
      
    else
      (wrong_guesses =~ /#{char}/i) ? false : wrong_guesses << char 
    end
    
  end
  
  def word_with_guesses
    wwg =''
    
     word.each_char do |letter|
      if guesses.include?(letter)
        wwg += letter
      else
        wwg += '-'
      end
    end
    wwg
  end
  
  def check_win_or_lose
    if self.word_with_guesses == @word
      return :win
    elsif wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
