//
//  LocalRecipeService.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 29/06/2022.
//

import Foundation
import CoreData

/**
 * LocalRecipeService
 *
 * This class manages the stored recipes.
 */

final public class LocalRecipeService {

    var favoriteRecipes: [FavoriteRecipe] = []

    /**
     This function fetches the recipes stored in CoreData.
     */
    func fetchRecipes(){
        favoriteRecipes = []
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let recipes =  try? CoreDataStack.shared.viewContext.fetch(request) else {
            return
        }
        for recipe in recipes {
            favoriteRecipes.append(recipe)
        }
    }

    /**
     This function deletes a FavoriteRecipe from CoreData
     
     - parameter recipe: Recipe to be deleted.
     */
    func removeRecipe(recipe: FavoriteRecipe?) {
        guard let recipeToRemove = recipe else {return}
        CoreDataStack.shared.viewContext.delete(recipeToRemove)

        do {
            try CoreDataStack.shared.viewContext.save()
        } catch  {
            // TODO: Print messa error for user.
        }
        fetchRecipes()
    }

    
}
