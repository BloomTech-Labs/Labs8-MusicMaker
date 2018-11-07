//
//  AssignmentMusicPieceTableViewCell.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/7/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class AssignmentMusicPieceTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var musicPiece: String? {
        didSet {
            guard let musicPiece = musicPiece else {
                musicPieceLabel.text = "Music Piece: Unknown"
                return
            }
            
            musicPieceLabel.text = "Music Piece: \(musicPiece)"
        }
    }

    // MARK: - Outlets
    
    @IBOutlet weak var musicPieceLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    

}

extension AssignmentMusicPieceTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicSheetPageCell", for: indexPath) as! MusicSheetPageCollectionViewCell
        
        return cell
    }
    
    // Don't forget to set the collection view's delegate and data source to be AssignmentMusicPieceTableViewCell
}
