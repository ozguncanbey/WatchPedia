//
//  YouTubePlayerView.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 22.11.2024.
//


import SwiftUI
@preconcurrency import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = context.coordinator
        loadVideo(in: webView)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        loadVideo(in: uiView)
    }
    
    private func loadVideo(in webView: WKWebView) {
        guard let videoURL = URL(string: "https://www.youtube.com/embed/\(videoID)?playsinline=1") else { return }
        let request = URLRequest(url: videoURL)
        webView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }
    }
}

struct TrailerView: View {
    let videoKey: String
    
    var body: some View {
        YouTubePlayerView(videoID: videoKey)
            .frame(height: 200)
            .cornerRadius(12)
    }
}
