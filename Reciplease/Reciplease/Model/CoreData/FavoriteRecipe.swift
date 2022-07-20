//
//  FavoriteRecipe.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 29/06/2022.
//

import Foundation
import CoreData

/**
 * FavoriteRecipe:
 *
 * This class is an object (favorite recipe) to be managed by CoreData.
 */
public class FavoriteRecipe: NSManagedObject {

}

public extension NSManagedObject {
  /**
   A new convenience init to makes the entity description specific to the passed in context.
   
   - parameter usedContext: an instance of NSManagedObjectContext.
   */
  convenience init(using usedContext: NSManagedObjectContext) {
    let name = String(describing: type(of: self))
    let entity = NSEntityDescription.entity(forEntityName: name, in: usedContext)!
    self.init(entity: entity, insertInto: usedContext)
  }
}
