class Hangman

	attr_accessor :word, :correct_letters, :wrong_count, :guesses

	def initialize(word)
		@word = word.upcase
		@wrong_count = 0
		@correct_letters = container_array
		@guesses = []
	end

	def container_array
		container = Array.new(word.length, '_ ')
	end

	def guess_letter(letters_guessed)
		@guesses << letters_guessed.upcase
		@guesses << ' '
		letters_guessed = letters_guessed.upcase
		
		if word.include?(letters_guessed)

			word.each_char.with_index do |letter, index_pos|
				if letters_guessed == letter
					container[index_pos] = letter
				end
			end
		else
			@wrong_count += 1
		end
	end

	def valid_letter_input?
		if word.match(/[^a-zA-Z]/)
			false
		else
			true
		end
	end

	def loser?
		if wrong_count == 8
			true
		else
			false
		end
	end

	def do_not_repeat(repeat_letter)
		if guesses.include?(repeat_letter)
			true
		else
			false
		end
	end
end