//
//  ViewController.swift
//  Photo Search
//
//  Created by ADMIN on 17/4/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let urlString =
    "https://api.unsplash.com/search/photos?page=30&query=office&client_id=YRtnAmFdt80Jmcj-ZNIEBSkT8u4F9gwUMgJOpfhEXuY"
    
    var results: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
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
                print(self!.results.count)
            }
            catch {
                print(error)
            }
            print("task ok")
        }
        
        task.resume()
    }

}

