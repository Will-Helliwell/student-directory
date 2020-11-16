def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.select{ |student| student[:name].chr == "a" }
  .each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" }
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = Array.new
  name = gets.chomp
  while !name.empty?
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
  name = gets.chomp
  end
  students
end

students = input_students
print_header
print(students)
print_footer(students)
