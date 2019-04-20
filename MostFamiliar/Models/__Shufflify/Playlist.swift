//
//  Playlist.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/20/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation

class Playlist: NSObject {
    static var playlists = [Playlist]()
    private var tracksDict = [Artist: [Track]]()
    var orderedTracks = [Track]() // ordered, even if order is "random order"
    
    var artists: [Artist] {
        return Array(tracksDict.keys)
    }
    
    override init() {
        super.init()
        Playlist.playlists.append(self)
    }
    
    override var description: String {
        return "Playlist with \(getTracks().count) tracks & \(artists.count) artists"
    }
    
    override var debugDescription: String {
        var out = "(BUMP) count: \(bumpCount)"
        var x = 1
        getTracks().forEach({ (track) in
            out += "\n[\(x)] [\(track.trackId.prefix(5))] \(track.trackName.uppercased()) by [\(track.artist.artistId.prefix(5))] \(track.artist.artistName)"
            x += 1
        })
        return out
    }
    
    var orderedTracksDescription: String {
        var out = "Tracks: "
        for (z, track) in getTracks().enumerated() {
            out += "\n\n[\(z + 1)] \(track.trackName)\n\(track.artist.artistName)\n\(track.prettyDuration)"
        }
        return out
    }
    
    func getTrack(at idx: Int) -> Track? {
        // for this example we assume no "endless playlist" feature as found in real Spotify
        let tracks = getTracks()
        let idx = idx < 0 ? tracks.count + idx : idx >= tracks.count ? idx % tracks.count : idx
        return getTracks()[idx]
    }
    
    func getTracks() -> [Track] {
        return orderedTracks.isEmpty ? tracksDict.values.flatMap({$0}) : orderedTracks
    }
    
    func spreadMaximizingDeltaWithRandomStart(length: Int, pipeCount: Int) -> [Int] {
        guard length > pipeCount else {
            return Array(0..<length)
        }
        var idxs = [Int]()
        let remainingSpaceToDivide = pipeCount + (length - pipeCount)
        let start = randomInt(upperBound: length)
        for k in 0..<pipeCount {
            var idx = start + ((remainingSpaceToDivide / pipeCount) * k)
            if idx >= length {
                idx = idx - length
            }
            idxs.append(idx)
        }
        return idxs
    }
    
    func shuffle() {
        let trackCount = tracksDict.values.flatMap({$0}).count // 10
        var availableIdxs = Array(0..<trackCount) // [0..<10]
        var trackIdIdxs = [Int: String]()  // 0: track1
        
        // O(n) despite nested loop.  we are looping over "all tracks"
        for (_, trackList) in tracksDict { // ("binky barnes", [track1, track2, track3])
            var positions = spreadMaximizingDeltaWithRandomStart(length: availableIdxs.count, pipeCount: trackList.count)
            for track in trackList {
                let innerIdx = positions.remove(at: randomInt(upperBound: positions.count))
                let outerIdx = availableIdxs[innerIdx]
                trackIdIdxs[outerIdx] = track.trackId
                availableIdxs[innerIdx] = -1
            }
            availableIdxs = availableIdxs.filter({$0 > -1})
        }
        for idx in 0..<trackCount {
            orderedTracks.append(Track.tracks[trackIdIdxs[idx]!]!)
        }
        
    }
    
    private func sift() {
        for bumpyIdx in getBumpyIdxs() {
            
            let availableIdxs = Array(0..<orderedTracks.count).filter({![getTrack(at: $0 - 1), getTrack(at: $0 + 1)].contains(getTrack(at: $0))})
            if availableIdxs.isEmpty {
                continue  // can't be helped
            }
            let rnd = randomInt(upperBound: orderedTracks.count)
            let holder = orderedTracks[rnd]
            orderedTracks[rnd] = orderedTracks[bumpyIdx]
            orderedTracks[bumpyIdx] = holder
        }
    }
    
    static func withRandomDetails(artistMin: Int, artistMax: Int, trackMin: Int, trackMax: Int) -> Playlist {
        let out = Playlist()
        (0..<randomInt(upperBound: artistMax, min: artistMin)).forEach { (k) in
            let artist = Artist.random(name: RandomGenerator.random(type: .artistName), trackCount: randomInt(upperBound: trackMax, min: trackMin))
            out.tracksDict[artist] = artist.tracks
        }
        return out
    }
    
    private func getBumpyIdxs() -> [Int] {
        let tracks = getTracks()
        guard tracks.count > 1 else {
            return []
        }
        var bumpIdxs = [Int]()
        for k in 0..<tracks.count {
            if getTrack(at: k)?.artist == getTrack(at: k - 1)?.artist {
                bumpIdxs.append(k)
            }
        }
        return bumpIdxs
    }
    
    var bumpCount: Int {
        return getBumpyIdxs().count
    }
}
