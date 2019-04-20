//
//  ShufflifyViewController.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/20/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit
import SwiftRandom
import SwiftSpinner


class ShufflifyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var tableView = UITableView()
    private var playList: Playlist?
    
    func getTrack(indexPath: IndexPath) -> Track? {
        return playList?.orderedTracks[indexPath.row]
    }
    
    // MARK: - UITableViewDataSource, UITableViewDelegate methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playList?.orderedTracks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShufflifyTableViewCell", for: indexPath) as! ShufflifyTableViewCell
        cell.loadTrackData(track: getTrack(indexPath: indexPath)!)
        return cell
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.coverSelfEntirely(with: tableView, obeyMargins: false)
        view.backgroundColor = UIColor.spotifyDarkGray()
        tableView.register(ShufflifyTableViewCell.self, forCellReuseIdentifier: "ShufflifyTableViewCell")
        tableView.backgroundColor = .clear
        
        playList = Playlist.withRandomDetails(artistMin: 10, artistMax: 30, trackMin: 5, trackMax: 20)
        tableView.reloadData()
    }
}
