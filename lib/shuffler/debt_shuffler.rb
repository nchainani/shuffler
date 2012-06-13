module Shuffler
  # The aim of DebtShuffler is to make life easy for person A by shuffling debt
  # such that person A has minimal number of checks to collect. Person A will call
  # DebtShuffler and pass in the people he/she owes or has to collect money from.
  # eg.
  # Person 1 owes Person 2 => 30$
  # Person 3 owes Person 1 => 20$
  # Person 4 owes Person 1 => 10$
  # 
  # Person 1 will use debt shuffler to shuffle debts between Person 2, 3, 4.
  # The output will be
  # Person 1 owes 0$ to anyone.
  # Person 2 will get $20 from Person 3 and $10 from Person 4
  # 
  class DebtShuffler
    # Two parameters
    # 1) objects - Array - Each element in this array corresponds to an entity you owe money to or have to collect money from
    # 2) method - Symbol - The method to call on the entity to get the amount owed/ to collect. Owed amounts should be positive
    def initialize(objects, method)
      @objects = objects
      @debt_map = {}

      @objects.each do |obj|
        @debt_map[obj] = {
          owed: obj.send(method.to_sym),
          adjustments: []
        }
      end
    end

    # Response is a hash
    # {
    #   object_1 => {
    #     owed        => new_amount,
    #     adjustments => [
    #       # implies object_1 will have to collect $20 from object_2
    #       from   => object_2,
    #       amount => 20
    #     ] 
    #   }
    #   object_to => {
    #     owed        => new_amount,
    #     adjustments => [
    #     # # implies object_2 will have to collect $20 from object_1
    #       to   => object_1,
    #       amount => 20
    #     ] 
    #   }
    # }
    def shuffle
      first_pass
      second_pass
      @debt_map
    end

    private

    # First pass finds any direct matches i.e. debts that could be directly adjusted
    # by a single object
    def first_pass
      return if !another_pass_required?
      @debt_map.each_pair do |obj, data|
        if data[:owed] < 0
          if (available_obj = first_greater(data[:owed]))
            transfer(available_obj, obj, data[:owed])
          end
        end
      end
    end

    # Second pass is required only when the first pass doesn't satisfy all the requirements. It breaks
    # the debt across multiple objects.
    def second_pass
      return if !another_pass_required?
      @debt_map.each_pair do |obj, data|
        if data[:owed] < 0 && data[:owed].abs <= total_available
          @debt_map.each_pair do |inner_obj, inner_data|
            break if data[:owed] == 0
            if inner_data[:owed] > 0
              transfer(inner_obj, obj, [data[:owed].abs, inner_data[:owed]].min)
            end
          end
        end
      end
    end

    # Returns the total amount owed 
    def total_available
      debt_array.inject(0) {|sum, value| sum += (value > 0 ? value : 0) }
    end

    
    def first_greater(debt)
      debt = debt.abs
      @debt_map.each_pair do |obj, data|
        if data[:owed] >= debt
          return obj
        end
      end
      nil
    end

    # Transfer money from one object to another object. Updates there adjustment tables
    def transfer(from, to, amount)
      amount = amount.abs
      @debt_map[from][:owed] -= amount
      @debt_map[from][:adjustments].push({
        from: to,
        amount: amount
      })
      @debt_map[to][:adjustments].push({
        to: from,
        amount: amount
      })
      @debt_map[to][:owed] += amount
    end

    # Determines whether we need one more pass or whether we have adjusted it all
    def another_pass_required?
      debt_array.min < 0
    end

    # Returns the debts in an array
    def debt_array
      debt = @debt_map.map {|obj, data| data[:owed]}
    end
  end
end