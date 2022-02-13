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
            HomeView()
                .tabItem{
                    Text("HOME")
                }
            SearchView()
                .tabItem{
                    Text("Search")
                }
            MyPageView()
                .tabItem{
                    Text("MyPage")
                }
            
            
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
