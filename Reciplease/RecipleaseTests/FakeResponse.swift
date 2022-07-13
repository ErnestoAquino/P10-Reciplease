//
//  FakeResponse.swift
//  RecipleaseTests
//
//  Created by Ernesto Elias Aquino Cifuentes on 07/07/2022.
//

import Foundation
import Alamofire

class FakeResponse {
    static let emptyRequest: URLRequest? = nil
    
    static let incorrectData = "Error".data(using: .utf8)

    static let imageData = "image".data(using: .utf8)

    static let url: String? = "https://edamam-product-images.s3.amazonaws.com/web-img/82e/82edcb8b3ed133d96d88646fb2b749c7.jpeg"

    static var correctData: Data? {
        let bundle = Bundle(for: FakeResponse.self)
        guard let url = bundle.url(forResource: "RecipeResponse", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }

    static var dataWithMissingElements: Data? {
        let bundle = Bundle(for: FakeResponse.self)
        guard let url = bundle.url(forResource: "RecipeResponseMissingElements", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }

    static var dataWithoutHits: Data? {
        let bundle = Bundle(for: FakeResponse.self)
        guard let url = bundle.url(forResource: "RecipeResponseWithoutHits", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }

    static var responseOK: HTTPURLResponse? {
        guard let url = URL(string: "www.openclassrooms.com") else {
            return nil
        }
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        return response
    }

    static var responseFail: HTTPURLResponse? {
        guard let url = URL(string: "www.openclassrooms.com") else {
            return nil
        }
        let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)
        return response
    }
}
