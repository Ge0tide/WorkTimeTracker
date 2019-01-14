require 'csv'
operating = true

def input_hours
    input = ""
    date_array = []

    puts '1 - Input for today'
    input = gets.to_i

    if input == 1
        puts "Please input the number of hours:"

        input = gets.to_f

        date = Date.today.strftime("%Y %m %d")

        CSV.foreach("data.csv") do |row|
            csv_date, none = row[0].to_s.split("?")
            date_array << csv_date
        end

        CSV.open("data.csv", "ab") do |csv|
            unless date_array.include? date
                csv << ["#{date}?#{input}"]
                return "Operation Performed successfully!"
            else
                return "Date already written!"
            end
        end
    end
end

def retrieve_hours
    input = ""
    hours_worked = 0
    date = Date.today

    puts '1 - Return hours for this month'
    input = gets.to_i

    if input == 1
        arr = CSV.read("data.csv")
        arr.each do |row|
            csv_date, hours = row[0].split("?")
            puts 'c'
            csv_date = Date.strptime(csv_date, "%Y %m %d")

            if csv_date.strftime("%m") == date.strftime("%m") # if same month
                hours_worked += hours.to_f
            end
        end
        return "Hours worked this month: #{hours_worked}"
    end
end

while operating
    input = ""

    puts '1 - Input hours'
    puts '2 - Retrieve hours'
    puts '3 - Quit'
    input = gets.to_i

    if input == 1
        puts "\n#{input_hours()}\n\n"
    elsif input == 2
        puts "\n#{retrieve_hours()}\n\n"
    elsif input == 3
        operating = false
    end
end


