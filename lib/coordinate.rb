# frozen_string_literal: true

# This class defines the position of a particular piece.
class Coordinate
end

# What is the difference between "coordinate," "position," and "square?"
## Coordinate - 2d array with a row and column
## Position - where a particular piece is, has a piece and a coordinate
## Square - fixed position on the board. has a coordinate and a color

# Currently I am using a "coordinate lookup" method on the game board that takes a coordinate and returns a piece, so that methods can be called on the piece.
# This is I think the primitive obsession issue.
# What would the extracted class look like, though? Simply the coordinate and the piece?
# How should these be built? Probably within the game board state.

