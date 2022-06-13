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
        guard let ingredients = ingredients else {return}
        let ingredientWithoutSpaces =  trimmingAllSpaces(ingredients)
        if ingredientWithoutSpaces.isEmpty {
            return
        }
        if ingredientWithoutSpaces.contains(",") {
            let tabIngredients = splitIngredients(ingredientWithoutSpaces)
            for ingredient in tabIngredients {
                refreshListIngredientWith("- " + ingredient.capitalized + "\n")
            }
            clearIngredientTextField()
        } else {
            refreshListIngredientWith("- " + ingredientWithoutSpaces.capitalized + "\n")
            clearIngredientTextField()
        }
    }

    /**
     This function trims a string using the comma " , " as a reference.
     
     - parameter ingredients: The string to be trimmed
     
     - returns: Returns a string table with the trimmed elements.
     */
    private func splitIngredients(_ ingredients: String) -> [String] {
        let ingredientsWithoutSpaces = trimmingAllSpaces(ingredients)
        return ingredientsWithoutSpaces.split(separator: ",").map{"\($0)"}
    }

    /**
     This function removes whitespace from a string.
     
     - parameter string: String with spaces to be removed.
     
     - returns: String without spaces or line breaks.
     */
    private func trimmingAllSpaces(_ string: String) -> String {
        return string.components(separatedBy: .whitespacesAndNewlines).joined()
    }
}
