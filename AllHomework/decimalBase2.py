def twoToDeci(myString):
    #first setting up the variables to count places and the running total
    counter = 2
    runningTotal = 0
    #creating a string without the first position for readablility
    newString = myString[1:]
    #iterate through the string to find when the digit is 1
    for i in range(0,len(newString)):
        if newString[i] == "1":
            #add the number -> divided by 2^ith place
            runningTotal = runningTotal + 1/(counter)
        counter = counter*2
    #return the total, always below 1
    return runningTotal

def deciToTwo(myNum, bitLen):
    #loop subt the 1/2^ith place bitLen number of times,
    #appending 1 to a string when possible
    #must be greater than 0
    myString = "."
    counter = 2
    useNum = myNum
    for i in range(0,bitLen):
        if useNum == 0:
            myString = myString + "0"
        elif useNum - 1/counter >= 0:
            myString = myString + "1"
            useNum = useNum - 1/counter
        else:
            myString = myString + "0"
        counter = counter*2
    #this all kinda came to me quick, so I didn't comment because I didn't want
    #to lose it, but I think what I did was pretty readable
    return myString
