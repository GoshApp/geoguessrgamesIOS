//
//  Service.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 16.12.2022.
//

import Foundation

class Service: NSObject {
    static let shared = Service()
    
    func fetchCourses(completion: @escaping ([Course]?, Error?) -> ()) {
        let urlString = "https://goshapp777.online/1234.txt"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch courses:", err)
                return
            }
            
            // check response
            
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    completion(courses, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
}
