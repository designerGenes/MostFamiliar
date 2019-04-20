//
//  ShufflifyTableViewCell.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/20/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class ShufflifyTableViewCell: UITableViewCell {
    @IBOutlet weak var lblSongTitle: UILabel!
    @IBOutlet weak var lblSongArtist: UILabel!
    @IBOutlet weak var lblSongAlbumTitle: UILabel!
    
    private var track: Track?
    
    func loadTrackData(track: Track) {
        self.track = track
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [lblSongTitle, lblSongArtist, lblSongAlbumTitle].forEach { (lbl) in
            lbl?.text = nil
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
