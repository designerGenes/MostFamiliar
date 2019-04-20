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
    @IBOutlet weak var lblExplicitLyrics: UILabel!
    @IBOutlet weak var lblExplicitLyricsWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblSongArtistLeadingConstraint: NSLayoutConstraint!
    private var track: Track?
    
    func loadTrackData(track: Track) {
        self.track = track
        lblSongTitle.text = track.trackName
        lblSongArtist.text = track.artist.artistName
        lblSongAlbumTitle.text = track.album?.albumName
        lblExplicitLyricsWidthConstraint.constant = track.isExplicit ? 60 : 0
        lblSongArtistLeadingConstraint.constant = track.isExplicit ? 8 : 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [lblSongTitle, lblSongArtist, lblSongAlbumTitle].forEach { (lbl) in
            lbl?.text = nil
        }
        backgroundColor = .clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }    
}
