module Elrio
  class PatternDetector
    def detect_pattern(array)
      max_n = array.size / 2
      longest_run = (0..0)
      longest_run_n = 1

      (1..max_n).each do |n|
        max_offset = [n-1, array.size - 2*n].min

        (0..max_offset).each do |offset|
          generator = NGramGenerator.new(array, n, offset)
          run = find_longest_run(generator)

          if run.size > [n, longest_run.size].max
            longest_run = run
            longest_run_n = n
          end
        end
      end

      if longest_run.size == 1
        start_cap = array.size
        end_cap = 0
      else
        start_cap = longest_run.first
        end_cap = array.count - longest_run.last - 1
      end

      Pattern.new(start_cap, end_cap, longest_run_n)
    end

    private

    def find_longest_run(generator)
      prev = nil
      runs = []

      generator.each do |ngram|
        if ngram == prev
          runs[-1] += ngram.size
        else
          runs << ngram.size
        end

        prev = ngram
      end

      longest_run_length = runs.max
      longest_run_index = runs.index(longest_run_length)

      if longest_run_index > 0
        run_start = runs[0, longest_run_index].reduce(:+)
      else
        run_start = 0
      end

      run_end = run_start + longest_run_length - 1

      (run_start..run_end)
    end
  end
end
