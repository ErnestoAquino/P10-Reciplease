//
//  AlamofireExtension.swift
//  Reciplease
//
//  Created by Ernesto Elias Aquino Cifuentes on 04/07/2022.
//

import Foundation
import Alamofire
import AlamofireImage



protocol SessionProtocol {
    func withRequest(_ convertible: URLRequestConvertible) -> DataRequestProtocol
    func withURL(_ convertible: URLConvertible) -> DataRequestProtocol
}

protocol DataRequestProtocol {
    func withResponse(completionHandler: @escaping (AFDataResponse<Data?>) -> Void)
    func withResponseImage(completionHandler: @escaping (AFDataResponse<Image>) -> Void)
}

extension Session: SessionProtocol {
    func withURL(_ convertible: URLConvertible) -> DataRequestProtocol {
        request(convertible) as DataRequestProtocol
    }

    func withRequest(_ convertible: URLRequestConvertible) -> DataRequestProtocol {
         request(convertible) as DataRequestProtocol
    }
}

extension DataRequest: DataRequestProtocol {
    func withResponseImage(completionHandler: @escaping (AFDataResponse<Image>) -> Void) {
        responseImage(completionHandler: completionHandler)
    }

    func withResponse(completionHandler: @escaping (AFDataResponse<Data?>) -> Void) {
        response(completionHandler: completionHandler)
    }
}
