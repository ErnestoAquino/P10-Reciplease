//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 20/06/2022.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var portionsRecipeLabel: UILabel!
    @IBOutlet weak var detailRecipeText: UITextView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    let defaultImage = UIImage(named: "defaultImage")
    var recipe: LocalRecipe?
    var recipeService = RecipeService()


    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteButton.image = UIImage(systemName: "suit.heart")

        titleRecipeLabel.text = recipe?.name
        preparationTimeLabel.text = recipe?.preparationTime
        portionsRecipeLabel.text = recipe?.portions
        detailRecipeText.text = recipe?.ingredientsDetail.joined(separator: "\n")
        if let dataImage = recipe?.image {
            imageRecipe.image = UIImage(data: dataImage)
        } else {
            imageRecipe.image = defaultImage
        }

        getDirectionsButton.round()
    }
    
    @IBAction func getDirectionButtonTaped() {
        guard let urlSource = recipe?.sourceUrl,
              let url = URL(string: urlSource) else {
                  return
              }
        UIApplication.shared.open(url)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        if favoriteButton.image == UIImage(systemName: "suit.heart") {
            favoriteButton.image = UIImage(systemName: "heart.fill")
            recipeService.saveRecipe(recipe)
        } else {
            favoriteButton.image = UIImage(systemName: "suit.heart")
        }
        
    }
}
