//
//  ImageCollectionViewCell.swift
//  Photo Search
//
//  Created by ADMIN on 25/4/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configure(_ imageURL: String) {
        guard let url = URL(string: imageURL) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: {(data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            print(data)
            DispatchQueue.main.async { [self] in
                let uiimage = UIImage(data: data)
                self.myImage.image = uiimage
            }
        }).resume()
    }
}
