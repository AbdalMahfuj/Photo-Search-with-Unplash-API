//
//  ViewController.swift
//  Photo Search
//
//  Created by ADMIN on 17/4/23.
//

import UIKit

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

class ViewController: UIViewController {
    
    let urlString =
    "https://api.unsplash.com/search/photos?page=1&query=office&client_id=YRtnAmFdt80Jmcj-ZNIEBSkT8u4F9gwUMgJOpfhEXuY"
    
    var results: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhoto()
    }
    

    func fetchPhoto() {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data=data, error == nil else {
                return
            }
            
            do {
                let jsonResults = try JSONDecoder().decode(APIResponse.self, from: data)
                self?.results = jsonResults.results
            }
            catch {
                print(error)
            }
            print("task ok")
        }
        
        task.resume()
    }

}

