//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by vaibhavi on 2021-04-08.
//  Copyright © 2021 Big Nerd Ranch. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var dateTaken: Date?
    @NSManaged public var photoID: String?
    @NSManaged public var remoteURL: URL?
    @NSManaged public var title: String?

}

extension Photo : Identifiable {

}
