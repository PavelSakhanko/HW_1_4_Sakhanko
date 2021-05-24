//
//  SuffixViewModel.swift
//  HW_1_4_Sakhanko
//
//  Created by Pavel Sakhanko on 25.04.21.
//

import Foundation

class SuffixViewModel: ObservableObject {

    struct Defaults {
        static let suiteName = "group.Pavel-Sakhanko.HW_1_4_Sakhanko"
        static var testText = "Privacy is a fundamental human right. At Apple, it’s also one of our core values. Your devices are important to so many parts of your life. What you share from those experiences, and who you share it with, should be up to you. We design Apple products to protect your privacy and give you control over your information. It’s not always easy. But that’s the kind of innovation we believe in."
    }

    @Published var allSuffixArrayAsc = [Suffix]()
    @Published var allSuffixArrayDesc = [Suffix]()
    @Published var top3SuffixArray = [Suffix]()
    @Published var top5SuffixArray = [Suffix]()
    @Published var stringSequenseArray = [String]()

    var defaults: UserDefaults? {
        UserDefaults(suiteName: Defaults.suiteName)
    }

    init() {
      synchronizeUserDefaults()
      assignSuffixArray()
    }

    fileprivate func synchronizeUserDefaults() {
      defaults?.synchronize()
    }

    fileprivate func setupSourceText() -> String {
      let textFromWeb = defaults?.object(forKey: "text") ?? Defaults.testText
      return textFromWeb as! String
    }

    fileprivate func assignSuffixArray() {
        splitSequence(sequence: setupSourceText()).forEach { sequence in
            allSuffixArrayAsc = suffixArray(sequence: sequence, baseSuffixArray: allSuffixArrayAsc)
                .sorted(by: { $0.title < $1.title })
        }

        allSuffixArrayDesc = allSuffixArrayAsc
            .sorted(by: { $0.title > $1.title })

        top3SuffixArray = Array(
            allSuffixArrayAsc
                .filter { $0.title.count == 3 }
                .prefix(10)
        )

        top5SuffixArray = Array(
            allSuffixArrayAsc
                .filter { $0.title.count == 5 }
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
