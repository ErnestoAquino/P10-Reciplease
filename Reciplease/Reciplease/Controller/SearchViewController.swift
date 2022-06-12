//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 06/06/2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var ingrentTextField: UITextField!
    @IBOutlet weak var listIngredientTextView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let recipeService = RecipeService()
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ingrentTextField.resignFirstResponder()
    }

    @IBAction func addButtonTapped() {
        recipeService.addIngredients(ingrentTextField.text)
        
    }

    @IBAction func clearButtonTapped() {
        recipeService.clearListIngredient()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeService.viewDelegate = self
        addButton.round()
        clearButton.round()
        searchButton.round()
    }

}

// MARK: -Extension
extension SearchViewController: SearchDelegate {
    /**
     This function displays an alert to user.
     
     - parameter message: String with the message to be display in the alert.
     */
    func warningMessage(_ message: String) {
        let alert: UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }

    /**
     This function adds an new element to list ingredient text view.
     
     - parameter value: String to be added to text view.
     */
    func refreshListIngredientWith(_ value: String) {
        listIngredientTextView.text.append(value)
    }

    /**
     This function clears the list of ingredients.
     */
    func clearListIngredient() {
        listIngredientTextView.text = ""
    }
}
