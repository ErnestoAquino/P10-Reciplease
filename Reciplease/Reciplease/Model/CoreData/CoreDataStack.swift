//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 28/06/2022.
//

import Foundation
import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    let persistentContainer: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    let persistentContainerName = "Reciplease"

    private init () {
        persistentContainer = NSPersistentContainer(name: persistentContainerName)
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError("Unresolved error \(String(describing: error?.localizedDescription))")
            }
        }
        mainContext = persistentContainer.viewContext
    }
}
