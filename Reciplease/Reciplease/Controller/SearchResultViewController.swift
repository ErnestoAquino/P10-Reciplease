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

    var recipeService: RecipeService?

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeService?.searchResultViewDelegate = self
    }
}

// MARK: -Extension.

extension SearchResultViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let section = recipeService?.listRecipes.count {
            return section
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultViewController.cellIdentifier, for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }

        if let recipe = recipeService?.listRecipes[indexPath.row] {
            if recipe.image == nil {
                    self.recipeService?.getImage(index: indexPath.row)
            }
            cell.configure(image: recipe.image, nameRecipe: recipe.name, ingredients: recipe.ingredientsDetail.joined(separator: ","), yield: recipe.portions, time: recipe.preparationTime)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let last = recipeService?.listRecipes.count else {return}
        let lastRecipe = last - 1
        if indexPath.row == lastRecipe {
            recipeService?.getNextRecipes()
            tableView.reloadData()
        }
    }
}

extension SearchResultViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailViewController {
            vc.recipe = recipeService?.listRecipes[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SearchResultViewController: SearchResultDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
}
