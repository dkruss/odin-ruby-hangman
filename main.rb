words_file = File.open('lib/google-10000-english-no-swears.txt')
all_words = []
File.readlines(words_file).each do |line|
    all_words << line.chomp
end

words = all_words.select { |word| word.length >= 5 and word.length < 13 }

def play_game(words,game_mode=1)
  if game_mode == 1
    current_word = words[rand(0..words.length)].split("")
    guesses = []
    incorrect = []
  else
    # add logic for importing variables from saved game
  end

  game_end = false
  #p current_word
  # the above line is for debugging only
   
  until game_end do
    hangman_string = ""
    puts "Guess a letter: "
    # add input validation to add this only if: only 1 character AND is alphabetical AND is not yet in guesses 
    # ALSO add save logic
    guess = gets.chomp.downcase
    guesses << guess

    if !current_word.include?(guess)
      incorrect << guess
    end

    for letter in current_word
      if guesses.include?(letter)
        hangman_string << "#{letter} "
      else
        hangman_string << "_ "
      end
    end

    puts hangman_string
    puts "Incorrect letters: #{incorrect.join(", ")}"

    if current_word - guesses == [] || incorrect.length > 8
      game_end = true
    end

  end

  if current_word - guesses == []
    puts "Congratulations, you won!"
  else
    puts "Better luck next time!"
  end

end

play_game(words)
# add play saved game logic