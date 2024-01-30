//
//  Extensions.swift
//  QuizAppHarsh
//
//  Created by My Mac Mini on 30/01/24.
//

import Foundation
extension Array {
    /// Picks `n` random elements (partial Fisher-Yates shuffle approach)
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            let j = Int(arc4random_uniform(UInt32(i + 1)))
            if j != i {
                copy.swapAt(i, j)
            }
        }
        return Array(copy.suffix(n))
    }
}


