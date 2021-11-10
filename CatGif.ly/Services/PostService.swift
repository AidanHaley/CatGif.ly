/*
 * 2021 Aidan Haley
 */

import Foundation
import UIKit

struct Environment {
    let apiURL = "https://api.thecatapi.com/v1/images/search"
    let apiKey = "0309707b-5cb9-4845-9ad5-b9215649d27a"
    
    //Add other headers here
    let parameters = [
        "order": "Random",
        "mime_types": "gif",
        "limit": "50"
    ]
    
    //Add othe filters here
    let filters = [
        "hats"
    ]
}

struct Post: Codable, Identifiable {
    let categories: [Category]?
    let id: String
    let url: String
    let height: Double

    struct Category: Codable {
        let id: Int
        let name: String
    }
}

protocol Service {
    func getPosts(completion: @escaping([Post]) -> Void)
}

class PostService: Service {
    func getPosts(completion: @escaping([Post]) -> Void) {
        //Construct URL
        var urlComponents = URLComponents(string: Environment().apiURL)!
        urlComponents.queryItems = Environment().parameters.map({ (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: String(value))
        })
        
        //Create Request
        var request = URLRequest(url: urlComponents.url!)
        request.setValue("x-api-key", forHTTPHeaderField: Environment().apiKey)
                        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            var posts: [Post]
            if let data = data {
                do {
                    posts = try JSONDecoder().decode([Post].self, from: data)
                    completion(self.filterPosts(posts: posts, filters: Environment().filters))
                } catch {
                    print("Error parsing data: \(error)")
                }
            }
        }.resume()
    }
    
    func filterPosts(posts: [Post], filters: [String]) -> [Post] {
        return posts.filter { post -> Bool in
            //Check if post contains categories
            guard let categories = post.categories else {
                return true
            }
            
            //Check these against pre-set filters
            for filter in filters {
                if categories.contains(where: { $0.name == filter}) {
                    //Filter out post
                    return false
                } else {
                    //Otherwise do not
                    return true
                }
            }
            
            return false
        }
    }
}
