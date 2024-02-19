//
//  ApiClient.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 19/02/2024.
//

import Foundation
import Combine

protocol ApiClientProtocol {
    var urlSession: URLSession { get }
    func dataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

class ApiClient: ApiClientProtocol {
    var urlSession: URLSession = .shared
    
//    func dataTaskPublisher(for url: URL) -> URLSession.DataTaskPublisher {
//        urlSession.dataTaskPublisher(for: url)
//    }
    
    func dataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        urlSession.dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
}



