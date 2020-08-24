//
//  Movie.swift
//  TneMovie
//
//  Created by skarev on 24.08.2020.
//  Copyright © 2020 skarev. All rights reserved.
//

import Foundation

struct Page: Codable {
    let page: Int
    let totalPages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
       case page
       case totalPages = "total_pages"
       case results
   }
}

struct Movie: Codable {
    let title: String
    let posterPath: String
    
    enum CodingKeys: String, CodingKey{
        case title
        case posterPath = "poster_path"
    }
}
