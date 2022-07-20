//
//  SessionFake.swift
//  RecipleaseTests
//
//  Created by Ernesto Elias Aquino Cifuentes on 06/07/2022.
//
import AlamofireImage
import Alamofire
import Foundation
import UIKit
@testable import Reciplease

/**
 * SessionFake:
 *
 * This class is a fake of the Session class defined in Alamofire.
 It is initialized with the data you want to simulate in the response.
 */
final class SessionFake: SessionProtocol {
    private var data: Data?
    private var response: URLResponse?
    private var result: Resultados

    init(data: Data?, response: URLResponse?, result: Resultados) {
        self.data = data
        self.response = response
        self.result = result
    }

    /**
     This method is a fake of the request method defined in the alamofire framework.
     
     - parameter convertible: Variable of type URLRequest.
     
     - returns: Returns an instance of DataRequestFake.
     */
    func withRequest(_ convertible: URLRequestConvertible) -> DataRequestProtocol {
        let task = DataRequestFake(data: data, urlResponse: response, result: result)
            return task
    }

    /**
     This method is a fake of the request method defined in the alamofire framework.
     
     - parameter convertible: String url for request.
     
     - returns: Returns an instance of DataRequestFake.
     */
    func withURL(_ convertible: URLConvertible) -> DataRequestProtocol {
        let task = DataRequestFake(data: data, urlResponse: response, result: result)
            return task
    }
}

/**
 * DataRequestFake:
 *
 * This class is a fake of the DataRequest class defined in Alamofire.
 */
final class DataRequestFake: DataRequestProtocol {

    private var data: Data?
    private var urlResponse: URLResponse?
    private var result: Resultados
    private var dataImage = "Image".data(using: .utf8)

    private let defaultImage = UIImage(named: "defaultImage")

    init(data: Data?, urlResponse: URLResponse?, result: Resultados) {
        self.data = data
        self.urlResponse = urlResponse
        self.result = result
    }


    /**
     This method is an fake of response deifined by Alamofire.
     
     - parameter completionHandler:  -> DataResponse.  Is the type of response sent by alamofire.
     The response depends on the value of Result.
     If it is .succes the response will be .succes CorrectData.
     If it is .failure the response will be .failure Error.
     */
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

    /**
     This method is a fake of the responseImage method defined by alamofire.
     
     - parameter completionHandler: -> DataResponse.  Is the type of response sent by alamofire. The response depends on the value of Result.
     If it is .succes the response will be .succes ImageData.
     If it is .failure the response will be .failure Error.
     */
    func withResponseImage(completionHandler: @escaping (AFDataResponse<Image>) -> Void) {
        switch result {
        case .success:
            let responseImageOK = AFDataResponse<Image>(request: nil, response: urlResponse as? HTTPURLResponse, data: data, metrics: nil, serializationDuration: 0, result: .success(defaultImage!))
            completionHandler(responseImageOK)
        case .failure:
            let responseImageFail = AFDataResponse<Image>(request: nil, response: urlResponse as? HTTPURLResponse, data: nil, metrics: nil, serializationDuration: 0, result: .failure(AFError.sessionDeinitialized))
            completionHandler(responseImageFail)
        }
    }
}

/**
 Enumeration to define the type of result to be obtained as a response when initializing the SessionFake class.
 
 Available cases:
 - **success**: Returns a correct response and the correct data.
 - **failure**: Returns a failed response and an error.
 */
enum Resultados {
    case success
    case failure
}
