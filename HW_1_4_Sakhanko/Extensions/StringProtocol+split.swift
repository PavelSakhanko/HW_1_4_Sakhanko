//
//  StringProtocol+words.swift
//  HW_1_4_Sakhanko
//
//  Created by Pavel Sakhanko on 25.04.21.
//

import Foundation

extension StringProtocol {
    var words: [SubSequence] {
        split(whereSeparator: \.isLetter.usePrefixNotEqual)
    }
}

extension Bool {
    var usePrefixNotEqual: Bool { !self }
}
