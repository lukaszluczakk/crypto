//
//  CommandLine.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 11/09/2021.
//

import Foundation

enum CommandLineArgument: String {
    case uiTest = "ui-test"
}

extension CommandLine {
    static func isTesting() -> Bool {
        self.arguments.contains(CommandLineArgument.uiTest.rawValue)
    }
}
