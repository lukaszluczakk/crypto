//
//  RegisterView.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/08/2021.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var vm: RegisterViewModel = RegisterViewModel()
    
    var body: some View {
        Text("Register view")
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
