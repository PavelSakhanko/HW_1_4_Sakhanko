//
//  CaseIterable+ordinal.swift
//  HW_1_4_Sakhanko
//
//  Created by Pavel Sakhanko on 25.04.21.
//

import Foundation

public extension CaseIterable where Self: Equatable {
    func ordinal() -> Self.AllCases.Index {
        Self.allCases.firstIndex(of: self)!
    }
}
