//
//  PixabayEntity+CoreDataProperties.swift
//  pixabay
//
//  Created by Ml bench-iOS Dev on 12/23/25.
//
//

public import Foundation
public import CoreData


public typealias PixabayEntityCoreDataPropertiesSet = NSSet

extension PixabayEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PixabayEntity> {
        return NSFetchRequest<PixabayEntity>(entityName: "PixabayEntity")
    }

    @NSManaged public var downloads: Int32
    @NSManaged public var height: Double
    @NSManaged public var id: Int32
    @NSManaged public var imageUrl: String
    @NSManaged public var likes: Int32
    @NSManaged public var tags: String
    @NSManaged public var width: Double
    @NSManaged public var userName: String

}

extension PixabayEntity : Identifiable {

}
