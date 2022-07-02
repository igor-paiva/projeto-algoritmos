class HeapItem
  attr_reader :id, :priority

  def initialize(id, priority)
    @id = id
    @priority = priority
  end

  def ==(other_item)
    @id == other_item.id
  end

  def <(other_item)
    @priority < other_item.priority
  end

  def >(other_item)
    @priority > other_item.priority
  end

  def to_s
    "ID: #{id} - Priority #{priority}"
  end
end

class Heap
  attr_reader :num, :list, :type

  def initialize(type: :min)
    @num = 0
    @list = []
    @type = type
  end

  def empty?
    @num == 0
  end

  def fix_up(k)
    while k > 1 && cmp(k / 2, k)
      swap_items(k, k / 2)

      k /= 2
    end
  end

  def fix_down(k)
    while 2 * k <= @num - 1
      j = 2 * k

      j += 1 if j < @num - 1 && cmp(j, j + 1)

      break unless cmp(k, j)

      swap_items(k, j)

      k = j
    end
  end

  def insert(id, priority)
    @list[@num += 1] = HeapItem.new(id, priority)

    fix_up(@num)
  end

  def remove_max
    swap_items(1, @num)

    fix_down(1)

    item = @list[@num]

    @num -= 1

    return item
  end

  private

  def cmp(idx_a, idx_b)
    return @list[idx_a] < @list[idx_b] if @type == :max

    @list[idx_a] > @list[idx_b]
  end

  def swap_items(idx_a, idx_b)
    tmp = @list[idx_a]

    @list[idx_a] = @list[idx_b]

    @list[idx_b] = tmp
  end
end
