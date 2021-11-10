/*
 * 2021 Aidan Haley
 */

import SwiftUI
import WebKit

struct GifImageView: UIViewRepresentable {
    
    enum GifType {
        case local
        case http
    }
    
    private let path: String
    private let type: GifType
    
    init(path: String, type: GifType) {
        self.path = path
        self.type = type
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        var url: URL
        var data: Data
        
        switch type {
        case .local:
            url = Bundle.main.url(forResource: path, withExtension: "gif")!
            data = try! Data(contentsOf: url)
            
        case .http:
            //TO:DO change to load url
            url = Bundle.main.url(forResource: path, withExtension: "gif")!
            data = try! Data(contentsOf: url)
        }
        
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.scrollView.isScrollEnabled = false
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
    
    
}

struct GifImageView_Previews: PreviewProvider {
    static var previews: some View {
        GifImageView(path: "splash", type: .local)
    }
}
