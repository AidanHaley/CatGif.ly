/*
 * 2021 Aidan Haley
 */

import Foundation

struct Post: Identifiable {
    let id: Int
    let text: String
}

protocol Service {
    func getPosts(completion: @escaping([Post]) -> Void)
}

class PostService: Service {
    func getPosts(completion: @escaping([Post]) -> Void) {
        DispatchQueue.main.async {
            completion([
                Post(id: 1, text: "Post 1"),
                Post(id: 2, text: "Post 2"),
                Post(id: 3, text: "Post 3")
            ])
        }
    }
}
