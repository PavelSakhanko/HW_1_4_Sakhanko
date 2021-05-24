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
      HStack {
          TextField("Enter Search Text", text: $suffixViewModel.searchText)
              .padding(.horizontal, 40)
              .frame(width: UIScreen.main.bounds.width - 110, height: 45, alignment: .leading)
              .background(Color(UIColor(named: "searchFieldBG")!))
              .clipped()
              .cornerRadius(10)
              .overlay(
                  HStack {
                      Image(systemName: "magnifyingglass")
                          .foregroundColor(Color(UIColor(named: "cancelText")!))
                          .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                          .padding(.leading, 16)
                  }
              )
              .autocapitalization(.none)
          Spacer()
              Button(action: {
                  self.suffixViewModel.searchText = ""
                  self.hideKeyboard()
              }) {
                  Text("Cancel")
                    .foregroundColor(Color(UIColor(named: "cancelText")!))
              }
              .padding(.trailing, 10)
              .transition(.move(edge: .trailing))
              .animation(.default)
       }.padding()
        .padding(.top, 30)

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
