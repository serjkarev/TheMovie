//
//  NetworkSevice.swift
//  TneMovie
//
//  Created by skarev on 24.08.2020.
//  Copyright © 2020 skarev. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getPopularMovies(page: Int, completion: @escaping (Result<Page?, Error>) -> Void)
}

class NetworkSevice: NetworkServiceProtocol {
    private let apiKey: String = "831eb7625ee6ccfe26505e0935870afa"
    private let apiBaseURL: String = "https://api.themoviedb.org/3"
    
    func getPopularMovies(page: Int, completion: @escaping (Result<Page?, Error>) -> Void) {
        let popularURL: String = "/movie/popular"
        guard let url = URL(string: apiBaseURL + popularURL) else { return }
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "api_key" : apiKey,
            "language" : "en-US",
            "page" : String(page)
        ]
        let urlSession = URLSession(configuration: config)
        print(url)
        let myQuery = urlSession.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let obj = try JSONDecoder().decode(Page.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }
        myQuery.resume()
    }
}
