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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(image: Data?, nameRecipe: String?, ingredients: String?, yield: String?, time: String?) {
        nameRecipeLabel.text = nameRecipe
        ingredientsRecipeLabel.text = ingredients
        yieldRecipeLabel.text = yield
        timeRecipeLabel.text = time

        guard let image = image else {
            return
        }
    
        imageRecipe.image = UIImage(data: image)
    }

}
