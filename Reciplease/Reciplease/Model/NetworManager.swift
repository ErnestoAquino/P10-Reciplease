//
//  NetworManager.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 13/06/2022.
//

import Foundation
import Alamofire
import AlamofireImage

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

//    public func getImage(url: String?, completionHandler: @escaping (Data?) -> Void) {
//        guard let url = url else {
//            completionHandler(nil)
//            return
//        }
//        AF.request(url).responseImage { response in
//                guard response.error == nil,
//                      let data = response.data else {
//                    completionHandler(nil)
//                    return
//                }
//                completionHandler(data)
//            }
//    }

    public func getImage(url: String?, completionHandler: @escaping (Data?) -> Void) {
        guard let url = url else {
            completionHandler(nil)
            return
        }
        AF.request(url).responseImage { response in
            DispatchQueue.main.async {
                guard response.error == nil,
                      let data = response.data else {
                    completionHandler(nil)
                    return
                }
                completionHandler(data)
            }
        }
    }
}


class test_networkManager {

    public func getInformation<T: Decodable>(request: URLRequest?, completionHandler: @escaping (T?, Error?)-> Void ) {
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

    public func getImage(url: String?, completionHandler: @escaping (Image?) -> Void) {
        guard let urlImage = url else {
            completionHandler(nil)
            return
        }
        AF.request(urlImage).responseImage { response in
            guard response.error != nil else {
                completionHandler(nil)
                return
            }
            completionHandler(response.value)
        }
    }

    public func getImageTwo(url: String?) -> Data? {
        var imageToReturn: Data?
        guard let imageUrl = url else {
            return nil
        }
        AF.request(imageUrl).responseImage { response in
                guard response.error != nil,
                      let data = response.data else {return}
                imageToReturn = data
        }

        return imageToReturn
    }

    public func getImageTres(url: String?, completionHanler: @escaping (Data?, Bool) -> Void)  {
        
        guard let urlImage = url else {
            completionHanler(nil, false)
            return
        }

        AF.request(urlImage).responseImage { response in
            DispatchQueue.main.async {
                guard response.error != nil,
                      let data = response.data else {
                    completionHanler(nil, false)
                    return
                }

                completionHanler(data, true)
            }
        }
    }

}


//  if let imageUrl = recipe.image {
//AF.request(imageUrl).responseImage { response in
//    if case .success(let image) = response.result {
//        print("image downloaded: \(image)")
//        DispatchQueue.main.async {
//            cell.imageRecipe.image = image
//            cell.imageRecipe.isHidden = false
//            cell.imageRecipe.contentMode = .scaleToFill
//            cell.imageRecipe.makeRounded()
//        }
//    }
//}
//}
