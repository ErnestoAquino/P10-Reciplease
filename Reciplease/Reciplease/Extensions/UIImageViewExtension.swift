//
//  UIImageViewExtension.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 18/06/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    /**
     This function rounds a UIIMageView and adds a green border around it.
     */
    func makeRounded() {
        let greenRecipe =  UIColor(red: 0.3529, green: 0.5725, blue: 0.3843, alpha: 1.0)
        
        layer.borderWidth = 2
        layer.masksToBounds = false
        layer.borderColor = greenRecipe.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
