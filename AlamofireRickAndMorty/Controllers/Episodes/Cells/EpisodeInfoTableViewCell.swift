//
//  EpisodeInfoTableViewCell.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 26.09.22.
//

import UIKit

class EpisodeInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var infoNameLabel: UILabel!
    @IBOutlet weak var infoDetailLabel: UILabel!
    
    static let identifier = "EpisodeInfoTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with episode: ResultsEpisode, in indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.pictureImageView?.image = (indexPath.row == 0) ? UIImage(systemName: "sparkles.tv") : UIImage(systemName: "calendar")
            self.infoNameLabel.text = (indexPath.row == 0) ? "Episode" : "Air Date"
            self.infoDetailLabel.text = (indexPath.row == 0) ? episode.episode : episode.air_date
        }
    }
}
