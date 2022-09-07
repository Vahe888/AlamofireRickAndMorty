//
//  DetailViewController.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 07.09.22.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = character?.name
        navigationController?.navigationBar.tintColor = .label

        configure(with: character)
    }

    private func configure(with model: Character?) {
        guard let model = model,
              let name = model.name,
              let imageURL = model.image,
              let url = URL(string: imageURL) else {
            return
        }
        
        DispatchQueue.main.async {
            self.nameLabel.text = name
            self.imageView.sd_setImage(with: url, completed: nil)
        }
    }
}
