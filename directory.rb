$cohorts = %w(january february march april may june july august september october november december)
$default_cohort = "november"

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print(students)
  students.each { |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)".center(50)
  }
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(50)
end

def input_students
  students = Array.new
  puts "Please enter the name and cohort of each student"
  puts "To finish, just hit return twice"

  while true do
    # get name, and break if nothing entered
    puts "Name:"
    name = gets.chomp
    break if name == ""
    # get cohort, only accepting months + nothing entered (which defaults to default_month)
    while true do
      puts "Cohort:"
      cohort = gets.chomp.downcase
      puts "captured: before#{cohort}after"
      puts cohort.class
      break if $cohorts.include?(cohort)
      if cohort == ""
        cohort = $default_cohort
        break
      end
    end
    # add name and cohort to array of hashes, print student count
    students << { name: name, cohort: cohort.to_sym}
    puts "Now we have #{students.count} students"
  end

  students
end

students = input_students
print_header
print(students)
#print_footer(students)
