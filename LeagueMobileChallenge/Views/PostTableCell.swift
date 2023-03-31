//
//  PostTableCell.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-03-31.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class PostTableCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let path = UIBezierPath(ovalIn: avatarImageView.bounds).cgPath
        let layer = CAShapeLayer()
        layer.path = path
        avatarImageView.layer.mask = layer
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        usernameLabel.text = nil
        titleLabel.text = nil
        descLabel.text = nil
    }
    
    func decorate(with postItem: PostItem) {
        avatarImageView.sd_setImage(with: postItem.avatar, placeholderImage: UIImage(systemName: "person.circle"))
        usernameLabel.text = postItem.userName
        titleLabel.text = postItem.title
        descLabel.text = postItem.body
    }
}
