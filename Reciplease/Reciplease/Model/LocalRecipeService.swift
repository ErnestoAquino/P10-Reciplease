//
//  LocalRecipeService.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 29/06/2022.
//

import Foundation
import CoreData

class LocalRecipeService {

    var favoriteRecipes: [FavoriteRecipe] = []

    func loadRecipes(){
        favoriteRecipes = []
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let recipes =  try? CoreDataStack.shared.viewContext.fetch(request) else {
            return
        }
        for recipe in recipes {
            favoriteRecipes.append(recipe)
        }
    }

    func removeRecipe(recipe: FavoriteRecipe?) {
        guard let recipeToRemove = recipe else {return}
        CoreDataStack.shared.viewContext.delete(recipeToRemove)

        do {
            try CoreDataStack.shared.viewContext.save()
        } catch  {
            // TODO: Print messa error for user.
        }
        loadRecipes()
    }

    
}
