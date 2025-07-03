require 'yaml'
require 'base64'

ALPHA = "abcdefghijklmnopqrstuvwxyz".split("")

words_file = File.open('lib/google-10000-english-no-swears.txt')
all_words = []
File.readlines(words_file).each do |line|
    all_words << line.chomp
end

words = all_words.select { |word| word.length >= 5 and word.length < 13 }

def hangman_string(current_word,guesses)
  word_progress = ""
  for letter in current_word
    if guesses.include?(letter)
      word_progress << "#{letter} "
    else
      word_progress << "_ "
    end
  end
  puts word_progress
end

def play_game(words,game_mode=0)
  if game_mode == 0
    current_word = words[rand(0..words.length)].split("")
    guesses = []
    incorrect = []
  else
    save_file = YAML.load File.read('lib/saved_game.yaml')
    current_word = Base64.decode64(save_file["current_word"]).split("")
    guesses = save_file["guesses"]
    incorrect = save_file["incorrect"]
    puts "Game imported successfully!"
    hangman_string(current_word,guesses)
    puts "Incorrect letters: #{incorrect.join(", ")}"
  end

  game_end = false
  game_saved = false
  #p current_word
  # the above line is for debugging only
   
  until game_end do
    valid_guess = false

    until valid_guess do 
      puts "Guess a letter, or type 'save' to quit: "
      guess = gets.chomp.downcase
      if !(guess == "save" || guess.length == 1)
        puts "Invalid guess. Either enter a single letter or type 'save' to quit."
      elsif guess == "save"
        game_end = true
        game_saved = true
        valid_guess = true
        encoded_word = Base64.encode64(current_word.join).chomp # so that the word isn't human readable from the saved_game.yaml file
        game_state = { "current_word" => encoded_word, "guesses" => guesses, "incorrect" => incorrect }.to_yaml
        save_file = File.open('lib/saved_game.yaml','w')
        save_file << game_state
        save_file.close
      elsif guesses.include?(guess)
        puts "Letter already guessed."
      elsif !ALPHA.include?(guess)
        puts "Not a valid letter."
      else
        valid_guess = true
      end
    end

    if game_saved
      break
    end
    
    guesses << guess

    if !current_word.include?(guess)
      incorrect << guess
    end

    hangman_string(current_word,guesses)

    puts "Incorrect letters: #{incorrect.join(", ")}"

    if current_word - guesses == [] || incorrect.length > 8
      game_end = true
    end

  end

  if current_word - guesses == []
    puts "Congratulations, you won!"
  elsif game_saved
    puts "Game saved!"
  else
    puts "The word was #{current_word.join}. Better luck next time!"
  end

end

if File.exist? 'lib/saved_game.yaml'
  puts "Save game found! Enter 'y' to load saved game, or anything else to load new game."
  new_game = gets.chomp.downcase
  if new_game == "y"
    play_game(words,1)
  else
    play_game(words)
  end
else
  play_game(words)
end