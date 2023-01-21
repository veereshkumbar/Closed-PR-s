//
//  PRTableViewCell.swift
//  GithubRepos
//
//  Created by Veeresh Kumbar on 18/01/23.
//

import UIKit
import SDWebImage

class PRTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var prNameLabel: UILabel!
    
    @IBOutlet weak var closedDateLabel: UILabel!
    
    @IBOutlet weak var createdDateLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var viewModel: PRTableViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.userImageView.layer.cornerRadius = self.userImageView.frame.width * 0.5
        self.userImageView.clipsToBounds = true
    }
    
    func config(viewModel: PRTableViewCellViewModel) {
        self.viewModel = viewModel
        bindData()
    }
    
    private func bindData() {
        if let imageUrl = viewModel?.userImageUrl {
            userImageView.sd_setImage(with: imageUrl)
        }
        userNameLabel.text = "\(viewModel?.userName ?? "")"
        prNameLabel.text = viewModel?.prTitle ?? ""
        createdDateLabel.text = viewModel?.createdAt ?? ""
        closedDateLabel.text = viewModel?.closedAt ?? ""
        
    }

}


extension String {
    func toUrl() -> URL? {
        return URL(string: self)
    }
}
