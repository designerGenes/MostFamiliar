//
//  Track.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/20/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import SwiftRandom

class Track: NSObject {
    static var tracks = [String: Track]()  // trackId: Track
    var trackName: String
    var duration: Double // in seconds
    var trackId: String
    var artistId: String
    var isExplicit: Bool = false
    
    var prettyDuration: String {
        let minutes = Int((duration - duration.truncatingRemainder(dividingBy: 60)) / 60)
        let seconds = Int(duration - Double(minutes * 60))
        return "\(minutes < 10 ? "0" : "")\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
    
    var artist: Artist {
        return Artist.artists[artistId]!
    }
    
    var album: Album? {
        return Album.albums[TrackAlbumTable.trackAlbumDict[trackId] ?? ""]
    }
    
    override var description: String {
        return "\(trackName) [\(prettyDuration)]"
    }
    
    static func withRandomDetails(name: String, artistId: String) -> Track {
        return Track(name: name, duration: Double(randomInt(upperBound: 400)), artistId: artistId, hasExplicitLyrics: randomInt(upperBound: 5) > 3)
    }
    
    init(name: String, duration: Double, artistId: String, id: String? = nil, hasExplicitLyrics: Bool = false) {
        self.trackName = name
        self.artistId = artistId
        self.trackId = id ?? UUID.init().uuidString
        self.duration = duration
        self.isExplicit = hasExplicitLyrics
        super.init()
        Track.tracks[self.trackId] = self
        var holder = ArtistTrackTable.artistTrackDict[artistId] ?? [Track]()
        holder.append(self)
        ArtistTrackTable.artistTrackDict[artistId] = holder
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let otherObj = object as? Track else {
            return false
        }
        let propsMatch = trackName == otherObj.trackName && trackId == otherObj.trackId && artistId == otherObj.artistId
        return otherObj === self || propsMatch
    }
}
