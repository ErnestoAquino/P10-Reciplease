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
        
     let persistentContainer: NSPersistentContainer
     let  mainContext: NSManagedObjectContext
         
    init() {
        persistentContainer = NSPersistentContainer(name: "Reciplease")
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


// Non utilisee


class PersistentContainer {
    private static var _model: NSManagedObjectModel?
    private static func model(name: String) throws -> NSManagedObjectModel {
        if _model == nil {
            _model = try loadModel(name: name, bundle: Bundle.main)
        }
        return _model!
    }
    private static func loadModel(name: String, bundle: Bundle) throws -> NSManagedObjectModel {
        guard let modelURL = bundle.url(forResource: name, withExtension: "momd") else {
            throw CoreDataError.modelURLNotFound(forResourceName: name)
        }

        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            throw CoreDataError.modelLoadingFailed(forURL: modelURL)
       }
        return model
    }

    enum CoreDataError: Error {
        case modelURLNotFound(forResourceName: String)
        case modelLoadingFailed(forURL: URL)
    }

    public static func container() throws -> NSPersistentContainer {
        let name = "Reciplease"
        return NSPersistentContainer(name: name, managedObjectModel: try model(name: name))
    }
}


