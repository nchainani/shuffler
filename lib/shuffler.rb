require "shuffler/version"

module Shuffler
  require 'shuffler/worker'
  # Your code goes here...
  
  def self.shuffle(objects, method = :debt)
    Shuffler::Worker.new(objects, method).shuffle
  end
end
