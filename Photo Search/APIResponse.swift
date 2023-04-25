//
//  APIResponse.swift
//  Photo Search
//
//  Created by ADMIN on 25/4/23.
//

import Foundation

struct APIResponse: Codable {
    let total : Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let full: String
}
