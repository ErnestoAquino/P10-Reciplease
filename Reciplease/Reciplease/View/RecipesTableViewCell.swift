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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(image: Data?, nameRecipe: String?, ingredients: String?, yield: String?, time: String?) {
        nameRecipeLabel.text = nameRecipe
        ingredientsRecipeLabel.text = ingredients
        
        if let yield = yield {
            yieldRecipeLabel.text = String(yield)
        }

        if let time = time {
            timeRecipeLabel.text = String(time) + " m"
        }

        guard let image = image else {
            imageRecipe.image = defaultImage
            imageRecipe.isHidden = false
            imageRecipe.makeRounded()
            return
        }
    
        imageRecipe.image = UIImage(data: image)
    }

}
