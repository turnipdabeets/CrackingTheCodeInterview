//: [Previous](@previous)

import Foundation

//: ### Write a program to swap odd and even bits in an integer with as few instructions as possible. (e.g. bit 0 and bit 1 are swapped, bit 2 and bit 3 are swapped, and so on)

// https://stackoverflow.com/questions/28339126/is-this-just-a-coincidence-that-0xaaaaaaaa-represents-binary-with-even-positions
// Swift logical shift happens on Int for signed ints
// Swift arithmetic shift happens on UInt for unsigned ints
// Swift uses signed integers unless you specify otherwise, so we need to use UInt here to get the logical shift

// 1010 in binary is 10 in decimal, which is also A in hex
// 8A's = 8 * 4 or 32bits -> 10101010101010101010101010101010

// 0101 in binary is 5 in decimal, which is also 5 in hex
// 85's = 8 * 4 or 32bits -> 01010101010101010101010101010101

func swapOddAndEven(_ num: UInt) -> UInt {
    // assumes 64 or 32 bit only
    let oddMask = num.bitWidth == 64
        ? 0xaaaaaaaaaaaaaaaa as UInt //64 bits of 1010
        : 0xaaaaaaaa as UInt //32 bits of 1010
    
    let evenMask = num.bitWidth == 64
        ? 0x5555555555555555 as UInt //64 bits of 0101
        : 0x55555555 as UInt //32 bits of 0101
    
    // use mask to get the 1s in even or odd positions
    // shift over 1s and then join them bakc together
    return ((num & oddMask) >> 1) | ((num & evenMask) << 1)
}

swapOddAndEven(0b11011110)
String(swapOddAndEven(0b11011110), radix: 2)

//let int: Int = 0
//let uint: UInt8 = 0
//
//String(0b0, radix: 2)
//String(~0b0, radix: 2)
//
//String(~int, radix: 2)
//String(~uint, radix: 2)
//String(Int(~uint), radix: 2)
//
//let a: Int = Int(~uint)
//let b: UInt8 = ~uint
//
//Int(~0b0 as UInt8)
//Int(~0b0 as Int)
//String(Int(~0b0 as UInt8), radix: 2)
//String(Int(~0b0 as Int), radix: 2)
//
//Int(~0b0 as UInt32)

//: [Next](@next)
