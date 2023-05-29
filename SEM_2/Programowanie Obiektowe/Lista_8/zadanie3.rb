class ONPExpression

  def initialize(expression)
    @expression = expression
  end

  def oblicz(variables)
    stack = []

    @expression.each do |element|
      case element
      when /\A-?\d+\z/ # integers
        stack.push(element.to_i)
      when "+", "-", "*", "/"
        right_operand = stack.pop
        left_operand = stack.pop
        result = calculate(left_operand, right_operand, element)
        stack.push(result)
      else # variable
        if variables[element]
          stack.push(variables[element])
        else
          raise "Nieznana zmienna: #{element}"
        end
      end

      puts stack.join(" ")
    end

    stack.pop
  end

  private

  def calculate(left, right, operator)
    case operator
    when "+"
      left + right
    when "-"
      left - right
    when "*"
      left * right
    when "/"
      left / right
    end
  end
end

expression = ["2", "3", "*", "x", "+", "5", "-"]
variables = { "x" => 4 }
onp = ONPExpression.new(expression)
puts "Wynik: #{onp.oblicz(variables)}"