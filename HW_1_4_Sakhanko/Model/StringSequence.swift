//
//  StringSequence.swift
//  HW_1_4_Sakhanko
//
//  Created by Pavel Sakhanko on 25.04.21.
//

import Foundation

struct StringSequence: IteratorProtocol, Sequence {

    let sequence: String
    var offset: String.Index

    init(sequence: String) {
        self.sequence = sequence
        self.offset = sequence.endIndex
    }

    mutating func next() -> Substring? {
        guard offset > sequence.startIndex else { return nil }
        offset = sequence.index(before: offset)
        return sequence.suffix(from: offset)
    }
}
