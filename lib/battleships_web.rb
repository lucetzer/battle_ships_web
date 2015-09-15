require 'sinatra/base'
require_relative 'water'
require_relative 'ship'
require_relative 'cell'
require_relative 'board'


class BattleshipsWeb < Sinatra::Base

  enable :sessions


  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
    erb :index
  end

  get '/new_game' do
    @name = params[:name]
    erb :new_game
  end

  get '/one_player_game' do
    session[:board] = Board.new(Cell) if session[:board] == nil
    session[:ship1] = Ship.new(4) if session[:ship1] == nil
    session[:board].place(session[:ship1], :A1) if session[:board].ships_count == 0
    @move = params[:move]
    @move = @move.to_sym if params[:move] != nil
    session[:board].shoot_at(@move) if @move != nil
    @result = session[:board].opponent_board
    erb :one_player_game
  end


  get '/example_board' do
    board = Board.new(Cell)
    ship1 = Ship.new(2)
    ship2 = Ship.new(3)
    ship3 = Ship.new(4)
    board.place(ship1, :A1)
    board.place(ship2, :C2)
    board.place(ship3, :E4)
    board.shoot_at(:A1)
    board.shoot_at(:E4)
    board.shoot_at(:A7)
    board.shoot_at(:E9)
    board.shoot_at(:C3)
    board.shoot_at(:D8)
    board.shoot_at(:C9)
    board.shoot_at(:A2)
    board.shoot_at(:F7)
    board.shoot_at(:G9)
    @result = board.print_board
    # @result = board.opponent_board

    erb :example_board
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
