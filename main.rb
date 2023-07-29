require_relative 'app'

def list_option
  puts ''
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - Exit'
end

def handle_selection(option, app)
  case option.to_i

  when 3
    create_person(app)

  when 4
    app.create_book

  when 5
    app.create_rental

  when 6
    puts 'ID of person: '
    id = gets.chomp.to_i
    app.list_rentals(id)

  when 7
    puts 'Thank you for using this app!'
    return false

  else
    puts 'Invalid input :('

  end
  true
end

def create_person(app)
  puts 'Do you want to create a student(1) or a teacher(2)? [Input the number]: '
  option = gets.chomp

  parent_permission = true

  puts 'age:'
  age = gets.chomp.to_i

  puts 'name: '
  name = gets.chomp

  puts 'Has parent permission? [Y/N]'
  permission_value = gets.chomp

  parent_permission = false if %w[N n NO no No].include?(permission_value)

  case option.to_i

  when 1
    app.create_student(name, age, parent_permission)

  when 2
    puts 'Specialization: '
    specialization = gets.chomp
    app.create_teacher(name, age, parent_permission, specialization)
  else
    puts 'Invalid input :( '
  end
end

def main
  status = true
  book_warden = App.new
  while status
    list_option
    option = gets.chomp.to_i
    if option == 1
      book_warden.list_books
    elsif option == 2
      book_warden.list_people
    else
      status = handle_selection(option, book_warden)
    end
  end
end

main
