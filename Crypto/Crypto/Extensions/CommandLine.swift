//
//  CommandLine.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 11/09/2021.
//

import Foundation

enum CommandLineArgument: String {
    case uiTestMockAuthentication = "Use mocked authentication service to log into app"
}

extension CommandLine {
    static func hasUITestMockAuthenticationArgument() -> Bool {
        self.arguments.contains(CommandLineArgument.uiTestMockAuthentication.rawValue)
    }
}
