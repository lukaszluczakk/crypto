//
//  CIrcleButtonAnimationView.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 19/07/2021.
//

import SwiftUI

struct CIrcleButtonAnimationView: View {
    @Binding var animate : Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0 )
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none)
    }
}

struct CIrcleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CIrcleButtonAnimationView(animate: .constant(false))
            .foregroundColor(Color.red)
            .frame(width: 100, height: 100)
    }
}
