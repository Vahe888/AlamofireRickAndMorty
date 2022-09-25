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
    @IBOutlet private weak var tableView: UITableView!
    var character: Character?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = character?.name
        navigationController?.navigationBar.tintColor = .label
        tableView.delegate = self
        tableView.dataSource = self
        configure(with: character)
    }

    private func configure(with model: Character?) {
        guard let model = model,
              let imageURL = model.image,
              let url = URL(string: imageURL) else {
            return
        }
        
        DispatchQueue.main.async {
            self.imageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.layer.cornerRadius = 150
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOpacity = 0.6
        imageView.layer.shadowOffset = CGSize(width: 5, height: 8)
        imageView.layer.shadowColor = getShadowColor(from: character?.status)
        imageView.clipsToBounds = false
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

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Barev Dzez"
        cell.textLabel?.textColor = .systemBackground
        return cell
    }
}
