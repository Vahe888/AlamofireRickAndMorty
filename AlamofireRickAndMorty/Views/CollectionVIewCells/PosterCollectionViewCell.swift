//
//  PosterCollectionViewCell.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 18.08.22.
//

import UIKit
import SDWebImage

class PosterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    static let identifier = "PosterCollectionViewCell"
    
    public func configure(with model: Character) {
        guard let imageURL = model.image,
                let url = URL(string: imageURL),
                let name = model.name else {
            return
        }
        
        DispatchQueue.main.async {
            self.nameLabel.text = name
            self.posterImageView.sd_setImage(with: url, completed: nil)
        }
    }
}
