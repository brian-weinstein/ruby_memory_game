require_relative "card"
require "byebug"

ALPHABET = *("A".."Z")

class Board

    def initialize
        @size = 4
        @grid = Array.new(4){Array.new(4)}
        self.populate
    end

    #picks random letters from alphabet to fill the grid
    #number of pairs required = size * 2
    
    def getRandomCards
        values = Hash.new(0)
        randomCards = ALPHABET.sample(@size * 2)
        randomCards.each {|v| values[v] = 0}
        values
    end

    def populate
        values = getRandomCards # values of the cards randomly chosen from alphabet
        while values.length > 0 do
            rand1 = rand(0...@size)
            rand2 = rand(0...@size)
            if @grid[rand1][rand2] == nil
                card = values.keys.sample #assigns random value to created card
                @grid[rand1][rand2] = Card.new(card) #assign card to grid randomly
                values[card] += 1  #number of cards with chosen value
                if values[card] >= 2 #once a pair is in the grid, delete value from possibilities
                    values.delete(card)
                end
            end
        end
    end

    def [](position)
        x,y = position
        @grid[x][y]
    end

    def []=(position,value)
        x,y = position
        @grid[x][y] = value
    end

    
    def render
        system("clear")
        puts "  0 1 2 3"
        @grid.each_with_index do |r,i|
            puts i.to_s + " " + r.join(" ")
        end
    end

    def won?
        @grid.all? do |c|
            c.all? do |x|
                x.revealed == true
            end
        end
    end

    def guess(position)
        x,y = position
        @grid[x][y].reveal
        @grid[x][y].value
    end

end