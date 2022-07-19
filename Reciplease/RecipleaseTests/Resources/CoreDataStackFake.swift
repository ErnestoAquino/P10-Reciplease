//
//  CoreDataStackFake.swift
//  RecipleaseTests
//
//  Created by Ernesto Elias Aquino Cifuentes on 16/07/2022.
//

import Foundation
import CoreData
@testable import Reciplease


class FakeCoreDataStack {

    private let persistentContainer: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    private let persistentContinerName = "Reciplease"
         
    init() {
        persistentContainer = NSPersistentContainer(name: persistentContinerName)
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType

        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError("Unresolved error \(String(describing: error?.localizedDescription))")
            }
        }
        mainContext = persistentContainer.viewContext
    }
}
