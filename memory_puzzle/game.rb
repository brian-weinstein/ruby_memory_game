require_relative "board"
require "byebug"

class Game
    attr_reader :previousGuess, :board

    def initialize
        @board = Board.new
        @previousGuess = nil
    end

    def turn(position)
        
        if @previousGuess == nil
            @previousGuess = position
            @board[position].reveal
        else
            if @board.guess(position) != @board.guess(previousGuess)
                @board.render
                puts "Incorrect Guess"
                sleep(2)
                @board[position].hide
                @board[previousGuess].hide
                @previousGuess = nil
            else
                @previousGuess = nil
            end
        
        end
            
    end

    def play
        while @board.won? == false
            @board.render
            puts "Enter a position with coordinates separated with a space like '4 7'"
            input = gets.chomp
            position = input.split(" ")
            position.map!(&:to_i)
            
            turn(position)
        end
        puts "YOU WIN!"
    end


end