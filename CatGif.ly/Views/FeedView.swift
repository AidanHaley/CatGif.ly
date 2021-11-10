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
            
            List(viewModel.posts) { post in
                Text(post.text)
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
