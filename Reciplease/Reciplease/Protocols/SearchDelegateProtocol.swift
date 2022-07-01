//
//  SearchDelegateProtocol.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 12/06/2022.
//

import Foundation

protocol SearchDelegate: AnyObject {
    func warningMessage(_ message: String)
    func refreshListIngredientWith(_ value: String)
    func clearListIngredient()
    func clearIngredientTextField()
    func showActivityIndicator(_ value: Bool)
    func goToSearchResultViewController(recipes: [LocalRecipe], nextURL: String?)
}


// Test
protocol SearchResultDelegate: AnyObject {
    func reloadTableView()
}
