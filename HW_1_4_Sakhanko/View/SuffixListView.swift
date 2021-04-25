//
//  SuffixListView.swift
//  HW_1_4_Sakhanko
//
//  Created by Pavel Sakhanko on 25.04.21.
//

import SwiftUI

struct SuffixListView: View {

    var suffixArray: [Suffix]

    var body: some View {
        List {
            ForEach(suffixArray) { suffix in
                HStack {
                    Text(suffix.title)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(suffix.count)")
                }
            }
        }
    }
}

