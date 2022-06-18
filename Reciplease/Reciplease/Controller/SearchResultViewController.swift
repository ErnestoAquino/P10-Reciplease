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
        return RecipeService.shared.listRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultViewController.cellIdentifier, for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        let recipe = RecipeService.shared.listRecipes[indexPath.row]

        // Zona de tests
                if let imageUrl = recipe.image {
                    AF.request(imageUrl).responseImage { response in
                        if case .success(let image) = response.result {
                            print("image downloaded: \(image)")
                            DispatchQueue.main.async {
                                cell.imageRecipe.image = image
                                cell.imageRecipe.isHidden = false
                                cell.imageRecipe.contentMode = .scaleAspectFill
                            }
                        }
                    }
                }

                
        // Fin zona de test

        cell.configure(image: recipe.imageData, nameRecipe: recipe.label, ingredients: recipe.ingredientLines?.joined(separator: ","), yield: "18", time: "0.0")
        return cell
    }
}
