//
//  ViewController.swift
//  Photo Search
//
//  Created by ADMIN on 17/4/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var results: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        myCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        myCollectionView.collectionViewLayout = layout
        myCollectionView.dataSource = self
        searchBar.delegate = self
        myCollectionView.backgroundColor = .systemBackground
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { // default searchbar delefate function
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            results = [] // before search results array should be empty
            myCollectionView.reloadData()
            fetchPhoto(text) // for every seach, fethphoto is called
        }
    }
    
    
    func fetchPhoto(_ query: String) {
        let urlString =
        "https://api.unsplash.com/search/photos?page=30&query=\(query)&client_id=YRtnAmFdt80Jmcj-ZNIEBSkT8u4F9gwUMgJOpfhEXuY"
        
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
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = results[indexPath.row].urls.regular // image url
        print(imageURLString)
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        cell.configure(imageURLString)
        //cell.backgroundColor = .red
        return cell
    }
    
    
}

