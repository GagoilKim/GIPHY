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
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .black
        UITabBar.appearance().barTintColor = .white
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

