module Elrio
  class CapInsetDetector
    def detect_cap_insets(array)
      prev = array.first
      runs = [1]

      (1...array.count).each do |i|
        if array[i] == prev
          runs[-1] += 1
        else
          runs << 1
        end

        prev = array[i]
      end

      longest_run_length = runs.max

      return [array.count, 0] if longest_run_length == 1

      longest_run_index = runs.index(longest_run_length)

      if longest_run_index > 0
        run_start = runs[0, longest_run_index].reduce(:+)
      else
        run_start = 0
      end

      run_end = run_start + longest_run_length

      [
        run_start,
        array.count - run_end
      ]
    end
  end
end
