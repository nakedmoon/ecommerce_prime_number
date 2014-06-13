Prime Number Generator Coding Challenge (Ecommerce)
======================

Prime Number Generator Coding Exercise

Overview:
Your task is to use test driven development to implement a prime number generator that returns an ordered list of all prime numbers in a given range (inclusive of the endpoints). You must implement the interface specified below. You may also create any other methods, interfaces and/or classes that you deem necessary to complete the project. You should also develop a small main program to drive your generator and to allow the user to specify the prime number range via the command line. To successfully complete the exercise, all unit tests must pass as well as provide 100% code coverage.
* Notes:
  * The code should handle inverse ranges such that 1-10 and 10-1 are equivalent.
  * Ensure that you run a test against the range 7900 and 7920 (valid primes are 7901, 7907, 7919).

Interface:
```cc
Interface PrimeNumberGenerator {
  List<Integer> generate(int startingValue, int endingValue);
  boolean isPrime(int value); 
  }
```
