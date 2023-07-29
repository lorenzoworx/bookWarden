require_relative 'book'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'

class App
  def initialize
    @people = []
    @books = []
  end

  def list_books
    puts 'List of Books: '
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    @people.each do |person|
      puts "[#{people.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_student(name, age, parent_permission)
    @people.push(Student.new(age: age, name: name, parent_permission: parent_permission))
  end

  def create_teacher(name, age, specialization)
    @people.push(Teacher.new(name: name, age: age, specialization: specialization))
  end

  def create_book
    puts 'Tile: '
    title = gets.chomp

    puts 'Author: '
    author = gets.chomp

    @books.push(Book.new(title, author))
  end

  def validate_id(id, collection_name, collection)
    while id.negative? || id >= collection.length
      puts "Invalid #{collection_name} ID. Please select a valid #{collection_name} from the list."
      id = gets.chomp.to_i
    end
    id
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: {book.title}, Author: #{book.author}"
    end

    book_index = gets.chomp.to_i
    book_index = validate_id(book_index, 'book', @books)

    puts 'Select a person from the following list by number(not ID)'
    @people.each_with_index do |person, index|
      puts "#{index}) Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end

    person_index = gets.chomp.to_i
    person_index = validate_id(person_index, 'person', @people)

    puts 'Date: '
    date = gets.chomp

    Rental.new(@books[book_index], @people[person_index], date)
  end

  def list_person_rentals
    @people.each do |person|
      next unless person.id == person_id

      (
            puts 'Rentals: '
            person.rentals.each do |rental|
              puts "Date: #{rental.date}, #{rental.book.title} by #{rental.book.author}"
            end
          )
    end
  end

  def create_person
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
end
