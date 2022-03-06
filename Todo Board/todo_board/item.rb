require_relative "todo_board"
require_relative "list"

class Item

    attr_accessor :title, :deadline, :description, :done

    def initialize(title, deadline, description)
        @title = title
        @deadline = deadline
        @description = description
        @done = false
    end

    def self.valid_date?(deadline)
        begin
            day = deadline[-2..-1].to_i
            month = deadline[5..6].to_i
            year = deadline[0..3].to_i

            if day >= 1 && day <= 31 && month >= 1 && month <= 12
                true
            else  
                false
            end
        end
        rescue
            false
    end

    def toggle
        @done == false ? @done = true : @done = false
    end
end

if false

    # pry testing

    load "item.rb"
    item1 = Item.new('Fix login page', '2019-10-42', 'It loads slow.')
    item2 = Item.new('Fix login page', '2019-10-30', 'It loads slow.')
    item3 = Item.new('Fix login page', '819-10-30', 'It loads slow.')
end