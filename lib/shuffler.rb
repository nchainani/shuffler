require "shuffler/version"

module Shuffler
  require 'shuffler/debt_shuffler'
  # Your code goes here...
  
  def self.shuffle(objects, method = :debt)
    Shuffler::DebtShuffler.new(objects, method).shuffle
  end
end
