class Function
  def initialize(proc)
    if proc.instance_of?(Proc)
      @procedure = proc
    else
      raise 'error'
    end
  end

  def value(x)
    return @procedure.call(x)
  end

  def zero(a, b, e)
    mid = (a+b)/2
    fa = value(a)
    fb = value(b)
    fmid = value(mid)
    if fa.abs < e
      return fa
    elsif fb.abs < e
      return fb
    elsif fmid.abs < e
      return mid
    elsif fa*fmid < 0
      return zero(a, mid, e)
    elsif fmid*fb < 0
      return zero(mid, b, e)
    else
      return nil
    end
  end

  def field(a, b)
    n = 100
    interval = (b-a).to_f/n
    result = 0
    result += value(a)/2
    result += value(b)/2
    for i in (1...n) do
      result += value(a + i * interval)
    end
    return interval*result
  end

  def deriv(x)
    delta = 0.000000001
    return (value(x + delta) - value(x)) / delta
  end
end


f1 = Function.new(proc {|x| x.abs})
puts ""
print "Funkcja F(x) = |x|:\n"
print "F(-1) = ", f1.value(-1), "\n"
print "F(0) = ", f1.value(0), "\n"
print "Msc. zerowe na przedziale [-13, 13] (z dokladnoscia e = 0.001): x0 = ", f1.zero(-13, 13, 0.001), "\n"
print "Pole pod wykresem na przedziale [0, 7]: ", f1.field(0, 7), "\n"
print "F(3) =  ", f1.value(3), "\n"
print "F'(3) = ", f1.deriv(3), "\n"

f2 = Function.new(proc {|x| (x**2)})
puts ""
print "Funkcja F(x) = x^2:\n"
print "F(-1) = ", f2.value(-1), "\n"
print "F(0) = ", f2.value(0), "\n"
print "Msc. zerowe na przedziale [-13, 13] (z dokladnoscia e = 0.001): x0 = ", f2.zero(-13, 13, 0.001), "\n"
print "Pole pod wykresem na przedziale [0, 7]: ", f2.field(0, 7), "\n"
print "F(3) =  ", f2.value(3), "\n"
print "F'(3) = ", f2.deriv(3), "\n"

f3 = Function.new(proc {|x| Math.sin(x)})
puts ""
print "Funkcja F(x) = sin(x):\n"
print "F(-1) = ", f3.value(-1), "\n"
print "F(0) = ", f3.value(0), "\n"
print "Msc. zerowe na przedziale [-13, 13] (z dokladnoscia e = 0.001): x0 = ", f3.zero(-13, 13, 0.001), "\n"
print "Pole pod wykresem na przedziale [0, 7]: ", f3.field(0, 7), "\n"
print "F(1) =  ", f3.value(1), "\n"
print "F'(1) = ", f3.deriv(1), "\n"

f4 = Function.new(proc {|x| (x + 7)})
puts ""
print "Funkcja F(x) = x+7:\n"
print "F(-1) = ", f4.value(-1), "\n"
print "F(0) = ", f4.value(0), "\n"
print "Msc. zerowe na przedziale [-13, 13] (z dokladnoscia e = 0.001): x0 = ", f4.zero(-13, 13, 0.001), "\n"
print "Pole pod wykresem na przedziale [0, 7]: ", f4.field(0, 7), "\n"
print "F(3) =  ", f4.value(3), "\n"
print "F'(3) = ", f4.deriv(3), "\n"