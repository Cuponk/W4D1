require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    new_board = TicTacToeNode.new(game, mark)
    new_board.children.each do |i|
      if i.winning_node?(i.next_mover_mark)
        return i.prev_move_pos
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end