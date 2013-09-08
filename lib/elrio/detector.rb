module Elrio
  class Detector
    def detect(array)
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

      return [0, 0] if runs.count == 1

      longest_run_length = runs.max

      return [array.count, 0] if longest_run_length == 1

      longest_run_index = runs.index(longest_run_length)

      run_start = runs[0, longest_run_index].reduce(:+)
      run_end = run_start + longest_run_length

      [
        run_start,
        array.count - run_end
      ]
    end
  end
end
