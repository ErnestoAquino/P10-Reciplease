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

    let defaultImage = UIImage(named: "defaultImage")

    var img: Data?
    var titleRecipe: String?
    var time: String?
    var portions: String?
    var details: [String]?
    var urlSource: String?


    override func viewDidLoad() {
        super.viewDidLoad()

        titleRecipeLabel.text = titleRecipe
        preparationTimeLabel.text = time
        portionsRecipeLabel.text = portions
        detailRecipeText.text = details?.joined(separator: "\n")
        if let dataImage = img {
            imageRecipe.image = UIImage(data: dataImage)
        } else {
            imageRecipe.image = defaultImage
        }

        getDirectionsButton.round()
    }
    
    @IBAction func getDirectionButtonTaped() {
        guard let urlSource = urlSource,
              let url = URL(string: urlSource) else {
                  return
              }
        UIApplication.shared.open(url)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
