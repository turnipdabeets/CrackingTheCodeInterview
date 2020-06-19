//: [Previous](@previous)

import Foundation

//: ### In the news post-apocalyptic world, the world queen is desperately concerned about the birth rate. Therefore, she decrees that all families should ensure that they have one girl else they face massive fines. If all families abide by this policy - that is, they continue to have childen until they have one girl, at which point they immediately stop - what will the gender ratio of the new generation be? Assume that the odds of someone having a boy or a girl on any given pregnancy is equal. Solve this out logically and then write a computer simulation of it.

// .5 birth probability of having a boy
// or
// .5 birth probability of having a girl

// have a girl, stop
// have a boy, have a girl, stop
// not all will have boys but all will have a girl so should be more than 50%

// probability of family to have a boy and a girl .5 x .5 = .25
// probability of family to have at least one girl = 1   (this is required)
// probability of family to have more than one girl = 0  (must stop after one)
// probability of family to have only boys = 0

// probability of a family to have one girl .5
// probability of a family to have one boy and one girl = .25
// probability of a family to have two boys and one girl = .5^3 = .125

// number of boys probability equaltion is .5^(num of boys + 1)

// This policy seems to favor girls. Intuition might suggest we'll have possibly 75% or more girls than boys if we consider probability of boys to girls  1 - .25 (family with boys)  = .75 (family with girls) but this logic is incorrect. We need to get the average number of boys.

// What if we made a string of G and B for each birth. The probabiliyt of the next character added to the string is still 50% B or G. 

/*:
 sequence | number of boys | probability | expected value of the number of boys
 G          0       *           1/2     =   0
 BG         1       *           1/4     =   1/4     or (32/128)
 BBG        2       *           1/8     =   2/8     or (32/128)
 BBBG       3       *           1/16    =   3/16    or (24/128)
 BBBBG      4       *           1/32    =   4/32    or (16/128)
 BBBBBG     5       *           1/64    =   5/64    or (10/128)
 BBBBBBG    6       *           1/128   =   6/128   or (6/128)
 
 common denominator for all is 128
    
    32+32+24+16+10+6          120
 -----------------------  = -------   This is close to 1!
          128                 128
 
 Families that potentially have more than one boy offset families with only one girl
 So the ratio is still 50% girls and 50% boys. Biology hasn't changed, only the conditions under which a family stops have kids changed.
**/

func randomFamily() -> (boys: Int, girls: Int) {
    var boys = 0
    var girls = 0
    
    while girls == 0 {
        if Bool.random() {
            girls += 1
        }else {
            boys += 1
        }
    }
    return (boys: boys, girls: girls)
}

func randomNFamilies(_ numberOfFamilies: Int) -> Double {
    var boys = 0
    var girls = 0
    
    for _ in 0..<numberOfFamilies {
        let result = randomFamily()
        boys += result.boys
        girls += result.girls
    }
    
    return Double(girls) / Double(girls + boys)
}

let ratioOfGirls = randomNFamilies(5000)

//: [Next](@next)
