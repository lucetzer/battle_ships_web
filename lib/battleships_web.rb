require 'sinatra/base'
require_relative 'board'
require_relative 'cell'
require_relative 'water'
require_relative 'ship'

class BattleshipsWeb < Sinatra::Base

  enable :sessions
  set :views, proc { File.join(root, '..', 'views') }

  get '/new_game' do
    erb :new_game
  end

  get '/new_board' do
    session[:name] = params[:name]
    @name = session[:name]
    session[:board] = Board.new(Cell)
    @display = session[:board].print_board
    session[:counter] = 0
    erb :new_board
  end

  get '/place_ships' do
    coords = params[:coords].to_sym
    session[:counter] += 1
    @size = session[:counter]
    session["ship#{@size}"] = Ship.new(@size)
    session[:board].place(session["ship#{@size}"], coords)
    @display = session[:board].print_board
    session[:board].ships_count < 5 ? erb(:place_ships) : erb(:fire)
  end

  get '/fire' do
    coords = params[:coords].to_sym
    session[:board].shoot_at(coords)
    @display = session[:board].opponent_board
    sunk_ships = 0 if session[:board].ships_count == 5
    5.times { |index| sunk_ships += 1 if session["ship#{index + 1}"].sunk? }
    @message = "Number of ships sunk: #{sunk_ships}"
    sunk_ships == 5 ? erb(:winner) : erb(:fire)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
