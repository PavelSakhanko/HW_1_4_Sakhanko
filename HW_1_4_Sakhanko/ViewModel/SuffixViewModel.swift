//
//  SuffixViewModel.swift
//  HW_1_4_Sakhanko
//
//  Created by Pavel Sakhanko on 25.04.21.
//

import Foundation

class SuffixViewModel: ObservableObject {
    
    struct Defaults {
        static let testText = "Control transfer statements change the order in which your code is executed, by transferring control from one piece of code to another. Swift has five control transfer statements."
    }
    
    @Published var allSuffixArrayAsc = [Suffix]()
    @Published var allSuffixArrayDesc = [Suffix]()
    @Published var top3SuffixArray = [Suffix]()
    @Published var top5SuffixArray = [Suffix]()
    
    @Published var stringSequenseArray = [String]()

    init() {
        assignSuffixArray()
    }

    fileprivate func assignSuffixArray() {
        splitSequence(sequence: Defaults.testText).forEach { sequence in
            allSuffixArrayAsc = suffixArray(sequence: sequence, baseSuffixArray: allSuffixArrayAsc)
                .sorted(by: { $0.title < $1.title })
        }

        allSuffixArrayDesc = allSuffixArrayAsc
            .sorted(by: { $0.title > $1.title })

        top3SuffixArray = Array(
            allSuffixArrayAsc
                .filter { $0.title.count == 3 }
                .sorted(by: { $0.count > $01.count })
                .prefix(10)
        )
        top5SuffixArray = Array(
            allSuffixArrayAsc
                .filter { $0.title.count == 5 }
                .sorted(by: { $0.count > $01.count })
                .prefix(10)
        )
    }

    fileprivate func splitSequence(sequence: String) -> [StringSequence] {
        sequence.words.map { StringSequence(sequence: String($0)) }
    }

    fileprivate func suffixArray(sequence: StringSequence, baseSuffixArray: [Suffix]) -> [Suffix] {
        var suffixArray = baseSuffixArray
        sequence.forEach { subString in
            let suffix = String(subString).lowercased()
            guard let element = suffixArray.first(where: { $0.title == suffix }) else {
                suffixArray.append(Suffix(title: suffix, count: 1))
                return
            }
            element.count += 1
        }
        return suffixArray
    }
}
