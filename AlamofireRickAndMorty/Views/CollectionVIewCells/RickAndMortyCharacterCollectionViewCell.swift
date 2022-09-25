//
//  RickAndMortyCharacterCollectionViewCell.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 21.09.22.
//

import UIKit

class RickAndMortyCharacterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RickAndMortyCharacterCollectionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    // MARK: - Configuration Function
    func configure(with viewModel: CharacterViewModel) {
        self.characterNameLabel.text = viewModel.name
        
        let url = URL(string: viewModel.image)
        self.characterImageView.sd_setImage(with: url)
    }
    
    // MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // MARK: Image View Configurations
        self.characterImageView.layer.borderWidth = 1
        self.characterImageView.layer.borderColor = UIColor.label.cgColor
        self.characterImageView.layer.cornerRadius = 75

        // MARK: Collection View Cell Configurations
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 30
    }
}
