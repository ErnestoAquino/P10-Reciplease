//
//  RecipeServiceMockDelegate.swift
//  RecipleaseTests
//
//  Created by Ernesto Elias Aquino Cifuentes on 07/07/2022.
//

import Foundation
@testable import Reciplease

class RecipeServiceMockDelegate: SearchDelegate {
    var warningMessageIsCalled = false
    var refreshListIngredientWithIsCalled = false
    var clearListIngredientIsCalled = false
    var clearIngredientTextFieldIsCalled = false
    var showActivityIndicatorIsCalled = false
    var goToSearchResultViewControllerIsCalled = false
    
    
    func warningMessage(_ message: String) {
        warningMessageIsCalled = true
    }
    
    func refreshListIngredientWith(_ value: String) {
        refreshListIngredientWithIsCalled = true
    }
    
    func clearListIngredient() {
        clearListIngredientIsCalled = true
    }
    
    func clearIngredientTextField() {
        clearIngredientTextFieldIsCalled = true
    }
    
    func showActivityIndicator(_ value: Bool) {
        showActivityIndicatorIsCalled = true
    }
    
    func goToSearchResultViewController(recipes: [LocalRecipe], nextURL: String?) {
        goToSearchResultViewControllerIsCalled = true
    }
}
