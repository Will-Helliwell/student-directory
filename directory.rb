@students = Array.new # an empty array accessible to all methods

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
    when "1" then input_students
    when "2" then print_directory
    when "3" then save_students
    when "4" then load_students
    when "9" then exit
    else puts "I don't know what you meant, try again"
  end
end

def add_student(name, cohort)
    @students << {name: name, cohort: cohort.to_sym}
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  cohort = "november"
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
  # open a new file students.csv and return a pointer to it ('file')
  file = File.open("students.csv", "w")
  # for each student, convert their hash data to an array, then a csv string.
  # then write it to the file
  @students.each{ |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  }
  # close the file
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    add_student(name, cohort)
  end
  file.close
end



try_load_students
interactive_menu
