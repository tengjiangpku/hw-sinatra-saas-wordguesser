class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @attempt_num = 0
  end

  def guess s
    unless not s.nil? and s.match(/^[a-zA-Z]$/)
      raise ArgumentError
    end
    s = s.downcase
    if @word.downcase.include?(s)
      if not @guesses.include?(s)
        @attempt_num += 1
        @guesses += s
        true
      else
        false
      end
    else
      if not @wrong_guesses.include?(s)
        @attempt_num += 1
        @wrong_guesses += s
        true
      else
        false
      end
    end
  end

  def word_with_guesses
    ans = ''
    @word.each_char do |i|
      if @guesses.include?(i)
        ans += i
      else
        ans += '-'
      end
    end
    ans
  end

  def check_win_or_lose
    if @guesses.size == @word.size && @guesses.delete(@word.downcase).empty?
      :win
    elsif @attempt_num >= 7
      :lose
    else
      :play
    end
  end


  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end


end