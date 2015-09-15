require 'sinatra/base'
require_relative 'water'
require_relative 'ship'
require_relative 'cell'
require_relative 'board'


class BattleshipsWeb < Sinatra::Base

  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
    erb :index
  end

  get '/new_game' do
    @name = params[:name]
    erb :new_game
  end

  get '/test' do
    erb :test
  end

  get '/example_board' do
    board = Board.new(Cell)
    ship1 = Ship.new(2)
    ship2 = Ship.new(3)
    ship3 = Ship.new(4)
    board.place(ship1, :A1)
    board.place(ship2, :C2)
    board.place(ship3, :E4)
    @result = board.print_board
    erb :example_board
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
