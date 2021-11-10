/*
 * 2021 Aidan Haley
 */

import Foundation

struct Environment {
    let apiURL = "https://api.thecatapi.com/v1/images/search"
    let apiKey = "0309707b-5cb9-4845-9ad5-b9215649d27a"
    
    //Add other filtering requirements here
    let parameters = [
        "order": "Random",
        "mime_types": "gif",
        "limit": "50"
    ]
}

struct Post: Codable, Identifiable {
    let id: String
    let url: String
    let height: Double
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
            if let data = data {
                do {
                    completion(try JSONDecoder().decode([Post].self, from: data))
                } catch {
                    print("Error parsing data: \(error)")
                }
            
            }
            
        }.resume()
    }
}
