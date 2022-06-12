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
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ingrentTextField.resignFirstResponder()
    }

    @IBAction func addButtonTapped() {
        
    }

    @IBAction func clearButtonTapped() {
        listIngredientTextView.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.round()
        clearButton.round()
        searchButton.round()
        // Do any additional setup after loading the view.
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
}
