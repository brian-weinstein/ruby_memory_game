class Card
    attr_reader :revealed,:value

    def initialize(value)
        @value = value
        @revealed = false
    end

    def hide
        @revealed = false
    end

    def reveal
        @revealed = true
    end

    def to_s
        if revealed == true
            @value
        else
            " "
        end
    end

end