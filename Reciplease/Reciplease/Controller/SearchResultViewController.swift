//
//  SearchResultViewController.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 08/06/2022.
//

import UIKit

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

        cell.configure(image: recipe.imageData, nameRecipe: recipe.label, ingredients: recipe.ingredientLines?.joined(separator: ","), yield: "18", time: "0.0")
        return cell
    }
}
