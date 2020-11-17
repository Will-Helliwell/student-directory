@students = Array.new # an empty array accessible to all methods

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

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = gets.chomp
  while !name.empty?
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students"
  name = gets.chomp
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1" then input_students
    when "2" then show_students
    when "3" then save_students
    when "9" then exit
    else puts "I don't know what you meant, try again"
  end
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

interactive_menu

=begin
students = input_students
print_header
print(students)
print_footer(students)
=end
