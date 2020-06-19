//: [Previous](@previous)

import Foundation

//: ### There is an 8x8 chessboard in which two diagonally opposite corners have been cut off. You are given 31 dominos, and a single domino can cover exactly two squares. Can you use the 31 dominos to cover the entire board? Prove your answer (by providing an example or showing why it's impossible).

// NO.

//  Even though (64 squares - 2) = 62 and (31 dominos X 2) = 62 it wont work because of the diagonal. If we cut off 2 diagonal opposite corners then the first and last row will only have 7 squares. This means one domino must always poke out into the next row. We'll be left with uneven number of squares next to each other.

//  By removing opposite corners we remove 2 of the same color square. For example we'll be left with 30 black and 32 white. Each domino takes up one white and one black. Therefore, 31 dominos need a total of 31 black and 31 white. However we are short on one of the colors. 

//: [Next](@next)
