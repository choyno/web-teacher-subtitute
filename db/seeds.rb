# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Maintenance Data

# ===================================
# START FOR SUBJECT
# ===================================
  subjects = [  { code: "RIZL1", name: "Life and Works of Rizal" }, 
                { code: "IT201", name: "Computer Programming 1: Programming Fundamentals" },
                { code: "ENGL1", name: "Study and Thinking Skills in English" }, 
                { code: "IT101", name: "IT Fundamentals" }
             ]

  subjects.each { |subject| Subject.create({ name: subject[:name], code: subject[:code] })  }


# ===================================
# START FOR TEACHER
# ===================================
  teachers = [ { first_name: 'Arlo Leo', last_name: 'Bolivar' },
               { first_name: 'Jofel', last_name: 'Lubino' }
             ]
  
  teachers.each { |teacher| Teacher.create({ first_name: teacher[:first_name], last_name: teacher[:last_name]  })  }


# ===================================
# START FOR DAYCODE
# ===================================
  day_codes = [  "MWF", "TTH" ]

  day_codes.each { |daycode| DayCode.create({ name: daycode  })  }


# ===================================
# START FOR REASON
# ===================================
  reasons = [ "Leave", "Absent", "Attending Meeting" ]
  
  reasons.eachd { |reason| Reason.create({ name: reason })  }
  
  
