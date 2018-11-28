//
//  AssignmentPlaybackTableViewCell.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/26/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import AVKit

class AssignmentPlaybackTableViewCell: UITableViewCell {
    
    var playerViewController: AVPlayerViewController? = nil {
        didSet {
            guard let playerViewController = playerViewController else { return }
            
//            playerViewController.view.frame = self.contentView.bounds
            self.contentView.addSubview(playerViewController.view);
            playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                self.contentView.layoutMarginsGuide.leftAnchor.constraint(equalTo: playerViewController.view.leftAnchor),
                self.contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: playerViewController.view.rightAnchor),
                self.contentView.layoutMarginsGuide.topAnchor.constraint(equalTo: playerViewController.view.topAnchor),
                self.contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: playerViewController.view.bottomAnchor),
                playerViewController.view.heightAnchor.constraint(equalTo: playerViewController.view.widthAnchor, multiplier: 9.0/16.0)
            ])
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        playerViewController = AVPlayerViewController()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
