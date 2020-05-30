//: [Previous](@previous)

import Foundation

//: ### Explain what the following code does: ((n & (n-1)) == 0)


/*
 
 n - 1 :
    subtracting from 1 followed by all zeros will turn into all 1s
        10000 -> 1111
    but subtracting 1 from anything else will decrese the least significant bit and we may have to borrow from zeros
        10100 -> 10011
    n - 1 will always be 1 less than n
 
 n & ... = 0
    AND requires both n's to have 1s in the same position
    =0 means that both n and n - 1 never have a 1 bit in the same position
 
 At first I thought this would prove if a number is Even, but if n and n-1 must have no 1s in common then this means n should be 1 followed by 0s, or a power of 2
 
 n  :  10000
 n-1:  01111
 
 n  :   1000
 n-1:   0111
 
 n  :   0100
 n-1:   0011
 
 n  :   0010
 n-1:   0001
 
 */

//: [Next](@next)
