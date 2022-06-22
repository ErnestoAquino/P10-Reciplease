//
//  SearchResultViewController.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 08/06/2022.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    static var cellIdentifier = "RecipeCell"

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: -Extension.

extension SearchResultViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return RecipeService.shared.listRecipes.count
        return RecipeService.shared.test_recipes.count
    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultViewController.cellIdentifier, for: indexPath) as? RecipesTableViewCell else {
//            return UITableViewCell()
//        }
//        let recipe = RecipeService.shared.listRecipes[indexPath.row]
//
//        // Zona de tests
//            if let imageUrl = recipe.image {
//                AF.request(imageUrl).responseImage { response in
//                    if case .success(let image) = response.result {
//                        DispatchQueue.main.async {
//                            cell.imageRecipe.image = image
//                            cell.imageRecipe.isHidden = false
//                            cell.imageRecipe.contentMode = .scaleToFill
//                            cell.imageRecipe.makeRounded()
//                        }
//                    }
//                }
//            }
//
//        cell.configure(image: recipe.imageData, nameRecipe: recipe.label, ingredients: recipe.ingredientLines?.joined(separator: ","), yield: recipe.portions, time: recipe.preparationTime)
//        return cell
//    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultViewController.cellIdentifier, for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }

        let recipe = RecipeService.shared.test_recipes[indexPath.row]

        if let imageURL = recipe.urlImage {
            AF.request(imageURL).responseImage { response in
                if case .success (let image) = response.result {
                    DispatchQueue.main.async {
                        cell.imageRecipe.image = image
                        RecipeService.shared.test_recipes[indexPath.row].image = response.data
                    }
                }
            }
        }

        cell.configure(image: recipe.image, nameRecipe: recipe.name, ingredients: recipe.ingredientsDetail.joined(separator: ","), yield: recipe.portions, time: recipe.preparationTime)
        return cell
    }

}

extension SearchResultViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailViewController {
            vc.img = RecipeService.shared.test_recipes[indexPath.row].image
            vc.titleRecipe = RecipeService.shared.test_recipes[indexPath.row].name
            vc.portions = RecipeService.shared.test_recipes[indexPath.row].portions
            vc.time = RecipeService.shared.test_recipes[indexPath.row].preparationTime
            vc.details = RecipeService.shared.test_recipes[indexPath.row].ingredientsDetail
            vc.urlSource = RecipeService.shared.test_recipes[indexPath.row].sourceUrl

            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
