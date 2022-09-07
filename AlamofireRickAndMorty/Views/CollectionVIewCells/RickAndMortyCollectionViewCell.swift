//
//  RickAndMortyCollectionViewCell.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 04.09.22.
//

import UIKit
import SDWebImage

class RickAndMortyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RickAndMortyCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = (Constants.itemWidth - 4) / 2
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor.label.cgColor
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(statusLabel)
        
        backgroundColor = .systemBackground
        
        // Image View Constraints
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        // Name Label Constraints
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12).isActive = true
        
        // Alive Label Constraints
        statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12).isActive = true
    }
    
    public func configure(with model: Character) {
        guard let name = model.name,
              let status = model.status,
              let imageURL = model.image,
              let url = URL(string: imageURL) else {
            return
        }
        self.nameLabel.text = name
        self.statusLabel.text = status.rawValue
        self.setColor(for: status)
        self.imageView.sd_setImage(with: url, completed: nil)
    }
    
    private func setColor(for status: Status?) {
        if let status = status {
            switch status {
            case .Alive:
                self.statusLabel.textColor = .systemGreen
            case .Dead:
                self.statusLabel.textColor = .systemRed
            case .unknown:
                self.statusLabel.textColor = .label
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 5, height: 8)
        self.layer.shadowColor = UIColor.label.cgColor
        self.clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
