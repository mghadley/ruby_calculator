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

def get_input
	user_input = gets.strip.downcase
	if user_input == 'clear' 
		@memory = nil
		main
	elsif user_input == 'quit'
		exit
	elsif user_input == 'trig'
		trig_menu
	elsif user_input == 'history'
		show_history
	elsif user_input == 'show memory'
		if @memory == nil
			puts "\nMemory is empty", "\n"
		else
			puts "\n", @memory, "\n"
		end
		main
	else
		return user_input
	end
end

def get_trig_input
	puts "Enter the number you would like to calcuate this for"
	user_input = get_input.gsub(/m/, "#{@memory}")
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

def main
	while true
		puts "Type 'quit' at anytime to quit"
		puts "Type 'clear' at anytime to clear the memory"
		puts "Type 'show memory' to view what is currently in memory"
		puts "Type 'trig' if you want to do some trig"
		puts "Type 'history' if you want to view a history of your calculations"
		puts "\nEnter what you would like calculated, with spaces or without"
		puts "If you would like to use the value in memory, type an 'm' in place of that value below"
		print ">"
		phrase = get_input.gsub(/m/, "#{@memory}")
		begin
			answer = eval(phrase)
		rescue Exception
			puts "YOU DID SOMETHING WRONG"
			puts "MAYBE A TYPO OR MAYBE YOU DIVIDED BY 0!!"
			main
		end
		@history["#{phrase}"] = answer
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

