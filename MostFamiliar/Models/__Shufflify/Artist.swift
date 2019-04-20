//
//  Artist.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/20/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import SwiftRandom

class ArtistTrackTable: NSObject {
    static var artistTrackDict = [String: [Track]]()  // artistId: [tracks]
}

class Artist: NSObject {
    static var artists = [String: Artist]() // artistId: Artist
    var artistId: String
    var artistName: String
    
    var tracks: [Track] {
        return ArtistTrackTable.artistTrackDict[self.artistId] ?? [Track]()
    }
    
    override var description: String {
        var out = "Artist named \(artistName) with \(tracks.count) tracks"
        for id in tracks.map({$0.trackId}) {
            out += "\n\t\(Track.tracks[id]!.description)"
        }
        return out
    }
    
    static func random(name: String, trackCount: Int = 0) -> Artist {
        let out = Artist(name: name)
        var albums = [Album]()
        var remainingTrackCount = trackCount
        while remainingTrackCount > 0 {
            albums.append(Album.withRandomSongs(albumName: name, artistId: out.artistId, trackMin: remainingTrackCount, trackMax: remainingTrackCount))
            remainingTrackCount -= albums.last!.trackIds.count
        }
        
        return out
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let otherObj = object as? Artist else {
            return false
        }
        return otherObj === self || otherObj.artistId == artistId
    }
    
    init(name: String, id: String? = nil) {
        artistId = id ?? UUID.init().uuidString
        artistName = name
        super.init()
        Artist.artists[artistId] = self
    }
}
