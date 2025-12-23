//
//  CoreDataManager.swift
//  pixabay
//
//  Created by Ml bench-iOS Dev on 12/23/25.
//


import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer
    let containerName = "PixabayModel"

    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data error: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }

    func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
