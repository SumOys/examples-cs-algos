#!/usr/bin/env ruby
require 'ascii_charts'
require 'pp'

def generate_set(size)
    (1..size).map { |e| rand 100000000 }
end

def swap!(set, i, j)
    temp = set[i]
    set[i] = set[j]
    set[j] = temp
end

def insert_sort!(set)
    (0..set.size - 1).each do |i|
        (i..set.size - 1).each do |j|
            if set[j] < set[i]
                swap!(set, i, j)
            end
        end
    end
end

def selection_sort!(set)
    (0..set.size - 1).each do |i|
        min_index = i
        (i..set.size - 1).each do |j|
            if set[j] < set[min_index]
                min_index = j
            end
            swap!(set, i, min_index)
        end
    end
end

def run_sorts(sort_algo)
    sizes = [10, 100, 1000, 10_000, 100_000, 1_000_000] #, 100_000_000, 100_000_000_000]

    sized_sets = sizes.map { |s| 
        puts "Generating set of size #{s}"
        generate_set(s)
    }
    results = sized_sets.map { |set|
        puts("Sorting set of size #{set.size}")
        start_time = Time.now
        if sort_algo == "insert" then
            insert_sort!(set)
        elsif sort_algo == "selection" then
            selection_sort!(set)
        else
            raise "Unknown sort algorithm #{sort_algo}"
        end
        end_time = Time.now
        [set.size, end_time.to_f - start_time.to_f]
    }
end


["insert", "selection"].each { |algo|
  puts "Sorting: #{algo}"
  result_times = run_sorts(sort_algo=algo)
  pp result_times
  puts AsciiCharts::Cartesian.new(result_times).draw
}

#set = generate_set(100)
#insert_sort!(set)
#selection_sort!(set)
#puts(set)