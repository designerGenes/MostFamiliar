//
//  Album.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/20/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation

class Album: Playlist {
    static var albums = [Album]()
    var albumName: String
    var albumId: String
    var artistId: String
    var trackIds = [String]()
    init(name: String, artistId: String, trackIds: [String]) {
        self.albumName = name
        self.trackIds = trackIds
        self.albumId = UUID.init().uuidString
        self.artistId = artistId
        super.init()
        Album.albums.append(self)
    }
    
    static func withRandomSongs(albumName: String, artistId: String, trackMin: Int, trackMax: Int) -> Album {
        
        let trackIds = (trackMin..<trackMin + randomInt(upperBound: trackMax - trackMin)).map({ _ -> Track in
            let randomTrackName = "track name"
            return Track.withRandomDetails(name: randomTrackName, artistId: artistId)
        }).map({$0.trackId})

        return Album(name: albumName, artistId: artistId, trackIds: trackIds)
    }
    
    override var description: String {
        var out = "Album named \(albumName) with \(trackIds.count) tracks: "
        for x in 0..<trackIds.count {
            let track = Track.tracks[trackIds[x]]!
            out += "\n[\(x + 1)] \(track.description)"
        }
        return out
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let otherObj = object as? Album else {
            return false
        }
        return otherObj === self || otherObj.albumId == albumId
    }
}
