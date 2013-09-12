require_relative 'app'

def assert(expected, actual, message)
  puts "Expected: #{expected.to_s.ljust(14)} Got: #{actual.to_s.ljust(14)}--#{message}"
end

my_cohort = Cohort.find(1)

my_student = Student.find(500)

assert("Alpha", my_cohort[:name], "Checking for proper DB setup.")
assert("Solon", my_student[:first_name], "Should have a valid first_name")

my_cohort[:name] = "Fireflies!"
my_cohort.save

assert("Fireflies!", Cohort.find(1)[:name], "Name should be changed")

my_student[:first_name] = "Lorenzo"
my_student.save

assert("Lorenzo", Student.find(500)[:first_name], "first_name should be changed.")

assert("2002", Student.all.length, "Expecting the length to be same")

# Student.create({cohort_id: 1, first_name: "Mario", last_name: "Lopez", email: "mario@themaxx.biz", gender: "m", birthdate: "1984-07-31"})
# assert("mario@themaxx.biz", Student.where("email = ?", "mario@themaxx.biz").first[:email], "Hope these are the same!") 


# Cohort.create({name: "Lobsters"})
# assert("Lobsters", Cohort.where("name = ?", "Lobsters").first[:name], "Should have a new cohort here!")

# my_student.cohort = Cohort.where("name = ?", "Theta").first

assert("Theta", my_student.cohort[:name], "Lorenzo is in the right cohort!")

my_student.cohort = my_cohort

assert("Fireflies!", my_student.cohort[:name], "Changed Lorenzo to the Fireflies cohort")

assert("238", my_cohort.students.length, "Check # students in the Fireflies! cohort")

Cohort.where("name = ?", "Theta").first.add_students([my_student])

assert("Theta", my_student.cohort[:name], "Moved Lorenzo back ot the Theta cohort")

assert("237", my_cohort.students.length, "Check # students in the Fireflies! cohort now")



assert("Lorenzo", my_student.first_name, "access method meta programming works!")
assert("Reichel", my_student.last_name, "access method meta programming works!")

assert("Fireflies!", my_cohort.name, "access method meta programming works!")

my_student.first_name = "Solon"
assert("Solon", my_student.first_name, "writer method meta programming works!")

my_cohort.name = "Alpha"
assert("Alpha", my_cohort.name, "writer method meta programming works!")

assert("Alpha", Cohort.find(1)[:name], "writer method updates db, too")

