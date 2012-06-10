module Shuffler
  class Worker
    def initialize(objects, method)
      @objects = objects
      @debt_map = {}

      @objects.each do |obj|
        @debt_map[obj] = {
          debt: obj.send(method.to_sym),
          adjustments: []
        }
      end
    end

    def shuffle
      first_pass
      second_pass
      @debt_map
    end

    private

    def first_pass
      return if !another_pass_required?
      @debt_map.each_pair do |obj, data|
        if data[:debt] < 0
          if (available_obj = first_greater(data[:debt].abs))
            transfer(available_obj, obj, data[:debt].abs)
          end
        end
      end
    end

    def second_pass
      return if !another_pass_required?
      @debt_map.each_pair do |obj, data|
        if data[:debt] < 0 && data[:debt].abs < total_positive
          @debt_map.each_pair do |inner_obj, inner_data|
            break if data[:debt] == 0
            if inner_data[:debt] > 0
              transfer(inner_obj, obj, [data[:debt].abs, inner_data[:debt].abs].min)
            end
          end
        end
      end
    end

    def total_positive
      debt_array.inject(0) {|sum, value| sum += (value > 0 ? value : 0) }
    end

    def first_greater(debt)
      @debt_map.each_pair do |obj, data|
        if data[:debt] >= debt
          return obj
        end
      end
      nil
    end

    def transfer(from, to, amount)
      @debt_map[from][:debt] -= amount
      @debt_map[from][:adjustments].push({
        from: to,
        amount: amount
      })
      @debt_map[to][:adjustments].push({
        to: from,
        amount: amount
      })
      @debt_map[to][:debt] += amount
    end

    def another_pass_required?
      debt_array.min < 0
    end

    def debt_array
      debt = @debt_map.map {|obj, data| data[:debt]}
    end
  end
end