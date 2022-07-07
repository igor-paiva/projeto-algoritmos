class HeapItem
  attr_reader :id, :data
  attr_accessor :priority

  def initialize(id, priority, data = {})
    @id = id
    @data = {}
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
  attr_reader :num, :list, :type, :els_hash

  def initialize(type: :min)
    @num = 0
    @list = []
    @type = type
    @els_hash = {} # { ID: index in @list }
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
    @els_hash[id] = @num + 1

    @list[@num += 1] = HeapItem.new(id, priority)

    fix_up(@num)
  end

  def remove
    swap_items(1, @num)

    fix_down(1)

    item = @list[@num]

    @els_hash.delete(@list[@num].id)

    @num -= 1

    return item
  end

  def change_priority(id, new_priority)
    idx = els_hash[id]

    current_priority = list[idx].priority

    return if current_priority == new_priority

    list[idx].priority = new_priority

    return fix_up(idx) if cmp_priorities(current_priority, new_priority)

    fix_down(idx)
  end

  def get_item(id)
    list[els_hash[id]]
  end

  private

  def cmp(idx_a, idx_b)
    cmp_priorities(@list[idx_a].priority, @list[idx_b].priority)
  end

  def cmp_priorities(priority_a, priority_b)
    return priority_a < priority_b if @type == :max

    priority_a > priority_b
  end

  def swap_items(idx_a, idx_b)
    swap_items_in_hash(idx_a, idx_b)

    tmp = @list[idx_a]

    @list[idx_a] = @list[idx_b]

    @list[idx_b] = tmp
  end

  def swap_items_in_hash(idx_a, idx_b)
    @els_hash[@list[idx_a].id] = idx_b

    @els_hash[@list[idx_b].id] = idx_a
  end
end
