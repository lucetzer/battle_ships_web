class HTMLprinter

  def print_board(board)
    printed_board = "<div style='height:50px; width:550px;'>"
    [*"A".."J"].each do |l|
      [*1..10].each do |n|
        if board.grid["#{l}#{n}".to_sym].content.is_a?(Water) && board.grid["#{l}#{n}".to_sym].content.hit == true
          printed_board += "<div style='background-color:#E2BE22; height:50px; width:50px; display:inline-block; border: 1px solid white;'> </div>"
        elsif board.grid["#{l}#{n}".to_sym].content.is_a?(Water) && board.grid["#{l}#{n}".to_sym].content.hit == false
          printed_board += "<div style='background-color:#0000FF; height:50px; width:50px; display:inline-block; border: 1px solid white;'> </div>"
        elsif board.grid["#{l}#{n}".to_sym].hit == true
          printed_board += "<div style='background-color:#FF0000; height:50px; width:50px; display:inline-block; border: 1px solid white;'> </div>"
        elsif board.grid["#{l}#{n}".to_sym].hit == false
          printed_board += "<div style='background-color:#008800; height:50px; width:50px; display:inline-block; border: 1px solid white;'> </div>"
        end
      end
    end
    printed_board += "</div>"
    printed_board
  end

  def opponent_board(board)
    printed_board = "<div style='height:50px; width:550px;'>"
    [*"A".."J"].each do |l|
      [*1..10].each do |n|
        if board.grid["#{l}#{n}".to_sym].content.is_a?(Water) && board.grid["#{l}#{n}".to_sym].content.hit == true
          printed_board += "<div style='background-color:#E2BE22; height:50px; width:50px; display:inline-block; border: 1px solid white;'> </div>"
        elsif board.grid["#{l}#{n}".to_sym].content.is_a?(Water) && board.grid["#{l}#{n}".to_sym].content.hit == false
          printed_board += "<div style='background-color:#0000FF; height:50px; width:50px; display:inline-block; border: 1px solid white;'> </div>"
        elsif board.grid["#{l}#{n}".to_sym].hit == true
          printed_board += "<div style='background-color:#FF0000; height:50px; width:50px; display:inline-block; border: 1px solid white;'> </div>"
        elsif board.grid["#{l}#{n}".to_sym].hit == false
          printed_board += "<div style='background-color:#0000FF; height:50px; width:50px; display:inline-block; border: 1px solid white;'> </div>"
        end
      end
    end
    printed_board += "</div>"
    printed_board
  end

end
