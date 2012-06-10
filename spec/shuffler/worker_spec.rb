class Person
  attr_accessor :debt
  def initialize(debt)
    self.debt = debt
  end
end

p = []
5.times do |index|
  p.push(Person.new(rand(100) * (index % 2 == 0 ? 1 : -1) ))
end

ap p