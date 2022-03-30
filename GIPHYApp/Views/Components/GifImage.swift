//
//  GifImage.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import Foundation
import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    
    let urlAddress : String
    
    func makeUIView(context: Context) ->  WKWebView {
        let webView = WKWebView()
        if let url = URL(string: urlAddress) {
            webView.load(URLRequest(url: url))
        }
        webView.contentMode = .scaleAspectFit
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
