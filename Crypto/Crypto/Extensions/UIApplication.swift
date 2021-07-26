//
//  UIApplication.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 26/07/2021.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
