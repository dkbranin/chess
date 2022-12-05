# frozen_string_literal: true

require_relative 'coordinate_mapper'

# Record each move made by each side
# Allow the record to be queried to see if a piece has previously moved

class MoveLogger
  attr_reader :log

  def initialize
    @log = []
  end

  def log_move(move)
    log.push(move)
  end

  def log_strings
    log.map { |move| "#{move[0]} -> #{move[1]}" }
  end

  def print_log
    running_log = log_strings
    turn_number = 1
    until running_log.length.zero?
      running_log.length == 1 ? one_left(log: running_log, number: turn_number) : pair(pair: running_log.shift(2), number: turn_number)
      turn_number += 1
    end
  end

  def one_left(log:, number:)
    last_value = log.shift
    puts "#{number}. #{last_value}"
  end

  def pair(pair:, number:)
    puts "#{number}. #{pair[0]}, #{pair[1]}"
  end

  def first_moves
    log.flatten(1).filter.with_index { |_move, index| index.even? }
  end
end

# log move
# accept new and old coordinates
# log as array pair

# print log
# print number, then array pair
# e.g., 1. d2 -> d4, d7 -> d5

# search log
# dig to see if coordinate exists
