//
//  SessionFake.swift
//  RecipleaseTests
//
//  Created by Ernesto Elias Aquino Cifuentes on 06/07/2022.
//
import Alamofire
import Foundation
@testable import Reciplease
enum Resultados {
    case success
    case failure
}

class SessionFake: SessionProtocol {

    var data: Data?
    var response: URLResponse?
    var result: Resultados

    init(data: Data?, response: URLResponse?, result: Resultados) {
        self.data = data
        self.response = response
        self.result = result
    }

    func withRequest(_ convertible: URLRequestConvertible) -> DataRequestProtocol {
        let task = DataRequestFake(data: data, urlResponse: response, result: result)
            return task
    }
}

class DataRequestFake: DataRequestProtocol {
    func withResponseImage(completionHandler: @escaping (AFDataResponse<UIImage>) -> Void) {
        
    }
    

    var data: Data?
    var urlResponse: URLResponse?
    var result: Resultados
    

    init(data: Data?, urlResponse: URLResponse?, result: Resultados) {
        self.data = data
        self.urlResponse = urlResponse
        self.result = result
    }


    func withResponse(completionHandler: @escaping (AFDataResponse<Data?>) -> Void) {
        switch result {
        case .success:
            let responseOK = AFDataResponse<Data?>(request: nil, response: urlResponse as? HTTPURLResponse, data: data, metrics: nil, serializationDuration: 0, result: .success(data))
            completionHandler(responseOK)

        case .failure:
            let responseFail = AFDataResponse<Data?>(request: nil, response: urlResponse as? HTTPURLResponse, data: data, metrics: nil, serializationDuration: 0, result: .failure(AFError.sessionDeinitialized))
            completionHandler(responseFail)
        }
    }
}
