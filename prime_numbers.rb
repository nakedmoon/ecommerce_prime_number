class PrimeNumbers

  @invalid_value = lambda {|v| !v.is_a?(Integer) || v <= 0}

  def self.list(starting_value, ending_value)
    # By definition, prime numbers must be integers and greater than 1.
    raise InvalidValueError, 'Invalid Input Value(s)' if [starting_value, ending_value].any?(&@invalid_value)
    min_value, max_value = [starting_value, ending_value].sort
    current_value = min_value
    prime_numbers = []
    while (current_value <= max_value)
      # i found a prime number
      prime_numbers << current_value if self.is_prime(current_value)
      # increment the main counter
      current_value+=1
    end
    prime_numbers
  end

  class InvalidValueError < StandardError

  end



  def self.is_prime(value, optimize = true)
    raise InvalidValueError, 'Invalid Input Value' if @invalid_value.call(value)
    actual_value = value
    actual_divisor = 2
    is_a_prime_number = true
    # It is unnecessary to check for factors until you reach actual_value-1
    # since the largest divisor must be no greater than half the number itself (actual_value/2).
    # I eliminate roughly half the number of loop iterations needed to determine if the number is a prime,
    # because the loop terminates at half the number rather than continuing until the actual number (minus one)
    # In this way we can have a significant reduction i terms of execution time when the number being tested is large
    # For benchmarking i can switch to the actual_value-1 version, setting optimize to false
    actual_value_max = optimize == true ? actual_value/2 : actual_value-1
    while(actual_divisor<=actual_value_max)
      is_a_prime_number = false if (actual_value % actual_divisor == 0)
      actual_divisor += 1
    end
    return is_a_prime_number
  end



end


# PrimeNumbers.list(-1,10) => PrimeNumbers::InvalidValueError: Invalid Input Value(s)
# PrimeNumbers.list(0,10) => PrimeNumbers::InvalidValueError: Invalid Input Value(s)
# PrimeNumbers.list(1,10) => [1, 2, 3, 5, 7]
# PrimeNumbers.list(10,1) => [1, 2, 3, 5, 7]
# PrimeNumbers.is_prime(11) => true


# require 'benchmark'

# puts Benchmark.measure { PrimeNumbers.is_prime(100000000) }
# 3.560000   0.000000   3.560000 (  3.628278)
# puts Benchmark.measure { PrimeNumbers.is_prime(100000000,false) }
# 7.140000   0.010000   7.150000 (  7.244712)


require 'rspec'

describe PrimeNumbers do
  it "raise InvalidValueError if list arguments aren't integers" do
    expect {PrimeNumbers.list(nil,10)}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value(s)')
    expect {PrimeNumbers.list(nil,10.1)}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value(s)')
    expect {PrimeNumbers.list(12.1,10.1)}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value(s)')
    expect {PrimeNumbers.list(10,nil)}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value(s)')
    expect {PrimeNumbers.list(nil,nil)}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value(s)')
    expect {PrimeNumbers.list(10,'nil')}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value(s)')
    expect {PrimeNumbers.list('10','nil')}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value(s)')
  end

  it "raise InvalidValueError if list arguments aren't >0" do
    expect {PrimeNumbers.list(-1,10)}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value(s)')
    expect {PrimeNumbers.list(1,-1)}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value(s)')
    expect {PrimeNumbers.list(-22,-33)}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value(s)')
  end

  it "raise InvalidValueError if is_prime argument is not integer" do
    expect {PrimeNumbers.is_prime(nil)}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value')
    expect {PrimeNumbers.is_prime('nil')}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value')
    expect {PrimeNumbers.is_prime('')}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value')
    expect {PrimeNumbers.is_prime(1.34)}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value')
  end

  it "raise InvalidValueError if is_prime argument is <=0" do
    expect {PrimeNumbers.is_prime(-1)}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value')
    expect {PrimeNumbers.is_prime(0)}.to raise_error(PrimeNumbers::InvalidValueError, 'Invalid Input Value')
  end


  it "checking is_prime with valid argument" do
    expect(PrimeNumbers.is_prime(11)).to eq(true)
    expect(PrimeNumbers.is_prime(10)).to eq(false)
  end

  it "checking list with valid arguments" do
    expect(PrimeNumbers.list(7900,7920)).to eq([7901,7907,7919])
    expect(PrimeNumbers.list(1,10)).to eq([1, 2, 3, 5, 7])
  end

  it "checking list against reverse interval, same but reverse intervals should return the same list" do
    output_list = PrimeNumbers.list(1,10)
    expect(PrimeNumbers.list(10,1)).to eq(output_list)
  end

end


#rspec prime_numbers.rb

# Finished in 0.0167 seconds (files took 0.14664 seconds to load)
# 7 examples, 0 failures




