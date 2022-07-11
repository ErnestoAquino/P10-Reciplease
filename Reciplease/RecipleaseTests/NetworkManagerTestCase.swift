//
//  NetworkManagerTestCase.swift
//  RecipleaseTests
//
//  Created by Ernesto Elias Aquino Cifuentes on 07/07/2022.
//

import XCTest
@testable import Reciplease

class NetworkManagerTestCase: XCTestCase {
    var expectation: XCTestExpectation!

     override func setUp() {
         super.setUp()
         expectation = XCTestExpectation(description: "Wait for queue change.")
     }

    // Creation of request for tests.
    func createRequestForTest() -> URLRequest? {
        guard let urlTranslation = URL(string: "https://urlForTests.com/") else {
            return nil
        }
        var request = URLRequest(url: urlTranslation)
        request.httpMethod = "POST"
        let body = "iAmABodyForTests"
        request.httpBody = body.data(using: .utf8)
        return request
    }

    func testGivenErrorInResponse_WhenLaunchGetInformation_ThenShouldHaveAnError() {
        //Given
        let sessionFake = SessionFake(data: nil, response: nil, result: .failure)
        let fakeNetworkManager = test_network_manager(session: sessionFake)
        let request = createRequestForTest()
        //When
        fakeNetworkManager.test_get_information(request: request) { response, error in
            //Then
            XCTAssertNotNil(error)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenEmptyRequest_WhenLaunchGetInformation_ThenCompletionHandlerShouldBeNilAndNil() {
        //Given
        let sessionFake = SessionFake(data: FakeResponse.correctData, response:FakeResponse.responseOK , result: .success)
        let fakeNetworkManager = test_network_manager(session: sessionFake)
        //When
        fakeNetworkManager.test_get_information(request: FakeResponse.emptyRequest) { response, error in
            //Then
            XCTAssertNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }


    func testGivenNoDataInResponse_WhenLaunchGetInformation_ThenComplationHandlerShouldBeNilAndNil() {
        //Given
        let session = SessionFake(data: nil, response: FakeResponse.responseOK, result: .success)
        let networkManager = test_network_manager(session: session)
        let request = createRequestForTest()
        // When
        networkManager.test_get_information(request: request) { response, error in
            // Then
            XCTAssertNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenWrongStatusCode_WhenGetInformation_ThenCompletionHandlerShouldBeNil() {
        //Given
        let session = SessionFake(data: FakeResponse.correctData, response: FakeResponse.responseFail, result: .success)
        let networkManager = test_network_manager(session: session)
        let request = createRequestForTest()
        //When
        networkManager.test_get_information(request: request) { response, error in
            // Then
            XCTAssertNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenIncorretDataReceived_WhenGetInformation_ThenCompletionHandlerShouldBeNilAndNil() {
        //Given
        let session = SessionFake(data: FakeResponse.incorrectData, response: FakeResponse.responseOK, result: .success)
        let networkManager = test_network_manager(session: session)
        let request = createRequestForTest()
        //When
        networkManager.test_get_information(request: request) { response, error in
            //Then
            XCTAssertNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenCorrectResponse_WhenGetInformation_ThenShouldHaveNotNilResponse() {
        //Given
        let session = SessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, result: .success)
        let networkManager = test_network_manager(session: session)
        let request = createRequestForTest()
        //When
        networkManager.test_get_information(request: request) { response, error in
            //Then
            XCTAssertNotNil(response)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
