//
//  FavoriteDetailRecipeViewController.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 30/06/2022.
//

import UIKit

class FavoriteDetailRecipeViewController: UIViewController {

    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var nameRecipeLabel: UILabel!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var detailRecipeTextView: UITextView!
    @IBOutlet weak var portionRecipeLabel: UILabel!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var recipe: FavoriteRecipe?
    let defaultImage = UIImage(named: "defaultImage")
    let localRecipeService = LocalRecipeService()

    override func viewDidLoad() {
        super.viewDidLoad()
        getDirectionsButton.round()
        favoriteButton.image = UIImage(systemName: "heart.fill")

        nameRecipeLabel.text = recipe?.name
        preparationTimeLabel.text = recipe?.preparationTime
        detailRecipeTextView.text = recipe?.ingredientsDetail
        portionRecipeLabel.text = recipe?.portions
        if let img = recipe?.image {
            imageRecipe.image = UIImage(data: img)
        } else {
            imageRecipe.image = defaultImage
        }
        
    }
    
    @IBAction func getDirectionButtonTapped() {
        openURL()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        localRecipeService.removeRecipe(recipe: recipe)
        favoriteButton.image = UIImage(systemName: "suit.heart")
    }

    private func openURL() {
        guard let sourceUrl = recipe?.sourceUrl,
              let url = URL(string: sourceUrl) else {
            return
        }
        UIApplication.shared.open(url)
    }
}
