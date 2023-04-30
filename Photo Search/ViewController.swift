//
//  ViewController.swift
//  Photo Search
//
//  Created by ADMIN on 17/4/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var results: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2) // uiscreen
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        myCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        myCollectionView.collectionViewLayout = layout
        myCollectionView.dataSource = self
        searchBar.delegate = self       // searchBar delegate
        myCollectionView.backgroundColor = .systemBackground
    }
    
    
    
    
}

extension ViewController : UICollectionViewDataSource {
    
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


extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            results = []
            myCollectionView.reloadData()
            fetchPhoto(with: text)
        }
    }
    
}


extension ViewController { // API stuffs
    
    private func fetchPhoto(with query: String) {
        let urlString =
            "https://api.unsplash.com/search/photos?page=1&per_page=30&query=\(query)&client_id=YRtnAmFdt80Jmcj-ZNIEBSkT8u4F9gwUMgJOpfhEXuY"
        
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
                DispatchQueue.main.async {
                    self?.myCollectionView.reloadData()
                    print(self!.results.count)
                }
            }
            catch {
                print(error)
            }
            print("task ok")
        }
        
        task.resume()
    }
}
