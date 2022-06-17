//
//  NetworManager.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 13/06/2022.
//

import Foundation
import Alamofire

class NetworkManager <T: Decodable>{
    
    public func getInformation(request: URLRequest?, completionHandler: @escaping (T?, Error?) -> Void) {
        guard let request = request else {
            completionHandler(nil, nil)
            return
        }

        AF.request(request).responseDecodable(of: RecipeResponse.self) { response in
            guard response.error == nil else {
                completionHandler(nil, response.error)
                return
            }
            guard let data = response.data,
                  response.response?.statusCode == 200 else {
                completionHandler(nil, nil)
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            decoder.dateDecodingStrategy = .secondsSince1970
            guard let recipeResponse =  try? decoder.decode(T.self, from: data) else {
                completionHandler(nil, nil)
                return
            }
            completionHandler(recipeResponse, nil)
        }
    }

// MARK: -Funciones de test.

}
