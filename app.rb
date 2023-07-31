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
    puts 'List of People: '
    @people.each do |person|
      puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_student(name, age, parent_permission)
    student = Student.new(name: name, age: age, parent_permission: parent_permission, classroom: nil)
    @people.push(student)
    puts 'Student successfully created'
  end

  def create_teacher(name, age, specialization)
    @people.push(Teacher.new(name: name, age: age, specialization: specialization))
    puts 'Teacher successfully created'
  end

  def create_book
    puts 'Tile: '
    title = gets.chomp

    puts 'Author: '
    author = gets.chomp

    @books.push(Book.new(title, author))
    puts 'Book successfully created'
  end

  def validate_id(id, collection_name, collection)
    if collection.empty?
      puts "The #{collection_name} collection is empty. Add some #{collecton_name}s."
      return nil
    end

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

  def person_option
    puts 'Do you want to create a student(1) or a teacher(2)? [Input the number]: '
    gets.chomp.to_i
  end

  def person_age
    puts 'Age:'
    gets.chomp.to_i
  end

  def person_name
    puts 'Name: '
    gets.chomp
  end

  def person_parent_permission
    puts 'Has parent permission? [Y/N]'
    %w[N n NO no No].include?(gets.chomp)
  end

  def create_person
    option = person_option
    name = person_name
    age = person_age
    parent_permission = !person_parent_permission

    puts "Option: #{option}, Name: #{name}, Age: #{age}, Parent Permission: #{parent_permission}"

    case option
    when 1
      create_student(name, age, parent_permission)
    when 2
      puts 'Specialization: '
      specialization = gets.chomp
      create_teacher(name, age, specialization)
    else
      puts 'Invalid input :( '
    end
  end
end
