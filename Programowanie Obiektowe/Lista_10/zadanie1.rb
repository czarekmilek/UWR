class Collection
  def initialize(elements)
    @elements = elements
  end

  def swap(i, j)
    @elements[i], @elements[j] = @elements[j], @elements[i]
  end

  def length
    @elements.length
  end

  def get(i)
    @elements[i]
  end
end

class Sorter
  def sort1(collection)
    n = collection.length
    for i in 0..n-2
      min_idx = i
      for j in i+1..n-1
        min_idx = j if collection.get(j) < collection.get(min_idx)
      end
      collection.swap(i, min_idx)
    end
    collection
  end

  def sort2(collection)
    n = collection.length
    gap = n
    swapped = true
    while gap > 1 || swapped
      gap = (gap / 1.3).to_i
      gap = 1 if gap < 1
      swapped = false
      for i in 0..n-gap-1
        if collection.get(i) > collection.get(i+gap)
          collection.swap(i, i+gap)
          swapped = true
        end
      end
    end
    collection
  end
end

# Przykład użycia

elements = [4, 2, 7, 1, 3]
collection = Collection.new(elements)

sorter = Sorter.new

sorted_collection1 = sorter.sort1(collection)
puts "Sort 1: #{sorted_collection1.get(0)}, #{sorted_collection1.get(1)}, #{sorted_collection1.get(2)}, #{sorted_collection1.get(3)}, #{sorted_collection1.get(4)}"

sorted_collection2 = sorter.sort2(collection)
puts "Sort 2: #{sorted_collection2.get(0)}, #{sorted_collection2.get(1)}, #{sorted_collection2.get(2)}, #{sorted_collection2.get(3)}, #{sorted_collection2.get(4)}"
