require 'shuffler'
describe Shuffler::DebtShuffler do

  before do
    class Person
      attr_accessor :debt
      def initialize(debt)
        self.debt = debt
      end
    end
  end

  it "no change when all positives" do
    p1 = Person.new(20)
    p2 = Person.new(10)
    p3 = Person.new(10)
    output = Shuffler.shuffle([p1, p2, p3], :debt)

    [p1, p2, p3].each do |person|
      output[person][:owed].should == person.debt
    end
  end

  it "shuffles when some negatives" do
    p1 = Person.new(100)
    p2 = Person.new(-70)
    p3 = Person.new(-20)
    output = Shuffler.shuffle([p1, p2, p3], :debt)

    [p1, p2, p3].each_with_index do |person, index|
      output[person][:owed].should == [10, 0, 0][index]
    end
  end

  it "spreads negative across multiple positives" do
    p1 = Person.new(5)
    p2 = Person.new(10)
    p3 = Person.new(15)
    p4 = Person.new(20)
    p5 = Person.new(-50)
    output = Shuffler.shuffle([p1, p2, p3, p4, p5], :debt)
    [p1, p2, p3].each_with_index do |person, index|
      output[person][:owed].should == 0
    end
  end

  it "no change when all negatives or zero" do
    p1 = Person.new(0)
    p2 = Person.new(-70)
    p3 = Person.new(-20)
    p4 = Person.new(0)
    output = Shuffler.shuffle([p1, p2, p3, p4], :debt)

    [p1, p2, p3].each_with_index do |person, index|
      output[person][:owed].should == person.debt
    end
  end
end