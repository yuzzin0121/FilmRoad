//
//  TVWebView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/23/24.
//

import SwiftUI
import WebKit

struct TVWebView: UIViewRepresentable {
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        guard let urlString, let url = URL(string: urlString) else {
            return WKWebView()
        }
        let webView = WKWebView()
        webView.backgroundColor = .black
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    // 뷰가 달라져야 할 때
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<TVWebView>) {
        guard let urlString, let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

