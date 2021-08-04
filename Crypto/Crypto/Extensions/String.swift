//
//  String.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 04/08/2021.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^]+>", with: "", options: .regularExpression, range: nil)
    }
}
