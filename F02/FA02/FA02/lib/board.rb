require_relative 'connect_tac_toe'
require_relative 'player'

class Board

    def self.build_stacks(n)
        array = Array.new(n) { Array.new([]) }
    end

    def initialize(n, max)
        @max_height = max
        @stacks = Board.build_stacks(n)
        if n < 4 || max < 4
            puts "Rows and columns must be >= 4"
            raise RuntimeError.new "rows and cols must be >= 4" 
        end
    end

    def max_height
        @max_height
    end
    
    def add(token, stack)
        if @stacks[stack].length < @max_height
            @stacks[stack] << token
            true
        else
            false
        end
    end
    
    def vertical_winner?(token)
        @stacks.any? { |subArr| subArr.all? { |el| el == token } && subArr.length == @max_height }
    end
    
    def horizontal_winner?(token)
        (0..@max_height).any? { |i| @stacks.all? { |stack| stack[i] == token } }
    end

    def winner?(token)
        vertical_winner?(token) || horizontal_winner?(token)
    end

    # This Board#print method is given for free and does not need to be modified
    # It is used to make your game playable.
    def print
        @stacks.each { |stack| p stack }
    end
end
