import random
import numpy as np

class numeroIgualASumaCudradoDeDigitosEsto(object):
  previous_sum_squares = [9*9*4]
  rewards = []
  results = []

  def __init__(self, max) -> None:
    self.max = max

  # Checks the relation between the max of Sum of Square Digits, e. g. 100,
  # the max value for 3 digits is 9^2 + 9^2 + 9^2 = 27^2 = 243 which is bigger than 100 (3 digit number) 
  # hence we can have a possible value that is equal to the sum of the square of its digits.
  # The contra prove will be for 1000 which will be 37^2 = 324 is way smaller than the digits,
  # hence there is no way for any value from the sum of the square of it digits gets even close to the
  # actual value. So I can bypass manually instead of doing this, but well...
  def checkSuitableValues(self, max):
    maxToCompute = 0
    while max >= 0:
      numDigits = self.checkMaxPossibleValuesDueToNumberOfDigits(max)
      maxToCompute = 9*9*numDigits
      # above is equivalent as below
      #v = [9] * numDigits
      #for a in v: maxToCompute += a*a

      if maxToCompute > max: break
        
      max = max / 10

    return maxToCompute

  def checkMaxPossibleValuesDueToNumberOfDigits(self, max):
    if max <= 0: return 0
    return self.checkMaxPossibleValuesDueToNumberOfDigits(int(max / 10)) + 1

  def squareAndSumRecursive(self, v):
    if v <= 0: return 0
    
    cDigit = v % 10
    return cDigit * cDigit + self.squareAndSumRecursive(int(v / 10))

  def main(self):
    self.previous_sum_squares.append(0)
    
    suitable = self.checkSuitableValues(self.max)
    self.rewards = [0] * self.max
    x = random.randint(0, suitable)
    i = 0
    previous = suitable
    already_computed = np.zeros(suitable)
    while i < suitable + 1:
      if already_computed[x] > 0: 
        res = np.where(already_computed == 0)[0]
        if len(res) > 0:
          x = res[0]
        else: break

      result = self.squareAndSumRecursive(x)
      already_computed[x] += 1

      if result == x:
        self.previous_sum_squares.append(int(result)) 
        self.rewards[result] += 10
        continue

      # if previous is smaller then we try to compute the next value (it may get closer)
      # otherwise we continue to try previous
      if result <= previous:
        self.rewards[x] += 1
        previous = result;
        x += 1
      else:
        self.rewards[x] -= 1
        x -= 1
      
      i += 1

    print("Values that equal themselves after summing the square of their digits are: ")
    print(self.results)
  
    k = 0
    for r in self.rewards:
      if r > 0:
        k += 1
        print("Values that got closer: " + str(k) + " | reward level: " + str(r))

if __name__ == "__main__": 
  self = numeroIgualASumaCudradoDeDigitosEsto(10000)
  self.main()
