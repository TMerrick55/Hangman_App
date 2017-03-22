require 'minitest/autorun'
require_relative 'hangman.rb'

class TestHangman < Minitest::Test

	def test_container_is_array
		hangman_object = Hangman.new('Salutations')
		results = hangman_object.correct_letters
		assert_equal(Array, results.class)	
	end

	def test_array_length_11
		hangman_object = Hangman.new('Salutations')
		results = hangman_object.correct_letters
		assert_equal(11, results.length)	
	end

	def test_array_elements
		hangman_object = Hangman.new('Salutations')
		results = hangman_object.correct_letters
		assert_equal(['_','_','_','_','_','_','_','_','_','_','_'], results)	
	end

	def test_array_correct_guess_A
		hangman_object = Hangman.new('Salutations')
		hangman_object.guess_letter('A')
		results = hangman_object.correct_letters
		assert_equal(['_','A','_','_','_','A','_','_','_','_','_'], results)	
	end

	def test_array_incorrect_guess_C_wrong_count_1
		hangman_object = Hangman.new('Salutations')
		hangman_object.guess_letter('C')
		results = hangman_object.wrong_count
		assert_equal(1, results)
	end

	def test_array_correct_guess_beckon
		hangman_object = Hangman.new('Beckon')
		hangman_object.guess_letter('b')
		results = hangman_object.correct_letters
		assert_equal(['B','_','_','_','_','_'], results)
	end

	def test_invalid_word_input_false
		hangman_object = Hangman.new('Friend1')
		results = hangman_object.valid_letter_input?
		assert_equal(false, results)
	end

	def test_valid_word_input_true
		hangman_object = Hangman.new('SaLutAtiOns')
		results = hangman_object.valid_letter_input?
		assert_equal(true, results)
	end

	def test_invalid_symbols_false
		hangman_object = Hangman.new('Salutations!')
		results = hangman_object.valid_letter_input?
		assert_equal(false, results)
	end

	def test_invalid_space_false
		hangman_object = Hangman.new('Twenty Four')
		results = hangman_object.valid_letter_input?
		assert_equal(false, results)
	end
end