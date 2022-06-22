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
        listIngredients = []
        test_recipes = []
    }

    /**
     This function clears the ingredients text field.
     */
    func clearIngredientTextField() {
        viewDelegate?.clearIngredientTextField()
    }

    /**
     This function displays the activity indicator.
     
     - parameter value: True to show or false to hide it.
     */
    func showActivityIndicator(_ value: Bool) {
        viewDelegate?.showActivityIndicator(value)
    }

    /**
     This function allows you to follow the segue :segueToResult.
     */
    func goToSearchResultViewController() {
        viewDelegate?.goToSearchResultViewController()
    }
}
