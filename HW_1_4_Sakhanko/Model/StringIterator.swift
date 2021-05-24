//
//  StringIterator.swift
//  HW_1_4_Sakhanko
//
//  Created by Pavel Sakhanko on 25.04.21.
//

import Foundation

struct StringIterator {
    let sequence: String

    func makeIterator() -> StringIterator {
        StringIterator(sequence: sequence)
    }
}
