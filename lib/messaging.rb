# frozen_string_literal: true

# Contains error and informational messages about the game state.
module Messaging
  def errors
    { invalid_text: 'Please enter your move in four characters indicating the coordinate for each move, like a1b2.',
      not_own_piece: "You have selected an initial square that doesn't contain one of your pieces.",
      checked: 'This move would cause your turn to end in check.',
      end_square_blocked: 'That square is not accessible because it is blocked by other pieces.',
      invalid_range: 'That move is not valid for this piece.' }
  end

  def alerts
    { in_check: 'You are in check.',
      checkmate: 'Game ends in checkmate.' }
  end
end
