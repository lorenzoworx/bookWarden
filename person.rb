class Person
  attr_reader :id
  attr_accessor :name, :age

  def initialize(name: 'unknown', age: nil, parent_permission: true)
    @id = generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def of_age?
    return true if @age >= 18
  end

  def generate_id
    Random.rand(1000..9999)
  end
end
