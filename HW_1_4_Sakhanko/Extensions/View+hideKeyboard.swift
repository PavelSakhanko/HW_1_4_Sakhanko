//
//  View+hideKeyboard.swift
//  HW_1_4_Sakhanko
//
//  Created by Pavel Sakhanko on 24.05.21.
//

import UIKit
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
