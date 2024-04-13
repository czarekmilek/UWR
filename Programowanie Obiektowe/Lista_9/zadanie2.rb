class Function2D
  def initialize(&block)
    @function = block
  end

  def value(x, y)
    @function.call(x, y)
  end

  def volume(a, b, c, d, step=0.01)
    volume = 0.0
    x = a
    while x < b
      y = c
      while y < d
        volume += value(x, y) * step * step
        y += step
      end
      x += step
    end
    volume
  end

  def contour_line(a, b, c, d, height, step=1)
    result = []
    x = a
    while x <= b
      y = c
      while y <= d
        if (value(x, y) - height).abs < step
          result << "(#{x}, #{y})"
        end
        y += step
      end
      x += step
    end
    result
  end
end


f = Function2D.new { |x, y| x + y}

# wartość funkcji w punkcie (1, 2)
puts "Wartość funkcji w punkcie (1, 2): "
puts f.value(1, 2)

# przybliżona objętość między wykresem funkcji a prostokątem [0, 2] x [0, 3]
puts "Przybliżona objętość między wykresem funkcji a prostokątem [0, 2] x [0, 3]: "
puts f.volume(0, 2, 0, 3)

# lista punktów na poziomie 0 w prostokącie [-1, -1] x [2, 2]
puts "Lista punktów na poziomie 0 w prostokącie [-1, -1] x [2, 2]: "
puts f.contour_line(-1, 2, -1, 2, 0)

# lista punktów na poziomie 3 w prostokącie [-2, -2] x [4, 6]
puts "Lista punktów na poziomie 3 w prostokącie [-2, -2] x [4, 6]: "
puts f.contour_line(-2, 4, -2, 6, 3)
