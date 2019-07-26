//
//  DataManager.swift
//  LG-Test
//
//  Copyright © 2019 Sanjeeva-Test. All rights reserved.
//

import Foundation

class DataManager {

    func getData(url: String, completion:@escaping (Data?, Error?) -> Void) {

        let urlRequest = URLRequest(url: URL(string: url)!)

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if (error != nil) {
                completion(nil, error)
            } else {
                completion(data, nil)
            }
        }.resume()
    }
}


