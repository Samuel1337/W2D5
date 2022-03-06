class Passenger

    def initialize(name)
        @name = name
        @flight_numbers = []
    end

    def name
        @name
    end

    def has_flight?(string)
        @flight_numbers.include?(string.upcase)
    end

    def add_flight(string)
        @flight_numbers << string.upcase if !has_flight?(string)
    end


end