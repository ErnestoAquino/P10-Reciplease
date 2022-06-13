//
//  RecipeServiceExtension.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 12/06/2022.
//

import Foundation

extension RecipeService: SearchDelegate {
    /**
     This function displays an alert to the user.
     
     - parameter message: String with the message to be displayed in the alert.
     */
    func warningMessage(_ message: String) {
        viewDelegate?.warningMessage(message)
    }

    /**
     This function adds an new element to list ingredient text view.
     
     - parameter value: String to be added to text view.
     */
    func refreshListIngredientWith(_ value: String) {
        viewDelegate?.refreshListIngredientWith(value)
    }

    /**
     This function clears the list of ingredients.
     */
    func clearListIngredient() {
        viewDelegate?.clearListIngredient()
    }

    /**
     This function clears the ingredients text field.
     */
    func clearIngredientTextField() {
        viewDelegate?.clearIngredientTextField()
    }
}
