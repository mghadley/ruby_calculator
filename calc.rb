class String
  def is_i?
     !!(self =~ /\A[-+]?[0-9]+\z/)
  end

  def is_f?
    !!Float(self) rescue false
  end

  def is_operator?(str)
  	operators = ['+','/','*','**','%','-']
  	operators.include? str
  end
end

def confirm_float(str)
	unless str.is_f?
		puts "*******INCORRECT INPUT TYPE********"
		main
	end
end

def confirm_operator(str)
	unless str.is_operator? str 
		puts "\n*******INCORRECT INPUT TYPE********", "\n"
		main
	end
end

def divide_by_zero?(operator, num2)
	if operator == "/" && num2 == 0
		puts "\n********NO DIVIDING BY 0********", "\n"
		main
	end
end

def get_input
	user_input = gets.strip.downcase
	if user_input == 'clear' 
		main
	elsif user_input == 'quit'
		exit
	elsif user_input == 'trig'
		trig_menu
	elsif user_input == 'history'
		show_history
	else
		return user_input
	end
end

def to_array(phrase)
	phrase.gsub(/[(]/, "|(").gsub(/[)]/, ")|").split("|").reject{ |i| i.empty? }
end

def get_trig_input
	puts "Enter the number you would like to calcuate this for"
	user_input = get_input
	confirm_float user_input
	user_input.to_f
end

@history = {}

def show_history
	@history.each do |key, value|
		puts "#{key}: #{value}"
	end
	main
end

#OLD FUNCTION FOR NON-BONUS PART
# def main
# 	while true
# 		puts "Type 'quit' at anytime to quit"
# 		puts "Type 'clear' at anytime to start over"
# 		puts "\nEnter your first number"
# 		print ">"
# 		num1 = get_input
# 		confirm_float num1
# 		num1 = num1.to_f
# 		puts "Enter your operator"
# 		print ">"
# 		operator = get_input
# 		confirm_operator operator
# 		puts "Enter your second number"
# 		print ">"
# 		num2 = get_input
# 		confirm_float num2
# 		num2 = num2.to_f
# 		divide_by_zero?(operator,num2)
# 		puts "\nANSWER:", num1.method(operator).(num2), "\n"
# 	end
# end

def main
	while true
		puts "Type 'quit' at anytime to quit"
		puts "Type 'clear' at anytime to start over"
		puts "Type 'trig' if you want to do some trig"
		puts "\nEnter what you would like calculated, with spaces or without"
		print ">"
		phrase = get_input.gsub(/m/, "@memory")
		begin
			answer = eval(phrase)
		rescue Exception
			puts "YOU DID SOMETHING WRONG"
			puts "MAYBE A TYPO OR MAYBE YOU DIVIDED BY 0!!"
			main
		end
		@history[phrase] = answer
		puts answer
		puts "Would you like to store this answer in memory? (y/n)"
		memory_input = gets.strip.downcase
		@memory = answer if memory_input == "y"
	end
end

def trig_menu
	puts "Enter the number of the action you would like to perform"
	puts "1 SINE"
	puts "2 COSINE"
	puts "3 TANGENT"
	user_selection = gets.strip
	case user_selection
		when "1"
			method = "sin"
			user_input = get_trig_input
			answer = Math.sin(user_input)
		when "2"
			method = "cos"
			user_input = get_trig_input
			answer = Math.cos(user_input)
		when "3"
			method = "tan"
			user_input = get_trig_input
			answer = Math.tan(user_input)
		else
			puts "INVALID COMMAND"
	end
	@history["#{method}(#{user_input}"] = answer
	puts "\nANSWER:", answer
	puts "Would you like to store this answer in memory? (y/n)"
	memory_input = gets.strip.downcase
	if memory_input == "y"
		@memory = answer
		puts "Saved. Any previously stored value has been erased."
		puts "Access your saved answer by typing 'm' in future calculations" 
	end
	main
end

puts "\nWelcome to the Ruby Calculator"
main

