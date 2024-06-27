//
//  YTWebView.swift
//  MealDB-Fetch
//
//  Created by Burhanuddin Jinwala on 6/26/24.
//

import SwiftUI
import WebKit

struct YTWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
