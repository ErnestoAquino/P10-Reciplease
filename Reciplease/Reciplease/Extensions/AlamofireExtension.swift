//
//  AlamofireExtension.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 04/07/2022.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftUI


protocol SessionProtocol {
    func withRequest(_ convertible: URLRequestConvertible) -> DataRequestProtocol
}

protocol DataRequestProtocol {
    func withResponse(completionHandler: @escaping (AFDataResponse<Data?>) -> Void)
    func withResponseImage(completionHandler: @escaping (AFDataResponse<UIImage>) -> Void)
}

extension Session: SessionProtocol {
    func withRequest(_ convertible: URLRequestConvertible) -> DataRequestProtocol {
         request(convertible) as DataRequestProtocol
    }
}

extension DataRequest: DataRequestProtocol {
    func withResponseImage(completionHandler: @escaping (AFDataResponse<UIImage>) -> Void) {
        responseImage(completionHandler: completionHandler)
    }
    

    func withResponse(completionHandler: @escaping (AFDataResponse<Data?>) -> Void) {
        response(completionHandler: completionHandler)
    }
}
