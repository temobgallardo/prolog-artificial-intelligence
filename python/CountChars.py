chars = list(set('La rabia es commo el picante. Una pizca te despierta, pero en exceso te adormece'))
print (chars)

check_string = "La rabia es commo el picante. Una pizca te despierta, pero en exceso te adormece"

for myChar in chars:
  count = check_string.count(myChar)
  if count >= 1:
    print (myChar, count)