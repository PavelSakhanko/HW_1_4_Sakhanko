//
//  MainView.swift
//  HW_1_4_Sakhanko
//
//  Created by Pavel Sakhanko on 28.03.21.
//

import SwiftUI

enum PickerMenu: String, CaseIterable {
    case allAsc = "ASC"
    case allDesc = "DESC"
    case threeDigit = "3-digit"
    case fiveDigit = "5-digit"
}

struct MainView: View {

    @ObservedObject var suffixViewModel: SuffixViewModel = .init()
    @State private var selection = 0

    var body: some View {
        VStack {
            Picker("", selection: $selection, content: {
                ForEach(PickerMenu.allCases, id: \.self) {
                    Text($0.rawValue).tag($0.ordinal())
                }
            }).pickerStyle(SegmentedPickerStyle())

            routeTo(selection)
        }
    }

    func routeTo(_ selection: Int) -> SuffixListView {

        var array = [Suffix]()

        switch selection {
        case 0:
            array = suffixViewModel.allSuffixArrayAsc
        case 1:
            array = suffixViewModel.allSuffixArrayDesc
        case 2:
            array = suffixViewModel.top3SuffixArray
        case 3:
            array = suffixViewModel.top5SuffixArray
        default:
            array = [Suffix]()
        }
        
        return SuffixListView(suffixArray: array)
    }
}
