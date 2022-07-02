//
//  RecipeServiceExtension.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 12/06/2022.
//

import Foundation

extension RecipeService: SearchDelegate {

    
    /**
     This function navigates to SearchResutlViewcontroller.
     
     - parameter recipes: Table with the recipes to pass to the view controller.
     - parameter nextURL: String containing the following elements of the search result.
     */
    func goToSearchResultViewController(recipes: [LocalRecipe], nextURL: String?) {
        viewDelegate?.goToSearchResultViewController(recipes: listRecipes, nextURL: nextURL)
    }
    
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
        listRecipes = []
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
}

extension RecipeService {
    convenience init() {
        self.init(recipes: [], nextRexipes: nil)
    }
}

extension RecipeService: SearchResultDelegate {
    func reloadTableView() {
        searchResultViewDelegate?.reloadTableView()
    }
}
