//
//  LocationInfoTableViewCell.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 25.09.22.
//

import UIKit

class LocationInfoTableViewCell: UITableViewCell {
    
    static let identifier = "LocationInfoTableViewCell"
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var infoNameLabel: UILabel!
    @IBOutlet weak var infoDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with location: ResultsLocation, in indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.pictureImageView?.image = (indexPath.row == 0) ? UIImage(systemName: "globe") : UIImage(systemName: "star.fill")
            self.infoNameLabel.text = (indexPath.row == 0) ? "Type" : "Dimention"
            self.infoDetailLabel.text = (indexPath.row == 0) ? location.type : location.dimension
        }

    }
}
