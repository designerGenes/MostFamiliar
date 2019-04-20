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


class ShufflifyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PlaylistDelegate {
    private var tableView = UITableView()
    private var playList: Playlist?
    
    func getTrack(indexPath: IndexPath) -> Track? {
        return playList?.getTracks()[indexPath.section]
    }
    
    // MARK: - PlaylistDelegate methods
    func didFillPlaylist(playlist: Playlist) {
        self.tableView.reloadData()
        SwiftSpinner.hide()
    }
    
    // MARK: - UITableViewDataSource, UITableViewDelegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section > 0 ? 0 : 64
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return playList?.getTracks().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShufflifyTableViewCell", for: indexPath) as! ShufflifyTableViewCell
        cell.loadTrackData(track: getTrack(indexPath: indexPath)!)
        return cell
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.coverSelfEntirely(with: tableView, obeyMargins: true)
        view.backgroundColor = UIColor.spotifyDarkGray()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ShufflifyTableViewCell", bundle: nil), forCellReuseIdentifier: "ShufflifyTableViewCell")
        
        tableView.backgroundColor = .clear

        tableView.separatorStyle = .none
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedBack(sender:)))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.spotifyGray()
        self.playList = Playlist.withRandomDetails(delegate: self, artistMin: 10, artistMax: 12, trackMin: 5, trackMax: 10)
        playList?.shuffle()
        tableView.reloadData()
        
    }
    
    @objc func tappedBack(sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
