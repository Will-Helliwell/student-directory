@cohorts = %w(january february march april may june july august september october november december)
@default_cohort = "november"

def show_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def show(students)
  # create an array of existing cohorts
  existing_cohorts = Array.new
  students.each { |student|
    # puts "#{student[:cohort]}""
    if !existing_cohorts.include?(student[:cohort])
      existing_cohorts << student[:cohort]
    end
  }
  # print students from each cohort in order
  existing_cohorts.each{ |month|
    students.each{ |student|
      if student[:cohort] == month
        puts "#{student[:name]} (#{student[:cohort]} cohort)".center(50)
      end
    }
  }
end

def show_footer(students)
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
      break if @cohorts.include?(cohort)
      if cohort == ""
        cohort = @default_cohort
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
show_header
show(students)
show_footer(students)
