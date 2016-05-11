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
	else
		return user_input
	end
end
		

def main
	while true
		puts "\nWelcome to the Ruby Calculator"
		puts "Type 'quit' at anytime to quit"
		puts "Type 'clear' at anytime to start over"
		puts "\nEnter your first number"
		print ">"
		num1 = get_input
		confirm_float num1
		num1 = num1.to_f
		puts "Enter your operator"
		print ">"
		operator = get_input
		confirm_operator operator
		puts "Enter your second number"
		print ">"
		num2 = get_input
		confirm_float num2
		num2 = num2.to_f
		divide_by_zero?(operator,num2)
		puts "\nANSWER:", num1.method(operator).(num2), "\n"
	end
end

main

