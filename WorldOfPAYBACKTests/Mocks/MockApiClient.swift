//
//  MockApiClient.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 19/02/2024.
//

import Foundation
import Combine

class MockApiClient: ApiClientProtocol {

    var stubbedUrlSession: URLSession!

    var urlSession: URLSession {
        return stubbedUrlSession
    }

    var stubbedDataTaskPublisherResult: AnyPublisher<(data: Data, response: URLResponse), URLError>!

    func dataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return stubbedDataTaskPublisherResult
    }
}
