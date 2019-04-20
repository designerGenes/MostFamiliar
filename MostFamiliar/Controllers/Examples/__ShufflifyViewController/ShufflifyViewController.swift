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

class RoundedCornerButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.height / 2
    }
}


class ShufflifyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ReshufflifyTableViewCellDelegate, UIScrollViewDelegate {
    private var tableView = UITableView()
    private var playList: Playlist?
    private var floatingReloadButton = RoundedCornerButton()
    private var ignoreScrollEvents = false
    
    
    func getTrack(indexPath: IndexPath) -> Track? {
        return playList?.getTracks()[indexPath.section]
    }
    
    func setFloatingReloadButtonShowing(shouldShow: Bool) {
        let targetAlpha: CGFloat = shouldShow ? 1 : 0
        guard floatingReloadButton.alpha != targetAlpha else {
            return
        }
        
        UIView.animate(withDuration: 0.15) {
            self.floatingReloadButton.alpha = targetAlpha
        }
        
    }
    
    // MARK: - UIScrollViewDelegate methods
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        ignoreScrollEvents = false
        self.playList = Playlist.withRandomDetails(artistMin: 10, artistMax: 20, trackMin: 5, trackMax: 10)
        self.playList?.shuffle()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0 && ignoreScrollEvents == true {
            ignoreScrollEvents = false
            self.playList = Playlist.withRandomDetails(artistMin: 10, artistMax: 20, trackMin: 5, trackMax: 10)
            self.playList?.shuffle()
        }
        if ignoreScrollEvents {
            return
        }
        setFloatingReloadButtonShowing(shouldShow: scrollView.contentOffset.y > (tableView.frame.size.height / 2))
    }
    
    // MARK: - ReshufflifyTableViewCellDelegate methods
    func didClickReload(in cell: ReshufflifyTableViewCell) {
        playList = Playlist.withRandomDetails(artistMin: 10, artistMax: 20, trackMin: 5, trackMax: 10)
        playList?.shuffle()
        tableView.reloadData()
    }
    
    @objc func clickedFloatingReloadButton(sender: UIButton) {
        setFloatingReloadButtonShowing(shouldShow: false)
        ignoreScrollEvents = true
        tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .bottom, animated: true)
    }
  
    
    // MARK: - UITableViewDataSource, UITableViewDelegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section < 1 ? 32 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section < 1 ? 16 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
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
        let id = indexPath.section == 0 ? "ReshufflifyTableViewCell" : "ShufflifyTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        (cell as? ShufflifyTableViewCell)?.loadTrackData(track: getTrack(indexPath: indexPath)!)
        (cell as? ReshufflifyTableViewCell)?.loadData(bumpCount: playList?.bumpCount ?? 0)
        (cell as? ReshufflifyTableViewCell)?.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is ReshufflifyTableViewCell {
            setFloatingReloadButtonShowing(shouldShow: false)
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.coverSelfEntirely(with: tableView, obeyMargins: true)
        view.backgroundColor = UIColor.spotifyDarkGray()
        tableView.dataSource = self
        tableView.delegate = self
        (tableView as? UIScrollView)?.delegate = self
        tableView.register(UINib(nibName: "ShufflifyTableViewCell", bundle: nil), forCellReuseIdentifier: "ShufflifyTableViewCell")
        tableView.register(UINib(nibName: "ReshufflifyTableViewCell", bundle: nil), forCellReuseIdentifier: "ReshufflifyTableViewCell")
        tableView.backgroundColor = .clear

        tableView.separatorStyle = .none
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedBack(sender:)))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.spotifyGray()
        self.playList = Playlist.withRandomDetails(artistMin: 10, artistMax: 12, trackMin: 5, trackMax: 10)
        playList?.shuffle()
        tableView.reloadData()
        
        view.addSubview(floatingReloadButton)
        let titleLabel = floatingReloadButton.titleLabel!
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20) //UIFont.filsonSoftBold(size: 40)
        titleLabel.textAlignment = .center
        floatingReloadButton.coverSelfEntirely(with: titleLabel)
        
        floatingReloadButton.backgroundColor = UIColor.spotifyGreen()
        floatingReloadButton.setTitle("New", for: .normal)
        floatingReloadButton.setTitleColor(.white, for: .normal)
        floatingReloadButton.addTarget(self, action: #selector(clickedFloatingReloadButton(sender:)), for: .touchUpInside)
        
        floatingReloadButton.alpha = 0
        floatingReloadButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            floatingReloadButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 32),
            floatingReloadButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16),
            floatingReloadButton.widthAnchor.constraint(equalToConstant: 64),
            floatingReloadButton.heightAnchor.constraint(equalTo: floatingReloadButton.widthAnchor)
            ])
        
    }
    
    @objc func tappedBack(sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
