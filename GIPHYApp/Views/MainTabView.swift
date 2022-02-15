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
        .accentColor(Color.black)
        .navigationViewStyle(.stack)
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
