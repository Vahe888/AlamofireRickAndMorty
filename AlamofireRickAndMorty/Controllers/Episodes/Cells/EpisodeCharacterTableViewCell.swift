//
//  EpisodeCharacterTableViewCell.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 26.09.22.
//

import UIKit

class EpisodeCharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    static let identifier = "EpisodeCharacterTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with character: ResultsCharacter, in indexPath: IndexPath) {
        guard let imageString = character.image, let url = URL(string: imageString), let name = character.name else {
            return
        }
        DispatchQueue.main.async {
            self.pictureImageView.sd_setImage(with: url)
            self.characterNameLabel.text = name
        }
    }
}
