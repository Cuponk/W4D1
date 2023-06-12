require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
		# check winner to see whether evaluator is not winner
		# and board has been won
		if board.winner == evaluator || board.winner.nil?
			return false
		else
			return true
		end	
	end
	if self.next_mover_mark == evaluator
		# go thru children and see whether they are losing
		# if all are losing, then we know current player lost
		self.children.all? {|child| child.losing_node?(evaluator)}
	else
		# next_mover_mark != evaluator, means opponents turn
		# if there is a next move that causes lost they will do it
		# if any losing node, opponent will play it
		self.children.any? {|child| child.losing_node?(evaluator)}
	end
  end

  def winning_node?(evaluator)
	# if board winner is evaluator, is winning node
	if board.over?
		if board.winner == evaluator || board.winner.nil?
			return false
		else
			return true
		end	
	end
	if self.next_mover_mark == evaluator
		self.children.all? {|child| child.losing_node?(evaluator)}
	else
		self.children.any? {|child| child.losing_node?(evaluator)}
	end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    next_mark = (self.next_mover_mark == :o ? :x : :o)
    @board.open_positions.map do |i|
      board = @board.dup
      board[i] = self.next_mover_mark
      TicTacToeNode.new(board, next_mark, i)
    end
  end
end