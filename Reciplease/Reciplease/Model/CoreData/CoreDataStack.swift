//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 28/06/2022.
//

import Foundation
import CoreData

final class CoreDataStack {

    public var viewContext: NSManagedObjectContext {
        return CoreDataStack.shared.persistentContainer.viewContext
    }

    static let shared = CoreDataStack()
    private init () {}

    private let persistentContainerName = "Reciplease"
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    } ()
}
