//
//  Photo.swift
//  Photorama
//
//  Created by vaibhavi on 2021-03-26.
//

import Foundation

struct FlickrPhoto: Codable {
    let title: String
    let remoteURL: URL?
    let photoID: String
    let dateTaken: Date
    
    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_z"
        case photoID = "id"
        case dateTaken = "datetaken"
    }
}

extension FlickrPhoto: Equatable {
    
    static func == (lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
        // Two Photos are the same iff they have the same PhotoID
        return lhs.photoID == rhs.photoID
    }
    
}
