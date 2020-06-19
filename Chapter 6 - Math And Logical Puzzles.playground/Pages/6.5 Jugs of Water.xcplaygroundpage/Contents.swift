//: [Previous](@previous)

import Foundation

//: ### You have a five-quart jug, a three-quart jug, and an unlimited supply of water (but no meausring cups). How would you come up with exactly four quarts of water? Note that the jugs are oddly shaped, such that filling up exactly "half" of the jug would be impossible.

/*:
 5 Quart | 3 Quart | Action
    0         3       fill 3 quart
    3         0       pour 3 into 5
    3         3       fill 3 quart again
    5         1       pour 3 into 5 with remaining 1 left in 3 quart
    0         1       empty 5 quart
    1         0       pour 1 into the 5 quart
    1         3       fill 3 quart  - DONE!
 
**/

// Book Solution
/*:
 5 Quart | 3 Quart | Action
    5         0       fill 5 quart
    2         3       pour 5 into 3 quart with 2 remaining in 5 quart
    2         0       empty 3 quart
    0         2       pour 2 into 3 quart
    5         2       fill 5 quart
    4         3       pour 1 into 3 quart (fill rest of 3 quart) from 5 quart
    4         0       empty 3 quart  - DONE!
 
**/


//: [Next](@next)
