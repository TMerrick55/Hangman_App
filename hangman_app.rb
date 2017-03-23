require 'sinatra'
require_relative 'hangman.rb'

enable :sessions

get '/' do
	erb :welcome
end

post '/players' do
	session[:p1] = params[:player1_name_input]
	session[:p2] = params[:player2_name_input]

	erb :choose_word, :locals => {p1: session[:p1], p2: session[:p2]}

end

post '/game_prep' do
	session[:guess_word] = params[:guess_word]
	session[:hangman] = Hangman.new(session[:guess_word])
	if session[:hangman].valid_letter_input? == false
		redirect '/invalid_word_choice'
	end

	session[:length] = session[:hangman].correct_letters.count

	redirect '/main_game_hangman'
end

get '/invalid_word_choice' do
	erb :invalid
end

get '/main_game_hangman' do
	session[:correct_letters] = session[:hangman].correct_letters.join
	session[:wrong] = session[:hangman].wrong_count

	if session[:wrong] == 8
		redirect '/you_lose'
	end

	erb :main_game, :locals => {p1: session[:p1], p2: session[:p2], guess_word: session[:guess_word], correct_letters: session[:correct_letters], length: session[:length], wrong: session[:wrong]}

end

post '/make_guess' do
	session[:letter] = params[:letter]
	session[:hangman].guess_letter(session[:letter])

	if session[:hangman].correct_letters.include?('_ ') == false
		redirect '/winner'
	else
		redirect '/main_game_hangman'
	end
end

get '/winner' do
	erb :winner
end

get '/you_lose' do
	erb :game_lost
	#'Game Over'
end