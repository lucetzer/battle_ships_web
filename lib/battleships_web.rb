require 'sinatra/base'
require_relative 'water'
require_relative 'ship'
require_relative 'cell'
require_relative 'board'

class BattleshipsWeb < Sinatra::Base

  enable :sessions

  set :views, proc { File.join(root, '..', 'views') }

  get '/new_game' do
    erb :new_game
  end

  get '/new_board' do
    session[:name] = params[:name]
    @name = session[:name]
    session[:board] = Board.new(Cell) if session[:board] == nil
    @display = session[:board].print_board
    session[:size] = 0
    erb :new_board
  end

  get '/place_ships' do
    @coords = params[:coord]
    @coords = @coords.to_sym if params[:coord] != nil
    session[:size] += 1
    session["ship#{session[:size]}"] = Ship.new(session[:size])
    session[:board].place(session["ship#{session[:size]}"], @coords)
    @display = session[:board].print_board
    if session[:board].ships_count <= 4
      @size = session[:size]
      erb :place_ships
    else
      erb :fire
    end
  end

  get '/fire' do
    @move = params[:coord]
    @move = @move.to_sym if params[:coord] != nil
    session[:board].shoot_at(@move) if @move != nil
    @display = session[:board].opponent_board
    @sunk_ships = 0 if session[:board].ships_count == 5
    5.times do |index|
      if session["ship#{index + 1}"].sunk?
        @sunk_ships += 1
        @message = "Number of ships sunk: #{@sunk_ships}"
      end
    end
    if @sunk_ships == 5
      erb :winner
    else
      erb :fire
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
