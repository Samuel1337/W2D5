require_relative "item"
require_relative "list"

class TodoBoard 

    def initialize(label)
        @hash = Hash.new
        @list = List.new(label)
        @hash[label]= @list
    end
    
    def get_command
        puts "Enter a command: "
        cmd, *args = gets.chomp.split(' ')
        
        case cmd

        when 'mklist'
            List.new(label)
            @hash[label] = @list
        when 'ls'
            puts @hash.keys.join(" ")
        when 'showall'
            @hash.each { |k, v| v.print } 
        when 'mktodo'
            @hash[args[0]].add_item(args[1], args[2], args[3])
        when 'up'
            @hash[args[0]].up(args[1].to_i, args[2].to_i)
        when 'down'
            @hash[args[0]].down(args[1].to_i, args[2].to_i)
        when 'swap'
            @hash[args[0]].swap(args[1].to_i, args[2].to_i)
        when 'sort'
            @hash[args[0]].sort_by_date!
        when 'priority'
            @hash[args[0]].print_priority
        when 'print'
            if args.length > 0
                @hash[args[0]].print_full_item(args[1].to_i)
            else
                @hash[args[0]].print
            end
        when 'toggle'
            @hash[args[0]].toggle_item(args[1].to_i)
        when 'rm'
            @hash[args[0]].remove_item(args[1].to_i)
        when 'purge'
            args.length > 0 ? @hash[args[0]].purge : @list.purge
        when 'quit'
            false
        else
            puts "Sorry, that command is not recognized."
        end

        true
    end

    def run
        while get_command == true do
            get_command
        end
    end
end

    load "todo_board.rb"
    todo = TodoBoard.new("label")
    todo.run

# if false
#     mktodo groceries butter 2019-10-24
#     mktodo groceries milk 2019-10-23
#     mktodo groceries candy 2019-10-31 sugar-free
#     mktodo groceries toothpaste 2019-10-29
#     print groceries
# end