//
//  PortfolioView.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 29/07/2021.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        LazyHStack (spacing: 10) {
                            ForEach(vm.allCoins) { coin in
                                CoinLogoView(coin: coin)
                                    .frame(width: 75)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                            }
                        }.padding(.horizontal, 4)
                        .padding(.leading)
                    })
                }
            }
            .navigationTitle("Edit portfolio ")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            })
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}
