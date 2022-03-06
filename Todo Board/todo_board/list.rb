require_relative "item"
require_relative "todo_board"

class List

    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
        
    end

    def add_item(title, deadline, description="") 
        item = Item.new(title, deadline, description)
        if Item.valid_date?(deadline)
            @items << item
            true
        else
            false
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        (index >= 0 && index < self.size) && index != nil
    end

    def swap(index_1, index_2)
        if valid_index?(index_1) && valid_index?(index_2) 
            @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
            true
        else
            false
        end
    end

    def [](index)
        @items[index]
    end

    def priority 
        @items[0]
    end
 
    def print
        bar = "-" * 38
        
        puts bar

        pad = 38 - self.label.length
        pad += 1 if pad % 2 != 0
        pad /= 2

        puts (" " * pad) + self.label + (" " * pad) 
        puts bar
        puts "Done".ljust(5) + "| Index | Item".ljust(20) + "| Deadline"
        puts bar
        @items.each { |item| puts (item.done == true ? 'Yes' : 'No').to_s.ljust(4) + " | " + @items.index(item).to_s.ljust(6) + "| " + item.title.ljust(10) + "| " + item.deadline  }
        puts bar
    end

    def print_full_item(index)
        bar = "-" * 38
        if valid_index?(index)
            @items[index].done == true ? done = 'DONE' : done = 'NOT DONE'  
            puts bar
            puts @items[index].title.ljust(18) + done.ljust(10) + @items[index].deadline
            puts @items[index].description
            puts bar
        else
            false
        end
    end

    def print_priority
        print_full_item(@items.index(priority))
    end

    def up(index, amount=1)
        if valid_index?(index)
            target = index-amount
            target = 0 if target <= 0
            i = index
            while i > target do
                swap(i, i-1)
                i -= 1
            end
        end
    end

    def down(index, amount=1)
        if valid_index?(index)
            target = index+amount
            target = @items.length - 1 if target >= @items.length
            i = index
            while i < target do
                swap(i, i+1)
                i += 1
            end
        end
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end

    def toggle_item(index)
        @items[index].toggle if valid_index?(index)
    end

    def remove_item(index)
        if valid_index?(index)
            target = @items.length - 1
            down(index, target)
            @items.pop
            true
        else
            false
        end
    end

    def purge
        while @items.any? { |item| item.done } do
            (0...@items.length).each { |idx| remove_item(idx) if @items[idx] != nil && @items[idx].done }
        end
    end
end


if false

    # pry testing

    load 'list.rb'
    my_list = List.new("Groceries")
    my_list.add_item('cheese', '2019-10-25', 'Get American and Feta for good measure.')
    my_list.add_item('toothpaste', '2019-10-25')
    my_list.add_item('shampoo', '10-24-2019')
    my_list.add_item('shampoo', '2019-10-24')
    my_list.add_item('candy', '2019-10-31', '4 bags should be enough')
    my_list.sort_by_date!
    my_list.print
end