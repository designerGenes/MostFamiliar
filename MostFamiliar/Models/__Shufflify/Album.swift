//
//  Album.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/20/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import SwiftRandom

class Album: Playlist {
    static var albums = [String: Album]()  // albumId: Album
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
        Album.albums[albumId] = self
        trackIds.forEach { (trackId) in
            TrackAlbumTable.trackAlbumDict[trackId] = albumId
        }
    }
    
    static func withRandomSongs(albumName: String, artistId: String, trackMin: Int, trackMax: Int) -> Album {
        let trackIds = (0..<randomInt(upperBound: trackMax, min: trackMin)).map({ _ in Track.withRandomDetails(name: RandomGenerator.random(type: .trackName), artistId: artistId).trackId
        })
        let out = Album(name: albumName, artistId: artistId, trackIds: trackIds)
        return out
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
