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
    private let mainContext: NSManagedObjectContext

    init (mainContext: NSManagedObjectContext = CoreDataStack.shared.viewContext){
        self.mainContext = mainContext
    }

    /**
     This function fetches the recipes stored in CoreData.
     */
    func fetchRecipes(){
        favoriteRecipes = []
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let recipes = try? mainContext.fetch(request) else {
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
    func deleteRecipe(recipe: FavoriteRecipe?) {
        guard let recipeToDelete = recipe else {return}
        mainContext.delete(recipeToDelete)
        do {
            try mainContext.save()
        } catch  {
            print("Sorry, we have encountered a problem deleting a recipe")
        }
       fetchRecipes()
    }

    /**
     This function saves the recipe using Core Data so that it can be consulted offline.
     
     - parameter recipeToSave: recipe to be saved.
     */
    func saveRecipe(_ recipeToSave: LocalRecipe?) {
        guard let recipeToSave = recipeToSave else { return }
        let recipe = FavoriteRecipe(using: mainContext)
        recipe.image = recipeToSave.image
        recipe.name = recipeToSave.name
        recipe.portions = recipeToSave.portions
        recipe.preparationTime = recipeToSave.preparationTime
        recipe.ingredientsDetail = recipeToSave.ingredientsDetail.joined(separator: "\n")
        recipe.urlImage = recipeToSave.urlImage
        recipe.sourceUrl = recipeToSave.sourceUrl

        do {
            try mainContext.save()
        } catch  {
            print ("Sorry, we have encountered an error saving the recipe.")
        }
    }
}
