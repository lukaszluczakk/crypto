//
//  HapticManager.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 31/07/2021.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
