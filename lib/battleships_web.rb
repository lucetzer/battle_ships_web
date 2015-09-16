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

  get '/new_board' do
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
    erb :fire
  end





  get '/example_board' do
    board = Board.new(Cell)
    ship1 = Ship.new(2)
    ship2 = Ship.new(3)
    ship3 = Ship.new(4)
    board.place(ship1, :A1)
    board.place(ship2, :C2)
    board.place(ship3, :E4)

    # board.shoot_at(:A1)
    # board.shoot_at(:E4)
    # board.shoot_at(:A7)
    # board.shoot_at(:E9)
    # board.shoot_at(:C3)
    # board.shoot_at(:D8)
    # board.shoot_at(:C9)
    # board.shoot_at(:A2)
    # board.shoot_at(:F7)
    # board.shoot_at(:G9)
    @result = board.print_board
    # @result = board.opponent_board

    erb :example_board
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
