//
//  StatistictModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 27/07/2021.
//

import Foundation

class StatistictModel : Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}