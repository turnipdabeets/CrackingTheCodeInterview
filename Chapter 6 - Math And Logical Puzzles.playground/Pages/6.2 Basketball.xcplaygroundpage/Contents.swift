//: [Previous](@previous)

import Foundation

//: ### You have a basketball hoop and someone says that you can play one of two games. If p is the probability of making a particular shot, for which values of p should you pick one game or the other?

//: Game 1:
//: - You get one shot to  make the hoop.

//: Game 2:
//: - You get three shots and you have to make two of the three shots.

//: game one has a probability to make one shot, say that shot is 50%
//: game two has a probability of maing exactly 2 of 3 shots.

//: The probability of making exaclty 2 shots is the probability of
//: - (win, win, lose) + (win, lose, win) + (lose, win, win) + (win, win, win)

// Probability of winning Game 1 is p
// Probability of winning Game 2 is
// [LWW]: (1 - p) * p * p +
// [WLW]: p * (1 - p) * p +
// [WWL]: p * p * (1 - p) +
// [WWW]: p * p * p
// = 3p^2 - 3p^3 + p^3
// = 3p^2 - 2p^3

// Pick Game 1 when p > 3p^2 - 2p^3
// Pick Game 2 when p < 3p^2 - 2p^3

// 2p^3 - 3p^2 + p

// p(2p^2 - 3p + 1)

// p(2p - 1)(p - 1)

// intersections are p = 0, p = 0.5, p = 1

// test p and 3p^2 - 2p^3 at p = 0, 0.25. 0.5, 0.75, and 1



//: [Next](@next)
