require 'csv'

@students = Array.new # an empty array accessible to all methods
@default_cohort = "november"

def try_load_students
  filename = ARGV.first
  if filename.nil? && File.exists?("students.csv")
    load_students("students.csv")
    puts "Loaded #{@students.count} from students.csv"
  elsif filename.nil?
    puts "No students yet loaded"
    return
  elsif File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} does not exist"
    exit
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the students"
  puts "4. Load the students"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
     confirm_choice(selection)
     input_students
    when "2"
     confirm_choice(selection)
     print_directory
    when "3"
     confirm_choice(selection)
     save_students
    when "4"
     confirm_choice(selection)
     load_students
    when "9"
     confirm_choice(selection)
     exit
    else puts "I don't know what you meant, try again"
  end
end

def confirm_choice(selection)
  case selection
  when "1" then puts "\nYou have chosen option 1, input students."
  when "2" then puts "\nYou have chosen option 2, show students."
  when "3" then puts "\nYou have chosen option 3, save students."
  when "4" then puts "\nYou have chosen option 4, load students."
  when "9" then puts "\nYou have chosen option 9, exiting program..."
  end
end

def add_student(name, cohort)
    @students << {name: name, cohort: cohort.to_sym}
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  cohort = @default_cohort
  while !name.empty?
    add_student(name, cohort)
    puts "Now we have #{@students.count} students"
  name = STDIN.gets.chomp
  end
end

def print_directory
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  CSV.open(ask_for_filename, "w") do |csv|
  # for each student, convert their hash data to an array, then a csv string.
  # then write it to the file
    @students.each{ |student|
      csv_line = [student[:name], student[:cohort]]
      csv << csv_line
    }
  end
end

def load_students(filename = ask_for_filename)
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort = line.chomp.split(",")
      add_student(name, cohort)
    end
  end
end

def ask_for_filename
  puts "Type the name of the file you would like to load from / save as:"
  STDIN.gets.chomp
end

try_load_students
interactive_menu
