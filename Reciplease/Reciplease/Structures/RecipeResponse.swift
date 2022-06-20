//
//  RecipeResponse.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 13/06/2022.
//

import Foundation

struct RecipeResponse: Decodable {
    let from: Int?
    let towards: Int?
    let count: Int?
    let links: Links?
    let hits: [Hit]?

    private enum CodingKeys: String, CodingKey {
        case from
        case towards = "to"
        case count
        case links = "_links"
        case hits
    }
}

struct Hit: Decodable {
    var recipe: Recipe?
    var links: Links?

    private enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

struct Recipe: Decodable {
    var label: String?
    var image: String?
    var source: String?
    var url: String?
    var yield: Float?
    var ingredientLines: [String]?
    var ingredients: [Ingredient]?
    var totalTime: Float?

    var imageData: Data?
    var portions: Int?
    var preparationTime: Int?
}

struct Ingredient: Decodable {
    var text: String?
    var quantity: Double?
    var measure: String?
//    var food: String?
    var weight: Double?
//    var fodID: String?
}

struct Links: Decodable {
    let same: Link?
    let next: Link?

    private enum CodingKeys: String, CodingKey {
        case same = "self"
        case next
    }
}

struct Link: Decodable {
    let href: String?
    let title: String?
}
