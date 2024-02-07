//
//  Contact.swift
//  L6Starter
//
//  Created by Sam Friedman on 10/24/22.
//

import Foundation
import UIKit

class Song: Codable {
    var id: Int
    var title: String
    var artist: String
    var bpm: Int
    var link: String

    init(id: Int, title: String, artist: String, bpm:Int, link: String) {
        self.id = id
        self.title = title
        self.artist = artist
        self.bpm = bpm
        self.link = link
    }
}

class SongResponse: Codable {
    
    var songs: [Song]
    
}
