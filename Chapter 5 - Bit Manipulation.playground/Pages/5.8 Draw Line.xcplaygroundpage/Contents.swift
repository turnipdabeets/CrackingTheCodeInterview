//: [Previous](@previous)

import Foundation

//: ### A monochrome screen is stored as a single array of bytes, allowing either consecutive pixels to be stored in one byte. The screen has width W where W is divisible by 8 (that is, no byte will be split across rows). The height of the screen, of course, can be derived from the length of the array and the width. Implement a function that draws a horizontal line from (x1, y) to (x2,y). The method signature should look something like:

//: - drawLine(byte[] screen, int width, int x1, int x2, int y)


//0xF in hex is 15 in decimal is 1111 in binary
//assume position 4 + 1
//(1 << (position + 1)) - 1 will give use 100000 then -1 becomes 11111
// move this over x1 amount 1111100
// assuming screen[y] is cleared out then we join with OR

func drawLine(_ screen: inout [Int], width: Int, x1: Int, x2: Int, y: Int) {
    let position = x2 - x1
    screen[y] |= ((1 << (position + 1)) - 1) << x1
}

// Book solution
func drawLineBookVersion(_ screen: inout [Int], width: Int, x1: Int, x2: Int, y: Int) {
    let startOffset = x1 % 8
    var firstFullByte = x1 / 8
    if startOffset != 0 {
        firstFullByte += 1
    }
    let endOffset = x2 % 8
    var lastFullByte = x2 / 8
    
    if endOffset != 7 {
        lastFullByte -= 1
    }
    
    // Set full bytes
    if lastFullByte > firstFullByte {
        for i in firstFullByte..<lastFullByte {
            screen[(width / 8) * y + i] = 0xFF
        }
        print(screen)
    }
    
    let startMask = 0xFF >> startOffset
    let endMask = ~(0xFF >> (endOffset + 1))
    
    if (x1 / 8) == (x2 / 8) {
        let mask = startMask & endMask
        screen[(width / 8) * y + (x1 / 8)] |= mask
    }else {
        if startOffset != 0 {
            let byteNumber = (width / 8) * y + firstFullByte - 1
            screen[byteNumber] |= startMask
        }
        if endOffset != 7 {
            let byteNumber = (width / 8) * y + lastFullByte + 1
            screen[byteNumber] |= endMask
        }
    }
 
}

var screen = [0,0,0,0,0,0,0,0]

drawLine(&screen, width: 0, x1: 2, x2: 6, y: 3)
screen.forEach { num in print( String(UInt(exactly: num)!, radix: 2) ) }

print("___________")
var screenBookVersion = [0,0,0,0,0,0,0,0]
drawLineBookVersion(&screenBookVersion, width: 0, x1: 2, x2: 6, y: 3)
screenBookVersion.forEach { num in print( String(UInt(exactly: num)!, radix: 2) ) }

//: [Next](@next)
