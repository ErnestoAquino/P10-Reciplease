//
//  RecipesTableViewCell.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 16/06/2022.
//

import UIKit
import SwiftUI

class RecipesTableViewCell: UITableViewCell {

    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var nameRecipeLabel: UILabel!
    @IBOutlet weak var ingredientsRecipeLabel: UILabel!
    @IBOutlet weak var yieldRecipeLabel: UILabel!
    @IBOutlet weak var timeRecipeLabel: UILabel!

    let defaultImage = UIImage(named: "defaultImage")
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(image: Data?, nameRecipe: String?, ingredients: String?, yield: String?, time: String?) {
        nameRecipeLabel.text = nameRecipe
        ingredientsRecipeLabel.text = ingredients
        yieldRecipeLabel.text = yield
        timeRecipeLabel.text = time
        if let image = image {
            imageRecipe.image = UIImage(data: image)
            imageRecipe.makeRounded()
        } else {
            imageRecipe.image = defaultImage
            imageRecipe.makeRounded()
        }
    }
}
