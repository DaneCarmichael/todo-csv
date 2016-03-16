require 'csv'

class Todo
  def initialize(file_name)
    @file_name = file_name #Don't touch this line or var
    # You will need to read from your CSV here and assign them to the @todos variable. make sure headers are set to true
    @todos = CSV.read(@file_name, {headers: true})
  end

  def start
    loop do
      system('clear')

      puts "---- TODO.rb ----"

      view_todos

      puts
      puts "What would you like to do?"
      puts "1) Exit 2) Add Todo 3) Mark Todo As Complete"
      print " > "
      action = gets.chomp.to_i
      case action
      when 1 then exit
      when 2 then add_todo
      when 3 then mark_todo
      else
        puts "\a"
        puts "Not a valid choice"
      end
    end
  end

  def view_todos
    puts "Unfinished"
    unfinished = @todos.select {|rows| rows["completed"] == "no"}
    unfinished.each_with_index do |unfinished, index|
      puts "#{index + 1}) #{unfinished["name"]}"
    end
    puts "Completed"
    finished = @todos.select {|rows| rows["completed"] == "yes"}
    finished.each_with_index do |finished, index|
      puts "#{index + 1}) #{finished["name"]}"
    end
  end

  def add_todo
    print "Name of Todo > "
    input = get_input
    @todos.push(["#{input}","no"])
  end

  def mark_todo
    print "Which todo have you finished?"
    row = get_input.to_i
    @todos[row-1][1] = "yes"
  end

  def todos
    @todos
  end

  private # Don't edit the below methods, but use them to get player input and to save the csv file
  def get_input
    gets.chomp
  end

  def save!
    File.write(@file_name, @todos.to_csv)
  end
end
