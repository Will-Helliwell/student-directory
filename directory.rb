@cohorts = %w(january february march april may june july august september october november december)
@default_cohort = "november"
@students = Array.new

def show_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def show
  # create an array of existing cohorts
  existing_cohorts = Array.new
  @students.each { |student|
    if !existing_cohorts.include?(student[:cohort])
      existing_cohorts << student[:cohort]
    end
  }
  # print students from each cohort in order
  existing_cohorts.each{ |month|
    @students.each{ |student|
      if student[:cohort] == month
        puts "#{student[:name]} (#{student[:cohort]} cohort)".center(50)
      end
    }
  }
end

def show_footer
  puts "Overall, we have #{@students.count} great students".center(50)
end

def input_students
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
    @students << { name: name, cohort: cohort.to_sym}
    if @students.length == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
  end
end

input_students
show_header
show
show_footer
