//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 06/06/2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var ingrentTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ingrentTextField.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.round()
        clearButton.round()
        searchButton.round()
        // Do any additional setup after loading the view.
    }

}
