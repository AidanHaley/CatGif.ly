/*
 * 2021 Aidan Haley
 */

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel: FeedViewModel
    
    @State var showSplash = true
    @State var showFeed = false
    
    init(viewModel: FeedViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            
            Color("Primary").ignoresSafeArea()
            
            //MARK: - Splash
            
            SplashOverlay()
                .opacity(showSplash ? 1 : 0)
                .onAppear(perform: {
                    //Fade out view after animation finished
                    DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
                        withAnimation {
                            showSplash.toggle()
                            showFeed.toggle()
                        }
                    })
                })
            
            //MARK: - Feed
            
            VStack {
                Text("CatGif.ly")
                
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        ForEach(viewModel.posts) { post in
                            //TO:DO - Resize webView content to remove whitespace
                            GifImageView(path: post.url, type: .http)
                                .cornerRadius(8)
                                .frame( height: CGFloat(post.height))
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .opacity(showFeed ? 1 : 0)
            .onAppear(perform: viewModel.getPosts)
            
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
