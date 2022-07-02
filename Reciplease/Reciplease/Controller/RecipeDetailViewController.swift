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
        configureView()
        getDirectionsButton.round()
    }
    
    @IBAction func getDirectionButtonTaped() {
        openURL()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        saveRecipe()
    }

    private func configureView() {
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
    }

    private func openURL() {
        guard let urlSource = recipe?.sourceUrl,
              let url = URL(string: urlSource) else {
                  return
              }
        UIApplication.shared.open(url)
    }

    private func saveRecipe() {
        if favoriteButton.image == UIImage(systemName: "suit.heart") {
            favoriteButton.image = UIImage(systemName: "heart.fill")
            recipeService.saveRecipe(recipe)
        }
    }
}
