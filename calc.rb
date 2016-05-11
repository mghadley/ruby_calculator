puts "Welcome to the Ruby Calculator"
puts "Enter your first number"

def sum (num1, num2)
	num1 + num2
end

def divide (num1, num2)
	num1 / num2
end

def is_prime?(n)
	divisors = 0
	return false if n <= 1
	return true if n ==2
	(2..(n/2)).each do |x|
		if n %
end