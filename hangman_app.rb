require 'sinatra'
require_relative 'hangman.rb'

enable :sessions

get '/' do
	erb :welcome
end

post '/players' do
	session[:p1] = params[:player1]
	session[:p2] = params[:player2]

	erb :choose_word, :locals => {p1: session[:p1], p2: session[:p2]}

end

post '/game_prep' do
	session[:chose_word] = params[:chose_word]
	session[:hangman] = Hangman.new(session[:chose_word])
	if session[:hangman].valid_input? == false
		redirect '/invalid_word_choice'
	end

	session[:length] = session[:hangman.correct_letters.count]

	redirect '/main_game_hangman'
end

get '/invalid_word_choice' do
	erb :invalid
end

get '/main_game_hangman' do
	session[:correct_letters] = session[:hangman].correct_letters.join
	session[:wrong] = session[:hangman].wrong_count

	if session[:hangman].wrong_count == 8
		redirect '/game_lost'
	end

	erb :main_game_hangman, :locals => {p1: session[:p1], p2: session[:p2], guess_word: session[:guess_word], correct: session[:correct_letters], length: session[:length], wrong: session[:wrong]}

end

post '/make_guess' do
	session[:letter] = params[:letter]
	session[:hangman].guess_letter(session[:letter])

	if session[:hangman].correct.include?('_')
		redirect '/main_game_hangman'
	else
		redirect '/winner'
	end
end

get '/winner' do
	erb :winner
end

get '/lose' do
	erb :game_lost
end