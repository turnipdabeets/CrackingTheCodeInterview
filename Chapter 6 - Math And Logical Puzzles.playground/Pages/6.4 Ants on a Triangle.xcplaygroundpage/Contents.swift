//: [Previous](@previous)

import Foundation

//: ### There are three ants on different vertices of a triangle. What is the probability of collision (between any two or all of them) if they start walking on the sides of the triangles? Assume that they walk at the same speed. Similarily, find the probability of collision with n ants on an n-vertex polygon.

// Assume an equilateral triangle then they wont collide if they are walking in the same direction and assume .5 probability for choosing one side. Then multiple each ants probability:

// In this case .5 x .5 x .5 with 3 vertices = probability of clockwise for all ants

// .5^number of vertices = probability of all three clockwise
// .5^number of vertices = probability of all three counterclockwise

// Either probability is addition
// add the above probability all clockwise + probability all counterclockwise
// (.5 x .5 x .5) + (.5 x .5 x .5) = .25 = probability of same direction


// The probability of collision is the probability of NOT moving in the same direction
// 1 - .25 = .75
// or : 1 - ((.5^n) + (.5^n))





//: [Next](@next)
