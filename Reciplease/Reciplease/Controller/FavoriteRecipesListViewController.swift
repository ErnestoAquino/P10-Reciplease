//
//  FavoriteRecipesListViewController.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 08/06/2022.
//

import UIKit

class FavoriteRecipesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var localRecipeService = LocalRecipeService()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        localRecipeService.fetchRecipes()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        localRecipeService.fetchRecipes()
        tableView.reloadData()
    }
}

//MARK: - Extesion

extension FavoriteRecipesListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberRows = localRecipeService.favoriteRecipes.count
        return numberRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultViewController.cellIdentifier, for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }

        let recipe =  localRecipeService.favoriteRecipes[indexPath.row]
        cell.configure(image: recipe.image,
                       nameRecipe: recipe.name,
                       ingredients: recipe.ingredientsDetail,
                       yield: recipe.portions,
                       time: recipe.preparationTime)
        return cell
    }
}

extension FavoriteRecipesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FavoriteDetailRecipeViewController") as? FavoriteDetailRecipeViewController {
            vc.recipe = localRecipeService.favoriteRecipes[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
