module Shuffler
  class Transfers < Array
    def amount_transferred(object)
      amount_deducted = 0
      amount_added = 0
      each do |transfer|
        amount_deducted += transfer[:amount] if transfer[:from] == object
        amount_added += transfer[:amount] if transfer[:to] == object
      end
      amount_added - amount_deducted
    end
  end
end