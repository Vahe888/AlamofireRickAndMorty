//
//  DetailTableViewController.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 21.09.22.
//

import UIKit
import SDWebImage

class DetailCharacterTableViewController: UITableViewController {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var starusLabel: UILabel!
    @IBOutlet weak var specieLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    var character: ResultsCharacter?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = character?.name
        navigationController?.navigationBar.tintColor = .label
        configure(with: character)
    }
    
    private func configure(with model: ResultsCharacter?) {
        guard let model = model,
              let imageURL = model.image,
              let url = URL(string: imageURL),
              let status = model.status,
              let specie = model.species,
              let gender = model.gender
        else {
            return
        }
        
        DispatchQueue.main.async {
            self.pictureImageView.sd_setImage(with: url, completed: nil)
            self.starusLabel.text = status.rawValue
            self.specieLabel.text = specie
            self.genderLabel.text = gender.rawValue
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pictureImageView.layer.cornerRadius = 150
        pictureImageView.layer.shadowRadius = 5
        pictureImageView.layer.shadowOpacity = 0.6
        pictureImageView.layer.shadowOffset = CGSize(width: 5, height: 8)
        pictureImageView.layer.shadowColor = getShadowColor(from: character?.status)
        pictureImageView.clipsToBounds = false
    }
    
    private func getShadowColor(from status: Status?) -> CGColor {
        switch status {
        case .Alive:
            return UIColor.green.cgColor
        case .Dead:
            return UIColor.red.cgColor
        default:
            return UIColor.label.cgColor
        }
	}
}
