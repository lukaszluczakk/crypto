//
//  SettingsView.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 04/08/2021.
//

import SwiftUI

struct SettingsView: View {
    let defaultURL = URL(string: "https://www.gogole.com")!
    let youtubeURL = URL(string: "https://youtube.com/c/swiftfulthinking")!
    let coffeURL = URL(string: "https://buymeacoffe.com/nicksarno")!
    let coingeckoURL = URL(string: "https://coingecko.com")!
    let personalURL = URL(string: "https://coingecko.com")!
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                List {
                    Section(header: Text("Swiftful Thinking")) {
                        VStack(alignment: .leading) {
                            Image("logo")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            Text("asdasd asdasd asdasdasda das dasda sdasdasdasdasdasd asdasd asdasdasdasdasd asd asdasdadadadsasda sdasdasdasdasd sdsd.")
                                .font(.callout)
                                .bold()
                                .foregroundColor(Color.theme.accent)
                        }
                    }
                    .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }
            
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
