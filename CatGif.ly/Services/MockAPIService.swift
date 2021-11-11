/*
 * 2021 Aidan Haley
 */

import Foundation

class MockAPIService: Service {
    func getPosts(completion: @escaping ([Post]) -> Void) {
        completion([
            Post(categories: nil, id: "1", url: "https://www.cats.com", height: 100),
            Post(categories: nil, id: "2", url: "https://www.cats.com", height: 200),
            Post(categories: nil, id: "3", url: "https://www.cats.com", height: 300)
        ])
    }
}
