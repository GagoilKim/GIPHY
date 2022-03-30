//
//  TabView.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SearchView()
                .background(.black)
                .tabItem{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.gray)
                }
            MyPageView()
                .tabItem{
                    Image(systemName: "person")
                        .foregroundColor(Color.gray)
                }
        }
        .accentColor(.purple)
        .navigationViewStyle(.stack)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
