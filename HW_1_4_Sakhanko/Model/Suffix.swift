//
//  Suffix.swift
//  HW_1_4_Sakhanko
//
//  Created by Pavel Sakhanko on 25.04.21.
//

import Foundation

class Suffix: Identifiable {

    var id = UUID()
    var title: String
    var count: Int

    init(title: String, count: Int) {
        self.title = title
        self.count = count 
    }
}
