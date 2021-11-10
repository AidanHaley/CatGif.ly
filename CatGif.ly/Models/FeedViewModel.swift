/*
 * 2021 Aidan Haley
 */

import Foundation

extension FeedView {
    final class FeedViewModel: ObservableObject {
        @Published var posts = [Post]()
        
        let postService: Service
        
        init(service: Service = PostService()) {
            self.postService = service
        }
        
        func getPosts() {
            postService.getPosts(completion: { [weak self] posts in
                self?.posts = posts
            })
        }
    }
}
