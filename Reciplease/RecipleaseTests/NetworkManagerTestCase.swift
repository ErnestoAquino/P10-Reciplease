//
//  NetworkManagerTestCase.swift
//  RecipleaseTests
//
//  Created by Ernesto Elias Aquino Cifuentes on 07/07/2022.
//

import XCTest
@testable import Reciplease

/**
 * NetworkManagerTestCase:
 *
 * Tests created for the NetworkManager class.
 */
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
        let session = SessionFake(data: nil, response: nil, result: .failure)
        let networkManager = NetworkManager(session)
        let request = createRequestForTest()
        //When
        networkManager.getInformation(request: request) { response, error in
            //Then
            XCTAssertNotNil(error)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenEmptyRequest_WhenLaunchGetInformation_ThenCompletionHandlerShouldBeNilAndNil() {
        //Given
        let session = SessionFake(data: FakeResponse.correctData, response:FakeResponse.responseOK , result: .success)
        let networkManager = NetworkManager(session)
        //When
        networkManager.getInformation(request: FakeResponse.emptyRequest) { response, error in
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
        let networkManager = NetworkManager(session)
        let request = createRequestForTest()
        // When
        networkManager.getInformation(request: request) { response, error in
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
        let networkManager = NetworkManager(session)
        let request = createRequestForTest()
        //When
        networkManager.getInformation(request: request) { response, error in
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
        let networkManager = NetworkManager(session)
        let request = createRequestForTest()
        //When
        networkManager.getInformation(request: request) { response, error in
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
        let networkManager = NetworkManager(session)
        let request = createRequestForTest()
        //When
        networkManager.getInformation(request: request) { response, error in
            //Then
            XCTAssertNotNil(response)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenNilUrl_WhenGetImage_ThenDataImageResponseShouldBeNil() {
        //Given
        let session = SessionFake(data: nil, response: FakeResponse.responseOK, result: .success)
        let networkManager = NetworkManager(session)
        //When
        networkManager.getImage(url: nil) { data in
            //Then
            XCTAssertNil(data)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGivenAnError_WhenGetImage_ThenDataImageResponseShouldBeNil() {
        //Given
        let session = SessionFake(data: nil, response: FakeResponse.responseOK, result: .failure)
        let networkManager = NetworkManager(session)
        //When
        networkManager.getImage(url: FakeResponse.url) { dataImage in
            //Then
            XCTAssertNil(dataImage)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGivenWrongStatusCodeInResponse_WhenGetImage_ThenDataImageResponseShouldBeNil() {
        //Given
        let session = SessionFake(data: FakeResponse.imageData, response: FakeResponse.responseFail, result: .success)
        let networkManager = NetworkManager(session)
        //When
        networkManager.getImage(url: FakeResponse.url) { dataImage in
            //Then
            XCTAssertNil(dataImage)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGivenNotData_WhenGetImage_ThenDataImageResponseShouldBeNil() {
        //Given
        let session = SessionFake(data: nil, response: FakeResponse.responseFail, result: .failure)
        let networkManager = NetworkManager(session)
        //When
        networkManager.getImage(url: FakeResponse.url) { dataImage in
            //Then
            XCTAssertNil(dataImage)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGivenCorrectResponse_WhenGetImage_ThenDataImageResponseShouldBeNotNil() {
        //Given
        let session = SessionFake(data: FakeResponse.imageData, response: FakeResponse.responseOK, result: .success)
        let networkManager = NetworkManager(session)
        //When
        networkManager.getImage(url: FakeResponse.url) { dataImage in
            //Then
            XCTAssertNotNil(dataImage)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
