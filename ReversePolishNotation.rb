def reverse_polish_notation(math_expression)
  priority = { "(" => 0, "+" => 1, "-" => 1, "*" => 2, "/" => 2, "^" => 3 }
  brackets = %w|( )|

  output = Array.new
  operation_stack = Array.new

  math_expression.each do |s|
    if brackets.include?(s)
      if s == ")"
        unless operation_stack.index("(").nil?
          index = operation_stack.index("(")
          count = operation_stack.length - index - 1

          count.times { output.push(operation_stack.pop) }
          operation_stack.delete_at(index)
        end
      else
        operation_stack.push(s)
      end
    else
      if priority.key?(s)
        if !operation_stack.empty? and priority.dig(operation_stack.last) >= priority.dig(s)
          output.push(operation_stack.pop)
          operation_stack.push(s)
        else
          operation_stack.push(s)
        end
      else
        output.push(s)
      end
    end

    # puts "output #{output.to_s}"
    # puts "stack #{operation_stack.to_s}"
  end

  operation_stack.length.times { output.push(operation_stack.pop) }
  return output
end

def calculate(reverse_polish)
  stack = Array.new
  digits = /[0-9]/
  operands = /[+\-*\/]/

  reverse_polish.each do |el|
    if el.match(digits).nil?
      second_number = stack.pop
      first_number = stack.pop
      stack.push(eval("#{first_number}#{el}#{second_number}"))
    else
      stack.push(el)
    end
  end

  stack.pop
end

puts "Reverse Polish notation!"
puts "Enter symbols one by one."
math_expression = []

while true do
  user_input = ""

  while user_input.empty?
    user_input = STDIN.gets.chomp.downcase
  end

  if user_input == "x"
    puts "Math expression: #{math_expression.join}"
    notation = reverse_polish_notation(math_expression)
    puts "Reverse Polish notation: #{notation.join(",")}"
    # puts "Calculated value: #{calculate(notation)}"
    exit 0
  else
    math_expression << user_input
  end
end
