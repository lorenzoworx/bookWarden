require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(name: 'Unknown', age: nil, parent_permission: true, classroom: nil)
    super(name, age, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    @classroom.students.push(self) unless @classroom.students.include?(self)
  end
end
