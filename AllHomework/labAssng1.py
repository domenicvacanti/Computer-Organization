#Problem 1, creating a function to change binary numbers to base 10
def binConverter(myString):
    #First I will set up the variables I will use to keep track of place and the
    #sum of the numbers
    counter = 0
    runningTotal = 0
    #Then I will reverse the string so I can look through it in the order I want
    #by splicing the string backwards
    newString = myString[::-1]
    #iterate through the string checking for 1's, when I find one I will add the
    #value of 2^(counter) to the running total
    for i in range(0,len(newString)):
        if newString[counter] == "1":
            runningTotal = runningTotal + 2**(counter)
        counter += 1
    #return the total, and its working so I guess I didnt forget too much python
    return runningTotal


#Problem 2, base 10 plus bit length to signed binary
def baseToBin(num, bitLength):
    #Set a working number to not change the input
    workingNum = num
    #make the working number positive to easily work with subtracting
    if workingNum < 0:
        workingNum = workingNum * -1
    #set a string to be used for return
    myString = ""
    #add the polarity of the original number
    if num >= 0:
        myString += "+"
    else:
        myString += "-"
    #find the 2^(counter) of the most left bit
    counter = bitLength-1
    #then we will look and see if 2^(counter) can come out of the number, if yes
    #add 1, if no add 0 to the string
    #breaks when counter goes negative or when we run out of bits
    while counter >= 0:
        otherNum = 2**(counter)
        if workingNum-otherNum >= 0:
            myString += "1"
            #make sure to keep track of the correct working number
            workingNum = workingNum - otherNum
        else:
            myString += "0"
        #subtract 1 from the counter to move down the number
        counter = counter - 1
    #check to see if the working number made it to 0 in len(bitLength) iterations
    if workingNum != 0:
        return "Overflow Error"
    #if the program made it here it is ready to return the final string
    return myString


#Problem 3, base 2 signed to ones comp
def baseTwoToOne(myString):
    if (myString[0] == "-") and (myString[1] == "1"):
        return "Overflow Error"
    counter = 1
    newString = ""
    if myString[0] == "+":
        return(myString[1:])
    while counter < len(myString):
        if myString[counter] == "1":
            newString += "0"
        else:
            newString += "1"
        counter += 1
    return newString


#Problem 4, base 2 to twos comp
def baseTwoToTwo(myString):
    if myString[0] == "-":
        negative = True
    if negative:
        oneString = baseTwoToOne(myString)
        myNum = binConverter(oneString)
        myNum += 1
        twoString = baseToBin(myNum,len(myString))
        return twoString[2:]
    return myString[1:]
        
        
#Problem 5, ceiling function
def ceilMe(num):
    #Going to dec by one and add to another, if there is anything greater than 0
    #it should still inc the one last time
    secondNum = 0
    forMe = True
    while forMe:
        num -= 1
        secondNum += 1
        if num <= 0:
            forMe = False
    return secondNum


#problem 6, range
def rangeOfThese(num1,num2,num3):
    #This may be cheating but this is the only way I can think to make this work
    num4 = num1
    num5 = num2
    num6 = num3
    uhOh = True
    c = 0
    myString = ""
    while uhOh:
        num4 -= 1
        num5 -= 1
        num6 -= 1
        if num4 <= 0:
            c += 1
            myString += "1"
            num4 += 1000000
        if num5 <= 0:
            c += 1
            myString += "2"
            num5 += 1000000
        if num6 <= 0:
            c += 1
            myString += "3"
            num6 += 10000000
        if c == 3:
            uhOh = False
    if myString[2] == "1":
        firstNum = num1
    if myString[2] == "2":
        firstNum = num2
    if myString[2] == "3":
        firstNum = num3
    if myString[0] == "1":
        lastNum = num1
    if myString[0] == "2":
        lastNum = num2
    if myString[0] == "3":
        lastNum = num3
    return (firstNum - lastNum)
    









        
