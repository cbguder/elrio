module Elrio
  class NGramGenerator
    include Enumerable

    def initialize(list, n = 1, offset = 0)
      @offset = offset
      @list = list
      @n = n
    end

    def each
      yield @list[0, @offset]

      i = @offset

      while i < @list.size
        yield @list[i, @n]
        i += @n
      end
    end
  end
end
