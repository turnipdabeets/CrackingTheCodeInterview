//: [Previous](@previous)

import Foundation

//: ### A bunch of people are living on an island, when a visitor comes with a strange order: all blue-eyed people must leave the island as soon as possible. There will be a flight out at 8:00pm every evening. Each person can see everyone else's eye color, but they do not know their own (nor is anyone allowed to tell them). Additionally, they do not know how many people have blue eyes, although they do know that at least one person does. How many days will it take the blue-eyed people to leave?

/*:
 Assume 1 person,
 There has to be one person, if there is exactly one person they will see no one with blue eyes on the first night and assume they must be that 1 person.
 
 Assume 2 people,
  - the first night
        - non-blue eyed people see both so they stay assuming 2 or more
        - blue eyes see 1 assume 1 or more so they both stay
  - but after first night if no one leaves we now can assume there is 2 or more blue eyes people. On night two since they both only see 1 other blue eye they both leave together.
 
 Assume 3 people,
  - the first night
        - non-blue eyed people see 3 blue eyes and assume 3 or more so they stay
        - blue eyes see 2 so assume 2 or more and they stay
  - the second night
        - non-blue eyed people see 3 blue eyes and assume 3 or more so they stay
        - blue eyes see 2 so assume 2 or more and they stay becasue they might not be one of the two
  - the third night
        - non-blue eyed people see 3 blue eyes and assume 3 or more so they stay
        - blue eyes see 2 so assume they must be the third person and they all leave together
 
It will take N nights for all the blue-eyed people to realize they have blue eyes and then they will all leave together on the plane, assuming capacity of course.
 
**/



//: [Next](@next)
