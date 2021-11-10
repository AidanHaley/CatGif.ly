/*
 * 2021 Aidan Haley
 */

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel: FeedViewModel
            
    init(viewModel: FeedViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        //Show splash on launch
      //  SplashOverlay()
        
        List(viewModel.posts) { post in
            Text(post.text)
        }
        .onAppear(perform: viewModel.getPosts)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {        
        FeedView()
    }
}
