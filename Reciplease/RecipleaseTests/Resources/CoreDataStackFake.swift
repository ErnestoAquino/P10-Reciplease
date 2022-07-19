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


// Non utilisee Test

class Test_FakeCoreDataStack {

    static let shared = Test_FakeCoreDataStack()
    private let persistentContainerName = "Reciplease"
    
    private init () {}

    var viewContext: NSManagedObjectContext {
        return Test_FakeCoreDataStack.shared.persistentContainer.viewContext
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        let description = container.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error.userInfo) for: \(storeDescription.description)")
            }
        }
        return container
    } ()
}


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

//class TestCoreDataStack: CoreDataStack {
//  override init() {
//    super.init()
//
//    let persistentStoreDescription = NSPersistentStoreDescription()
//    persistentStoreDescription.type = NSInMemoryStoreType
//
//    let container = NSPersistentContainer(
//      name: CoreDataStack.modelName,
//      managedObjectModel: CoreDataStack.model)
//    container.persistentStoreDescriptions = [persistentStoreDescription]
//
//    container.loadPersistentStores { _, error in
//      if let error = error as NSError? {
//        fatalError("Unresolved error \(error), \(error.userInfo)")
//      }
//    }
//
//    storeContainer = container
//  }
//}

