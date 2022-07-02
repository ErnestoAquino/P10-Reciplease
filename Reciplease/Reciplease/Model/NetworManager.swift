//
//  NetworManager.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 13/06/2022.
//

import Foundation
import Alamofire
import AlamofireImage

/**
 * NetworkManager
 *
 * This class handles network requests using the Alamofire and AlamofireImage packets.
 */
public final class NetworkManager <T: Decodable>{

    /**
     This function retrieves the contents of a URL based on the specified URL request object, and calls a handler  completion.
     
     - parameter request:           A URL request object that provides the URL, request type, body data or body stream, and so on.
     - parameter completionHandler: This completion handler takes the following parameters: T? : The data returned by the server like a structure decodable type. Error? :
      An error object that indicates why the request failed, or nil if the request was successful.
     */
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

    /**
     This function retrieves an image from the url passed in parameter.
     
     - parameter url:               String url for request
     - parameter completionHandler:  This completion handler takes the following parameters: Data? : The data returned by the server if the operation was successful or nil if there was an error.
     */
    public func getImage(url: String?, completionHandler: @escaping (Data?) -> Void) {
        guard let url = url else {
            completionHandler(nil)
            return
        }
        AF.request(url).responseImage { response in
                guard response.error == nil,
                      let data = response.data else {
                    completionHandler(nil)
                    return
                }
                completionHandler(data)
        }
    }
}

