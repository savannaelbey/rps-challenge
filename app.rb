require 'sinatra/base'
require './lib/player.rb'
require './lib/human.rb'
require './lib/computer.rb'
require './lib/game.rb'

class RPS < Sinatra::Base

  before do
    @game = Game.instance
  end

  get '/' do
    erb :index
  end

  post '/name' do
    @game = Game.create(Human.new(params[:player_name]), Computer.new)
    redirect '/play'
  end

  get '/play' do
    erb :play
  end

  post '/move' do
    @game.play(params[:player_move])
    if @game.game_over?
      redirect '/result'
    else
      redirect '/play'
    end
  end

  get '/result' do
    erb :result
  end

  run! if app_file == $0
end
