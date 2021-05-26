//
//  SuffixViewModel.swift
//  HW_1_4_Sakhanko
//
//  Created by Pavel Sakhanko on 25.04.21.
//

import Foundation
import Combine

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
    // Search
    @Published var debouncedText = ""
    @Published var searchText = ""
    @Published var bufSuffixArrayAsc = [Suffix]()
    // Feed
    @Published var feeds = [Suffix]()

    private var subscriptions = Set<AnyCancellable>()

    var defaults: UserDefaults? {
        UserDefaults(suiteName: Defaults.suiteName)
    }

    init() {
      setupTextSearching()
      synchronizeUserDefaults()
      assignSuffixArray()
      setupFeedText()
    }

    fileprivate func setupTextSearching() {
      $searchText
        .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
        .removeDuplicates()
        .map({ (string) -> String? in
            if string.count < 1 {
                self.allSuffixArrayAsc = self.bufSuffixArrayAsc
                return nil
            }

            return string
        })
        .compactMap{ $0 }
        .sink(receiveValue: { t in
            self.debouncedText = t
            self.allSuffixArrayAsc = self.allSuffixArrayAsc.filter { word in
              if word.title.count == 0 {
                return false
              } else {
                return word.title.contains(t)
              }
            }
        } )
        .store(in: &subscriptions)
    }

    fileprivate func synchronizeUserDefaults() {
      defaults?.synchronize()
    }

    var textArray: [String] {
      defaults?.array(forKey: "textArray") as? [String] ?? ["Test"]
    }

    fileprivate func setupSourceText() -> String {
      textArray[textArray.count - 1]
    }

    fileprivate func setupFeedText() {
      textArray.forEach { text in
        let suffix = Suffix(title: text, count: 0)
        feeds.append(suffix)
      }
    }

    fileprivate func assignSuffixArray() {
        splitSequence(sequence: setupSourceText()).forEach { sequence in
            allSuffixArrayAsc = suffixArray(sequence: sequence, baseSuffixArray: allSuffixArrayAsc)
                .sorted(by: { $0.title < $1.title })
            bufSuffixArrayAsc = allSuffixArrayAsc
        }

        allSuffixArrayDesc = bufSuffixArrayAsc
            .sorted(by: { $0.title > $1.title })

        top3SuffixArray = Array(
            bufSuffixArrayAsc
                .filter { $0.title.count == 3 }
                .prefix(10)
        )

        top5SuffixArray = Array(
            bufSuffixArrayAsc
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
