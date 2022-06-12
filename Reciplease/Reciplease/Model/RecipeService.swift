//
//  RecipeService.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 12/06/2022.
//

import Foundation

class RecipeService {
// MARK: - Variables
    weak var viewDelegate: SearchDelegate?

// MARK: - Funtions
    func addIngredients(_ ingredients: String?) {
        guard let ingredients = ingredients,
              !ingredients.isEmpty  else {
            warningMessage("Please enter a valid ingredient.")
            return
        }
        refreshListIngredientWith("\n- \(ingredients.capitalized)")
    }
}
