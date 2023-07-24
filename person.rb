class Person
  attr_reader :id, :name, :age

  def initialize(name = "unknown", age = nil, parent_permission = true)
    @id = generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def name=(new_name)
    @name = new_name
  end

  def age=(new_age)
    @age = new_age
  end

  def can_use_services? 
    of_age? || @parent_permission
  end

  private

  def of_age?
    return true if @age >= 18
    false
  end

  def generate_id
    return Random.rand(1000..9999)
end
