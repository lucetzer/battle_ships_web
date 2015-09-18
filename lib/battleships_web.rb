require 'sinatra/base'
require_relative '../game_setup'
require_relative 'HTMLprinter'

class BattleshipsWeb < Sinatra::Base

  enable :sessions
  set :views, proc { File.join(root, '..', 'views') }

  # @grid = $board1.show_board(HTMLPrinter)

  get '/' do
    erb :index
  end

  post '/new_player' do
    session[:name] = params[:name]
    redirect '/new_player'
  end

  get '/new_player' do
    @player = session[:name]
    erb :new_player
  end

  post '/new_board' do
    session[:coord] = params[:coord].to_sym
    session[:orientation] = params[:orientation].to_sym
    redirect '/new_board'
  end

  get '/new_board' do
    session[:board] = Board.new(Cell)
    @display = session[:board].show_board(HTMLprinter)
    # session[:counter] = 0
    erb :new_board
  end
  #
  # get '/place_ships' do
  #   coords = params[:coords].to_sym
  #   orientation = params[:orientation].to_sym
  #   session[:counter] += 1
  #   @size = session[:counter]
  #   session["ship#{@size}"] = Ship.new(@size)
  #   session[:board].place(session["ship#{@size}"], coords, orientation)
  #   @display = session[:board].print_board
  #   session[:board].ships_count < 5 ? erb(:place_ships) : erb(:fire)
  # end
  #
  # post '/place_ships' do
  #   session[:coord] = params[:coord]
  #   session[:orientation]
  #   session[:size]
  #
  #
  # end
  #
  #
  # get '/fire' do
  #   coords = params[:coords].to_sym
  #   session[:board].shoot_at(coords)
  #   @display = session[:board].opponent_board
  #   sunk_ships = 0 if session[:board].ships_count == 5
  #   5.times { |index| sunk_ships += 1 if session["ship#{index + 1}"].sunk? }
  #   @message = "Number of ships sunk: #{sunk_ships}"
  #   sunk_ships == 5 ? erb(:winner) : erb(:fire)
  # end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
