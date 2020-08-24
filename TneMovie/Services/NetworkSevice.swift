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
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3/movie/popular"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: String(page))
        ]
        guard let url = urlComponents.url else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
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
        }.resume()
    }
    
}
