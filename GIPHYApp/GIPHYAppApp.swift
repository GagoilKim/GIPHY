//
//  GIPHYAppApp.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import SwiftUI

@main
struct GIPHYAppApp: App {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UITabBar.appearance().barTintColor = UIColor.black
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
