# Checks the relation between the max of Sum of Square Digits, e. g. 100,
# the max value for 3 digits is 9^2 + 9^2 + 9^2 = 27^2 = 243 which is bigger than 100 (3 digit number)
# hence we can have a possible value that is equal to the sum of the square of its digits.
# The contra prove will be for 1000 which will be 37^2 = 324 is way smaller than the digits,
# hence there is no way for any value from the sum of the square of it digits gets even close to the
# actual value. So I can bypass manually instead of doing this, but well...
def CheckSuitableValues(max):
    maxToCompute = 0
    while max >= 0:
        numDigits = CheckMaxPossibleValuesDueToNumberOfDigits(max)
        maxToCompute = 9*9*numDigits
        # above is equivalent as below
        #v = [9] * numDigits
        #for a in v: maxToCompute += a*a

        if maxToCompute > max:
            break
        max = max / 10

    return maxToCompute


def CheckMaxPossibleValuesDueToNumberOfDigits(max):
    if max <= 0: return 0
    return CheckMaxPossibleValuesDueToNumberOfDigits(int(max / 10)) + 1


def SquareAndSumRecursive(v):
    if v <= 0:
        return 0

    cDigit = v % 10
    return cDigit * cDigit + SquareAndSumRecursive(int(v / 10))


def SquareAndSum(i):
    sumOfSqrs = 0

    while i > 0:
        cDigit = i % 10
        sumOfSqrs += cDigit * cDigit
        i /= 10

    return sumOfSqrs


res = []
max = 10000
suitable = CheckSuitableValues(max)
for x in range(suitable):
    r = SquareAndSumRecursive(x)
    print("Value: " + str(x))
    print("Sum of squared digits: " + str(r))
    if r == x:
        res.append(r)

print("Values that equal themselves after summing the square of their digits are: ")
print(res)
